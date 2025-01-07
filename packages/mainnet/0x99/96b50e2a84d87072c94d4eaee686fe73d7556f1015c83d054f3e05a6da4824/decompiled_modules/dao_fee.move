module 0x9996b50e2a84d87072c94d4eaee686fe73d7556f1015c83d054f3e05a6da4824::dao_fee {
    struct DaoFeeInfo has key {
        id: 0x2::object::UID,
    }

    struct DaoFee<phantom T0, phantom T1> has store {
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
    }

    struct FeeCreatedEvent<phantom T0, phantom T1> has copy, drop {
        dummy_field: bool,
    }

    struct CoinDepositedEvent<phantom T0, phantom T1> has copy, drop {
        x_val: u64,
        y_val: u64,
    }

    struct CoinWithdrawnEvent<phantom T0, phantom T1> has copy, drop {
        x_val: u64,
        y_val: u64,
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut DaoFeeInfo, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<DaoFee<T0, T1>>())), 401);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, DaoFee<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<DaoFee<T0, T1>>()));
        0x2::balance::join<T0>(&mut v0.coin_x, arg1);
        0x2::balance::join<T1>(&mut v0.coin_y, arg2);
        let v1 = CoinDepositedEvent<T0, T1>{
            x_val : 0x2::balance::value<T0>(&arg1),
            y_val : 0x2::balance::value<T1>(&arg2),
        };
        0x2::event::emit<CoinDepositedEvent<T0, T1>>(v1);
    }

    public(friend) fun getBalance<T0, T1>(arg0: &mut DaoFeeInfo) : (u64, u64) {
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<DaoFee<T0, T1>>())), 401);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, DaoFee<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<DaoFee<T0, T1>>()));
        (0x2::balance::value<T0>(&v0.coin_x), 0x2::balance::value<T1>(&v0.coin_y))
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DaoFeeInfo{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<DaoFeeInfo>(v0);
    }

    public(friend) fun register<T0, T1>(arg0: &mut DaoFeeInfo) {
        let v0 = DaoFee<T0, T1>{
            coin_x : 0x2::balance::zero<T0>(),
            coin_y : 0x2::balance::zero<T1>(),
        };
        assert!(!0x2::dynamic_field::exists_<0x1::ascii::String>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<DaoFee<T0, T1>>())), 402);
        0x2::dynamic_field::add<0x1::ascii::String, DaoFee<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<DaoFee<T0, T1>>()), v0);
        let v1 = FeeCreatedEvent<T0, T1>{dummy_field: false};
        0x2::event::emit<FeeCreatedEvent<T0, T1>>(v1);
    }

    public fun withdraw<T0, T1>(arg0: &mut DaoFeeInfo, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg3) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 402);
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<DaoFee<T0, T1>>())), 401);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, DaoFee<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<DaoFee<T0, T1>>()));
        let v1 = CoinWithdrawnEvent<T0, T1>{
            x_val : arg1,
            y_val : arg2,
        };
        0x2::event::emit<CoinWithdrawnEvent<T0, T1>>(v1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.coin_x, arg1), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.coin_y, arg2), arg3))
    }

    // decompiled from Move bytecode v6
}

