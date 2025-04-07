module 0xd7363a9e821a9546b69f4e7190f67367bc48237edb6ed517cb5076b99927dc88::integ {
    struct INTEG has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RM has store, key {
        id: 0x2::object::UID,
    }

    struct DepositValueEvent has copy, drop {
        deposited_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
    }

    struct SuilendWrapper<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    struct LendingSuilendKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_suilend<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut RM, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingSuilendKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<LendingSuilendKey>(&arg1.id, v0), 1);
        let v1 = SuilendWrapper<T0>{
            id                   : 0x2::object::new(arg2),
            obligation_owner_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg2),
        };
        let v2 = LendingSuilendKey{dummy_field: false};
        0x2::dynamic_field::add<LendingSuilendKey, SuilendWrapper<T0>>(&mut arg1.id, v2, v1);
    }

    public fun claim_rewards<T0, T1>(arg0: &RM, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = LendingSuilendKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<LendingSuilendKey>(&arg0.id, v0), 402);
        let v1 = LendingSuilendKey{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg1, &0x2::dynamic_field::borrow<LendingSuilendKey, SuilendWrapper<T0>>(&arg0.id, v1).obligation_owner_cap, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cleanup_acap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun cleanup_rm(arg0: RM) {
        let RM { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun deposit_to_suilend<T0, T1>(arg0: &RM, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingSuilendKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<LendingSuilendKey>(&arg0.id, v0), 2);
        let v1 = LendingSuilendKey{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg2, &0x2::dynamic_field::borrow<LendingSuilendKey, SuilendWrapper<T0>>(&arg0.id, v1).obligation_owner_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg4, arg3, arg5), arg5);
    }

    public fun get_total_usd_value<T0>(arg0: &RM, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        let v0 = LendingSuilendKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<LendingSuilendKey>(&arg0.id, v0), 401);
        let v1 = LendingSuilendKey{dummy_field: false};
        let v2 = DepositValueEvent{deposited_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&0x2::dynamic_field::borrow<LendingSuilendKey, SuilendWrapper<T0>>(&arg0.id, v1).obligation_owner_cap)))};
        0x2::event::emit<DepositValueEvent>(v2);
    }

    fun init(arg0: INTEG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_rm(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RM{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RM>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun unwrap<T0>(arg0: &mut RM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingSuilendKey{dummy_field: false};
        let SuilendWrapper {
            id                   : v1,
            obligation_owner_cap : v2,
        } = 0x2::dynamic_field::remove<LendingSuilendKey, SuilendWrapper<T0>>(&mut arg0.id, v0);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v2, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v1);
    }

    public fun withdraw_from_suilend<T0, T1>(arg0: &RM, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = LendingSuilendKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<LendingSuilendKey>(&arg0.id, v0), 3);
        let v1 = LendingSuilendKey{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg3, arg4, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T1>(arg2, arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg3, &0x2::dynamic_field::borrow<LendingSuilendKey, SuilendWrapper<T0>>(&arg0.id, v1).obligation_owner_cap, arg4, arg1, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6), arg6)
    }

    public fun withdraw_sui_from_suilend<T0>(arg0: &RM, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = LendingSuilendKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<LendingSuilendKey>(&arg0.id, v0), 3);
        let v1 = LendingSuilendKey{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg3, arg4, arg6);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg2, arg3, &0x2::dynamic_field::borrow<LendingSuilendKey, SuilendWrapper<T0>>(&arg0.id, v1).obligation_owner_cap, arg4, arg1, arg7), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg2, arg3, &v2, arg5, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg3, v2, arg7)
    }

    // decompiled from Move bytecode v6
}

