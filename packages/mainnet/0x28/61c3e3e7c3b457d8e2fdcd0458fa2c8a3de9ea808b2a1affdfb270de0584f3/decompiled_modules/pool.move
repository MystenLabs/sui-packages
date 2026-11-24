module 0x2861c3e3e7c3b457d8e2fdcd0458fa2c8a3de9ea808b2a1affdfb270de0584f3::pool {
    struct LP<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<T0>,
        lp_supply: 0x2::balance::Supply<LP<T0>>,
        locked_lp: 0x2::balance::Balance<LP<T0>>,
        fee_bps: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        sui_amount: u64,
        token_amount: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        sui_to_token: bool,
        amount_in: u64,
        amount_out: u64,
    }

    entry fun add_liquidity<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128);
        let v3 = (0x2::balance::value<T0>(&arg0.token_reserve) as u128);
        let v4 = (0x2::balance::supply_value<LP<T0>>(&arg0.lp_supply) as u128);
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
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - v8, arg4), 0x2::tx_context::sender(arg4));
        };
        if (v9 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v1 - v9, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0>>>(0x2::coin::from_balance<LP<T0>>(0x2::balance::increase_supply<LP<T0>>(&mut arg0.lp_supply, v15), arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun create_pool<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = 0x1::u128::sqrt((v0 as u128) * (v1 as u128));
        assert!(v2 > (1000 as u128), 2);
        let v3 = LP<T0>{dummy_field: false};
        let v4 = 0x2::balance::create_supply<LP<T0>>(v3);
        let v5 = Pool<T0>{
            id            : 0x2::object::new(arg2),
            sui_reserve   : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            token_reserve : 0x2::coin::into_balance<T0>(arg1),
            lp_supply     : v4,
            locked_lp     : 0x2::balance::increase_supply<LP<T0>>(&mut v4, 1000),
            fee_bps       : 30,
        };
        let v6 = PoolCreated{
            pool_id      : 0x2::object::id<Pool<T0>>(&v5),
            sui_amount   : v0,
            token_amount : v1,
        };
        0x2::event::emit<PoolCreated>(v6);
        0x2::transfer::share_object<Pool<T0>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0>>>(0x2::coin::from_balance<LP<T0>>(0x2::balance::increase_supply<LP<T0>>(&mut v4, (v2 as u64) - 1000), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun remove_liquidity<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<LP<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LP<T0>>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = (0x2::balance::supply_value<LP<T0>>(&arg0.lp_supply) as u128);
        let v2 = (((v0 as u128) * (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128) / v1) as u64);
        let v3 = (((v0 as u128) * (0x2::balance::value<T0>(&arg0.token_reserve) as u128) / v1) as u64);
        assert!(v2 >= arg2 && v3 >= arg3, 3);
        0x2::balance::decrease_supply<LP<T0>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0>>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v2), arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v3), arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun swap_sui_to_token<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128);
        let v2 = (0x2::balance::value<T0>(&arg0.token_reserve) as u128);
        assert!(v1 > 0 && v2 > 0, 4);
        let v3 = (v0 as u128) * (10000 - 30);
        let v4 = ((v3 * v2 / (v1 * 10000 + v3)) as u64);
        assert!(v4 >= arg2 && v4 > 0, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v5 = Swapped{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            sui_to_token : true,
            amount_in    : v0,
            amount_out   : v4,
        };
        0x2::event::emit<Swapped>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v4), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun swap_token_to_sui<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128);
        let v2 = (0x2::balance::value<T0>(&arg0.token_reserve) as u128);
        assert!(v1 > 0 && v2 > 0, 4);
        let v3 = (v0 as u128) * (10000 - 30);
        let v4 = ((v3 * v1 / (v2 * 10000 + v3)) as u64);
        assert!(v4 >= arg2 && v4 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v5 = Swapped{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            sui_to_token : false,
            amount_in    : v0,
            amount_out   : v4,
        };
        0x2::event::emit<Swapped>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v4), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

