module 0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond {
    struct SUILEND_POND has drop {
        dummy_field: bool,
    }

    struct SuilendPond<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    public fun claim_interest<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SUILEND_POND{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::collect<T1, SUILEND_POND>(arg1, v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg3, &arg0.cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.cap))) - 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::debt_value<T1, SUILEND_POND>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_pipe<T1, SUILEND_POND>(arg1))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg2)))), arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5));
    }

    public fun claim_reward<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SUILEND_POND{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::collect<T1, SUILEND_POND>(arg1, v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg2, &arg0.cap, arg5, arg3, arg4, true, arg6));
    }

    public fun create_pond<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendPond<T0, T1>{
            id  : 0x2::object::new(arg2),
            cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg2),
        };
        0x2::transfer::share_object<SuilendPond<T0, T1>>(v0);
    }

    public fun deposit<T0, T1, T2: drop>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg2: u64, arg3: bool, arg4: T2, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_game_supported<T1, T2>(arg1);
        deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
    }

    public fun deposit_by_manager<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg2: u64, arg3: bool, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_valid_manager<SUILEND_POND>(arg1, 0x2::tx_context::sender(arg7));
        deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun deposit_internal<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg2: u64, arg3: bool, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3) {
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::output_from_house<T1, SUILEND_POND>(arg1, arg2)
        } else {
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::output<T1, SUILEND_POND>(arg1, arg2)
        };
        let v1 = SUILEND_POND{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg4, arg6, &arg0.cap, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg4, arg6, arg5, 0x2::coin::from_balance<T1>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::destroy_output_carrier<T1, SUILEND_POND>(v0, v1), arg7), arg7), arg7);
    }

    public fun repay<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_valid_manager<SUILEND_POND>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = SUILEND_POND{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::input<T0, SUILEND_POND>(arg0, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::input<T0, SUILEND_POND>(0x2::coin::into_balance<T0>(arg1), v0));
    }

    public fun withdraw<T0, T1, T2: drop>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg2: u64, arg3: bool, arg4: T2, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_game_supported<T1, T2>(arg1);
        withdraw_internal<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
    }

    public fun withdraw_by_manager<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg2: u64, arg3: bool, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_valid_manager<SUILEND_POND>(arg1, 0x2::tx_context::sender(arg7));
        withdraw_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun withdraw_internal<T0, T1>(arg0: &SuilendPond<T0, T1>, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg2: u64, arg3: bool, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = SUILEND_POND{dummy_field: false};
        if (arg3) {
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::input_to_house<T1, SUILEND_POND>(arg1, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::input<T1, SUILEND_POND>(0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg4, arg6, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg4, arg6, &arg0.cap, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg4)))), arg7), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg7)), v0));
        } else {
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::input<T1, SUILEND_POND>(arg1, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::input<T1, SUILEND_POND>(0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg4, arg6, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg4, arg6, &arg0.cap, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg4)))), arg7), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg7)), v0));
        };
    }

    // decompiled from Move bytecode v6
}

