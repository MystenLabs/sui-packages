module 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::pawtato_quests {
    struct PAWTATO_QUESTS has drop {
        dummy_field: bool,
    }

    struct QuestSystem has key {
        id: 0x2::object::UID,
        treasury_address: address,
        version: u64,
        paused: bool,
        pawtato_package_cap: 0x1::option::Option<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        pending_burned_tool_ids: vector<0x2::object::ID>,
        burned_tool_ids: vector<0x2::object::ID>,
    }

    struct WorldQuestRegistry has key {
        id: 0x2::object::UID,
        quests: 0x2::table::Table<0x2::object::ID, WorldQuest>,
        user_quest_completions: 0x2::table::Table<address, vector<0x2::object::ID>>,
        quest_ids: vector<0x2::object::ID>,
        quest_users: vector<address>,
        total_influence_distributed: u64,
    }

    struct QuestAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WorldQuest has drop, store {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        objective: 0x1::string::String,
        flavor_text: 0x1::string::String,
        image_url: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        resource_requirements: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        tool_requirements: 0x2::vec_map::VecMap<u8, u64>,
        influence_reward: u64,
        completed_by: vector<address>,
        total_influence_distributed: u64,
        visible: bool,
    }

    struct RepresentingLandSet has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        land_type: 0x1::string::String,
    }

    struct WorldQuestCreated has copy, drop {
        quest_id: 0x2::object::ID,
        name: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        influence_reward: u64,
    }

    struct WorldQuestCompleted has copy, drop {
        quest_id: 0x2::object::ID,
        user: address,
        land_id: 0x2::object::ID,
        influence_reward: u64,
        resources_donated: vector<0x1::string::String>,
        tools_donated: vector<u8>,
    }

    fun add_land_influence(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_land(arg1, arg2, arg3));
        let v1 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Influence");
        let v2 = if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(v0, &v1)) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1))
        } else {
            0
        };
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_land_influence(arg0, arg1, arg3, v2 + arg4);
    }

    public entry fun add_pawtato_package_cap(arg0: &QuestAdminCap, arg1: &mut QuestSystem, arg2: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap) {
        0x1::option::fill<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&mut arg1.pawtato_package_cap, arg2);
    }

    public entry fun burn_all_pending_tools(arg0: &mut QuestSystem, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg2: &mut 0x2::transfer_policy::TransferPolicyCap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        if (0x1::vector::length<0x2::object::ID>(&arg0.pending_burned_tool_ids) == 0) {
            return
        };
        0x2::transfer_policy::remove_rule<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Config>(arg1, arg2);
        let v0 = 0;
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.pending_burned_tool_ids) && v0 < 100) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.pending_burned_tool_ids);
            let (v2, v3) = 0x2::kiosk::purchase_with_cap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, 0x2::kiosk::list_with_purchase_cap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, &arg0.kiosk_cap, v1, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
            let v4 = v3;
            if (0x2::transfer_policy::has_rule<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg1)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, &mut v4, 0x2::coin::zero<0x2::sui::SUI>(arg4));
            };
            let (_, _, _) = 0x2::transfer_policy::confirm_request<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, v4);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::burn_tool_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), v2, arg3, arg4);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.burned_tool_ids, v1);
            v0 = v0 + 1;
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2);
    }

    fun check_not_paused(arg0: &QuestSystem) {
        assert!(!arg0.paused, 701);
    }

    fun check_version(arg0: &QuestSystem) {
        assert!(arg0.version == 1, 700);
    }

    public entry fun complete_world_quest_with_resource<T0>(arg0: &mut QuestSystem, arg1: &mut WorldQuestRegistry, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: vector<0x2::object::ID>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = validate_user_representing_land(arg2, v0);
        assert!(0x2::table::contains<0x2::object::ID, WorldQuest>(&arg1.quests, arg4), 704);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, WorldQuest>(&mut arg1.quests, arg4);
        validate_quest_active(v2, 0x2::clock::timestamp_ms(arg11));
        validate_quest_not_completed(v2, v0);
        let v3 = v2.influence_reward;
        0x1::vector::push_back<address>(&mut v2.completed_by, v0);
        v2.total_influence_distributed = v2.total_influence_distributed + v3;
        let v4 = v2.tool_requirements;
        let v5 = v2.resource_requirements;
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x1::vector::empty<u8>();
        let v8 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        if (v9 > 0) {
            let v10 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x2::sui::SUI>();
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v5, &v10)) {
                assert!(v9 >= *0x2::vec_map::get<0x1::string::String, u64>(&v5, &v10), 707);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.treasury_address);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v10, v9);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        let v11 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>();
        let v12 = 0x2::coin::value<T0>(&arg6);
        if (v12 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v5, &v11)) {
                assert!(v12 >= *0x2::vec_map::get<0x1::string::String, u64>(&v5, &v11), 707);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg3, arg6);
                0x1::vector::push_back<0x1::string::String>(&mut v6, v11);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v11, v12);
            } else {
                0x2::coin::destroy_zero<T0>(arg6);
            };
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
        let v13 = 0;
        while (v13 < 0x2::vec_map::length<0x1::string::String, u64>(&v5)) {
            let (v14, v15) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&v5, v13);
            if (*v15 > 0) {
                assert!(0x2::vec_map::contains<0x1::string::String, u64>(&v8, v14), 707);
                assert!(*0x2::vec_map::get<0x1::string::String, u64>(&v8, v14) >= *v15, 707);
            };
            v13 = v13 + 1;
        };
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_quest_completions, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.user_quest_completions, v0, 0x1::vector::empty<0x2::object::ID>());
            0x1::vector::push_back<address>(&mut arg1.quest_users, v0);
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_quest_completions, v0), arg4);
        let v16 = 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::calculate_boosted_influence_reward(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg2, v0, v3, arg11);
        arg1.total_influence_distributed = arg1.total_influence_distributed + v16;
        let v17 = &mut v7;
        process_tool_donations(&v4, arg0, v17, arg7, arg8, arg9, arg10, arg12);
        add_land_influence(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg2, v0, v1, v16);
        let v18 = WorldQuestCompleted{
            quest_id          : arg4,
            user              : v0,
            land_id           : v1,
            influence_reward  : v16,
            resources_donated : v6,
            tools_donated     : v7,
        };
        0x2::event::emit<WorldQuestCompleted>(v18);
    }

    public entry fun complete_world_quest_with_resources<T0, T1, T2>(arg0: &mut QuestSystem, arg1: &mut WorldQuestRegistry, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T2>, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg12: vector<0x2::object::ID>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = validate_user_representing_land(arg2, v0);
        assert!(0x2::table::contains<0x2::object::ID, WorldQuest>(&arg1.quests, arg4), 704);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, WorldQuest>(&mut arg1.quests, arg4);
        validate_quest_active(v2, 0x2::clock::timestamp_ms(arg13));
        validate_quest_not_completed(v2, v0);
        let v3 = v2.influence_reward;
        0x1::vector::push_back<address>(&mut v2.completed_by, v0);
        v2.total_influence_distributed = v2.total_influence_distributed + v3;
        let v4 = v2.tool_requirements;
        let v5 = v2.resource_requirements;
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x1::vector::empty<u8>();
        let v8 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        if (v9 > 0) {
            let v10 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<0x2::sui::SUI>();
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v5, &v10)) {
                assert!(v9 >= *0x2::vec_map::get<0x1::string::String, u64>(&v5, &v10), 707);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.treasury_address);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v10, v9);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        let v11 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>();
        let v12 = 0x2::coin::value<T0>(&arg6);
        if (v12 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v5, &v11)) {
                assert!(v12 >= *0x2::vec_map::get<0x1::string::String, u64>(&v5, &v11), 707);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg3, arg6);
                0x1::vector::push_back<0x1::string::String>(&mut v6, v11);
                if (0x2::vec_map::contains<0x1::string::String, u64>(&v8, &v11)) {
                    let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut v8, &v11);
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v11, *0x2::vec_map::get<0x1::string::String, u64>(&v8, &v11) + v12);
                } else {
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v11, v12);
                };
            } else {
                0x2::coin::destroy_zero<T0>(arg6);
            };
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
        let v15 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T1>();
        let v16 = 0x2::coin::value<T1>(&arg7);
        if (v16 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v5, &v15)) {
                assert!(v16 >= *0x2::vec_map::get<0x1::string::String, u64>(&v5, &v15), 707);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T1>(arg3, arg7);
                0x1::vector::push_back<0x1::string::String>(&mut v6, v15);
                if (0x2::vec_map::contains<0x1::string::String, u64>(&v8, &v15)) {
                    let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut v8, &v15);
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v15, *0x2::vec_map::get<0x1::string::String, u64>(&v8, &v15) + v16);
                } else {
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v15, v16);
                };
            } else {
                0x2::coin::destroy_zero<T1>(arg7);
            };
        } else {
            0x2::coin::destroy_zero<T1>(arg7);
        };
        let v19 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T2>();
        let v20 = 0x2::coin::value<T2>(&arg8);
        if (v20 > 0) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v5, &v19)) {
                assert!(v20 >= *0x2::vec_map::get<0x1::string::String, u64>(&v5, &v19), 707);
                0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T2>(arg3, arg8);
                0x1::vector::push_back<0x1::string::String>(&mut v6, v19);
                if (0x2::vec_map::contains<0x1::string::String, u64>(&v8, &v19)) {
                    let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut v8, &v19);
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v19, *0x2::vec_map::get<0x1::string::String, u64>(&v8, &v19) + v20);
                } else {
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v8, v19, v20);
                };
            } else {
                0x2::coin::destroy_zero<T2>(arg8);
            };
        } else {
            0x2::coin::destroy_zero<T2>(arg8);
        };
        let v23 = 0;
        while (v23 < 0x2::vec_map::length<0x1::string::String, u64>(&v5)) {
            let (v24, v25) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&v5, v23);
            if (*v25 > 0) {
                assert!(0x2::vec_map::contains<0x1::string::String, u64>(&v8, v24), 707);
                assert!(*0x2::vec_map::get<0x1::string::String, u64>(&v8, v24) >= *v25, 707);
            };
            v23 = v23 + 1;
        };
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_quest_completions, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.user_quest_completions, v0, 0x1::vector::empty<0x2::object::ID>());
            0x1::vector::push_back<address>(&mut arg1.quest_users, v0);
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_quest_completions, v0), arg4);
        let v26 = 0x916f631158cdbfdc24e19cefb496c729ba8522fa8aab35c4b4875bef9544d2e5::quest_helpers::calculate_boosted_influence_reward(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg2, v0, v3, arg13);
        arg1.total_influence_distributed = arg1.total_influence_distributed + v26;
        let v27 = &mut v7;
        process_tool_donations(&v4, arg0, v27, arg9, arg10, arg11, arg12, arg14);
        add_land_influence(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg2, v0, v1, v26);
        let v28 = WorldQuestCompleted{
            quest_id          : arg4,
            user              : v0,
            land_id           : v1,
            influence_reward  : v26,
            resources_donated : v6,
            tools_donated     : v7,
        };
        0x2::event::emit<WorldQuestCompleted>(v28);
    }

    public entry fun create_world_quest(arg0: &QuestAdminCap, arg1: &mut QuestSystem, arg2: &mut WorldQuestRegistry, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: vector<0x1::string::String>, arg10: vector<u64>, arg11: vector<u8>, arg12: vector<u64>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = 0x2::object::new(arg14);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg9)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg9, v3), *0x1::vector::borrow<u64>(&arg10, v3));
            v3 = v3 + 1;
        };
        let v4 = 0x2::vec_map::empty<u8, u64>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&arg11)) {
            0x2::vec_map::insert<u8, u64>(&mut v4, *0x1::vector::borrow<u8>(&arg11, v5), *0x1::vector::borrow<u64>(&arg12, v5));
            v5 = v5 + 1;
        };
        let v6 = WorldQuest{
            id                          : v1,
            name                        : arg3,
            description                 : arg4,
            objective                   : arg5,
            flavor_text                 : arg6,
            image_url                   : arg7,
            start_time                  : arg8,
            end_time                    : arg8 + 172800000,
            resource_requirements       : v2,
            tool_requirements           : v4,
            influence_reward            : arg13,
            completed_by                : 0x1::vector::empty<address>(),
            total_influence_distributed : 0,
            visible                     : true,
        };
        0x2::table::add<0x2::object::ID, WorldQuest>(&mut arg2.quests, v1, v6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.quest_ids, v1);
        0x2::object::delete(v0);
        let v7 = WorldQuestCreated{
            quest_id         : v1,
            name             : arg3,
            start_time       : arg8,
            end_time         : arg8 + 172800000,
            influence_reward : arg13,
        };
        0x2::event::emit<WorldQuestCreated>(v7);
    }

    public fun get_all_quest_ids(arg0: &WorldQuestRegistry) : vector<0x2::object::ID> {
        arg0.quest_ids
    }

    public fun get_all_quest_users(arg0: &WorldQuestRegistry) : vector<address> {
        arg0.quest_users
    }

    public fun get_pending_burned_tool_count(arg0: &QuestSystem) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.pending_burned_tool_ids)
    }

    public fun get_quest_completion_count(arg0: &WorldQuestRegistry, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, WorldQuest>(&arg0.quests, arg1), 704);
        0x1::vector::length<address>(&0x2::table::borrow<0x2::object::ID, WorldQuest>(&arg0.quests, arg1).completed_by)
    }

    public fun get_quest_details(arg0: &WorldQuestRegistry, arg1: 0x2::object::ID) : (0x1::string::String, 0x1::string::String, u64, u64, u64) {
        assert!(0x2::table::contains<0x2::object::ID, WorldQuest>(&arg0.quests, arg1), 704);
        let v0 = 0x2::table::borrow<0x2::object::ID, WorldQuest>(&arg0.quests, arg1);
        (v0.name, v0.description, v0.start_time, v0.end_time, v0.influence_reward)
    }

    public fun get_quest_influence_distributed(arg0: &WorldQuestRegistry, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, WorldQuest>(&arg0.quests, arg1), 704);
        0x2::table::borrow<0x2::object::ID, WorldQuest>(&arg0.quests, arg1).total_influence_distributed
    }

    public fun get_quest_info(arg0: &WorldQuestRegistry, arg1: 0x2::object::ID) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64) {
        assert!(0x2::table::contains<0x2::object::ID, WorldQuest>(&arg0.quests, arg1), 704);
        let v0 = 0x2::table::borrow<0x2::object::ID, WorldQuest>(&arg0.quests, arg1);
        (v0.name, v0.description, v0.objective, v0.flavor_text, v0.image_url, v0.start_time, v0.end_time, v0.influence_reward, 0x1::vector::length<address>(&v0.completed_by))
    }

    public fun get_quest_status_for_user(arg0: &WorldQuestRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u64) : u8 {
        if (!0x2::table::contains<0x2::object::ID, WorldQuest>(&arg0.quests, arg1)) {
            return 3
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, WorldQuest>(&arg0.quests, arg1);
        if (0x1::vector::contains<address>(&v0.completed_by, &arg2)) {
            return 2
        };
        if (arg3 > v0.end_time) {
            return 3
        };
        if (arg3 < v0.start_time) {
            return 0
        };
        1
    }

    public fun get_quests_batch_with_user_status(arg0: &WorldQuestRegistry, arg1: vector<0x2::object::ID>, arg2: address, arg3: u64) : (vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u8>) {
        abort 711
    }

    public fun get_quests_batch_with_user_status_v2(arg0: &WorldQuestRegistry, arg1: vector<0x2::object::ID>, arg2: address, arg3: u64) : (vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<vector<0x1::string::String>>, vector<vector<u64>>, vector<vector<u8>>, vector<vector<u64>>, vector<u8>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<vector<0x1::string::String>>();
        let v10 = 0x1::vector::empty<vector<u64>>();
        let v11 = 0x1::vector::empty<vector<u8>>();
        let v12 = 0x1::vector::empty<vector<u64>>();
        let v13 = 0x1::vector::empty<u8>();
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v15 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v14);
            if (0x2::table::contains<0x2::object::ID, WorldQuest>(&arg0.quests, v15)) {
                let v16 = 0x2::table::borrow<0x2::object::ID, WorldQuest>(&arg0.quests, v15);
                if (!v16.visible) {
                    v14 = v14 + 1;
                    0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b""));
                    0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b""));
                    0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b""));
                    0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b""));
                    0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b""));
                    0x1::vector::push_back<u64>(&mut v5, 0);
                    0x1::vector::push_back<u64>(&mut v6, 0);
                    0x1::vector::push_back<u64>(&mut v7, 0);
                    0x1::vector::push_back<u64>(&mut v8, 0);
                    0x1::vector::push_back<vector<0x1::string::String>>(&mut v9, 0x1::vector::empty<0x1::string::String>());
                    0x1::vector::push_back<vector<u64>>(&mut v10, 0x1::vector::empty<u64>());
                    0x1::vector::push_back<vector<u8>>(&mut v11, 0x1::vector::empty<u8>());
                    0x1::vector::push_back<vector<u64>>(&mut v12, 0x1::vector::empty<u64>());
                    0x1::vector::push_back<u8>(&mut v13, 3);
                    continue
                };
                0x1::vector::push_back<0x1::string::String>(&mut v0, v16.name);
                0x1::vector::push_back<0x1::string::String>(&mut v1, v16.description);
                0x1::vector::push_back<0x1::string::String>(&mut v2, v16.objective);
                0x1::vector::push_back<0x1::string::String>(&mut v3, v16.flavor_text);
                0x1::vector::push_back<0x1::string::String>(&mut v4, v16.image_url);
                0x1::vector::push_back<u64>(&mut v5, v16.start_time);
                0x1::vector::push_back<u64>(&mut v6, v16.end_time);
                0x1::vector::push_back<u64>(&mut v7, v16.influence_reward);
                0x1::vector::push_back<u64>(&mut v8, 0x1::vector::length<address>(&v16.completed_by));
                let v17 = 0x1::vector::empty<0x1::string::String>();
                let v18 = 0x1::vector::empty<u64>();
                let v19 = 0;
                while (v19 < 0x2::vec_map::length<0x1::string::String, u64>(&v16.resource_requirements)) {
                    let (v20, v21) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&v16.resource_requirements, v19);
                    0x1::vector::push_back<0x1::string::String>(&mut v17, *v20);
                    0x1::vector::push_back<u64>(&mut v18, *v21);
                    v19 = v19 + 1;
                };
                0x1::vector::push_back<vector<0x1::string::String>>(&mut v9, v17);
                0x1::vector::push_back<vector<u64>>(&mut v10, v18);
                let v22 = 0x1::vector::empty<u8>();
                let v23 = 0x1::vector::empty<u64>();
                let v24 = 0;
                while (v24 < 0x2::vec_map::length<u8, u64>(&v16.tool_requirements)) {
                    let (v25, v26) = 0x2::vec_map::get_entry_by_idx<u8, u64>(&v16.tool_requirements, v24);
                    0x1::vector::push_back<u8>(&mut v22, *v25);
                    0x1::vector::push_back<u64>(&mut v23, *v26);
                    v24 = v24 + 1;
                };
                0x1::vector::push_back<vector<u8>>(&mut v11, v22);
                0x1::vector::push_back<vector<u64>>(&mut v12, v23);
                let v27 = if (0x1::vector::contains<address>(&v16.completed_by, &arg2)) {
                    2
                } else if (arg3 > v16.end_time) {
                    3
                } else if (arg3 < v16.start_time) {
                    0
                } else {
                    1
                };
                0x1::vector::push_back<u8>(&mut v13, v27);
            } else {
                0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b""));
                0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b""));
                0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b""));
                0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b""));
                0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b""));
                0x1::vector::push_back<u64>(&mut v5, 0);
                0x1::vector::push_back<u64>(&mut v6, 0);
                0x1::vector::push_back<u64>(&mut v7, 0);
                0x1::vector::push_back<u64>(&mut v8, 0);
                0x1::vector::push_back<vector<0x1::string::String>>(&mut v9, 0x1::vector::empty<0x1::string::String>());
                0x1::vector::push_back<vector<u64>>(&mut v10, 0x1::vector::empty<u64>());
                0x1::vector::push_back<vector<u8>>(&mut v11, 0x1::vector::empty<u8>());
                0x1::vector::push_back<vector<u64>>(&mut v12, 0x1::vector::empty<u64>());
                0x1::vector::push_back<u8>(&mut v13, 3);
            };
            v14 = v14 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13)
    }

    public fun get_quests_paginated(arg0: &WorldQuestRegistry, arg1: u64, arg2: u64) : (vector<0x2::object::ID>, u64, bool) {
        let v0 = &arg0.quest_ids;
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

    public fun get_total_burned_tool_count(arg0: &QuestSystem) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.burned_tool_ids)
    }

    public fun get_total_influence_distributed(arg0: &WorldQuestRegistry) : u64 {
        arg0.total_influence_distributed
    }

    public fun get_user_quest_completions(arg0: &WorldQuestRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_quest_completions, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_quest_completions, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun has_user_completed_quest(arg0: &WorldQuestRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, WorldQuest>(&arg0.quests, arg2)) {
            return false
        };
        0x1::vector::contains<address>(&0x2::table::borrow<0x2::object::ID, WorldQuest>(&arg0.quests, arg2).completed_by, &arg1)
    }

    fun init(arg0: PAWTATO_QUESTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = QuestAdminCap{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = QuestSystem{
            id                      : 0x2::object::new(arg1),
            treasury_address        : 0x2::tx_context::sender(arg1),
            version                 : 1,
            paused                  : false,
            pawtato_package_cap     : 0x1::option::none<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(),
            kiosk                   : v1,
            kiosk_cap               : v2,
            pending_burned_tool_ids : 0x1::vector::empty<0x2::object::ID>(),
            burned_tool_ids         : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v4 = WorldQuestRegistry{
            id                          : 0x2::object::new(arg1),
            quests                      : 0x2::table::new<0x2::object::ID, WorldQuest>(arg1),
            user_quest_completions      : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            quest_ids                   : 0x1::vector::empty<0x2::object::ID>(),
            quest_users                 : 0x1::vector::empty<address>(),
            total_influence_distributed : 0,
        };
        0x2::transfer::share_object<QuestSystem>(v3);
        0x2::transfer::share_object<WorldQuestRegistry>(v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAWTATO_QUESTS>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<QuestAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun process_tool_donations(arg0: &0x2::vec_map::VecMap<u8, u64>, arg1: &mut QuestSystem, arg2: &mut vector<u8>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: vector<0x2::object::ID>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<u8, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg6)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg6, v1);
            let (v3, v4) = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::borrow_for_modification<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg3, arg4, v2, arg7);
            let v5 = v3;
            let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_item_type(&v5);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::mark_tool_as_burned_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg1.pawtato_package_cap), &mut v5);
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::return_after_modification<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg1.kiosk, &arg1.kiosk_cap, v5, v4, arg5, arg7);
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.pending_burned_tool_ids, v2);
            if (0x2::vec_map::contains<u8, u64>(&v0, &v6)) {
                let v7 = 0x2::vec_map::get_mut<u8, u64>(&mut v0, &v6);
                *v7 = *v7 + 1;
            } else {
                0x2::vec_map::insert<u8, u64>(&mut v0, v6, 1);
            };
            0x1::vector::push_back<u8>(arg2, v6);
            v1 = v1 + 1;
        };
        let v8 = 0;
        while (v8 < 0x2::vec_map::length<u8, u64>(arg0)) {
            let (v9, v10) = 0x2::vec_map::get_entry_by_idx<u8, u64>(arg0, v8);
            if (0x2::vec_map::contains<u8, u64>(&v0, v9)) {
                assert!(*0x2::vec_map::get<u8, u64>(&v0, v9) >= *v10, 710);
            } else if (*v10 > 0) {
                abort 710
            };
            v8 = v8 + 1;
        };
    }

    public entry fun remove_world_quest(arg0: &QuestAdminCap, arg1: &mut QuestSystem, arg2: &mut WorldQuestRegistry, arg3: 0x2::object::ID) {
        check_version(arg1);
        assert!(0x1::vector::is_empty<address>(&0x2::table::borrow<0x2::object::ID, WorldQuest>(&arg2.quests, arg3).completed_by), 708);
        0x2::table::remove<0x2::object::ID, WorldQuest>(&mut arg2.quests, arg3);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg2.quest_ids, &arg3);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg2.quest_ids, v1);
        };
    }

    public entry fun set_paused(arg0: &QuestAdminCap, arg1: &mut QuestSystem, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_quest_visibility(arg0: &QuestAdminCap, arg1: &mut QuestSystem, arg2: &mut WorldQuestRegistry, arg3: 0x2::object::ID, arg4: bool) {
        check_version(arg1);
        assert!(0x2::table::contains<0x2::object::ID, WorldQuest>(&arg2.quests, arg3), 704);
        0x2::table::borrow_mut<0x2::object::ID, WorldQuest>(&mut arg2.quests, arg3).visible = arg4;
    }

    public entry fun set_representing_land(arg0: &mut QuestSystem, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Land Type");
        let v2 = *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_land(arg1, v0, arg2)), &v1);
        let v3 = if (v2 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Estate")) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Estate")
        } else {
            assert!(v2 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Province"), 702);
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Province")
        };
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_rep_land(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg1, v0, arg2);
        let v4 = RepresentingLandSet{
            user      : v0,
            nft_id    : arg2,
            land_type : v3,
        };
        0x2::event::emit<RepresentingLandSet>(v4);
    }

    public entry fun update_treasury_address(arg0: &QuestAdminCap, arg1: &mut QuestSystem, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &QuestAdminCap, arg1: &mut QuestSystem) {
        assert!(arg1.version < 1, 13906835097761349631);
        arg1.version = 1;
    }

    fun validate_quest_active(arg0: &WorldQuest, arg1: u64) {
        assert!(arg1 >= arg0.start_time, 705);
        assert!(arg1 <= arg0.end_time, 709);
    }

    fun validate_quest_not_completed(arg0: &WorldQuest, arg1: address) {
        assert!(!0x1::vector::contains<address>(&arg0.completed_by, &arg1), 706);
    }

    fun validate_user_representing_land(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: address) : 0x2::object::ID {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_rep_land_id(arg0, arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 703);
        0x1::option::destroy_some<0x2::object::ID>(v0)
    }

    // decompiled from Move bytecode v6
}

