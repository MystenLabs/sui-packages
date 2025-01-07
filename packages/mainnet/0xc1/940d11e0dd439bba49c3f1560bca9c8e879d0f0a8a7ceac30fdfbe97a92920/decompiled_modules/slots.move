module 0xc1940d11e0dd439bba49c3f1560bca9c8e879d0f0a8a7ceac30fdfbe97a92920::slots {
    struct Slots has copy, drop, store {
        dummy_field: bool,
    }

    struct SlotsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun deposit<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>) {
        let v0 = Slots{dummy_field: false};
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::put_with_fee<T0, Slots>(arg0, v0, arg1);
    }

    public fun deposit_0<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::pipe_exists<T0, 0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SUILEND_POND>(arg0)) {
            deposit<T0>(arg0, arg1);
            return
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, arg4, arg5);
        let v0 = Slots{dummy_field: false};
        let (v1, v2) = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_changes(0x2::coin::value<T0>(&arg1));
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::put_with_fee<T0, Slots>(arg0, v0, arg1);
        0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Slots>(arg2, arg0, v1, false, v0, arg3, arg4, arg6, arg7);
        0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Slots>(arg2, arg0, v2, true, v0, arg3, arg4, arg6, arg7);
    }

    public fun deposit_bal<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: 0x2::balance::Balance<T0>) {
        let v0 = Slots{dummy_field: false};
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::join<T0, Slots>(arg0, v0, arg1);
    }

    public fun deposit_bal_0<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: 0x2::balance::Balance<T0>, arg2: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::pipe_exists<T0, 0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SUILEND_POND>(arg0)) {
            deposit_bal<T0>(arg0, arg1);
            return
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, arg4, arg5);
        let v0 = Slots{dummy_field: false};
        let (v1, v2) = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_changes(0x2::balance::value<T0>(&arg1));
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::join<T0, Slots>(arg0, v0, arg1);
        0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Slots>(arg2, arg0, v1, false, v0, arg3, arg4, arg6, arg7);
        0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Slots>(arg2, arg0, v2, true, v0, arg3, arg4, arg6, arg7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SlotsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SlotsAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw_funds<T0>(arg0: &SlotsAdminCap, arg1: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = Slots{dummy_field: false};
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::take_with_fee_reimbursement<T0, Slots>(arg1, v0, arg2, arg3)
    }

    public fun withdraw_funds_0<T0>(arg0: &SlotsAdminCap, arg1: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg2: u64, arg3: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: &0x2::clock::Clock, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (!0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::pipe_exists<T0, 0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SUILEND_POND>(arg1)) {
            return withdraw_funds<T0>(arg0, arg1, arg2, arg8)
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, arg5, arg6);
        let v0 = Slots{dummy_field: false};
        let (v1, v2) = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_changes(arg2);
        let v3 = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_balance<T0>(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::borrow_house<T0>(arg1));
        if (v1 > v3) {
            0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Slots>(arg3, arg1, v1 - v3, false, v0, arg4, arg5, arg7, arg8);
        };
        let v4 = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::house_balance<T0>(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::borrow_house<T0>(arg1));
        if (v2 > v4) {
            0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Slots>(arg3, arg1, v2 - v4, true, v0, arg4, arg5, arg7, arg8);
        };
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::take_with_fee_reimbursement<T0, Slots>(arg1, v0, arg2, arg8)
    }

    // decompiled from Move bytecode v6
}

