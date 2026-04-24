module 0xca99c5a57f482baae2c9e3f76d8b8010b44563e6ab8e6cfe6b50def2b7fde9ca::r {
    struct R has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        access_list: vector<address>,
        total_swaps: u64,
        total_profit: u64,
    }

    struct SwapEvent has copy, drop {
        dex: u8,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    fun access_check(arg0: &R, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.access_list, &v0), 1);
    }

    public fun admin(arg0: &R) : address {
        arg0.admin
    }

    fun admin_check(arg0: &R, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
    }

    public fun assert_min_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 6);
    }

    fun emit_swap_and_count(arg0: &mut R, arg1: u8, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = SwapEvent{
            dex        : arg1,
            a2b        : arg2,
            amount_in  : arg3,
            amount_out : arg4,
        };
        0x2::event::emit<SwapEvent>(v0);
        arg0.total_swaps = arg0.total_swaps + 1;
    }

    public fun grant_access(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        let v0 = &mut arg0.access_list;
        grant_access_if_absent(v0, arg1);
    }

    fun grant_access_if_absent(arg0: &mut vector<address>, arg1: address) {
        if (!0x1::vector::contains<address>(arg0, &arg1)) {
            0x1::vector::push_back<address>(arg0, arg1);
        };
    }

    public fun haedal_pmm_a2b<T0, T1>(arg0: &mut R, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg6);
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x2::coin::from_balance<T0>(arg4, arg6);
        0x2::coin::destroy_zero<T0>(v1);
        let v2 = 0x2::coin::into_balance<T1>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg1, arg5, arg2, arg3, &mut v1, v0, 0, arg6));
        emit_swap_and_count(arg0, 20, true, v0, 0x2::balance::value<T1>(&v2));
        v2
    }

    public fun haedal_pmm_b2a<T0, T1>(arg0: &mut R, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg6);
        let v0 = 0x2::balance::value<T1>(&arg4);
        let v1 = 0x2::coin::from_balance<T1>(arg4, arg6);
        0x2::coin::destroy_zero<T1>(v1);
        let v2 = 0x2::coin::into_balance<T0>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg1, arg5, arg2, arg3, &mut v1, v0, 0, arg6));
        emit_swap_and_count(arg0, 20, false, v0, 0x2::balance::value<T0>(&v2));
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        r_new(arg0);
    }

    fun kiosk_v3_link(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::kiosk_lock_rule::Rule) {
        abort 0
    }

    public fun migrate(arg0: &mut R, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    public fun obric_a2b<T0, T1>(arg0: &mut R, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg7);
        let v0 = 0x2::coin::into_balance<T1>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg1, arg6, arg2, arg3, arg4, 0x2::coin::from_balance<T0>(arg5, arg7), arg7));
        emit_swap_and_count(arg0, 21, true, 0x2::balance::value<T0>(&arg5), 0x2::balance::value<T1>(&v0));
        v0
    }

    public fun obric_b2a<T0, T1>(arg0: &mut R, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg7);
        let v0 = 0x2::coin::into_balance<T0>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg1, arg6, arg2, arg3, arg4, 0x2::coin::from_balance<T1>(arg5, arg7), arg7));
        emit_swap_and_count(arg0, 21, false, 0x2::balance::value<T1>(&arg5), 0x2::balance::value<T0>(&v0));
        v0
    }

    fun phantom_dep_anchor(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: &0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext) {
        abort 0
    }

    public fun r_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = R{
            id           : 0x2::object::new(arg0),
            version      : 1,
            admin        : 0x2::tx_context::sender(arg0),
            access_list  : v0,
            total_swaps  : 0,
            total_profit : 0,
        };
        0x2::transfer::share_object<R>(v1);
    }

    public fun revoke_access(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        let v0 = &mut arg0.access_list;
        revoke_all_access_entries(v0, arg1);
    }

    fun revoke_all_access_entries(arg0: &mut vector<address>, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(arg0, &arg1);
        let v2 = v0;
        let v3 = v1;
        while (v2) {
            0x1::vector::remove<address>(arg0, v3);
            let (v4, v5) = 0x1::vector::index_of<address>(arg0, &arg1);
            v2 = v4;
            v3 = v5;
        };
    }

    public fun steamm_omm_v2_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut R, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: u64, arg7: u64, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: 0x2::balance::Balance<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        access_check(arg0, arg12);
        let v0 = 0x2::balance::value<T1>(&arg10);
        let v1 = 0x2::coin::from_balance<T1>(arg10, arg12);
        let v2 = 0x2::coin::zero<T2>(arg12);
        0x87b4289a2d040d37a05fa7839267c2b579d9437c4ba1a4a35c681f80431d9233::steamm_omm_v2::omm_swap_v2_<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg5, arg8, arg6, arg11), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg5, arg9, arg7, arg11), &mut v1, &mut v2, true, v0, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::into_balance<T2>(v2);
        emit_swap_and_count(arg0, 22, true, v0, 0x2::balance::value<T2>(&v3));
        v3
    }

    public fun steamm_omm_v2_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut R, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: u64, arg7: u64, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: 0x2::balance::Balance<T2>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg12);
        let v0 = 0x2::balance::value<T2>(&arg10);
        let v1 = 0x2::coin::zero<T1>(arg12);
        let v2 = 0x2::coin::from_balance<T2>(arg10, arg12);
        0x87b4289a2d040d37a05fa7839267c2b579d9437c4ba1a4a35c681f80431d9233::steamm_omm_v2::omm_swap_v2_<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg5, arg8, arg6, arg11), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg5, arg9, arg7, arg11), &mut v1, &mut v2, false, v0, arg11, arg12);
        0x2::coin::destroy_zero<T2>(v2);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        emit_swap_and_count(arg0, 22, false, v0, 0x2::balance::value<T1>(&v3));
        v3
    }

    public fun total_profit(arg0: &R) : u64 {
        arg0.total_profit
    }

    public fun total_swaps(arg0: &R) : u64 {
        arg0.total_swaps
    }

    public fun transfer_admin(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        arg0.admin = arg1;
    }

    public fun version(arg0: &R) : u64 {
        arg0.version
    }

    public fun zofai_slp_a2b<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut R, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: 0x2::balance::Balance<T1>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T6> {
        access_check(arg0, arg17);
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::create_vaults_valuation<T0>(arg16, arg1);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T1>(arg1, arg3, arg4, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T2>(arg1, arg5, arg6, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T3>(arg1, arg7, arg8, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T4>(arg1, arg9, arg10, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T5>(arg1, arg11, arg12, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T6>(arg1, arg13, arg14, &mut v0);
        let v1 = 0x2::coin::into_balance<T6>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::swap_v2_ptb<T0, T1, T6>(arg1, arg2, 0x2::coin::from_balance<T1>(arg15, arg17), 0, v0, arg4, arg14, arg17));
        emit_swap_and_count(arg0, 19, true, 0x2::balance::value<T1>(&arg15), 0x2::balance::value<T6>(&v1));
        v1
    }

    public fun zofai_slp_b2a<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut R, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: 0x2::balance::Balance<T6>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg17);
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::create_vaults_valuation<T0>(arg16, arg1);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T1>(arg1, arg3, arg4, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T2>(arg1, arg5, arg6, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T3>(arg1, arg7, arg8, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T4>(arg1, arg9, arg10, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T5>(arg1, arg11, arg12, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T6>(arg1, arg13, arg14, &mut v0);
        let v1 = 0x2::coin::into_balance<T1>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::swap_v2_ptb<T0, T6, T1>(arg1, arg2, 0x2::coin::from_balance<T6>(arg15, arg17), 0, v0, arg14, arg4, arg17));
        emit_swap_and_count(arg0, 19, false, 0x2::balance::value<T6>(&arg15), 0x2::balance::value<T1>(&v1));
        v1
    }

    public fun zofai_zlp_a2b<T0, T1, T2, T3, T4>(arg0: &mut R, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: 0x2::balance::Balance<T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        access_check(arg0, arg13);
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::create_vaults_valuation<T0>(arg12, arg1);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T1>(arg1, arg3, arg4, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T2>(arg1, arg5, arg6, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T3>(arg1, arg7, arg8, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T4>(arg1, arg9, arg10, &mut v0);
        let v1 = 0x2::coin::into_balance<T3>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::swap_v2_ptb<T0, T1, T3>(arg1, arg2, 0x2::coin::from_balance<T1>(arg11, arg13), 0, v0, arg4, arg8, arg13));
        emit_swap_and_count(arg0, 19, true, 0x2::balance::value<T1>(&arg11), 0x2::balance::value<T3>(&v1));
        v1
    }

    public fun zofai_zlp_b2a<T0, T1, T2, T3, T4>(arg0: &mut R, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: 0x2::balance::Balance<T3>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg13);
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::create_vaults_valuation<T0>(arg12, arg1);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T1>(arg1, arg3, arg4, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T2>(arg1, arg5, arg6, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T3>(arg1, arg7, arg8, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T4>(arg1, arg9, arg10, &mut v0);
        let v1 = 0x2::coin::into_balance<T1>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::swap_v2_ptb<T0, T3, T1>(arg1, arg2, 0x2::coin::from_balance<T3>(arg11, arg13), 0, v0, arg8, arg4, arg13));
        emit_swap_and_count(arg0, 19, false, 0x2::balance::value<T3>(&arg11), 0x2::balance::value<T1>(&v1));
        v1
    }

    // decompiled from Move bytecode v7
}

