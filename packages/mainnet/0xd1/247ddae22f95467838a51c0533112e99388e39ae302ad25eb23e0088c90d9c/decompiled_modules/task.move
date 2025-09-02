module 0xd1247ddae22f95467838a51c0533112e99388e39ae302ad25eb23e0088c90d9c::task {
    struct TreasuryRegistry has key {
        id: 0x2::object::UID,
        official_treasury_id: 0x2::object::ID,
        admin: address,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        admin: address,
        balances: 0x2::bag::Bag,
    }

    struct CheckInEvent has copy, drop {
        user_id: u64,
        sender: address,
    }

    struct RechargeEvent has copy, drop {
        order_id: u64,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        receiver: address,
    }

    struct TreasuryCreatedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        admin: address,
    }

    public fun check_in(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != 0, 2);
        let v0 = CheckInEvent{
            user_id : arg0,
            sender  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CheckInEvent>(v0);
    }

    public fun contains_coin_type<T0>(arg0: &TreasuryRegistry, arg1: &Treasury) : bool {
        assert!(0x2::object::id<Treasury>(arg1) == arg0.official_treasury_id, 5);
        0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, 0x1::type_name::get<T0>())
    }

    public fun get_admin(arg0: &TreasuryRegistry, arg1: &Treasury) : address {
        assert!(0x2::object::id<Treasury>(arg1) == arg0.official_treasury_id, 5);
        arg1.admin
    }

    public fun get_balance<T0>(arg0: &TreasuryRegistry, arg1: &Treasury) : u64 {
        assert!(0x2::object::id<Treasury>(arg1) == arg0.official_treasury_id, 5);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, v0))
        } else {
            0
        }
    }

    public fun get_official_treasury_id(arg0: &TreasuryRegistry) : 0x2::object::ID {
        arg0.official_treasury_id
    }

    public fun get_registry_admin(arg0: &TreasuryRegistry) : address {
        arg0.admin
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id       : 0x2::object::new(arg0),
            admin    : @0x724f4f8920bc2b06619c865ffc03af2dc004c434c37de46948e3bedc22b5919a,
            balances : 0x2::bag::new(arg0),
        };
        let v1 = 0x2::object::id<Treasury>(&v0);
        let v2 = TreasuryRegistry{
            id                   : 0x2::object::new(arg0),
            official_treasury_id : v1,
            admin                : @0x724f4f8920bc2b06619c865ffc03af2dc004c434c37de46948e3bedc22b5919a,
        };
        0x2::transfer::share_object<Treasury>(v0);
        0x2::transfer::share_object<TreasuryRegistry>(v2);
        let v3 = TreasuryCreatedEvent{
            treasury_id : v1,
            registry_id : 0x2::object::id<TreasuryRegistry>(&v2),
            admin       : @0x724f4f8920bc2b06619c865ffc03af2dc004c434c37de46948e3bedc22b5919a,
        };
        0x2::event::emit<TreasuryCreatedEvent>(v3);
    }

    public fun recharge<T0>(arg0: &TreasuryRegistry, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Treasury>(arg1) == arg0.official_treasury_id, 5);
        assert!(arg4 > 0, 1);
        assert!(0x2::coin::value<T0>(arg3) >= arg4, 3);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg3, arg4, arg5)));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg3, arg4, arg5)));
        };
        let v1 = RechargeEvent{
            order_id  : arg2,
            amount    : arg4,
            coin_type : v0,
            sender    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RechargeEvent>(v1);
    }

    public fun withdraw<T0>(arg0: &TreasuryRegistry, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Treasury>(arg1) == arg0.official_treasury_id, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 4);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v1), 3);
        let v2 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, v1));
        assert!(v2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v1), arg2), v0);
        let v3 = WithdrawEvent{
            amount    : v2,
            coin_type : v1,
            receiver  : v0,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

