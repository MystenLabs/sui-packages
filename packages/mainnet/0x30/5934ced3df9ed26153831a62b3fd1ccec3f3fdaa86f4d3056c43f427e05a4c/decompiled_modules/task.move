module 0x305934ced3df9ed26153831a62b3fd1ccec3f3fdaa86f4d3056c43f427e05a4c::task {
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

    struct Treasury has key {
        id: 0x2::object::UID,
        admin: address,
        balances: 0x2::bag::Bag,
    }

    public fun check_in(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != 0, 3);
        let v0 = CheckInEvent{
            user_id : arg0,
            sender  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CheckInEvent>(v0);
    }

    public fun contains_coin_type<T0>(arg0: &Treasury) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())
    }

    public fun create_treasury(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id       : 0x2::object::new(arg1),
            admin    : arg0,
            balances : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun get_balance<T0>(arg0: &Treasury) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun recharge<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 4);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4)));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4)));
        };
        let v1 = RechargeEvent{
            order_id  : arg1,
            amount    : arg3,
            coin_type : v0,
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RechargeEvent>(v1);
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1), 4);
        let v2 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v1));
        assert!(v2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), arg1), v0);
        let v3 = WithdrawEvent{
            amount    : v2,
            coin_type : v1,
            receiver  : v0,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

