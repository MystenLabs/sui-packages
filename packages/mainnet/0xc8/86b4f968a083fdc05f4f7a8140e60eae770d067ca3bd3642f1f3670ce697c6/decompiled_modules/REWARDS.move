module 0xc886b4f968a083fdc05f4f7a8140e60eae770d067ca3bd3642f1f3670ce697c6::REWARDS {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_b_reserve: 0x2::balance::Balance<T0>,
        coin_c_reserve: 0x2::balance::Balance<T1>,
        treasury: address,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        amount_in: u64,
        amount_out_b: u64,
        amount_out_c: u64,
        coin_type_in: 0x1::string::String,
        coin_type_out_b: 0x1::string::String,
        coin_type_out_c: 0x1::string::String,
    }

    struct AddLiquidityEvent has copy, drop {
        sender: address,
        amount_b: u64,
        amount_c: u64,
        coin_type_b: 0x1::string::String,
        coin_type_c: 0x1::string::String,
    }

    struct AddCoinToFieldEvent has copy, drop {
        sender: address,
        coin_amount: u64,
        field_name: 0x1::string::String,
        coin_type: 0x1::string::String,
    }

    struct RemoveCoinFromFieldEvent has copy, drop {
        sender: address,
        coin_amount: u64,
        field_name: 0x1::string::String,
        coin_type: 0x1::string::String,
    }

    struct CoinWrapper<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun swap<T0, T1, T2>(arg0: &mut Pool<T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0 && (arg2 > 0 || arg3 > 0), 0);
        if (arg2 > 0) {
            assert!(0x2::balance::value<T1>(&arg0.coin_b_reserve) >= arg2, 1);
        };
        if (arg3 > 0) {
            assert!(0x2::balance::value<T2>(&arg0.coin_c_reserve) >= arg3, 1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_reserve, arg2), arg4), v0);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.coin_c_reserve, arg3), arg4), v0);
        };
        let v2 = SwapEvent{
            sender          : v0,
            amount_in       : v1,
            amount_out_b    : arg2,
            amount_out_c    : arg3,
            coin_type_in    : 0x1::string::utf8(b"CoinType"),
            coin_type_out_b : 0x1::string::utf8(b"CoinTypeB"),
            coin_type_out_c : 0x1::string::utf8(b"CoinTypeC"),
        };
        0x2::event::emit<SwapEvent>(v2);
    }

    public entry fun add_coin_to_field<T0, T1, T2>(arg0: &mut Pool<T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        let v0 = CoinWrapper<T0>{
            id      : 0x2::object::new(arg3),
            balance : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::dynamic_object_field::add<0x1::string::String, CoinWrapper<T0>>(&mut arg0.id, arg2, v0);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0 || v2 > 0, 0);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.coin_b_reserve, 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        if (v2 > 0) {
            0x2::balance::join<T1>(&mut arg0.coin_c_reserve, 0x2::coin::into_balance<T1>(arg2));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v0);
        };
        let v3 = AddLiquidityEvent{
            sender      : v0,
            amount_b    : v1,
            amount_c    : v2,
            coin_type_b : 0x1::string::utf8(b"CoinTypeB"),
            coin_type_c : 0x1::string::utf8(b"CoinTypeC"),
        };
        0x2::event::emit<AddLiquidityEvent>(v3);
    }

    public entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) > 0 && 0x2::coin::value<T1>(&arg1) > 0, 0);
        let v0 = Pool<T0, T1>{
            id             : 0x2::object::new(arg3),
            coin_b_reserve : 0x2::coin::into_balance<T0>(arg0),
            coin_c_reserve : 0x2::coin::into_balance<T1>(arg1),
            treasury       : arg2,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun get_pool_liquidity<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_b_reserve), 0x2::balance::value<T1>(&arg0.coin_c_reserve))
    }

    public entry fun remove_coin_from_field<T0, T1, T2>(arg0: &mut Pool<T1, T2>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let CoinWrapper {
            id      : v0,
            balance : v1,
        } = 0x2::dynamic_object_field::remove<0x1::string::String, CoinWrapper<T0>>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_with_dynamic_fields<T0, T1, T2>(arg0: &mut Pool<T1, T2>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let CoinWrapper {
            id      : v1,
            balance : v2,
        } = 0x2::dynamic_object_field::remove<0x1::string::String, CoinWrapper<T0>>(&mut arg0.id, 0x1::string::utf8(b"coin_in"));
        let v3 = 0x2::coin::from_balance<T0>(v2, arg3);
        0x2::object::delete(v1);
        let v4 = 0x2::coin::value<T0>(&v3);
        assert!(v4 > 0 && (arg1 > 0 || arg2 > 0), 0);
        if (arg1 > 0) {
            assert!(0x2::balance::value<T1>(&arg0.coin_b_reserve) >= arg1, 1);
        };
        if (arg2 > 0) {
            assert!(0x2::balance::value<T2>(&arg0.coin_c_reserve) >= arg2, 1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.treasury);
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_reserve, arg1), arg3), v0);
        };
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.coin_c_reserve, arg2), arg3), v0);
        };
        let v5 = SwapEvent{
            sender          : v0,
            amount_in       : v4,
            amount_out_b    : arg1,
            amount_out_c    : arg2,
            coin_type_in    : 0x1::string::utf8(b"CoinType"),
            coin_type_out_b : 0x1::string::utf8(b"CoinTypeB"),
            coin_type_out_c : 0x1::string::utf8(b"CoinTypeC"),
        };
        0x2::event::emit<SwapEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

