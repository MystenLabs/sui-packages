module 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::honey_trade {
    struct NectarCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimHoneyCap has store, key {
        id: 0x2::object::UID,
        total_claimed: u64,
        total_distributed: u64,
    }

    struct HoneyManager has store, key {
        id: 0x2::object::UID,
        token_trade_cap: 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::TokenTradeCap,
        honey_kraft_cap: 0x2::coin::TreasuryCap<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>,
        honey_policy_cap: 0x2::token::TokenPolicyCap<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>,
        honey_for_users: 0x2::balance::Balance<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>,
        honey_for_team: 0x2::balance::Balance<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>,
        max_distribution_rate: u64,
        distribution_rate: u64,
        last_claim_ts: u64,
        total_distributed: u64,
        honey_claimers: 0x2::linked_table::LinkedTable<address, u64>,
        total_burnt: u64,
        bag: 0x2::bag::Bag,
        module_version: u64,
    }

    struct DistributionRateUpdated has copy, drop {
        distribution_rate: u64,
    }

    struct HoneyClaimedByClaimerCap has copy, drop {
        claimer_id: address,
        total_claimed: u64,
        total_distributed: u64,
        claimed_amount: u64,
    }

    struct NewHoneyClaimerMinted has copy, drop {
        claimer_id: address,
    }

    struct DistributionPctsUpdated has copy, drop {
        claimers_list: vector<address>,
        pcts: vector<u64>,
    }

    struct HoneyBurnt has copy, drop {
        honey_burnt_tax: u64,
        honey_burnt_sui_fee: u64,
        total_honey_burnt: u64,
    }

    struct SwapResultInfo has copy, drop {
        x_offer_amt: u64,
        x_return_amt: u64,
        x_total_fee: u64,
        y_offer_amt: u64,
        y_return_amt: u64,
        y_total_fee: u64,
        creator_fee_amt: u64,
        amm_fee_amt: u64,
        protocol_fee_amt: u64,
        error: u64,
        token_tax_amt: u64,
        honey_tax_amt: u64,
        admin_tax_amt: u64,
    }

    struct DistributionConfig has copy, store {
        distribution_rate: u64,
        max_distribution_rate: u64,
        total_distributed: u64,
        last_claim_ts: u64,
        honey_for_users_balance: u64,
        honey_for_team_balance: u64,
    }

    struct HoneyClaimersInfo has copy, drop {
        claimers: vector<address>,
        percentages: vector<u64>,
        total_claimers: u64,
    }

    public fun add_execmpt_for_honey(arg0: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYieldAdminCap, arg1: &mut 0x2::token::TokenPolicy<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>, arg2: &mut HoneyManager, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg2);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::add_exempt<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(arg1, &arg2.honey_policy_cap, arg3, arg4);
    }

    public fun add_liquidity_to_token_x_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HoneyManager, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T0>, arg3: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg4: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg5: 0x2::token::Token<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T0>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>> {
        let (v0, v1) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::to_coin_for_add_liquidity_with_tax<T0>(&arg1.token_trade_cap, arg2, arg3, 0x2::token::split<T0>(&mut arg5, arg7, arg11), arg10, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg10, v1, arg11);
        let (v6, v7) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::transfer_with_tax<T0>(arg5, 0x2::tx_context::sender(arg11), arg2, arg3, arg10, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg10, v7, arg11);
        0x2::token::destroy_zero<T0>(v6);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg6), 0x2::tx_context::sender(arg11), arg11);
        0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::add_liquidity<T0, T1, T2>(arg0, arg4, 0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, arg8, arg11)), arg9)
    }

    public fun add_liquidity_to_x_token_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HoneyManager, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T1>, arg3: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg4: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::token::Token<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>> {
        let (v0, v1) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::to_coin_for_add_liquidity_with_tax<T1>(&arg1.token_trade_cap, arg2, arg3, 0x2::token::split<T1>(&mut arg6, arg8, arg11), arg10, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v1, arg11);
        let (v6, v7) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::transfer_with_tax<T1>(arg6, 0x2::tx_context::sender(arg11), arg2, arg3, arg10, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v7, arg11);
        0x2::token::destroy_zero<T1>(v6);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg5), 0x2::tx_context::sender(arg11), arg11);
        0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::add_liquidity<T0, T1, T2>(arg0, arg4, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, arg7, arg11)), 0x2::coin::into_balance<T1>(v0), arg9)
    }

    public fun burn_honey_from_supply(arg0: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg1: &mut 0x2::token::TokenPolicy<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>, arg2: &mut HoneyManager, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 1, 5036);
        let v0 = 0x2::token::spent_balance<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(arg1);
        0x2::token::flush<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(arg1, &mut arg2.honey_kraft_cap, arg3);
        let v1 = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::withdraw_honey_to_burn(arg0, &arg2.honey_kraft_cap);
        let v2 = 0x2::balance::value<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&v1);
        let (v3, v4) = 0x2::token::from_coin<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(0x2::coin::from_balance<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(v1, arg3), arg3);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&arg2.honey_policy_cap, v4, arg3);
        0x2::token::burn<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut arg2.honey_kraft_cap, v3);
        arg2.total_burnt = arg2.total_burnt + v0 + v2;
        let v9 = HoneyBurnt{
            honey_burnt_tax     : v0,
            honey_burnt_sui_fee : v2,
            total_honey_burnt   : arg2.total_burnt,
        };
        0x2::event::emit<HoneyBurnt>(v9);
    }

    public fun claim_creator_rewards_for_honey(arg0: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyBoughtBackClaimCap, arg1: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::TokenRules, arg2: &HoneyManager, arg3: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>, arg4: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: &mut 0x2::token::TokenPolicy<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>, arg6: &mut 0x2::tx_context::TxContext) {
        validation_check(arg2);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::claim_creator_rewards<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(arg1, &arg2.honey_policy_cap, arg3, arg4, arg5, arg6);
    }

    public fun claim_honey(arg0: &mut ClaimHoneyCap, arg1: &mut HoneyManager, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY> {
        validation_check(arg1);
        increment_total_distributed(arg2, arg1);
        assert!(0x2::linked_table::contains<address, u64>(&arg1.honey_claimers, 0x2::object::uid_to_address(&arg0.id)), 5037);
        let v0 = *0x2::linked_table::borrow<address, u64>(&arg1.honey_claimers, 0x2::object::uid_to_address(&arg0.id)) * (arg1.total_distributed - arg0.total_distributed) / 100;
        arg0.total_distributed = arg1.total_distributed;
        arg0.total_claimed = arg0.total_claimed + v0;
        let v1 = HoneyClaimedByClaimerCap{
            claimer_id        : 0x2::object::uid_to_address(&arg0.id),
            total_claimed     : arg0.total_claimed,
            total_distributed : arg1.total_distributed,
            claimed_amount    : v0,
        };
        0x2::event::emit<HoneyClaimedByClaimerCap>(v1);
        0x2::balance::split<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut arg1.honey_for_users, v0)
    }

    public fun entry_add_liquidity_to_token_x_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HoneyManager, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T0>, arg3: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg4: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg5: 0x2::token::Token<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T0>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity_to_token_x_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg11), arg11);
    }

    public fun entry_add_liquidity_to_x_token_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HoneyManager, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T1>, arg3: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg4: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::token::Token<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity_to_x_token_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg11), arg11);
    }

    public fun get_all_claimers(arg0: &HoneyManager) : HoneyClaimersInfo {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x2::linked_table::front<address, u64>(&arg0.honey_claimers);
        while (0x1::option::is_some<address>(v2)) {
            let v3 = *0x1::option::borrow<address>(v2);
            0x1::vector::push_back<address>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, *0x2::linked_table::borrow<address, u64>(&arg0.honey_claimers, v3));
            v2 = 0x2::linked_table::next<address, u64>(&arg0.honey_claimers, v3);
        };
        HoneyClaimersInfo{
            claimers       : v0,
            percentages    : v1,
            total_claimers : 0x2::linked_table::length<address, u64>(&arg0.honey_claimers),
        }
    }

    public fun get_claim_cap_info(arg0: &ClaimHoneyCap) : (address, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.total_claimed, arg0.total_distributed)
    }

    public fun get_claimable_amount(arg0: &ClaimHoneyCap, arg1: &HoneyManager, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (v0 > arg1.last_claim_ts) {
            v0 - arg1.last_claim_ts
        } else {
            0
        };
        let v2 = arg1.total_distributed + v1 * arg1.distribution_rate / 1000;
        let v3 = 0x2::object::uid_to_address(&arg0.id);
        assert!(0x2::linked_table::contains<address, u64>(&arg1.honey_claimers, v3), 5037);
        (*0x2::linked_table::borrow<address, u64>(&arg1.honey_claimers, v3) * (v2 - arg0.total_distributed) / 100, v2)
    }

    public fun get_claimer_percentage(arg0: &HoneyManager, arg1: address) : u64 {
        assert!(0x2::linked_table::contains<address, u64>(&arg0.honey_claimers, arg1), 5037);
        *0x2::linked_table::borrow<address, u64>(&arg0.honey_claimers, arg1)
    }

    public fun get_distribution_config(arg0: &HoneyManager) : DistributionConfig {
        DistributionConfig{
            distribution_rate       : arg0.distribution_rate,
            max_distribution_rate   : arg0.max_distribution_rate,
            total_distributed       : arg0.total_distributed,
            last_claim_ts           : arg0.last_claim_ts,
            honey_for_users_balance : 0x2::balance::value<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&arg0.honey_for_users),
            honey_for_team_balance  : 0x2::balance::value<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&arg0.honey_for_team),
        }
    }

    public fun get_system_stats(arg0: &HoneyManager) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        (10000000000000000, 0x2::balance::value<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&arg0.honey_for_users), 0x2::balance::value<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&arg0.honey_for_team), arg0.total_distributed, arg0.total_burnt, arg0.distribution_rate, arg0.max_distribution_rate, 0x2::linked_table::length<address, u64>(&arg0.honey_claimers))
    }

    public fun increment_honey_manager(arg0: &mut HoneyManager) {
        assert!(arg0.module_version < 1, 5035);
        arg0.module_version = 1;
    }

    fun increment_total_distributed(arg0: &0x2::clock::Clock, arg1: &mut HoneyManager) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 <= arg1.last_claim_ts) {
            return
        };
        arg1.last_claim_ts = v0;
        arg1.total_distributed = arg1.total_distributed + (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((v0 - arg1.last_claim_ts) as u256), (arg1.distribution_rate as u256), (1000 as u256)) as u64);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NectarCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<NectarCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun kraft_genesis_honey(arg0: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::PoolRegistry, arg1: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::TokenRules, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYieldAdminCap, arg4: 0x2::coin::TreasuryCap<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>, arg5: 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::TokenTradeCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(0x2::coin::mint<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut arg4, 10000000000000000, arg6));
        let (v1, v2) = 0x2::token::new_policy<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::set_token_taxes<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(arg0, arg1, arg2, &mut v4, &v3, 300, 100, 100, 100, 0, 150, 0, 100, 5, arg6);
        let v5 = HoneyManager{
            id                    : 0x2::object::new(arg6),
            token_trade_cap       : arg5,
            honey_kraft_cap       : arg4,
            honey_policy_cap      : v3,
            honey_for_users       : 0x2::balance::split<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut v0, 60 * 10000000000000000 / 100),
            honey_for_team        : v0,
            max_distribution_rate : 1000000000,
            distribution_rate     : 0,
            last_claim_ts         : 0,
            total_distributed     : 0,
            honey_claimers        : 0x2::linked_table::new<address, u64>(arg6),
            total_burnt           : 0,
            bag                   : 0x2::bag::new(arg6),
            module_version        : 1,
        };
        0x2::transfer::share_object<HoneyManager>(v5);
        0x2::token::share_policy<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(v4);
    }

    public fun make_swap_token_x_pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::PoolRegistry, arg2: &HoneyManager, arg3: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T0>, arg4: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg6: &mut 0x2::token::TokenPolicy<T0>, arg7: 0x2::token::Token<T0>, arg8: u64, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 1, 5036);
        let v0 = 0x2::coin::value<T1>(&arg9) > 0;
        let v1 = 0x2::balance::zero<T0>();
        if (!v0) {
            let (v2, v3) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::sell_tokens_with_tax<T0>(&arg2.token_trade_cap, arg3, arg4, arg7, arg6, arg12);
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg6, v3, arg12);
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(v2));
        } else {
            0x2::token::destroy_zero<T0>(arg7);
        };
        let (v8, v9) = 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::swap_with_tax<T0, T1, T2, T3, T4>(arg0, arg1, arg5, v1, arg8, 0x2::coin::into_balance<T1>(arg9), arg10, arg11);
        let v10 = v8;
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<T1>(v9, 0x2::tx_context::sender(arg12), arg12);
        if (v0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg6, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::buy_tokens_with_tax<T0>(&arg2.token_trade_cap, 0x2::coin::from_balance<T0>(v10, arg12), arg3, arg4, arg6, 0x2::tx_context::sender(arg12), arg12), arg12);
        } else if (0x2::balance::value<T0>(&v10) > 0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg6, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::transfer_without_tax<T0>(&arg2.token_trade_cap, arg6, 0x2::coin::from_balance<T0>(v10, arg12), 0x2::tx_context::sender(arg12), arg12), arg12);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
    }

    public fun make_swap_x_token_pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::PoolRegistry, arg2: &HoneyManager, arg3: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T1>, arg4: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg6: &mut 0x2::token::TokenPolicy<T1>, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: 0x2::token::Token<T1>, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 1, 5036);
        let v0 = 0x2::coin::value<T0>(&arg7) > 0;
        let v1 = 0x2::balance::zero<T1>();
        if (!v0) {
            let (v2, v3) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::sell_tokens_with_tax<T1>(&arg2.token_trade_cap, arg3, arg4, arg9, arg6, arg12);
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, v3, arg12);
            0x2::balance::join<T1>(&mut v1, 0x2::coin::into_balance<T1>(v2));
        } else {
            0x2::token::destroy_zero<T1>(arg9);
        };
        let (v8, v9) = 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::swap_with_tax<T0, T1, T2, T3, T4>(arg0, arg1, arg5, 0x2::coin::into_balance<T0>(arg7), arg8, v1, arg10, arg11);
        let v10 = v9;
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<T0>(v8, 0x2::tx_context::sender(arg12), arg12);
        if (v0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::buy_tokens_with_tax<T1>(&arg2.token_trade_cap, 0x2::coin::from_balance<T1>(v10, arg12), arg3, arg4, arg6, 0x2::tx_context::sender(arg12), arg12), arg12);
        } else if (0x2::balance::value<T1>(&v10) > 0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::transfer_without_tax<T1>(&arg2.token_trade_cap, arg6, 0x2::coin::from_balance<T1>(v10, arg12), 0x2::tx_context::sender(arg12), arg12), arg12);
        } else {
            0x2::balance::destroy_zero<T1>(v10);
        };
    }

    public fun mint_new_honey_claimer(arg0: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyManager, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        increment_total_distributed(arg2, arg1);
        let v0 = ClaimHoneyCap{
            id                : 0x2::object::new(arg3),
            total_claimed     : 0,
            total_distributed : arg1.total_distributed,
        };
        0x2::linked_table::push_back<address, u64>(&mut arg1.honey_claimers, 0x2::object::uid_to_address(&v0.id), 0);
        let v1 = NewHoneyClaimerMinted{claimer_id: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<NewHoneyClaimerMinted>(v1);
        0x2::transfer::public_transfer<ClaimHoneyCap>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun query_swap_token_x_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::PoolRegistry, arg2: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg3: &0x2::token::TokenPolicy<T0>, arg4: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = arg7 > 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        if (!v0) {
            let (v4, v5, v6, v7) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::calculate_sell_tax_amounts<T0>(arg3, arg4, arg5, arg10);
            v1 = v7;
            v2 = v6;
            v3 = v5;
            arg5 = v4;
        };
        let (v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::query_swap<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9);
        let v18 = v9;
        if (v0) {
            let (v19, v20, v21, v22) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::calculate_buy_tax_amounts<T0>(arg3, arg4, v9, arg10);
            v1 = v22;
            v2 = v21;
            v3 = v20;
            v18 = v19;
        };
        (v8, v18, v10, v11, v12, v13, v14, v15, v16, v17, v3, v2, v1)
    }

    public fun query_swap_token_x_pool_info<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::PoolRegistry, arg2: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg3: &0x2::token::TokenPolicy<T0>, arg4: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address) : SwapResultInfo {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12) = query_swap_token_x_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        SwapResultInfo{
            x_offer_amt      : v0,
            x_return_amt     : v1,
            x_total_fee      : v2,
            y_offer_amt      : v3,
            y_return_amt     : v4,
            y_total_fee      : v5,
            creator_fee_amt  : v6,
            amm_fee_amt      : v7,
            protocol_fee_amt : v8,
            error            : v9,
            token_tax_amt    : v10,
            honey_tax_amt    : v11,
            admin_tax_amt    : v12,
        }
    }

    public fun query_swap_x_token_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::PoolRegistry, arg2: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg3: &0x2::token::TokenPolicy<T1>, arg4: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = arg5 > 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        if (!v0) {
            let (v4, v5, v6, v7) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::calculate_sell_tax_amounts<T1>(arg3, arg4, arg7, arg10);
            v1 = v7;
            v2 = v6;
            v3 = v5;
            arg7 = v4;
        };
        let (v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::query_swap<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9);
        let v18 = v12;
        if (v0) {
            let (v19, v20, v21, v22) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::calculate_buy_tax_amounts<T1>(arg3, arg4, v12, arg10);
            v1 = v22;
            v2 = v21;
            v3 = v20;
            v18 = v19;
        };
        (v8, v9, v10, v11, v18, v13, v14, v15, v16, v17, v3, v2, v1)
    }

    public fun query_swap_x_token_pool_info<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::PoolRegistry, arg2: &0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg3: &0x2::token::TokenPolicy<T1>, arg4: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address) : SwapResultInfo {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12) = query_swap_x_token_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        SwapResultInfo{
            x_offer_amt      : v0,
            x_return_amt     : v1,
            x_total_fee      : v2,
            y_offer_amt      : v3,
            y_return_amt     : v4,
            y_total_fee      : v5,
            creator_fee_amt  : v6,
            amm_fee_amt      : v7,
            protocol_fee_amt : v8,
            error            : v9,
            token_tax_amt    : v10,
            honey_tax_amt    : v11,
            admin_tax_amt    : v12,
        }
    }

    public fun remove_execmpt_for_honey(arg0: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYieldAdminCap, arg1: &mut 0x2::token::TokenPolicy<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>, arg2: &mut HoneyManager, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg2);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::remove_exempt<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(arg1, &arg2.honey_policy_cap, arg3, arg4);
    }

    public fun remove_liquidity_from_x_token_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HoneyManager, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T1>, arg3: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg4: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg5: 0x2::coin::Coin<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 1, 5036);
        let v0 = 0x2::coin::into_balance<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(arg5);
        let (v1, v2, v3) = 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::remove_liquidity_burn_tax<T0, T1, T2>(arg0, arg4, 0x2::balance::split<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(&mut v0, arg6), arg7, arg8, arg9);
        0x2::balance::join<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(&mut v0, v3);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg11), arg11);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg11), arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::from_coin_for_remove_liquidity_with_tax<T1>(&arg1.token_trade_cap, 0x2::coin::from_balance<T1>(v2, arg11), arg2, arg3, arg10, 0x2::tx_context::sender(arg11), arg11), arg11);
    }

    public fun remove_liquidity_token_x_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &HoneyManager, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T0>, arg3: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg4: &mut 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LiquidityPool<T0, T1, T2>, arg5: 0x2::coin::Coin<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T0>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 1, 5036);
        let v0 = 0x2::coin::into_balance<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(arg5);
        let (v1, v2, v3) = 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::remove_liquidity_burn_tax<T0, T1, T2>(arg0, arg4, 0x2::balance::split<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(&mut v0, arg6), arg7, arg8, arg9);
        0x2::balance::join<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(&mut v0, v3);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg11), arg11);
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::destroy_or_transfer_balance<0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg11), arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg10, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::from_coin_for_remove_liquidity_with_tax<T0>(&arg1.token_trade_cap, 0x2::coin::from_balance<T0>(v1, arg11), arg2, arg3, arg10, 0x2::tx_context::sender(arg11), arg11), arg11);
    }

    public fun set_max_distribution_rate(arg0: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyManager, arg2: u64) {
        validation_check(arg1);
        arg1.max_distribution_rate = arg2;
    }

    public fun transfer_token<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T0>, arg3: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::transfer_with_tax<T0>(0x2::token::split<T0>(&mut arg0, arg4, arg6), arg5, arg2, arg3, arg1, arg6);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg1, v1, arg6);
        0x2::token::destroy_zero<T0>(v0);
        let (v6, v7) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::transfer_with_tax<T0>(arg0, 0x2::tx_context::sender(arg6), arg2, arg3, arg1, arg6);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg1, v7, arg6);
        0x2::token::destroy_zero<T0>(v6);
    }

    public fun update_distribution_pcts(arg0: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyManager, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3) && 0x2::linked_table::length<address, u64>(&arg1.honey_claimers) == 0x1::vector::length<address>(&arg2), 5038);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            let v3 = *0x1::vector::borrow<u64>(&arg3, v0);
            v1 = v1 + v3;
            assert!(0x2::linked_table::contains<address, u64>(&arg1.honey_claimers, v2), 5037);
            *0x2::linked_table::borrow_mut<address, u64>(&mut arg1.honey_claimers, v2) = v3;
            v0 = v0 + 1;
        };
        assert!(v1 == 100, 5038);
        let v4 = DistributionPctsUpdated{
            claimers_list : arg2,
            pcts          : arg3,
        };
        0x2::event::emit<DistributionPctsUpdated>(v4);
    }

    public fun update_distribution_rate_via_nectar(arg0: &NectarCap, arg1: &mut HoneyManager, arg2: &0x2::clock::Clock, arg3: u64) {
        validation_check(arg1);
        increment_total_distributed(arg2, arg1);
        if (arg3 > arg1.max_distribution_rate) {
            return
        };
        arg1.distribution_rate = arg3;
        let v0 = DistributionRateUpdated{distribution_rate: arg3};
        0x2::event::emit<DistributionRateUpdated>(v0);
    }

    fun validation_check(arg0: &HoneyManager) {
        assert!(arg0.module_version == 1, 5039);
    }

    // decompiled from Move bytecode v6
}

