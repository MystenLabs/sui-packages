module 0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        pause: bool,
        fee_rate: u64,
        vault: 0x2::bag::Bag,
        version: u64,
    }

    struct ConfirmSwapEvent has copy, drop {
        sender: address,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        amount_out_limit: u64,
        fee_amount: u64,
        provider: 0x1::string::String,
    }

    struct CollectFeeEvent has copy, drop {
        collector: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SwapRequest {
        sender: address,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount: u64,
        amount_out_limit: u64,
        provider: vector<u8>,
    }

    public fun checked_package_version(arg0: &Config) {
        assert!(arg0.version <= 1, 6);
    }

    public fun checked_pause(arg0: &Config) {
        assert!(!arg0.pause, 7);
    }

    public fun collect_fee<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vault, v0)) {
            abort 8
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, v0);
        let v2 = CollectFeeEvent{
            collector : 0x2::tx_context::sender(arg2),
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<CollectFeeEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public(friend) fun deduct_fee<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0x2::coin::value<T0>(&arg1) * arg0.fee_rate / 1000000;
        if (v0 == 0) {
            return (arg1, 0)
        };
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v1, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v1), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v0, arg2)));
        (arg1, v0)
    }

    public(friend) fun destroy_swap_request(arg0: SwapRequest) : (address, 0x1::type_name::TypeName, 0x1::type_name::TypeName, u64, u64, vector<u8>) {
        let SwapRequest {
            sender           : v0,
            from             : v1,
            target           : v2,
            amount           : v3,
            amount_out_limit : v4,
            provider         : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    public(friend) fun emit_confirm_swap_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>) {
        let v0 = ConfirmSwapEvent{
            sender           : arg0,
            from             : arg1,
            target           : arg2,
            amount_in        : arg3,
            amount_out       : arg4,
            amount_out_limit : arg5,
            fee_amount       : arg6,
            provider         : 0x1::string::utf8(arg7),
        };
        0x2::event::emit<ConfirmSwapEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id       : 0x2::object::new(arg0),
            pause    : false,
            fee_rate : 2000,
            vault    : 0x2::bag::new(arg0),
            version  : 1,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg1.version < arg2, 6);
        arg1.version = arg2;
    }

    public(friend) fun new_wrap_context(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : SwapRequest {
        SwapRequest{
            sender           : 0x2::tx_context::sender(arg5),
            from             : arg0,
            target           : arg1,
            amount           : arg2,
            amount_out_limit : arg3,
            provider         : arg4,
        }
    }

    public fun set_fee_rate(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 100000, 5);
        arg1.fee_rate = arg2;
    }

    public fun set_pause(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.pause = arg2;
    }

    // decompiled from Move bytecode v6
}

