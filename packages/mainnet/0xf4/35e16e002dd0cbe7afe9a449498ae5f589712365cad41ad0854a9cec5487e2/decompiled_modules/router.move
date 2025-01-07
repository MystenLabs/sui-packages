module 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::router {
    struct NoneCoin {
        dummy_field: bool,
    }

    public fun get_cumulative_prices<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo) : (u128, u128, u64) {
        if (0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>()) {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_cumulative_prices<T0, T1>(arg0)
        } else {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_cumulative_prices<T1, T0>(arg0)
        }
    }

    public fun get_dao_fee<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo) : u64 {
        if (0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>()) {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_dao_fee<T0, T1>(arg0)
        } else {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_dao_fee<T1, T0>(arg0)
        }
    }

    public fun get_dao_fees_config<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo) : (u64, u64) {
        if (0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>()) {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_dao_fees_config<T0, T1>(arg0)
        } else {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_dao_fees_config<T1, T0>(arg0)
        }
    }

    public fun get_fee<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo) : u64 {
        if (0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>()) {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_fee<T0, T1>(arg0)
        } else {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_fee<T1, T0>(arg0)
        }
    }

    public fun get_fees_config<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo) : (u64, u64) {
        if (0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>()) {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_fees_config<T0, T1>(arg0)
        } else {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_fees_config<T1, T0>(arg0)
        }
    }

    public fun get_reserves_size<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo) : (u64, u64) {
        if (0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>()) {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_reserves_size<T0, T1>(arg0)
        } else {
            let (v2, v3) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_reserves_size<T1, T0>(arg0);
            (v3, v2)
        }
    }

    public fun add_liquidity<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>) {
        assert!(0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>(), 208);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 >= arg3, 203);
        assert!(v1 >= arg5, 202);
        let (v2, v3) = calc_optimal_coin_values<T0, T1>(arg0, v0, v1, arg3, arg5);
        (arg2, arg4, 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::mint<T0, T1>(arg0, arg1, 0x2::coin::split<T0>(&mut arg2, v2, arg6), 0x2::coin::split<T1>(&mut arg4, v3, arg6), arg6))
    }

    public fun calc_optimal_coin_values<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let (v0, v1) = get_reserves_size<T0, T1>(arg0);
        if (v0 == 0 && v1 == 0) {
            return (arg1, arg2)
        };
        let v2 = convert_with_current_price(arg1, v0, v1);
        if (v2 <= arg2) {
            assert!(v2 >= arg4, 202);
            return (arg1, v2)
        };
        let v3 = convert_with_current_price(arg2, v1, v0);
        assert!(v3 <= arg1, 204);
        assert!(v3 >= arg3, 203);
        (v3, arg2)
    }

    public fun convert_with_current_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 200);
        assert!(arg1 > 0 && arg2 > 0, 201);
        let v0 = (arg0 as u128) * (arg2 as u128) / (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 208);
        (v0 as u64)
    }

    public fun get_amount_in<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        get_coin_in_with_fees<T0, T1>(arg2, arg3, arg4, arg1, arg0)
    }

    public fun get_amount_out<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        get_coin_out_with_fees<T0, T1>(arg2, arg3, arg4, arg0, arg1)
    }

    fun get_coin_in_with_fees<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg3 > arg2, 202);
        let v0 = (arg2 as u128);
        0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::math::mul_div_u128(v0, (arg4 as u128) * (arg1 as u128), ((arg3 as u128) - v0) * ((arg1 - arg0) as u128)) + 1
    }

    fun get_coin_out_with_fees<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::math::mul_to_u128(arg2, arg1 - arg0);
        0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::math::mul_div_u128(v0, (arg4 as u128), 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::math::mul_to_u128(arg3, arg1) + v0)
    }

    public fun get_reserves_for_lp_coins<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LiquidityPool<T0, T1>, arg2: u64) : (u64, u64) {
        let (v0, v1) = get_reserves_size<T0, T1>(arg0);
        let v2 = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::get_lp_total<T0, T1>(arg1);
        let v3 = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::math::mul_div_u128((arg2 as u128), (v0 as u128), (v2 as u128));
        let v4 = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::math::mul_div_u128((arg2 as u128), (v1 as u128), (v2 as u128));
        assert!(v3 > 0 && v4 > 0, 200);
        (v3, v4)
    }

    public fun is_swap_exists<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo) : bool {
        0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>() && 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::is_pool_exists<T0, T1>(arg0) || 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::is_pool_exists<T1, T0>(arg0)
    }

    public fun register_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg4: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>> {
        assert!(0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>(), 208);
        0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::register<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::LPCoin<T0, T1>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>(), 208);
        let (v0, v1) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::burn<T0, T1>(arg0, arg1, arg2, arg5);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::coin::value<T0>(&v3) >= arg3, 205);
        assert!(0x2::coin::value<T1>(&v2) >= arg4, 205);
        (v3, v2)
    }

    fun swap_coin_for_coin_unchecked<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = if (0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::coin_helper::is_sorted<T0, T1>()) {
            let (v2, v3) = 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::swap<T0, T1>(arg0, arg1, arg2, arg3, 0, 0x2::coin::zero<T1>(arg5), arg4, arg5);
            (v3, v2)
        } else {
            0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::swap<T1, T0>(arg0, arg1, arg2, 0x2::coin::zero<T1>(arg5), arg4, arg3, 0, arg5)
        };
        0x2::coin::destroy_zero<T0>(v1);
        v0
    }

    public fun swap_coin_for_exact_coin<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = get_reserves_size<T0, T1>(arg0);
        let (v3, v4) = get_fees_config<T0, T1>(arg0);
        let v5 = get_amount_in<T0, T1>(v1, v2, v3, v4, arg4);
        let v6 = 0x2::coin::value<T0>(&arg3);
        assert!(v5 <= v6, 206);
        let v7 = if (v5 < v6) {
            let v8 = 0x2::coin::split<T0>(&mut arg3, v5, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
            swap_coin_for_coin_unchecked<T0, T1>(arg0, arg1, arg2, v8, arg4, arg5)
        } else {
            swap_coin_for_coin_unchecked<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v0);
    }

    public fun swap_exact_coin_for_coin<T0, T1>(arg0: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::liquidity_pool::SwapInfo, arg1: &mut 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::dao_storage::DaoStorageInfo, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = get_reserves_size<T0, T1>(arg0);
        let (v3, v4) = get_fees_config<T0, T1>(arg0);
        let v5 = get_amount_out<T0, T1>(v1, v2, v3, v4, 0x2::coin::value<T0>(&arg3));
        assert!(v5 >= arg4, 205);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(swap_coin_for_coin_unchecked<T0, T1>(arg0, arg1, arg2, arg3, v5, arg5), v0);
    }

    // decompiled from Move bytecode v6
}

