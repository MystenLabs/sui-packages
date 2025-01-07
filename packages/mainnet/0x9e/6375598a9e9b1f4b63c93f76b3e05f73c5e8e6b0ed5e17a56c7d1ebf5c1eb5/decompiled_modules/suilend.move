module 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::suilend {
    struct SuilendObligationKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CloseReceipt {
        deposits: 0x2::vec_map::VecMap<u64, u64>,
    }

    public fun check_exist_obligation_cap<T0, T1, T2>(arg0: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>) : bool {
        let v0 = SuilendObligationKey<T2>{dummy_field: false};
        0x2::bag::contains<SuilendObligationKey<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets<T0, T1>(arg0), v0)
    }

    public fun claim_rewards<T0, T1, T2, T3>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendObligationKey<T2>{dummy_field: false};
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, T3>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, T3>(arg0);
        };
        0x2::balance::join<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T3>(arg0)), 0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T2, T3>(arg1, 0x2::bag::borrow<SuilendObligationKey<T2>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets<T0, T1>(arg0), v0), arg2, arg3, arg4, arg5, arg6)));
    }

    public fun close_asset<T0, T1, T2, T3>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &mut CloseReceipt, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendObligationKey<T2>{dummy_field: false};
        let (_, v2) = 0x2::vec_map::remove<u64, u64>(&mut arg1.deposits, &arg3);
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, T3>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, T3>(arg0);
        };
        0x2::balance::join<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T3>(arg0)), 0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T2, T3>(arg2, arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T2, T3>(arg2, arg3, 0x2::bag::borrow<SuilendObligationKey<T2>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets<T0, T1>(arg0), v0), arg4, v2, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T2, T3>>(), arg5)));
    }

    public fun deposit<T0, T1, T2, T3>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AdminCap<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_locked_period<T0, T1>(arg0, arg5);
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, T3>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, T3>(arg0);
        };
        if (!check_exist_obligation_cap<T0, T1, T2>(arg0)) {
            let v0 = SuilendObligationKey<T2>{dummy_field: false};
            0x2::bag::add<SuilendObligationKey<T2>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T2>(arg3, arg6));
        };
        let v1 = SuilendObligationKey<T2>{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T2, T3>(arg3, arg4, 0x2::bag::borrow<SuilendObligationKey<T2>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets<T0, T1>(arg0), v1), arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T2, T3>(arg3, arg4, arg5, 0x2::coin::from_balance<T3>(0x2::balance::split<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T3>(arg0)), arg2), arg6), arg6), arg6);
    }

    public fun finalize_close<T0, T1, T2>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: CloseReceipt) {
        let CloseReceipt { deposits: v0 } = arg1;
        assert!(0x2::vec_map::is_empty<u64, u64>(&v0), 101);
        let v1 = SuilendObligationKey<T2>{dummy_field: false};
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(0x2::bag::remove<SuilendObligationKey<T2>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v1), @0xb3fc768f8bb3c772321e3e7781cac4a45585b4bc64043686beb634d65341798);
    }

    public fun initialize_close<T0, T1, T2>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg2: &0x2::clock::Clock) : CloseReceipt {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_withdraw_time<T0, T1>(arg0, arg2);
        let v0 = if (check_exist_obligation_cap<T0, T1, T2>(arg0)) {
            let v1 = SuilendObligationKey<T2>{dummy_field: false};
            let v2 = 0x2::vec_map::empty<u64, u64>();
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(0x2::bag::borrow<SuilendObligationKey<T2>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets<T0, T1>(arg0), v1))));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v3)) {
                let v5 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v3, v4);
                0x2::vec_map::insert<u64, u64>(&mut v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v5), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(v5));
                v4 = v4 + 1;
            };
            v2
        } else {
            0x2::vec_map::empty<u64, u64>()
        };
        CloseReceipt{deposits: v0}
    }

    public fun withdraw<T0, T1, T2, T3>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AdminCap<T1>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_locked_period<T0, T1>(arg0, arg5);
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, T3>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, T3>(arg0);
        };
        let v0 = SuilendObligationKey<T2>{dummy_field: false};
        0x2::balance::join<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T3>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T3>(arg0)), 0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T2, T3>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T2, T3>(arg3, arg4, 0x2::bag::borrow<SuilendObligationKey<T2>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets<T0, T1>(arg0), v0), arg5, arg2, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T2, T3>>(), arg6)));
    }

    // decompiled from Move bytecode v6
}

