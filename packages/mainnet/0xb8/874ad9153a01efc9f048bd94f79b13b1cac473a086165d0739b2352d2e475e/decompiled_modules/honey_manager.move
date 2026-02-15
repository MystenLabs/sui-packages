module 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::honey_manager {
    struct HONEY_MANAGER has drop {
        dummy_field: bool,
    }

    struct HoneyManager has store, key {
        id: 0x2::object::UID,
        honey_kraft_cap: 0x2::coin::TreasuryCap<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>,
        honey_policy_cap: 0x2::token::TokenPolicyCap<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>,
        honey_for_users: 0x2::balance::Balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>,
        honey_for_team: 0x2::balance::Balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>,
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

    struct DistributionPctsUpdated has copy, drop {
        claimers_list: vector<address>,
        pcts: vector<u64>,
    }

    struct HoneyBurnt has copy, drop {
        honey_burnt_tax: u64,
        honey_burnt_sui_fee: u64,
        total_honey_burnt: u64,
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

    public fun mint_new_honey_claimer(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyManager, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        increment_total_distributed(arg2, arg1);
        let (v0, v1) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::mint_new_honey_claimer(&arg1.honey_kraft_cap, arg1.total_distributed, arg3);
        0x2::linked_table::push_back<address, u64>(&mut arg1.honey_claimers, v0, 0);
        0x2::transfer::public_transfer<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::ClaimHoneyCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun add_exempt_for_honey(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYieldAdminCap, arg1: &mut 0x2::token::TokenPolicy<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg2: &mut HoneyManager, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg2);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::add_exempt<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(arg1, &arg2.honey_policy_cap, arg3, arg4);
    }

    public fun burn_honey_from_supply(arg0: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg1: &mut 0x2::token::TokenPolicy<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg2: &mut HoneyManager, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 5036);
        let v0 = 0x2::token::spent_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(arg1);
        0x2::token::flush<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(arg1, &mut arg2.honey_kraft_cap, arg3);
        let v1 = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::withdraw_honey_to_burn(arg0, &arg2.honey_kraft_cap);
        let v2 = 0x2::balance::value<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&v1);
        let (v3, v4) = 0x2::token::from_coin<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(0x2::coin::from_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(v1, arg3), arg3);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&arg2.honey_policy_cap, v4, arg3);
        0x2::token::burn<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&mut arg2.honey_kraft_cap, v3);
        arg2.total_burnt = arg2.total_burnt + v0 + v2;
        let v9 = HoneyBurnt{
            honey_burnt_tax     : v0,
            honey_burnt_sui_fee : v2,
            total_honey_burnt   : arg2.total_burnt,
        };
        0x2::event::emit<HoneyBurnt>(v9);
    }

    public fun claim_creator_rewards_for_honey(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyBoughtBackClaimCap, arg1: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::TokenRules, arg2: &HoneyManager, arg3: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg4: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg5: &mut 0x2::token::TokenPolicy<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg6: &mut 0x2::tx_context::TxContext) {
        validation_check(arg2);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::claim_creator_rewards<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(arg1, &arg2.honey_policy_cap, arg3, arg4, arg5, arg6);
    }

    public fun claim_honey(arg0: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::ClaimHoneyCap, arg1: &mut HoneyManager, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY> {
        validation_check(arg1);
        increment_total_distributed(arg2, arg1);
        let v0 = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::get_claimer_id(arg0);
        assert!(0x2::linked_table::contains<address, u64>(&arg1.honey_claimers, v0), 5037);
        let v1 = (0xaa64ebb6d9ecc506ebd0b411e77c27059844f46bddecc417c8687640fca481d2::math::mul_div_u128((*0x2::linked_table::borrow<address, u64>(&arg1.honey_claimers, v0) as u128), ((arg1.total_distributed - 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::get_claimer_total_distributed(arg0)) as u128), (100 as u128)) as u64);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::update_claimer_capability(&arg1.honey_kraft_cap, arg0, arg1.total_distributed, v1);
        0x2::balance::split<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&mut arg1.honey_for_users, v1)
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

    public fun get_claimable_amount(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::ClaimHoneyCap, arg1: &HoneyManager, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (v0 > arg1.last_claim_ts) {
            v0 - arg1.last_claim_ts
        } else {
            0
        };
        let v2 = arg1.total_distributed + v1 * arg1.distribution_rate / 1000;
        let (v3, _, v5) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::get_claim_cap_info(arg0);
        assert!(0x2::linked_table::contains<address, u64>(&arg1.honey_claimers, v3), 5037);
        ((0xaa64ebb6d9ecc506ebd0b411e77c27059844f46bddecc417c8687640fca481d2::math::mul_div_u128((*0x2::linked_table::borrow<address, u64>(&arg1.honey_claimers, v3) as u128), ((v2 - v5) as u128), (100 as u128)) as u64), v2)
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
            honey_for_users_balance : 0x2::balance::value<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&arg0.honey_for_users),
            honey_for_team_balance  : 0x2::balance::value<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&arg0.honey_for_team),
        }
    }

    public fun get_system_stats(arg0: &HoneyManager) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        (10000000000000000, 0x2::balance::value<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&arg0.honey_for_users), 0x2::balance::value<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&arg0.honey_for_team), arg0.total_distributed, arg0.total_burnt, arg0.distribution_rate, arg0.max_distribution_rate, 0x2::linked_table::length<address, u64>(&arg0.honey_claimers))
    }

    public fun increment_honey_manager(arg0: &mut HoneyManager) {
        assert!(arg0.module_version < 0, 5035);
        arg0.module_version = 0;
    }

    fun increment_total_distributed(arg0: &0x2::clock::Clock, arg1: &mut HoneyManager) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 <= arg1.last_claim_ts) {
            return
        };
        arg1.last_claim_ts = v0;
        arg1.total_distributed = arg1.total_distributed + (0xaa64ebb6d9ecc506ebd0b411e77c27059844f46bddecc417c8687640fca481d2::math::mul_div_u256(((v0 - arg1.last_claim_ts) as u256), (arg1.distribution_rate as u256), (1000 as u256)) as u64);
    }

    fun init(arg0: HONEY_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HONEY_MANAGER>(arg0, arg1);
        let v1 = 0x2::display::new<HoneyManager>(&v0, arg1);
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"HONEY Emission Manager"));
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Controls HONEY token emission rates, distribution schedules, and burn tracking for the HoneyPlay protocol."));
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://assets.honeyplay.fun/global_objects/honey_manager.png"));
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"project"), 0x1::string::utf8(b"https://honeyplay.fun"));
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"Max Emission Rate (HONEY/s)"), 0x1::string::utf8(b"{max_distribution_rate}"));
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"Current Emission Rate (HONEY/s)"), 0x1::string::utf8(b"{distribution_rate}"));
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"Last Distribution (ms)"), 0x1::string::utf8(b"{last_claim_ts}"));
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"Total Distributed (micro HONEY)"), 0x1::string::utf8(b"{total_distributed}"));
        0x2::display::add<HoneyManager>(&mut v1, 0x1::string::utf8(b"Total Burnt (micro HONEY)"), 0x1::string::utf8(b"{total_burnt}"));
        0x2::display::update_version<HoneyManager>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<HoneyManager>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_honey_manager(arg0: 0x2::balance::Balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg1: 0x2::token::TokenPolicyCap<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg2: 0x2::coin::TreasuryCap<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg3: &mut 0x2::tx_context::TxContext) : 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::ClaimHoneyCap {
        let v0 = HoneyManager{
            id                    : 0x2::object::new(arg3),
            honey_kraft_cap       : arg2,
            honey_policy_cap      : arg1,
            honey_for_users       : 0x2::balance::split<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(&mut arg0, 60 * 10000000000000000 / 100),
            honey_for_team        : arg0,
            max_distribution_rate : 1000000000,
            distribution_rate     : 0,
            last_claim_ts         : 0,
            total_distributed     : 0,
            honey_claimers        : 0x2::linked_table::new<address, u64>(arg3),
            total_burnt           : 0,
            bag                   : 0x2::bag::new(arg3),
            module_version        : 0,
        };
        let (v1, v2) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::mint_new_honey_claimer(&v0.honey_kraft_cap, v0.total_distributed, arg3);
        0x2::linked_table::push_back<address, u64>(&mut v0.honey_claimers, v1, 0);
        0x2::transfer::share_object<HoneyManager>(v0);
        v2
    }

    public fun remove_exempt_for_honey(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYieldAdminCap, arg1: &mut 0x2::token::TokenPolicy<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg2: &mut HoneyManager, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg2);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::remove_exempt<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(arg1, &arg2.honey_policy_cap, arg3, arg4);
    }

    public fun set_max_distribution_rate(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyManager, arg2: u64) {
        validation_check(arg1);
        arg1.max_distribution_rate = arg2;
    }

    public fun update_distribution_pcts(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyManager, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::linked_table::contains<address, u64>(&arg1.honey_claimers, v1)) {
                *0x2::linked_table::borrow_mut<address, u64>(&mut arg1.honey_claimers, v1) = *0x1::vector::borrow<u64>(&arg3, v0);
            };
            v0 = v0 + 1;
        };
        let v2 = 0;
        let v3 = 0x2::linked_table::front<address, u64>(&arg1.honey_claimers);
        while (0x1::option::is_some<address>(v3)) {
            let v4 = *0x1::option::borrow<address>(v3);
            v2 = v2 + *0x2::linked_table::borrow<address, u64>(&arg1.honey_claimers, v4);
            v3 = 0x2::linked_table::next<address, u64>(&arg1.honey_claimers, v4);
        };
        assert!(v2 == 100, 5038);
        let v5 = DistributionPctsUpdated{
            claimers_list : arg2,
            pcts          : arg3,
        };
        0x2::event::emit<DistributionPctsUpdated>(v5);
    }

    public fun update_distribution_rate_via_nectar(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::NectarCap, arg1: &mut HoneyManager, arg2: &0x2::clock::Clock, arg3: u64) {
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
        assert!(arg0.module_version == 0, 5039);
    }

    // decompiled from Move bytecode v6
}

