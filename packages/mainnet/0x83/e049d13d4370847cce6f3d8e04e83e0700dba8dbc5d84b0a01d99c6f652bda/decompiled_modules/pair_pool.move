module 0x83e049d13d4370847cce6f3d8e04e83e0700dba8dbc5d84b0a01d99c6f652bda::pair_pool {
    struct PairLP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PairPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<PairLP<T0, T1>>,
        locked_lp: 0x2::balance::Balance<PairLP<T0, T1>>,
        fee_bps: u64,
    }

    struct PairPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct PairSwapped has copy, drop {
        pool_id: 0x2::object::ID,
        a_to_b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    entry fun add_liquidity<T0, T1>(arg0: &mut PairPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = (0x2::balance::value<T0>(&arg0.reserve_a) as u128);
        let v3 = (0x2::balance::value<T1>(&arg0.reserve_b) as u128);
        let v4 = (0x2::balance::supply_value<PairLP<T0, T1>>(&arg0.lp_supply) as u128);
        let v5 = if (v2 > 0) {
            if (v3 > 0) {
                v4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 4);
        let v6 = (v0 as u128) * v4 / v2;
        let v7 = (v1 as u128) * v4 / v3;
        let (v8, v9, v10) = if (v6 <= v7) {
            let v11 = (v0 as u128) * v3 / v2;
            let v12 = if (v11 == 0) {
                1
            } else {
                (v11 as u64)
            };
            (v0, v12, v6)
        } else {
            let v13 = (v1 as u128) * v2 / v3;
            let v14 = if (v13 == 0) {
                1
            } else {
                (v13 as u64)
            };
            (v14, v1, v7)
        };
        let v15 = (v10 as u64);
        assert!(v15 >= arg3 && v15 > 0, 3);
        if (v8 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0 - v8, arg4), 0x2::tx_context::sender(arg4));
        };
        if (v9 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v1 - v9, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<PairLP<T0, T1>>>(0x2::coin::from_balance<PairLP<T0, T1>>(0x2::balance::increase_supply<PairLP<T0, T1>>(&mut arg0.lp_supply, v15), arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = 0x1::u128::sqrt((v0 as u128) * (v1 as u128));
        assert!(v2 > (1000 as u128), 2);
        let v3 = PairLP<T0, T1>{dummy_field: false};
        let v4 = 0x2::balance::create_supply<PairLP<T0, T1>>(v3);
        let v5 = PairPool<T0, T1>{
            id        : 0x2::object::new(arg2),
            reserve_a : 0x2::coin::into_balance<T0>(arg0),
            reserve_b : 0x2::coin::into_balance<T1>(arg1),
            lp_supply : v4,
            locked_lp : 0x2::balance::increase_supply<PairLP<T0, T1>>(&mut v4, 1000),
            fee_bps   : 30,
        };
        let v6 = PairPoolCreated{
            pool_id  : 0x2::object::id<PairPool<T0, T1>>(&v5),
            amount_a : v0,
            amount_b : v1,
        };
        0x2::event::emit<PairPoolCreated>(v6);
        0x2::transfer::share_object<PairPool<T0, T1>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PairLP<T0, T1>>>(0x2::coin::from_balance<PairLP<T0, T1>>(0x2::balance::increase_supply<PairLP<T0, T1>>(&mut v4, (v2 as u64) - 1000), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun remove_liquidity<T0, T1>(arg0: &mut PairPool<T0, T1>, arg1: 0x2::coin::Coin<PairLP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<PairLP<T0, T1>>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = (0x2::balance::supply_value<PairLP<T0, T1>>(&arg0.lp_supply) as u128);
        let v2 = (((v0 as u128) * (0x2::balance::value<T0>(&arg0.reserve_a) as u128) / v1) as u64);
        let v3 = (((v0 as u128) * (0x2::balance::value<T1>(&arg0.reserve_b) as u128) / v1) as u64);
        assert!(v2 >= arg2 && v3 >= arg3, 3);
        0x2::balance::decrease_supply<PairLP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<PairLP<T0, T1>>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v2), arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun swap_a_to_b<T0, T1>(arg0: &mut PairPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = (0x2::balance::value<T0>(&arg0.reserve_a) as u128);
        let v2 = (0x2::balance::value<T1>(&arg0.reserve_b) as u128);
        assert!(v1 > 0 && v2 > 0, 4);
        let v3 = (v0 as u128) * (10000 - 30);
        let v4 = ((v3 * v2 / (v1 * 10000 + v3)) as u64);
        assert!(v4 >= arg2 && v4 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        let v5 = PairSwapped{
            pool_id    : 0x2::object::id<PairPool<T0, T1>>(arg0),
            a_to_b     : true,
            amount_in  : v0,
            amount_out : v4,
        };
        0x2::event::emit<PairSwapped>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v4), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun swap_b_to_a<T0, T1>(arg0: &mut PairPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = (0x2::balance::value<T0>(&arg0.reserve_a) as u128);
        let v2 = (0x2::balance::value<T1>(&arg0.reserve_b) as u128);
        assert!(v1 > 0 && v2 > 0, 4);
        let v3 = (v0 as u128) * (10000 - 30);
        let v4 = ((v3 * v1 / (v2 * 10000 + v3)) as u64);
        assert!(v4 >= arg2 && v4 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        let v5 = PairSwapped{
            pool_id    : 0x2::object::id<PairPool<T0, T1>>(arg0),
            a_to_b     : false,
            amount_in  : v0,
            amount_out : v4,
        };
        0x2::event::emit<PairSwapped>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v4), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

