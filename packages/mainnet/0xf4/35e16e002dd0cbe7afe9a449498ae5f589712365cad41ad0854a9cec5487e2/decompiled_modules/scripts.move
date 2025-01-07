module 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::scripts {
    public entry fun add_liquidity<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = handle_coin_obj<T0>(arg0, arg1, arg8);
        let v1 = handle_coin_obj<T1>(arg3, arg4, arg8);
        let (v2, v3, v4) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::add_liquidity<T0, T1>(arg6, arg7, v0, arg2, v1, arg5, arg8);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::tx_context::sender(arg8);
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v7);
        };
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>(v4, v7);
    }

    public entry fun register_pool<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg6: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = handle_coin_obj<T0>(arg0, arg1, arg7);
        let v1 = handle_coin_obj<T1>(arg2, arg3, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>(0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::register_pool<T0, T1>(v0, v1, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: vector<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = handle_lpcoin_obj<T0, T1>(arg0, arg1, arg6);
        let (v1, v2) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::remove_liquidity<T0, T1>(arg4, arg5, v0, arg2, arg3, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v3);
    }

    public entry fun swap_coin_for_exact_coin<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u64, arg3: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg4: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = handle_coin_obj<T0>(arg0, arg1, arg6);
        0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::swap_coin_for_exact_coin<T0, T1>(arg3, arg4, arg5, v0, arg2, arg6);
    }

    public entry fun swap_exact_coin_for_coin<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u64, arg3: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg4: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = handle_coin_obj<T0>(arg0, arg1, arg6);
        0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router::swap_exact_coin_for_coin<T0, T1>(arg3, arg4, arg5, v0, arg2, arg6);
    }

    fun handle_coin_obj<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 3);
        assert!(arg1 > 0, 4);
        let v0 = 0x2::coin::zero<T0>(arg2);
        let v1 = 0;
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0) {
            let v2 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            if (v1 < arg1) {
                let v3 = 0x2::coin::value<T0>(&v2);
                if (v3 + v1 <= arg1) {
                    0x2::coin::join<T0>(&mut v0, v2);
                    v1 = v3 + v1;
                    continue
                };
                let v4 = arg1 - v1;
                0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut v2, v4, arg2));
                v1 = v1 + v4;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
                continue
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        assert!(0x2::coin::value<T0>(&v0) == arg1, 2);
        v0
    }

    fun handle_lpcoin_obj<T0, T1>(arg0: vector<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>> {
        assert!(0x1::vector::length<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>(&arg0) > 0, 3);
        assert!(arg1 > 0, 4);
        let v0 = 0x2::coin::zero<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>(arg2);
        let v1 = 0;
        while (0x1::vector::length<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>(&arg0) > 0) {
            let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>(&mut arg0);
            if (v1 < arg1) {
                let v3 = 0x2::coin::value<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>(&v2);
                if (v3 + v1 <= arg1) {
                    0x2::coin::join<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>(&mut v0, v2);
                    v1 = v3 + v1;
                    continue
                };
                let v4 = arg1 - v1;
                0x2::coin::join<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>(&mut v0, 0x2::coin::split<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>(&mut v2, v4, arg2));
                v1 = v1 + v4;
                0x2::transfer::public_transfer<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>(v2, 0x2::tx_context::sender(arg2));
                continue
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>(v2, 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>>(arg0);
        assert!(0x2::coin::value<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>(&v0) == arg1, 2);
        v0
    }

    // decompiled from Move bytecode v6
}

