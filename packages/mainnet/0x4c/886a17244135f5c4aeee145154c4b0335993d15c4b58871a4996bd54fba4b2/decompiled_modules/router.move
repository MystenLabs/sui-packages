module 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        pause: bool,
        fee_rate: u64,
        fee_recipient: address,
        vault: 0x2::bag::Bag,
        version: u64,
    }

    struct SwapContext {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        expect_amount_out: u64,
        amount_out_limit: u64,
        balances: 0x2::bag::Bag,
    }

    struct ConfirmSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        expect_amount_out: u64,
        amount_out_limit: u64,
        fee_rate: u64,
        fee_amount: u64,
    }

    struct SwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        pool_id: 0x2::object::ID,
        dex: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        amount_in_remaining: u64,
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.version <= 1, 6);
    }

    public fun collect_fee<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vault, v0)) {
            abort 8
        };
        0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, v0), arg2)
    }

    public fun confirm_swap<T0>(arg0: &mut GlobalConfig, arg1: SwapContext, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        checked_package_version(arg0);
        let SwapContext {
            quote_id          : v0,
            from              : v1,
            target            : v2,
            amount_in         : v3,
            expect_amount_out : v4,
            amount_out_limit  : v5,
            balances          : v6,
        } = arg1;
        let v7 = v6;
        let (v8, v9) = deduct_fee<T0>(arg0, 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v7, v2));
        let v10 = v8;
        assert!(0x2::balance::value<T0>(&v10) >= v5, 1);
        assert!(0x2::bag::is_empty(&v7), 2);
        0x2::bag::destroy_empty(v7);
        let v11 = ConfirmSwapEvent{
            quote_id          : v0,
            from              : v1,
            target            : v2,
            amount_in         : v3,
            amount_out        : 0x2::balance::value<T0>(&v10),
            expect_amount_out : v4,
            amount_out_limit  : v5,
            fee_rate          : arg0.fee_rate,
            fee_amount        : v9,
        };
        0x2::event::emit<ConfirmSwapEvent>(v11);
        0x2::coin::from_balance<T0>(v10, arg2)
    }

    fun deduct_fee<T0>(arg0: &mut GlobalConfig, arg1: 0x2::balance::Balance<T0>) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x2::balance::value<T0>(&arg1) * arg0.fee_rate / 1000000;
        if (v0 == 0) {
            return (arg1, 0)
        };
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v1, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v1), 0x2::balance::split<T0>(&mut arg1, v0));
        (arg1, v0)
    }

    public fun emit_swap_event<T0, T1>(arg0: &SwapContext, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwapEvent{
            quote_id            : arg0.quote_id,
            pool_id             : arg2,
            dex                 : 0x1::string::utf8(arg1),
            from                : 0x1::type_name::get<T0>(),
            target              : 0x1::type_name::get<T1>(),
            amount_in           : arg3,
            amount_out          : arg4,
            amount_in_remaining : arg5,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id            : 0x2::object::new(arg0),
            pause         : false,
            fee_rate      : 2000,
            fee_recipient : @0xcb536a1e7824e308b0cab72b2d538de80391ff990b6ae2eb75d76ef7abef5b9b,
            vault         : 0x2::bag::new(arg0),
            version       : 1,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun max_amount_in() : u64 {
        18446744073709551615
    }

    public fun merge_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg1.version < arg2, 6);
        arg1.version = arg2;
    }

    public fun new_swap_context<T0, T1>(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : SwapContext {
        checked_package_version(arg0);
        assert!(!arg0.pause, 7);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 3);
        let v1 = 0x2::bag::new(arg5);
        let v2 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1, v2, 0x2::coin::into_balance<T0>(arg4));
        SwapContext{
            quote_id          : arg1,
            from              : v2,
            target            : 0x1::type_name::get<T1>(),
            amount_in         : v0,
            expect_amount_out : arg2,
            amount_out_limit  : arg3,
            balances          : v1,
        }
    }

    public fun set_fee_rate(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 <= 100000, 5);
        arg1.fee_rate = arg2;
    }

    public fun set_fee_receiver(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert!(arg2 != arg1.fee_recipient, 4);
        arg1.fee_recipient = arg2;
    }

    public fun set_pause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.pause = arg2;
    }

    public fun take_balance<T0>(arg0: &mut SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        if (0x2::balance::value<T0>(v1) <= arg1) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::split<T0>(v1, arg1)
        }
    }

    public fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

