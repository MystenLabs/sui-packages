module 0x7310ef1552c1a769101b11e897a1b58f5d3d69cb06797555b86116e6b74ed22c::pond {
    struct SUILEND_POND has drop {
        dummy_field: bool,
    }

    struct SuilendPond<phantom T0> has key {
        id: 0x2::object::UID,
        cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    public fun claim<T0, T1>(arg0: &SuilendPond<T0>, arg1: &mut 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::Unihouse, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SUILEND_POND{dummy_field: false};
        0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::collect<T1, SUILEND_POND>(arg1, v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg2, &arg0.cap, arg5, arg3, arg4, true, arg6));
    }

    public fun create_pond<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendPond<T0>{
            id  : 0x2::object::new(arg2),
            cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg2),
        };
        0x2::transfer::share_object<SuilendPond<T0>>(v0);
    }

    public fun deposit<T0, T1, T2: drop>(arg0: &SuilendPond<T0>, arg1: &mut 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::Unihouse, arg2: u64, arg3: T2, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::assert_game_supported<T1, T2>(arg1);
        deposit_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun deposit_by_manager<T0, T1>(arg0: &SuilendPond<T0>, arg1: &mut 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::Unihouse, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::assert_valid_manager<SUILEND_POND>(arg1, 0x2::tx_context::sender(arg6));
        deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun deposit_internal<T0, T1>(arg0: &SuilendPond<T0>, arg1: &mut 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::Unihouse, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SUILEND_POND{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg5, &arg0.cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg5, arg4, 0x2::coin::from_balance<T1>(0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::pipe::destroy_output_carrier<T1, SUILEND_POND>(0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::output<T1, SUILEND_POND>(arg1, arg2), v0), arg6), arg6), arg6);
    }

    public fun repay<T0>(arg0: &mut 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::assert_valid_manager<SUILEND_POND>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = SUILEND_POND{dummy_field: false};
        0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::input<T0, SUILEND_POND>(arg0, 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::pipe::input<T0, SUILEND_POND>(0x2::coin::into_balance<T0>(arg1), v0));
    }

    public fun withdraw<T0, T1, T2: drop>(arg0: &SuilendPond<T0>, arg1: &mut 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::Unihouse, arg2: u64, arg3: T2, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::assert_game_supported<T1, T2>(arg1);
        withdraw_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun withdraw_by_manager<T0, T1, T2: drop>(arg0: &SuilendPond<T0>, arg1: &mut 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::Unihouse, arg2: u64, arg3: T2, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::assert_valid_manager<SUILEND_POND>(arg1, 0x2::tx_context::sender(arg7));
        withdraw_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    fun withdraw_internal<T0, T1>(arg0: &SuilendPond<T0>, arg1: &mut 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::Unihouse, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SUILEND_POND{dummy_field: false};
        0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::unihouse::input<T1, SUILEND_POND>(arg1, 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::pipe::input<T1, SUILEND_POND>(0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg4, &arg0.cap, arg5, arg2, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6)), v0));
    }

    // decompiled from Move bytecode v6
}

