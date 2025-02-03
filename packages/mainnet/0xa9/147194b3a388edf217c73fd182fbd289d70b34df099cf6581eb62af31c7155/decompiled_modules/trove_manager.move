module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager {
    struct Deposit<phantom T0> has copy, drop {
        user: address,
        amount: u64,
        source: 0x1::string::String,
        from: 0x1::option::Option<address>,
    }

    struct Withdraw<phantom T0> has copy, drop {
        user: address,
        amount: u64,
    }

    struct TroveManager has key {
        id: 0x2::object::UID,
        trove_map: 0x2::table::Table<address, 0x2::bag::Bag>,
    }

    fun borrow_user_trove_balance_mut<T0>(arg0: &mut TroveManager, arg1: address) : &mut 0x2::balance::Balance<T0> {
        let v0 = &mut arg0.trove_map;
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(v0, arg1), 3);
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(v0, arg1);
        let v2 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(v1, v2), 4);
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v2)
    }

    public fun get_trove_value<T0>(arg0: &TroveManager, arg1: address) : u64 {
        let v0 = &arg0.trove_map;
        if (!0x2::table::contains<address, 0x2::bag::Bag>(v0, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow<address, 0x2::bag::Bag>(v0, arg1);
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v1, v2)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TroveManager{
            id        : 0x2::object::new(arg0),
            trove_map : 0x2::table::new<address, 0x2::bag::Bag>(arg0),
        };
        0x2::transfer::share_object<TroveManager>(v0);
    }

    fun put_coin_into_trove<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0)) {
            0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public(friend) fun put_coin_into_user_trove<T0>(arg0: &mut TroveManager, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.trove_map;
        if (!0x2::table::contains<address, 0x2::bag::Bag>(v0, arg1)) {
            0x2::table::add<address, 0x2::bag::Bag>(v0, arg1, 0x2::bag::new(arg5));
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(v0, arg1);
        put_coin_into_trove<T0>(v1, arg2);
        let v2 = Deposit<T0>{
            user   : arg1,
            amount : 0x2::coin::value<T0>(&arg2),
            source : 0x1::string::utf8(arg3),
            from   : arg4,
        };
        0x2::event::emit<Deposit<T0>>(v2);
    }

    public fun take_all_from_trove<T0>(arg0: &mut TroveManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = get_trove_value<T0>(arg0, v0);
        if (v1 > 0) {
            let v3 = Withdraw<T0>{
                user   : v0,
                amount : v1,
            };
            0x2::event::emit<Withdraw<T0>>(v3);
            0x2::coin::take<T0>(borrow_user_trove_balance_mut<T0>(arg0, v0), v1, arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        }
    }

    public fun take_coin_from_trove<T0>(arg0: &mut TroveManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(get_trove_value<T0>(arg0, v0) >= arg1, 2);
        let v1 = Withdraw<T0>{
            user   : v0,
            amount : arg1,
        };
        0x2::event::emit<Withdraw<T0>>(v1);
        0x2::coin::take<T0>(borrow_user_trove_balance_mut<T0>(arg0, v0), arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

