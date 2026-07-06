module 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_scoin_entry {
    public fun admin_force_refresh_scallop_scoin<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::scallop_leg_auth();
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::force_sync_protocol_balance<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), view_scallop_scoin_underlying<T0, T1>(arg0, arg1, arg2, arg3), arg3, arg4, &v0);
    }

    public fun admin_recall_scallop_scoin_to_idle<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin_recall::AdminRecallReceipt<T0>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_scallop_scoin_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3));
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::trigger_accrue_if_needed<T0, T1>(arg0, arg3, arg4, arg5);
        let v0 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::scallop_leg_auth();
        let v1 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP();
        let v2 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::select_scoin_withdraw_amount<T0>(arg4, (arg2 as u128), query_scallop_scoin_total<T0, T1>(arg0));
        if (v2 == 0) {
            return
        };
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin_recall::add_recall_withdraw_leg<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v1, withdraw_underlying_scoin<T0>(0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin_recall::extract_recall_holding<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v1, v2, &v0), arg3, arg4, arg5, arg6), &v0);
    }

    public fun deposit_to_scallop_scoin<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::DepositReceipt<T0>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_scallop_scoin_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3));
        let v0 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::scallop_leg_auth();
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::trigger_accrue_if_needed<T0, T1>(arg0, arg3, arg4, arg5);
        let v1 = query_scallop_scoin_underlying<T0, T1>(arg0, arg4);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::sync_for_deposit<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg0, arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), v1, arg5, &v0);
        let v2 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::resolve_requested_deposit_amount<T0>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), arg2);
        if (v2 == 0) {
            return
        };
        let (v3, v4) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::begin_deposit_leg<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), v2, &v0);
        let v5 = v3;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = deposit_underlying_scoin<T0>(v5, arg3, arg4, arg5, arg6);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::store_deposit_holding<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), v7, &v0);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::finish_deposit_leg_accounted<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v4, v6, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_math::accounted_value_delta_capped(v1, query_scallop_scoin_underlying<T0, T1>(arg0, arg4), v6), 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::max_accounted_value_gap_for_input<T0, T1>(arg0, v6), &v0);
    }

    fun deposit_underlying_scoin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_adapter::deposit<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(arg0, arg4), arg3, arg4))
    }

    fun query_scallop_scoin_total<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>) : u64 {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP())
    }

    fun query_scallop_scoin_underlying<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u128 {
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::query_underlying_from_scoin_amount<T0>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::query_holding_balance<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP()))
    }

    public fun rebalance_deposit_to_scallop_scoin<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::RebalanceReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_scallop_scoin_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg2));
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::trigger_accrue_if_needed<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::scallop_leg_auth();
        let v1 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP();
        let v2 = query_scallop_scoin_underlying<T0, T1>(arg0, arg3);
        let v3 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::get_amount(0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::expected_deposit_plan<T0>(arg1), v1);
        if (v3 == 0) {
            return
        };
        let v4 = (0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::rebalance_balance_value<T0>(arg1) as u128);
        let v5 = if (v3 < v4) {
            (v3 as u64)
        } else {
            (v4 as u64)
        };
        let v6 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::resolve_requested_rebalance_deposit_amount<T0>(arg1, v1, v5);
        if (v6 == 0) {
            return
        };
        let (v7, v8) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::begin_rebalance_deposit_leg<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v1, v6, &v0);
        let v9 = v7;
        let v10 = 0x2::balance::value<T0>(&v9);
        if (v10 == 0) {
            0x2::balance::destroy_zero<T0>(v9);
            0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::finish_rebalance_deposit_leg_accounted<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v8, 0, 0, 0, &v0);
            return
        };
        let v11 = deposit_underlying_scoin<T0>(v9, arg2, arg3, arg4, arg5);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::store_rebalance_holding<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v1, v11, &v0);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::finish_rebalance_deposit_leg_accounted<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v8, v10, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_math::accounted_value_delta_capped(v2, query_scallop_scoin_underlying<T0, T1>(arg0, arg3), v10), 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::max_accounted_value_gap_for_input<T0, T1>(arg0, v10), &v0);
    }

    public fun rebalance_withdraw_from_scallop_scoin<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::RebalanceReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_scallop_scoin_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg2));
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::trigger_accrue_if_needed<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::scallop_leg_auth();
        let v1 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP();
        let v2 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::select_scoin_withdraw_amount<T0>(arg3, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::get_amount(0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::expected_withdraw_plan<T0>(arg1), v1), query_scallop_scoin_total<T0, T1>(arg0));
        if (v2 == 0) {
            return
        };
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::add_rebalance_withdraw_leg<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v1, withdraw_underlying_scoin<T0>(0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_rebalance::extract_rebalance_holding<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v1, v2, &v0), arg2, arg3, arg4, arg5), &v0);
    }

    public fun refresh_scallop_scoin<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::assert_refresh_gate<T0, T1>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), arg3, arg4);
        let v0 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::scallop_leg_auth();
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::sync_protocol_balance_by_auth<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), view_scallop_scoin_underlying<T0, T1>(arg0, arg1, arg2, arg3), arg3, &v0);
    }

    public fun view_scallop_scoin_underlying<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) : u128 {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_scallop_scoin_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg2), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg1));
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::trigger_accrue_if_needed<T0, T1>(arg0, arg1, arg2, arg3);
        query_scallop_scoin_underlying<T0, T1>(arg0, arg2)
    }

    public fun withdraw_from_scallop_scoin<T0, T1>(arg0: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::WithdrawReceipt<T0, T1>, arg2: u128, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_scallop_scoin_config<T0, T1>(arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3));
        let v0 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::scallop_leg_auth();
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::trigger_accrue_if_needed<T0, T1>(arg0, arg3, arg4, arg5);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::sync_for_withdraw<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg0, arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), query_scallop_scoin_underlying<T0, T1>(arg0, arg4), arg5, &v0);
        let v1 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::resolve_requested_withdraw_assets<T0, T1>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), arg2);
        if (v1 == 0) {
            return
        };
        let v2 = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common::select_scoin_withdraw_amount<T0>(arg4, v1, query_scallop_scoin_total<T0, T1>(arg0));
        if (v2 == 0) {
            return
        };
        let (v3, v4) = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::begin_withdraw_leg<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), v2, &v0);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_user_entry::finish_withdraw_leg<T0, T1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_entry::ScallopLegAuth>(arg1, arg0, v4, withdraw_underlying_scoin<T0>(v3, arg3, arg4, arg5, arg6), &v0);
    }

    fun withdraw_underlying_scoin<T0>(arg0: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0) == 0) {
            0x2::balance::destroy_zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0);
            return 0x2::balance::zero<T0>()
        };
        0x2::coin::into_balance<T0>(0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_adapter::withdraw<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, arg4), arg3, arg4))
    }

    // decompiled from Move bytecode v7
}

