module 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter {
    public fun claim_rewards<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun create_obligation<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg1)
    }

    public fun calculate_accounted_value_delta(arg0: u128, arg1: u128) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        let v0 = arg1 - arg0;
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun calculate_ctoken_for_underlying<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u128) : u64 {
        let (v0, v1) = get_ctoken_ratio<T0, T1>(arg0);
        if (v0 == 0) {
            return (arg1 as u64)
        };
        (((arg1 * v1 + v0 - 1) / v0) as u64)
    }

    public fun calculate_max_accounted_gap(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = ((((arg0 as u128) * (5 as u128) + 9999) / 10000) as u64);
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public fun deposit<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun deposit_ctokens_to_obligation<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun get_accounting_available_liquidity<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0))
    }

    public fun get_available_liquidity<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        get_accounting_available_liquidity<T0, T1>(arg0)
    }

    public fun get_ctoken_ratio<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : (u128, u128) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T0>(v0);
        if (v1 == 0) {
            return (1000000000000000000, 1000000000000000000)
        };
        ((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<T0>(v0)) as u128), (v1 as u128))
    }

    public fun get_immediate_available_liquidity<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        0x2::balance::value<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::balances_available_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::balances<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0))))
    }

    public fun get_obligation_ctoken_amount<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(arg1)))
    }

    public fun get_underlying_balance<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64) : u128 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T0>(v0) == 0) {
            return (arg1 as u128)
        };
        (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(v0))) as u128)
    }

    public fun refresh_price<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, arg1, arg2, arg3);
    }

    public fun select_ctoken_withdraw_amount(arg0: u128, arg1: u64, arg2: u128, arg3: u128, arg4: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = ((((arg0 as u256) * (arg3 as u256) + (arg2 as u256) - 1) / (arg2 as u256)) as u128);
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_math::mul_div((arg4 as u128), arg3, arg2);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        let v4 = if (v3 > (arg1 as u128)) {
            (arg1 as u128)
        } else {
            v3
        };
        (v4 as u64)
    }

    public fun trigger_accrue<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<T0>(arg0, arg1, arg2);
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0, arg1, arg2, arg3, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4)
    }

    public fun withdraw_ctokens_from_obligation<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun withdraw_sui<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg1, &v0, arg4, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg1, v0, arg5)
    }

    // decompiled from Move bytecode v6
}

