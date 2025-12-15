module 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_divine_calling {
    struct DivineCallingRegistry has key {
        id: 0x2::object::UID,
        divine_callings: 0x2::table::Table<0x2::object::ID, DivineCalling>,
        user_calling_participations: 0x2::table::Table<address, vector<0x2::object::ID>>,
        calling_ids: vector<0x2::object::ID>,
        calling_users: vector<address>,
        total_influence_distributed: u64,
    }

    struct DivineCalling has store {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        objective: 0x1::string::String,
        completion_condition: 0x1::string::String,
        flavor_text: 0x1::string::String,
        image_url: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        goal_type: u8,
        goal_resource_type: 0x1::option::Option<0x1::string::String>,
        goal_tool_type: 0x1::option::Option<u8>,
        goal_amount: u64,
        current_progress: u64,
        contribution_tiers: vector<ContributionTier>,
        contributors: 0x2::table::Table<address, UserContribution>,
        contributor_addresses: vector<address>,
        total_contributors: u64,
        total_influence_distributed: u64,
        fixed_rewards: vector<DivineReward>,
        status: u8,
        visible: bool,
        custom_config: vector<u64>,
    }

    struct ContributionTier has drop, store {
        tier_index: u8,
        tier_name: 0x1::string::String,
        required_amount: u64,
        influence_reward: u64,
    }

    struct DivineReward has drop, store {
        reward_type: u8,
        type_identifier: 0x1::string::String,
        amount: u64,
        description: 0x1::string::String,
    }

    struct UserContribution has store {
        tier_selected: u8,
        amount_contributed: u64,
        contribution_time: u64,
        rewards_claimed: bool,
    }

    struct DivineCallingCreated has copy, drop {
        calling_id: 0x2::object::ID,
        name: 0x1::string::String,
        goal_type: u8,
        goal_amount: u64,
        start_time: u64,
        end_time: u64,
    }

    struct DivineCallingContribution has copy, drop {
        calling_id: 0x2::object::ID,
        calling_name: 0x1::string::String,
        user: address,
        goal_type: u8,
        goal_identifier: 0x1::string::String,
        tier_index: u8,
        amount: u64,
        new_progress: u64,
    }

    struct DivineCallingCompleted has copy, drop {
        calling_id: 0x2::object::ID,
        total_contributions: u64,
        total_contributors: u64,
        success: bool,
    }

    struct DivineRewardsClaimed has copy, drop {
        calling_id: 0x2::object::ID,
        user: address,
        land_id: 0x2::object::ID,
        influence_reward: u64,
        fixed_rewards_count: u64,
    }

    struct DebugEvent has copy, drop {
        messages: vector<0x1::string::String>,
    }

    public entry fun claim_rewards_coin<T0>(arg0: &mut DivineCallingRegistry, arg1: &mut 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_version(arg1);
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2, v3) = claim_rewards_internal(arg0, arg1, arg2, arg4, v0, arg5);
        let v4 = 0x2::table::borrow<0x2::object::ID, DivineCalling>(&arg0.divine_callings, arg4);
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::vector::borrow<DivineReward>(&v4.fixed_rewards, v5);
            if (v6.reward_type == 0) {
                assert!(0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(v6.type_identifier) == 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>()), 1718);
                mint_and_transfer_coin_by_type<T0>(arg1, arg3, v6.amount, v0, arg6);
            } else if (v6.reward_type == 1) {
                abort 1717
            };
            v5 = v5 + 1;
        };
        let v7 = DivineRewardsClaimed{
            calling_id          : arg4,
            user                : v0,
            land_id             : v1,
            influence_reward    : v2,
            fixed_rewards_count : v3,
        };
        0x2::event::emit<DivineRewardsClaimed>(v7);
    }

    public entry fun claim_rewards_coin_multi<T0, T1, T2, T3>(arg0: &mut DivineCallingRegistry, arg1: &mut 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_version(arg1);
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2, v3) = claim_rewards_internal(arg0, arg1, arg2, arg4, v0, arg5);
        let v4 = 0x2::table::borrow<0x2::object::ID, DivineCalling>(&arg0.divine_callings, arg4);
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::vector::borrow<DivineReward>(&v4.fixed_rewards, v5);
            if (v6.reward_type == 0) {
                if (v5 == 0) {
                    assert!(0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(v6.type_identifier) == 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>()), 1718);
                    mint_and_transfer_coin_by_type<T0>(arg1, arg3, v6.amount, v0, arg6);
                } else if (v5 == 1) {
                    assert!(0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(v6.type_identifier) == 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T1>()), 1718);
                    mint_and_transfer_coin_by_type<T1>(arg1, arg3, v6.amount, v0, arg6);
                } else if (v5 == 2) {
                    assert!(0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(v6.type_identifier) == 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T2>()), 1718);
                    mint_and_transfer_coin_by_type<T2>(arg1, arg3, v6.amount, v0, arg6);
                } else {
                    assert!(v5 == 3, 1718);
                    assert!(0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(v6.type_identifier) == 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::normalize_type_string(0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T3>()), 1718);
                    mint_and_transfer_coin_by_type<T3>(arg1, arg3, v6.amount, v0, arg6);
                };
            } else if (v6.reward_type == 1) {
                abort 1717
            };
            v5 = v5 + 1;
        };
        let v7 = DivineRewardsClaimed{
            calling_id          : arg4,
            user                : v0,
            land_id             : v1,
            influence_reward    : v2,
            fixed_rewards_count : v3,
        };
        0x2::event::emit<DivineRewardsClaimed>(v7);
    }

    fun claim_rewards_internal(arg0: &mut DivineCallingRegistry, arg1: &mut 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: 0x2::object::ID, arg4: address, arg5: &0x2::clock::Clock) : (0x2::object::ID, u64, u64) {
        let v0 = 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::validate_user_representing_land(arg2, arg4);
        assert!(0x2::table::contains<0x2::object::ID, DivineCalling>(&arg0.divine_callings, arg3), 1712);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, DivineCalling>(&mut arg0.divine_callings, arg3);
        assert!(v1.status == 4, 1705);
        assert!(0x2::table::contains<address, UserContribution>(&v1.contributors, arg4), 1704);
        let v2 = 0x2::table::borrow_mut<address, UserContribution>(&mut v1.contributors, arg4);
        assert!(!v2.rewards_claimed, 1706);
        let v3 = 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::calculate_boosted_influence_reward(0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::get_package_cap(arg1), arg2, arg4, 0x1::vector::borrow<ContributionTier>(&v1.contribution_tiers, (v2.tier_selected as u64)).influence_reward, arg5);
        v1.total_influence_distributed = v1.total_influence_distributed + v3;
        arg0.total_influence_distributed = arg0.total_influence_distributed + v3;
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::add_land_influence(0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::get_package_cap(arg1), arg2, arg4, v0, v3);
        v2.rewards_claimed = true;
        (v0, v3, 0x1::vector::length<DivineReward>(&v1.fixed_rewards))
    }

    public entry fun contribute_resource_to_divine_calling<T0>(arg0: &mut DivineCallingRegistry, arg1: &mut 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: 0x2::object::ID, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_version(arg1);
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::validate_user_representing_land(arg2, v0);
        assert!(0x2::table::contains<0x2::object::ID, DivineCalling>(&arg0.divine_callings, arg4), 1712);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, DivineCalling>(&mut arg0.divine_callings, arg4);
        assert!(v2.visible, 1701);
        assert!(v2.status == 1 || v2.status == 4, 1701);
        assert!(v1 >= v2.start_time, 1714);
        assert!(v1 <= v2.end_time, 1713);
        assert!(v2.goal_type == 0, 1708);
        assert!(0x1::option::is_some<0x1::string::String>(&v2.goal_resource_type), 1708);
        assert!(*0x1::option::borrow<0x1::string::String>(&v2.goal_resource_type) == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>(), 1709);
        assert!(!0x2::table::contains<address, UserContribution>(&v2.contributors, v0), 1703);
        assert!((arg5 as u64) < 0x1::vector::length<ContributionTier>(&v2.contribution_tiers), 1702);
        let v3 = 0x2::coin::value<T0>(&arg6);
        assert!(v3 == 0x1::vector::borrow<ContributionTier>(&v2.contribution_tiers, (arg5 as u64)).required_amount, 1711);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg3, arg6);
        v2.current_progress = v2.current_progress + v3;
        let v4 = UserContribution{
            tier_selected      : arg5,
            amount_contributed : v3,
            contribution_time  : v1,
            rewards_claimed    : false,
        };
        0x2::table::add<address, UserContribution>(&mut v2.contributors, v0, v4);
        0x1::vector::push_back<address>(&mut v2.contributor_addresses, v0);
        v2.total_contributors = v2.total_contributors + 1;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_calling_participations, v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_calling_participations, v0), arg4);
        } else {
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v5, arg4);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_calling_participations, v0, v5);
            0x1::vector::push_back<address>(&mut arg0.calling_users, v0);
        };
        if (v2.current_progress >= v2.goal_amount) {
            v2.status = 4;
            let v6 = DivineCallingCompleted{
                calling_id          : arg4,
                total_contributions : v2.current_progress,
                total_contributors  : v2.total_contributors,
                success             : true,
            };
            0x2::event::emit<DivineCallingCompleted>(v6);
        };
        let v7 = if (0x1::option::is_some<0x1::string::String>(&v2.goal_resource_type)) {
            *0x1::option::borrow<0x1::string::String>(&v2.goal_resource_type)
        } else {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"")
        };
        let v8 = DivineCallingContribution{
            calling_id      : arg4,
            calling_name    : v2.name,
            user            : v0,
            goal_type       : v2.goal_type,
            goal_identifier : v7,
            tier_index      : arg5,
            amount          : v3,
            new_progress    : v2.current_progress,
        };
        0x2::event::emit<DivineCallingContribution>(v8);
    }

    public entry fun contribute_tools_to_divine_calling(arg0: &mut DivineCallingRegistry, arg1: &mut 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: 0x2::object::ID, arg4: u8, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: vector<0x2::object::ID>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_version(arg1);
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::validate_user_representing_land(arg2, v0);
        assert!(0x2::table::contains<0x2::object::ID, DivineCalling>(&arg0.divine_callings, arg3), 1712);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, DivineCalling>(&mut arg0.divine_callings, arg3);
        assert!(v2.visible, 1701);
        assert!(v2.status == 1 || v2.status == 4, 1701);
        assert!(v1 >= v2.start_time, 1714);
        assert!(v1 <= v2.end_time, 1713);
        assert!(v2.goal_type == 1, 1708);
        assert!(0x1::option::is_some<u8>(&v2.goal_tool_type), 1708);
        assert!(!0x2::table::contains<address, UserContribution>(&v2.contributors, v0), 1703);
        assert!((arg4 as u64) < 0x1::vector::length<ContributionTier>(&v2.contribution_tiers), 1702);
        let v3 = 0x1::vector::borrow<ContributionTier>(&v2.contribution_tiers, (arg4 as u64));
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg8);
        assert!(v4 == v3.required_amount, 1711);
        let v5 = 0x2::vec_map::empty<u8, u64>();
        0x2::vec_map::insert<u8, u64>(&mut v5, *0x1::option::borrow<u8>(&v2.goal_tool_type), v3.required_amount);
        let v6 = 0x1::vector::empty<u8>();
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::process_tool_donations(&v5, arg1, &mut v6, arg5, arg6, arg7, arg8, arg10);
        v2.current_progress = v2.current_progress + v4;
        let v7 = UserContribution{
            tier_selected      : arg4,
            amount_contributed : v4,
            contribution_time  : v1,
            rewards_claimed    : false,
        };
        0x2::table::add<address, UserContribution>(&mut v2.contributors, v0, v7);
        0x1::vector::push_back<address>(&mut v2.contributor_addresses, v0);
        v2.total_contributors = v2.total_contributors + 1;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_calling_participations, v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_calling_participations, v0), arg3);
        } else {
            let v8 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v8, arg3);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_calling_participations, v0, v8);
            0x1::vector::push_back<address>(&mut arg0.calling_users, v0);
        };
        if (v2.current_progress >= v2.goal_amount) {
            v2.status = 4;
            let v9 = DivineCallingCompleted{
                calling_id          : arg3,
                total_contributions : v2.current_progress,
                total_contributors  : v2.total_contributors,
                success             : true,
            };
            0x2::event::emit<DivineCallingCompleted>(v9);
        };
        let v10 = if (0x1::option::is_some<u8>(&v2.goal_tool_type)) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string((*0x1::option::borrow<u8>(&v2.goal_tool_type) as u64))
        } else {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"")
        };
        let v11 = DivineCallingContribution{
            calling_id      : arg3,
            calling_name    : v2.name,
            user            : v0,
            goal_type       : v2.goal_type,
            goal_identifier : v10,
            tier_index      : arg4,
            amount          : v4,
            new_progress    : v2.current_progress,
        };
        0x2::event::emit<DivineCallingContribution>(v11);
    }

    public entry fun create_divine_calling_resource(arg0: &0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestAdminCap, arg1: &mut DivineCallingRegistry, arg2: &0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: 0x1::string::String, arg12: u64, arg13: vector<0x1::string::String>, arg14: vector<u64>, arg15: vector<u64>, arg16: vector<vector<0x1::string::String>>, arg17: vector<u64>, arg18: &mut 0x2::tx_context::TxContext) {
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_version(arg2);
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_not_paused(arg2);
        assert!(0x1::string::length(&arg3) > 0, 1720);
        assert!(0x1::string::length(&arg4) > 0, 1720);
        assert!(0x1::string::length(&arg5) > 0, 1720);
        assert!(0x1::string::length(&arg6) > 0, 1720);
        assert!(0x1::string::length(&arg7) > 0, 1720);
        assert!(0x1::string::length(&arg8) > 0, 1720);
        assert!(0x1::string::length(&arg11) > 0, 1720);
        assert!(arg12 > 0, 1711);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg13);
        assert!(v0 >= 1 && v0 <= 5, 1716);
        assert!(0x1::vector::length<u64>(&arg14) == v0, 1716);
        assert!(0x1::vector::length<u64>(&arg15) == v0, 1716);
        let v1 = 0x1::vector::length<vector<0x1::string::String>>(&arg16);
        let v2 = 0;
        while (v2 < v1) {
            assert!(0x1::vector::length<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg16, v2)) == 4, 1715);
            v2 = v2 + 1;
        };
        let v3 = 0x2::object::new(arg18);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x1::vector::empty<ContributionTier>();
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<u64>(&arg14, v6);
            let v8 = *0x1::vector::borrow<u64>(&arg15, v6);
            assert!(v7 > 0, 1711);
            assert!(v8 > 0, 1711);
            let v9 = ContributionTier{
                tier_index       : (v6 as u8),
                tier_name        : *0x1::vector::borrow<0x1::string::String>(&arg13, v6),
                required_amount  : v7,
                influence_reward : v8,
            };
            0x1::vector::push_back<ContributionTier>(&mut v5, v9);
            v6 = v6 + 1;
        };
        let v10 = 0x1::vector::empty<DivineReward>();
        let v11 = 0;
        while (v11 < v1) {
            let v12 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg16, v11);
            let v13 = *0x1::vector::borrow<0x1::string::String>(v12, 1);
            assert!(0x1::string::length(&v13) > 0, 1720);
            let v14 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x1::vector::borrow<0x1::string::String>(v12, 2));
            let v15 = *0x1::vector::borrow<0x1::string::String>(v12, 3);
            assert!(v14 > 0, 1711);
            assert!(0x1::string::length(&v15) > 0, 1720);
            let v16 = DivineReward{
                reward_type     : (0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x1::vector::borrow<0x1::string::String>(v12, 0)) as u8),
                type_identifier : v13,
                amount          : v14,
                description     : v15,
            };
            0x1::vector::push_back<DivineReward>(&mut v10, v16);
            v11 = v11 + 1;
        };
        let v17 = DivineCalling{
            id                          : v4,
            name                        : arg3,
            description                 : arg4,
            objective                   : arg5,
            completion_condition        : arg6,
            flavor_text                 : arg7,
            image_url                   : arg8,
            start_time                  : arg9,
            end_time                    : arg9 + arg10,
            goal_type                   : 0,
            goal_resource_type          : 0x1::option::some<0x1::string::String>(arg11),
            goal_tool_type              : 0x1::option::none<u8>(),
            goal_amount                 : arg12,
            current_progress            : 0,
            contribution_tiers          : v5,
            contributors                : 0x2::table::new<address, UserContribution>(arg18),
            contributor_addresses       : 0x1::vector::empty<address>(),
            total_contributors          : 0,
            total_influence_distributed : 0,
            fixed_rewards               : v10,
            status                      : 1,
            visible                     : true,
            custom_config               : arg17,
        };
        0x2::table::add<0x2::object::ID, DivineCalling>(&mut arg1.divine_callings, v4, v17);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.calling_ids, v4);
        0x2::object::delete(v3);
        let v18 = DivineCallingCreated{
            calling_id  : v4,
            name        : arg3,
            goal_type   : 0,
            goal_amount : arg12,
            start_time  : arg9,
            end_time    : arg9 + arg10,
        };
        0x2::event::emit<DivineCallingCreated>(v18);
    }

    public entry fun create_divine_calling_tool(arg0: &0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestAdminCap, arg1: &mut DivineCallingRegistry, arg2: &0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: u8, arg12: u64, arg13: vector<0x1::string::String>, arg14: vector<u64>, arg15: vector<u64>, arg16: vector<vector<0x1::string::String>>, arg17: vector<u64>, arg18: &mut 0x2::tx_context::TxContext) {
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_version(arg2);
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_not_paused(arg2);
        assert!(0x1::string::length(&arg3) > 0, 1720);
        assert!(0x1::string::length(&arg4) > 0, 1720);
        assert!(0x1::string::length(&arg5) > 0, 1720);
        assert!(0x1::string::length(&arg6) > 0, 1720);
        assert!(0x1::string::length(&arg7) > 0, 1720);
        assert!(0x1::string::length(&arg8) > 0, 1720);
        assert!(arg12 > 0, 1711);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg13);
        assert!(v0 >= 1 && v0 <= 5, 1716);
        assert!(0x1::vector::length<u64>(&arg14) == v0, 1716);
        assert!(0x1::vector::length<u64>(&arg15) == v0, 1716);
        let v1 = 0x1::vector::length<vector<0x1::string::String>>(&arg16);
        let v2 = 0;
        while (v2 < v1) {
            assert!(0x1::vector::length<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg16, v2)) == 4, 1715);
            v2 = v2 + 1;
        };
        let v3 = 0x2::object::new(arg18);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x1::vector::empty<ContributionTier>();
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<u64>(&arg14, v6);
            let v8 = *0x1::vector::borrow<u64>(&arg15, v6);
            assert!(v7 > 0, 1711);
            assert!(v8 > 0, 1711);
            let v9 = ContributionTier{
                tier_index       : (v6 as u8),
                tier_name        : *0x1::vector::borrow<0x1::string::String>(&arg13, v6),
                required_amount  : v7,
                influence_reward : v8,
            };
            0x1::vector::push_back<ContributionTier>(&mut v5, v9);
            v6 = v6 + 1;
        };
        let v10 = 0x1::vector::empty<DivineReward>();
        let v11 = 0;
        while (v11 < v1) {
            let v12 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg16, v11);
            let v13 = *0x1::vector::borrow<0x1::string::String>(v12, 1);
            assert!(0x1::string::length(&v13) > 0, 1720);
            let v14 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x1::vector::borrow<0x1::string::String>(v12, 2));
            let v15 = *0x1::vector::borrow<0x1::string::String>(v12, 3);
            assert!(v14 > 0, 1711);
            assert!(0x1::string::length(&v15) > 0, 1720);
            let v16 = DivineReward{
                reward_type     : (0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x1::vector::borrow<0x1::string::String>(v12, 0)) as u8),
                type_identifier : v13,
                amount          : v14,
                description     : v15,
            };
            0x1::vector::push_back<DivineReward>(&mut v10, v16);
            v11 = v11 + 1;
        };
        let v17 = DivineCalling{
            id                          : v4,
            name                        : arg3,
            description                 : arg4,
            objective                   : arg5,
            completion_condition        : arg6,
            flavor_text                 : arg7,
            image_url                   : arg8,
            start_time                  : arg9,
            end_time                    : arg9 + arg10,
            goal_type                   : 1,
            goal_resource_type          : 0x1::option::none<0x1::string::String>(),
            goal_tool_type              : 0x1::option::some<u8>(arg11),
            goal_amount                 : arg12,
            current_progress            : 0,
            contribution_tiers          : v5,
            contributors                : 0x2::table::new<address, UserContribution>(arg18),
            contributor_addresses       : 0x1::vector::empty<address>(),
            total_contributors          : 0,
            total_influence_distributed : 0,
            fixed_rewards               : v10,
            status                      : 1,
            visible                     : true,
            custom_config               : arg17,
        };
        0x2::table::add<0x2::object::ID, DivineCalling>(&mut arg1.divine_callings, v4, v17);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.calling_ids, v4);
        0x2::object::delete(v3);
        let v18 = DivineCallingCreated{
            calling_id  : v4,
            name        : arg3,
            goal_type   : 1,
            goal_amount : arg12,
            start_time  : arg9,
            end_time    : arg9 + arg10,
        };
        0x2::event::emit<DivineCallingCreated>(v18);
    }

    fun destroy_divine_calling(arg0: DivineCalling) {
        let DivineCalling {
            id                          : _,
            name                        : _,
            description                 : _,
            objective                   : _,
            completion_condition        : _,
            flavor_text                 : _,
            image_url                   : _,
            start_time                  : _,
            end_time                    : _,
            goal_type                   : _,
            goal_resource_type          : _,
            goal_tool_type              : _,
            goal_amount                 : _,
            current_progress            : _,
            contribution_tiers          : _,
            contributors                : v15,
            contributor_addresses       : v16,
            total_contributors          : _,
            total_influence_distributed : _,
            fixed_rewards               : _,
            status                      : _,
            visible                     : _,
            custom_config               : _,
        } = arg0;
        let v23 = v16;
        let v24 = v15;
        if (0x2::table::is_empty<address, UserContribution>(&v24)) {
            0x2::table::destroy_empty<address, UserContribution>(v24);
        } else {
            let v25 = 0;
            while (v25 < 0x1::vector::length<address>(&v23)) {
                let v26 = *0x1::vector::borrow<address>(&v23, v25);
                if (0x2::table::contains<address, UserContribution>(&v24, v26)) {
                    let UserContribution {
                        tier_selected      : _,
                        amount_contributed : _,
                        contribution_time  : _,
                        rewards_claimed    : _,
                    } = 0x2::table::remove<address, UserContribution>(&mut v24, v26);
                };
                v25 = v25 + 1;
            };
            0x2::table::destroy_empty<address, UserContribution>(v24);
        };
    }

    public fun get_divine_callings_batch_with_status(arg0: &DivineCallingRegistry, arg1: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: vector<0x2::object::ID>, arg3: address, arg4: &0x2::clock::Clock) : (vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<u64>, vector<u64>, vector<bool>, vector<u8>, vector<0x1::string::String>, vector<u8>, vector<u64>, vector<u64>, vector<u8>, vector<bool>, vector<u8>, vector<u64>, vector<bool>, vector<bool>, vector<vector<0x1::string::String>>, vector<vector<u64>>, vector<vector<u64>>, vector<vector<0x1::string::String>>, vector<u64>, vector<u64>, vector<bool>) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_rep_land_id(arg1, arg3);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<u64>();
        let v10 = 0x1::vector::empty<bool>();
        let v11 = 0x1::vector::empty<u8>();
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = 0x1::vector::empty<u8>();
        let v14 = 0x1::vector::empty<u64>();
        let v15 = 0x1::vector::empty<u64>();
        let v16 = 0x1::vector::empty<u8>();
        let v17 = 0x1::vector::empty<bool>();
        let v18 = 0x1::vector::empty<u8>();
        let v19 = 0x1::vector::empty<u64>();
        let v20 = 0x1::vector::empty<bool>();
        let v21 = 0x1::vector::empty<bool>();
        let v22 = 0x1::vector::empty<vector<0x1::string::String>>();
        let v23 = 0x1::vector::empty<vector<u64>>();
        let v24 = 0x1::vector::empty<vector<u64>>();
        let v25 = 0x1::vector::empty<vector<0x1::string::String>>();
        let v26 = 0x1::vector::empty<u64>();
        let v27 = 0x1::vector::empty<u64>();
        let v28 = 0x1::vector::empty<bool>();
        let v29 = 0;
        while (v29 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v30 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v29);
            if (0x2::table::contains<0x2::object::ID, DivineCalling>(&arg0.divine_callings, v30)) {
                let v31 = 0x2::table::borrow<0x2::object::ID, DivineCalling>(&arg0.divine_callings, v30);
                0x1::vector::push_back<0x1::string::String>(&mut v2, v31.name);
                0x1::vector::push_back<0x1::string::String>(&mut v3, v31.description);
                0x1::vector::push_back<0x1::string::String>(&mut v4, v31.objective);
                0x1::vector::push_back<0x1::string::String>(&mut v5, v31.completion_condition);
                0x1::vector::push_back<0x1::string::String>(&mut v6, v31.flavor_text);
                0x1::vector::push_back<0x1::string::String>(&mut v7, v31.image_url);
                0x1::vector::push_back<u64>(&mut v8, v31.start_time);
                0x1::vector::push_back<u64>(&mut v9, v31.end_time);
                0x1::vector::push_back<bool>(&mut v10, v31.visible);
                0x1::vector::push_back<u8>(&mut v11, v31.goal_type);
                let v32 = if (0x1::option::is_some<0x1::string::String>(&v31.goal_resource_type)) {
                    *0x1::option::borrow<0x1::string::String>(&v31.goal_resource_type)
                } else {
                    0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"")
                };
                0x1::vector::push_back<0x1::string::String>(&mut v12, v32);
                let v33 = if (0x1::option::is_some<u8>(&v31.goal_tool_type)) {
                    *0x1::option::borrow<u8>(&v31.goal_tool_type)
                } else {
                    0
                };
                0x1::vector::push_back<u8>(&mut v13, v33);
                0x1::vector::push_back<u64>(&mut v14, v31.goal_amount);
                0x1::vector::push_back<u64>(&mut v15, v31.current_progress);
                let v34 = v31.status;
                let v35 = v34;
                if (v34 == 1) {
                    if (v31.current_progress >= v31.goal_amount) {
                        v35 = 4;
                    } else if (v0 > v31.end_time) {
                        v35 = 5;
                    };
                };
                0x1::vector::push_back<u8>(&mut v16, v35);
                let v36 = 0x2::table::contains<address, UserContribution>(&v31.contributors, arg3);
                0x1::vector::push_back<bool>(&mut v17, v36);
                if (v36) {
                    let v37 = 0x2::table::borrow<address, UserContribution>(&v31.contributors, arg3);
                    0x1::vector::push_back<u8>(&mut v18, v37.tier_selected);
                    0x1::vector::push_back<u64>(&mut v19, v37.amount_contributed);
                    0x1::vector::push_back<bool>(&mut v20, v37.rewards_claimed);
                    let v38 = if (v35 == 4) {
                        if (!v37.rewards_claimed) {
                            0x1::option::is_some<0x2::object::ID>(&v1)
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    0x1::vector::push_back<bool>(&mut v21, v38);
                } else {
                    0x1::vector::push_back<u8>(&mut v18, 255);
                    0x1::vector::push_back<u64>(&mut v19, 0);
                    0x1::vector::push_back<bool>(&mut v20, false);
                    0x1::vector::push_back<bool>(&mut v21, false);
                };
                let v39 = 0x1::vector::empty<0x1::string::String>();
                let v40 = 0x1::vector::empty<u64>();
                let v41 = 0x1::vector::empty<u64>();
                let v42 = 0;
                while (v42 < 0x1::vector::length<ContributionTier>(&v31.contribution_tiers)) {
                    let v43 = 0x1::vector::borrow<ContributionTier>(&v31.contribution_tiers, v42);
                    0x1::vector::push_back<0x1::string::String>(&mut v39, v43.tier_name);
                    0x1::vector::push_back<u64>(&mut v40, v43.required_amount);
                    0x1::vector::push_back<u64>(&mut v41, v43.influence_reward);
                    v42 = v42 + 1;
                };
                0x1::vector::push_back<vector<0x1::string::String>>(&mut v22, v39);
                0x1::vector::push_back<vector<u64>>(&mut v23, v40);
                0x1::vector::push_back<vector<u64>>(&mut v24, v41);
                let v44 = 0x1::vector::empty<0x1::string::String>();
                let v45 = 0;
                while (v45 < 0x1::vector::length<DivineReward>(&v31.fixed_rewards)) {
                    let v46 = 0x1::vector::borrow<DivineReward>(&v31.fixed_rewards, v45);
                    0x1::vector::push_back<0x1::string::String>(&mut v44, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string((v46.reward_type as u64)));
                    0x1::vector::push_back<0x1::string::String>(&mut v44, v46.type_identifier);
                    0x1::vector::push_back<0x1::string::String>(&mut v44, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(v46.amount));
                    0x1::vector::push_back<0x1::string::String>(&mut v44, v46.description);
                    v45 = v45 + 1;
                };
                0x1::vector::push_back<vector<0x1::string::String>>(&mut v25, v44);
                0x1::vector::push_back<u64>(&mut v26, v31.total_contributors);
                let v47 = if (v31.goal_amount == 0) {
                    100
                } else {
                    let v48 = v31.current_progress * 100 / v31.goal_amount;
                    if (v48 > 100) {
                        100
                    } else {
                        v48
                    }
                };
                0x1::vector::push_back<u64>(&mut v27, v47);
                let v49 = if (v35 == 1 || v35 == 4) {
                    if (v0 >= v31.start_time) {
                        v0 <= v31.end_time
                    } else {
                        false
                    }
                } else {
                    false
                };
                0x1::vector::push_back<bool>(&mut v28, v49);
            } else {
                0x1::vector::push_back<0x1::string::String>(&mut v2, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b""));
                0x1::vector::push_back<0x1::string::String>(&mut v3, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b""));
                0x1::vector::push_back<0x1::string::String>(&mut v7, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b""));
                0x1::vector::push_back<u64>(&mut v8, 0);
                0x1::vector::push_back<u64>(&mut v9, 0);
                0x1::vector::push_back<bool>(&mut v10, false);
                0x1::vector::push_back<u8>(&mut v11, 0);
                0x1::vector::push_back<0x1::string::String>(&mut v12, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b""));
                0x1::vector::push_back<u8>(&mut v13, 0);
                0x1::vector::push_back<u64>(&mut v14, 0);
                0x1::vector::push_back<u64>(&mut v15, 0);
                0x1::vector::push_back<u8>(&mut v16, 0);
                0x1::vector::push_back<bool>(&mut v17, false);
                0x1::vector::push_back<u8>(&mut v18, 255);
                0x1::vector::push_back<u64>(&mut v19, 0);
                0x1::vector::push_back<bool>(&mut v20, false);
                0x1::vector::push_back<bool>(&mut v21, false);
                0x1::vector::push_back<vector<0x1::string::String>>(&mut v22, 0x1::vector::empty<0x1::string::String>());
                0x1::vector::push_back<vector<u64>>(&mut v23, 0x1::vector::empty<u64>());
                0x1::vector::push_back<vector<u64>>(&mut v24, 0x1::vector::empty<u64>());
                0x1::vector::push_back<vector<0x1::string::String>>(&mut v25, 0x1::vector::empty<0x1::string::String>());
                0x1::vector::push_back<u64>(&mut v26, 0);
                0x1::vector::push_back<u64>(&mut v27, 0);
                0x1::vector::push_back<bool>(&mut v28, false);
            };
            v29 = v29 + 1;
        };
        (v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28)
    }

    public fun get_divine_callings_paginated(arg0: &DivineCallingRegistry, arg1: u64, arg2: u64) : vector<0x2::object::ID> {
        abort 1717
    }

    public fun get_divine_callings_paginated_v2(arg0: &DivineCallingRegistry, arg1: u64, arg2: u64) : (vector<0x2::object::ID>, u64, bool) {
        let v0 = &arg0.calling_ids;
        let v1 = 0x1::vector::length<0x2::object::ID>(v0);
        if (arg1 >= v1 || arg2 == 0) {
            return (0x1::vector::empty<0x2::object::ID>(), v1, false)
        };
        let v2 = arg1 + arg2;
        let v3 = if (v2 > v1) {
            v1
        } else {
            v2
        };
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (arg1 < v3) {
            0x1::vector::push_back<0x2::object::ID>(&mut v4, *0x1::vector::borrow<0x2::object::ID>(v0, arg1));
            arg1 = arg1 + 1;
        };
        (v4, v1, v3 < v1)
    }

    public entry fun init_divine_calling_registry(arg0: &0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DivineCallingRegistry{
            id                          : 0x2::object::new(arg1),
            divine_callings             : 0x2::table::new<0x2::object::ID, DivineCalling>(arg1),
            user_calling_participations : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            calling_ids                 : 0x1::vector::empty<0x2::object::ID>(),
            calling_users               : 0x1::vector::empty<address>(),
            total_influence_distributed : 0,
        };
        0x2::transfer::share_object<DivineCallingRegistry>(v0);
    }

    fun mint_and_transfer_coin_by_type<T0>(arg0: &mut 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<T0>(0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::get_package_cap(arg0), arg1, 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::get_quest_system_id(arg0), arg2, arg4), arg3);
    }

    public entry fun remove_divine_calling(arg0: &0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestAdminCap, arg1: &mut DivineCallingRegistry, arg2: &0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::QuestSystem, arg3: 0x2::object::ID) {
        0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests::check_version(arg2);
        assert!(0x2::table::contains<0x2::object::ID, DivineCalling>(&arg1.divine_callings, arg3), 1712);
        let v0 = 0x2::table::remove<0x2::object::ID, DivineCalling>(&mut arg1.divine_callings, arg3);
        let v1 = v0.contributor_addresses;
        arg1.total_influence_distributed = arg1.total_influence_distributed - v0.total_influence_distributed;
        destroy_divine_calling(v0);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&arg1.calling_ids, &arg3);
        if (v2) {
            0x1::vector::remove<0x2::object::ID>(&mut arg1.calling_ids, v3);
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v1)) {
            let v5 = *0x1::vector::borrow<address>(&v1, v4);
            if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_calling_participations, v5)) {
                let v6 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_calling_participations, v5);
                let (v7, v8) = 0x1::vector::index_of<0x2::object::ID>(v6, &arg3);
                if (v7) {
                    0x1::vector::remove<0x2::object::ID>(v6, v8);
                };
                if (0x1::vector::is_empty<0x2::object::ID>(v6)) {
                    0x2::table::remove<address, vector<0x2::object::ID>>(&mut arg1.user_calling_participations, v5);
                    let (v9, v10) = 0x1::vector::index_of<address>(&arg1.calling_users, &v5);
                    if (v9) {
                        0x1::vector::remove<address>(&mut arg1.calling_users, v10);
                    };
                };
            };
            v4 = v4 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

