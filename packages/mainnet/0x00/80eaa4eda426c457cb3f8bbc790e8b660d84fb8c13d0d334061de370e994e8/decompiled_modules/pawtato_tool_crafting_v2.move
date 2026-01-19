module 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2 {
    struct ToolCraftingStarted has copy, drop {
        user: address,
        item_type: u8,
        item_category: u8,
        index: u64,
        started_at: u64,
        duration: u64,
    }

    struct ToolCraftingClaimed has copy, drop {
        user: address,
        item_type: u8,
        item_category: u8,
        index: u64,
        nft_id: 0x2::object::ID,
    }

    struct ToolCraftingInstant has copy, drop {
        user: address,
        item_type: u8,
        item_category: u8,
        nft_id: 0x2::object::ID,
        instant_fee: u64,
    }

    struct CraftingToolQueue has key {
        id: 0x2::object::UID,
        treasury_address: address,
        users: 0x2::table::Table<address, vector<CraftingDetails>>,
        crafters: vector<address>,
        version: u64,
        paused: bool,
        pawtato_package_cap: 0x1::option::Option<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>,
    }

    struct CraftingDetails has copy, drop, store {
        item_type: u8,
        item_category: u8,
        started_at: u64,
        duration: u64,
    }

    struct CraftingAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ToolResourceCost has copy, drop {
        resource_type: u8,
        amount: u64,
    }

    public fun get_user_jobs(arg0: &CraftingToolQueue, arg1: address) : vector<CraftingDetails> {
        if (0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, arg1)) {
            *0x2::table::borrow<address, vector<CraftingDetails>>(&arg0.users, arg1)
        } else {
            0x1::vector::empty<CraftingDetails>()
        }
    }

    fun add_user_to_crafters(arg0: &mut vector<address>, arg1: address) {
        if (!is_user_in_crafters(arg0, arg1)) {
            0x1::vector::push_back<address>(arg0, arg1);
        };
    }

    public entry fun automated_migrate_queue(arg0: &CraftingAdminCap, arg1: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::CraftingToolQueue, arg2: &mut CraftingToolQueue, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg2);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::get_all_crafters(arg1);
        let v1 = 0x1::vector::length<address>(&v0);
        assert!(arg3 < v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(arg3 < arg4, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        let v2 = if (arg4 > v1) {
            v1
        } else {
            arg4
        };
        let v3 = arg3;
        let v4 = 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg2.pawtato_package_cap);
        while (v3 < v2) {
            let v5 = *0x1::vector::borrow<address>(&v0, v3);
            let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::get_user_jobs(arg1, v5);
            if (!0x1::vector::is_empty<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::CraftingDetails>(&v6)) {
                if (!0x2::table::contains<address, vector<CraftingDetails>>(&arg2.users, v5)) {
                    let v7 = convert_old_jobs_to_new_format(v4, v6);
                    if (0x1::vector::is_empty<CraftingDetails>(&v7)) {
                        v3 = v3 + 1;
                        continue
                    };
                    0x2::table::add<address, vector<CraftingDetails>>(&mut arg2.users, v5, v7);
                    0x1::vector::push_back<address>(&mut arg2.crafters, v5);
                };
            };
            v3 = v3 + 1;
        };
    }

    fun calculate_instant_fee_sui(arg0: u64) : u64 {
        let v0 = arg0 / 3600000;
        let v1 = v0;
        if (arg0 % 3600000 > 0) {
            v1 = v0 + 1;
        };
        v1 * 50000000
    }

    fun calculate_instant_fee_tato(arg0: &CraftingToolQueue, arg1: u64) : u64 {
        let v0 = arg1 / 3600000;
        let v1 = v0;
        if (arg1 % 3600000 > 0) {
            v1 = v0 + 1;
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"tato_instant_fee_per_hour")) {
            v1 * *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"tato_instant_fee_per_hour")
        } else {
            0
        }
    }

    public fun check_version(arg0: &CraftingToolQueue) {
        assert!(arg0.version == 3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    public entry fun claim(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        claim_tool_internal(arg0, arg1, arg3, v0, arg4, arg5, arg6, arg7, arg2, arg8);
    }

    public entry fun claim_instant(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: &0x2::random::Random, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_instant_fee_sui(peek_remaining_time(arg0, arg2, arg3, arg9));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.treasury_address);
        claim_instant_internal(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8, arg9);
    }

    fun claim_instant_internal(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: &0x2::random::Random, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v1 = 0x2::table::borrow_mut<address, vector<CraftingDetails>>(&mut arg0.users, v0);
        assert!(arg3 < 0x1::vector::length<CraftingDetails>(v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v2 = 0x1::vector::borrow<CraftingDetails>(v1, arg3);
        let v3 = v2.item_type;
        0x1::vector::remove<CraftingDetails>(v1, arg3);
        let v4 = ToolCraftingInstant{
            user          : v0,
            item_type     : v3,
            item_category : v2.item_category,
            nft_id        : mint_and_lock_tool(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg1, v3, arg5, arg6, arg7, arg8, arg9),
            instant_fee   : arg4,
        };
        0x2::event::emit<ToolCraftingInstant>(v4);
        if (0x1::vector::is_empty<CraftingDetails>(v1)) {
            let v5 = &mut arg0.crafters;
            remove_user_from_crafters(v5, v0);
        };
    }

    public entry fun claim_instant_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg5: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: &0x2::random::Random, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_instant_fee_tato(arg0, peek_remaining_time(arg0, arg2, arg3, arg9));
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg4) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg4, arg0.treasury_address);
        claim_instant_internal(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun claim_multiple(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: vector<u64>, arg4: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v1 > 0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v2 = 0;
        while (v2 < v1) {
            claim_tool_internal(arg0, arg1, *0x1::vector::borrow<u64>(&arg3, v2), v0, arg4, arg5, arg6, arg7, arg2, arg8);
            v2 = v2 + 1;
        };
    }

    fun claim_tool_internal(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: u64, arg3: address, arg4: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, vector<CraftingDetails>>(&mut arg0.users, arg3);
        assert!(arg2 < 0x1::vector::length<CraftingDetails>(v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v1 = 0x1::vector::borrow<CraftingDetails>(v0, arg2);
        assert!(0x2::clock::timestamp_ms(arg8) >= v1.started_at + v1.duration, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_ready_yet());
        let v2 = v1.item_type;
        0x1::vector::remove<CraftingDetails>(v0, arg2);
        let v3 = ToolCraftingClaimed{
            user          : arg3,
            item_type     : v2,
            item_category : v1.item_category,
            index         : arg2,
            nft_id        : mint_and_lock_tool(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg1, v2, arg4, arg5, arg6, arg7, arg9),
        };
        0x2::event::emit<ToolCraftingClaimed>(v3);
        if (0x1::vector::is_empty<CraftingDetails>(v0)) {
            let v4 = &mut arg0.crafters;
            remove_user_from_crafters(v4, arg3);
        };
    }

    fun complete_instant_craft(arg0: &CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: u8, arg3: u64, arg4: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = ToolCraftingInstant{
            user          : v0,
            item_type     : arg2,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(arg2),
            nft_id        : mint_and_lock_tool(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg1, arg2, arg4, arg5, arg6, arg7, arg8),
            instant_fee   : arg3,
        };
        0x2::event::emit<ToolCraftingInstant>(v1);
    }

    fun convert_old_jobs_to_new_format(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: vector<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::CraftingDetails>) : vector<CraftingDetails> {
        let v0 = 0x1::vector::empty<CraftingDetails>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::CraftingDetails>(&arg1)) {
            let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::extract_crafting_details_fields(arg0, 0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::CraftingDetails>(&arg1, v1));
            let v3 = CraftingDetails{
                item_type     : (*0x1::vector::borrow<u64>(&v2, 0) as u8),
                item_category : (*0x1::vector::borrow<u64>(&v2, 1) as u8),
                started_at    : *0x1::vector::borrow<u64>(&v2, 2),
                duration      : *0x1::vector::borrow<u64>(&v2, 3),
            };
            0x1::vector::push_back<CraftingDetails>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    fun craft_2_res<T0, T1>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        validate_and_consume_coin<T0>(arg1, arg4, arg5, arg8);
        validate_and_consume_coin<T1>(arg1, arg6, arg7, arg8);
        start_crafting_internal(arg0, arg2, arg3, arg8);
    }

    fun craft_3_res<T0, T1, T2>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: 0x2::coin::Coin<T2>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        validate_and_consume_coin<T0>(arg1, arg4, arg5, arg10);
        validate_and_consume_coin<T1>(arg1, arg6, arg7, arg10);
        validate_and_consume_coin<T2>(arg1, arg8, arg9, arg10);
        start_crafting_internal(arg0, arg2, arg3, arg10);
    }

    fun craft_4_res<T0, T1, T2, T3>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: 0x2::coin::Coin<T2>, arg9: u64, arg10: 0x2::coin::Coin<T3>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        validate_and_consume_coin<T0>(arg1, arg4, arg5, arg12);
        validate_and_consume_coin<T1>(arg1, arg6, arg7, arg12);
        validate_and_consume_coin<T2>(arg1, arg8, arg9, arg12);
        validate_and_consume_coin<T3>(arg1, arg10, arg11, arg12);
        start_crafting_internal(arg0, arg2, arg3, arg12);
    }

    fun craft_5_res<T0, T1, T2, T3, T4>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: 0x2::coin::Coin<T2>, arg9: u64, arg10: 0x2::coin::Coin<T3>, arg11: u64, arg12: 0x2::coin::Coin<T4>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        validate_and_consume_coin<T0>(arg1, arg4, arg5, arg14);
        validate_and_consume_coin<T1>(arg1, arg6, arg7, arg14);
        validate_and_consume_coin<T2>(arg1, arg8, arg9, arg14);
        validate_and_consume_coin<T3>(arg1, arg10, arg11, arg14);
        validate_and_consume_coin<T4>(arg1, arg12, arg13, arg14);
        start_crafting_internal(arg0, arg2, arg3, arg14);
    }

    fun get_all_crafters_from_old_queue(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting::CraftingToolQueue) : vector<address> {
        0x1::vector::empty<address>()
    }

    public fun get_amount(arg0: &ToolResourceCost) : u64 {
        arg0.amount
    }

    fun get_crafting_duration(arg0: u8) : u64 {
        if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow()) {
            86400000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw()) {
            21600000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel()) {
            21600000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln()) {
            172800000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe()) {
            21600000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket()) {
            21600000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe()) {
            86400000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma()) {
            259200000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_signal_horn()) {
            43200000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_abacus()) {
            21600000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_crystal_ball()) {
            86400000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon()) {
            1209600000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel()) {
            86400000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_basket()) {
            21600000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wooden_runepen()) {
            259200000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_stone_runepen()) {
            259200000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_iron_runepen()) {
            259200000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag()) {
            86400000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_runic_resonator()) {
            1209600000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_sledgehammer()) {
            259200000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_mould_deckle()) {
            259200000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_lapidary_kit()) {
            604800000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_carving_kit()) {
            604800000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_artificers_kit()) {
            604800000
        } else {
            assert!(arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_anvil(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            259200000
        }
    }

    public fun get_resource_type(arg0: &ToolResourceCost) : u8 {
        arg0.resource_type
    }

    fun get_slot_limit(arg0: address, arg1: u8) : u64 {
        1
    }

    public fun get_tool_resource_costs(arg0: u8) : vector<ToolResourceCost> {
        if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow()) {
            let v1 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 10000000000,
            };
            let v2 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 2000000000,
            };
            let v3 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v4 = 0x1::vector::empty<ToolResourceCost>();
            let v5 = &mut v4;
            0x1::vector::push_back<ToolResourceCost>(v5, v1);
            0x1::vector::push_back<ToolResourceCost>(v5, v2);
            0x1::vector::push_back<ToolResourceCost>(v5, v3);
            v4
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw()) {
            let v6 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wood(),
                amount        : 30000000000,
            };
            let v7 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone(),
                amount        : 30000000000,
            };
            let v8 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v9 = 0x1::vector::empty<ToolResourceCost>();
            let v10 = &mut v9;
            0x1::vector::push_back<ToolResourceCost>(v10, v6);
            0x1::vector::push_back<ToolResourceCost>(v10, v7);
            0x1::vector::push_back<ToolResourceCost>(v10, v8);
            v9
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel()) {
            let v11 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wood(),
                amount        : 30000000000,
            };
            let v12 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone(),
                amount        : 30000000000,
            };
            let v13 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v14 = 0x1::vector::empty<ToolResourceCost>();
            let v15 = &mut v14;
            0x1::vector::push_back<ToolResourceCost>(v15, v11);
            0x1::vector::push_back<ToolResourceCost>(v15, v12);
            0x1::vector::push_back<ToolResourceCost>(v15, v13);
            v14
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln()) {
            let v16 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(),
                amount        : 50000000000,
            };
            let v17 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_coal(),
                amount        : 30000000000,
            };
            let v18 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 25000000000,
            };
            let v19 = 0x1::vector::empty<ToolResourceCost>();
            let v20 = &mut v19;
            0x1::vector::push_back<ToolResourceCost>(v20, v16);
            0x1::vector::push_back<ToolResourceCost>(v20, v17);
            0x1::vector::push_back<ToolResourceCost>(v20, v18);
            v19
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe()) {
            let v21 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 5000000000,
            };
            let v22 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 1000000000,
            };
            let v23 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v24 = 0x1::vector::empty<ToolResourceCost>();
            let v25 = &mut v24;
            0x1::vector::push_back<ToolResourceCost>(v25, v21);
            0x1::vector::push_back<ToolResourceCost>(v25, v22);
            0x1::vector::push_back<ToolResourceCost>(v25, v23);
            v24
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket()) {
            let v26 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 5000000000,
            };
            let v27 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 1000000000,
            };
            let v28 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v29 = 0x1::vector::empty<ToolResourceCost>();
            let v30 = &mut v29;
            0x1::vector::push_back<ToolResourceCost>(v30, v26);
            0x1::vector::push_back<ToolResourceCost>(v30, v27);
            0x1::vector::push_back<ToolResourceCost>(v30, v28);
            v29
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe()) {
            let v31 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 15000000000,
            };
            let v32 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 5000000000,
            };
            let v33 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v34 = 0x1::vector::empty<ToolResourceCost>();
            let v35 = &mut v34;
            0x1::vector::push_back<ToolResourceCost>(v35, v31);
            0x1::vector::push_back<ToolResourceCost>(v35, v32);
            0x1::vector::push_back<ToolResourceCost>(v35, v33);
            v34
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma()) {
            let v36 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(),
                amount        : 3000000000,
            };
            let v37 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 10000000000,
            };
            let v38 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 25000000000,
            };
            let v39 = 0x1::vector::empty<ToolResourceCost>();
            let v40 = &mut v39;
            0x1::vector::push_back<ToolResourceCost>(v40, v36);
            0x1::vector::push_back<ToolResourceCost>(v40, v37);
            0x1::vector::push_back<ToolResourceCost>(v40, v38);
            v39
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_signal_horn()) {
            let v41 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wood(),
                amount        : 25000000000,
            };
            let v42 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(),
                amount        : 1000000000,
            };
            let v43 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v44 = 0x1::vector::empty<ToolResourceCost>();
            let v45 = &mut v44;
            0x1::vector::push_back<ToolResourceCost>(v45, v41);
            0x1::vector::push_back<ToolResourceCost>(v45, v42);
            0x1::vector::push_back<ToolResourceCost>(v45, v43);
            v44
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_abacus()) {
            let v46 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 3000000000,
            };
            let v47 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wood(),
                amount        : 30000000000,
            };
            let v48 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v49 = 0x1::vector::empty<ToolResourceCost>();
            let v50 = &mut v49;
            0x1::vector::push_back<ToolResourceCost>(v50, v46);
            0x1::vector::push_back<ToolResourceCost>(v50, v47);
            0x1::vector::push_back<ToolResourceCost>(v50, v48);
            v49
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_crystal_ball()) {
            let v51 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 250000000,
            };
            let v52 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 3000000000,
            };
            let v53 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 10000000000,
            };
            let v54 = 0x1::vector::empty<ToolResourceCost>();
            let v55 = &mut v54;
            0x1::vector::push_back<ToolResourceCost>(v55, v51);
            0x1::vector::push_back<ToolResourceCost>(v55, v52);
            0x1::vector::push_back<ToolResourceCost>(v55, v53);
            v54
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon()) {
            let v56 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 10000000000,
            };
            let v57 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(),
                amount        : 25000000000,
            };
            let v58 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 100000000000,
            };
            let v59 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 250000000000,
            };
            let v60 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(),
                amount        : 250000000000,
            };
            let v61 = 0x1::vector::empty<ToolResourceCost>();
            let v62 = &mut v61;
            0x1::vector::push_back<ToolResourceCost>(v62, v56);
            0x1::vector::push_back<ToolResourceCost>(v62, v57);
            0x1::vector::push_back<ToolResourceCost>(v62, v58);
            0x1::vector::push_back<ToolResourceCost>(v62, v59);
            0x1::vector::push_back<ToolResourceCost>(v62, v60);
            v61
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel()) {
            let v63 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 15000000000,
            };
            let v64 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(),
                amount        : 15000000000,
            };
            let v65 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 3000000000,
            };
            let v66 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 10000000000,
            };
            let v67 = 0x1::vector::empty<ToolResourceCost>();
            let v68 = &mut v67;
            0x1::vector::push_back<ToolResourceCost>(v68, v63);
            0x1::vector::push_back<ToolResourceCost>(v68, v64);
            0x1::vector::push_back<ToolResourceCost>(v68, v65);
            0x1::vector::push_back<ToolResourceCost>(v68, v66);
            v67
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_basket()) {
            let v69 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wood(),
                amount        : 50000000000,
            };
            let v70 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 5000000000,
            };
            let v71 = 0x1::vector::empty<ToolResourceCost>();
            let v72 = &mut v71;
            0x1::vector::push_back<ToolResourceCost>(v72, v69);
            0x1::vector::push_back<ToolResourceCost>(v72, v70);
            v71
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wooden_runepen()) {
            let v73 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 15000000000,
            };
            let v74 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(),
                amount        : 5000000000,
            };
            let v75 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 1000000000,
            };
            let v76 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 25000000000,
            };
            let v77 = 0x1::vector::empty<ToolResourceCost>();
            let v78 = &mut v77;
            0x1::vector::push_back<ToolResourceCost>(v78, v73);
            0x1::vector::push_back<ToolResourceCost>(v78, v74);
            0x1::vector::push_back<ToolResourceCost>(v78, v75);
            0x1::vector::push_back<ToolResourceCost>(v78, v76);
            v77
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_stone_runepen()) {
            let v79 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(),
                amount        : 15000000000,
            };
            let v80 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 5000000000,
            };
            let v81 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 1000000000,
            };
            let v82 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 25000000000,
            };
            let v83 = 0x1::vector::empty<ToolResourceCost>();
            let v84 = &mut v83;
            0x1::vector::push_back<ToolResourceCost>(v84, v79);
            0x1::vector::push_back<ToolResourceCost>(v84, v80);
            0x1::vector::push_back<ToolResourceCost>(v84, v81);
            0x1::vector::push_back<ToolResourceCost>(v84, v82);
            v83
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_iron_runepen()) {
            let v85 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 10000000000,
            };
            let v86 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(),
                amount        : 3000000000,
            };
            let v87 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 1000000000,
            };
            let v88 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 25000000000,
            };
            let v89 = 0x1::vector::empty<ToolResourceCost>();
            let v90 = &mut v89;
            0x1::vector::push_back<ToolResourceCost>(v90, v85);
            0x1::vector::push_back<ToolResourceCost>(v90, v86);
            0x1::vector::push_back<ToolResourceCost>(v90, v87);
            0x1::vector::push_back<ToolResourceCost>(v90, v88);
            v89
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag()) {
            let v91 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 250000000000,
            };
            let v92 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(),
                amount        : 25000000000,
            };
            let v93 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 10000000000,
            };
            let v94 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 100000000000,
            };
            let v95 = 0x1::vector::empty<ToolResourceCost>();
            let v96 = &mut v95;
            0x1::vector::push_back<ToolResourceCost>(v96, v91);
            0x1::vector::push_back<ToolResourceCost>(v96, v92);
            0x1::vector::push_back<ToolResourceCost>(v96, v93);
            0x1::vector::push_back<ToolResourceCost>(v96, v94);
            v95
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_runic_resonator()) {
            let v97 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(),
                amount        : 25000000000,
            };
            let v98 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 25000000000,
            };
            let v99 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 10000000000,
            };
            let v100 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_dawnstone(),
                amount        : 1000000000,
            };
            let v101 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_titanium_splinter(),
                amount        : 1000000000,
            };
            let v102 = 0x1::vector::empty<ToolResourceCost>();
            let v103 = &mut v102;
            0x1::vector::push_back<ToolResourceCost>(v103, v97);
            0x1::vector::push_back<ToolResourceCost>(v103, v98);
            0x1::vector::push_back<ToolResourceCost>(v103, v99);
            0x1::vector::push_back<ToolResourceCost>(v103, v100);
            0x1::vector::push_back<ToolResourceCost>(v103, v101);
            v102
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_sledgehammer()) {
            let v104 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 25000000000,
            };
            let v105 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 25000000000,
            };
            let v106 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 10000000000,
            };
            let v107 = 0x1::vector::empty<ToolResourceCost>();
            let v108 = &mut v107;
            0x1::vector::push_back<ToolResourceCost>(v108, v104);
            0x1::vector::push_back<ToolResourceCost>(v108, v105);
            0x1::vector::push_back<ToolResourceCost>(v108, v106);
            v107
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_mould_deckle()) {
            let v109 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 50000000000,
            };
            let v110 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 5000000000,
            };
            let v111 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 10000000000,
            };
            let v112 = 0x1::vector::empty<ToolResourceCost>();
            let v113 = &mut v112;
            0x1::vector::push_back<ToolResourceCost>(v113, v109);
            0x1::vector::push_back<ToolResourceCost>(v113, v110);
            0x1::vector::push_back<ToolResourceCost>(v113, v111);
            v112
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_lapidary_kit()) {
            let v114 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 50000000000,
            };
            let v115 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(),
                amount        : 50000000000,
            };
            let v116 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 50000000000,
            };
            let v117 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 25000000000,
            };
            let v118 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_dawnstone(),
                amount        : 3000000000,
            };
            let v119 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 100000000000,
            };
            let v120 = 0x1::vector::empty<ToolResourceCost>();
            let v121 = &mut v120;
            0x1::vector::push_back<ToolResourceCost>(v121, v114);
            0x1::vector::push_back<ToolResourceCost>(v121, v115);
            0x1::vector::push_back<ToolResourceCost>(v121, v116);
            0x1::vector::push_back<ToolResourceCost>(v121, v117);
            0x1::vector::push_back<ToolResourceCost>(v121, v118);
            0x1::vector::push_back<ToolResourceCost>(v121, v119);
            v120
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_carving_kit()) {
            let v122 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 50000000000,
            };
            let v123 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(),
                amount        : 50000000000,
            };
            let v124 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 50000000000,
            };
            let v125 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 25000000000,
            };
            let v126 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_chaos_seed(),
                amount        : 3000000000,
            };
            let v127 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 100000000000,
            };
            let v128 = 0x1::vector::empty<ToolResourceCost>();
            let v129 = &mut v128;
            0x1::vector::push_back<ToolResourceCost>(v129, v122);
            0x1::vector::push_back<ToolResourceCost>(v129, v123);
            0x1::vector::push_back<ToolResourceCost>(v129, v124);
            0x1::vector::push_back<ToolResourceCost>(v129, v125);
            0x1::vector::push_back<ToolResourceCost>(v129, v126);
            0x1::vector::push_back<ToolResourceCost>(v129, v127);
            v128
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_artificers_kit()) {
            let v130 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(),
                amount        : 50000000000,
            };
            let v131 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(),
                amount        : 50000000000,
            };
            let v132 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 50000000000,
            };
            let v133 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal(),
                amount        : 25000000000,
            };
            let v134 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_titanium_splinter(),
                amount        : 3000000000,
            };
            let v135 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 100000000000,
            };
            let v136 = 0x1::vector::empty<ToolResourceCost>();
            let v137 = &mut v136;
            0x1::vector::push_back<ToolResourceCost>(v137, v130);
            0x1::vector::push_back<ToolResourceCost>(v137, v131);
            0x1::vector::push_back<ToolResourceCost>(v137, v132);
            0x1::vector::push_back<ToolResourceCost>(v137, v133);
            0x1::vector::push_back<ToolResourceCost>(v137, v134);
            0x1::vector::push_back<ToolResourceCost>(v137, v135);
            v136
        } else {
            assert!(arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_anvil(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            let v138 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(),
                amount        : 25000000000,
            };
            let v139 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wood(),
                amount        : 10000000000,
            };
            let v140 = ToolResourceCost{
                resource_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water(),
                amount        : 10000000000,
            };
            let v141 = 0x1::vector::empty<ToolResourceCost>();
            let v142 = &mut v141;
            0x1::vector::push_back<ToolResourceCost>(v142, v138);
            0x1::vector::push_back<ToolResourceCost>(v142, v139);
            0x1::vector::push_back<ToolResourceCost>(v142, v140);
            v141
        }
    }

    public entry fun initialize(arg0: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CraftingToolQueue{
            id                  : 0x2::object::new(arg1),
            treasury_address    : @0xcd3fdfe7af0dfffe74d9581b148f82355c11c0ba143fdc91bcddc74d798333d0,
            users               : 0x2::table::new<address, vector<CraftingDetails>>(arg1),
            crafters            : 0x1::vector::empty<address>(),
            version             : 3,
            paused              : false,
            pawtato_package_cap : 0x1::option::some<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(arg0),
        };
        let v1 = CraftingAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CraftingAdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<CraftingToolQueue>(v0);
    }

    public entry fun instant_craft<T0, T1, T2, T3, T4, T5>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg12: &0x2::random::Random, arg13: &mut 0x2::kiosk::Kiosk, arg14: &0x2::kiosk::KioskOwnerCap, arg15: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_tato(arg0, get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg3, arg0.treasury_address);
        validate_and_consume_resources<T0, T1, T2, T3, T4, T5>(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg15);
        complete_instant_craft(arg0, arg2, arg4, v0, arg11, arg12, arg13, arg14, arg15);
    }

    fun instant_craft_2_res<T0, T1>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::kiosk::KioskOwnerCap, arg13: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_sui(get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<T0>(arg1, arg5, arg6, arg13);
        validate_and_consume_coin<T1>(arg1, arg7, arg8, arg13);
        complete_instant_craft(arg0, arg2, arg4, v0, arg9, arg10, arg11, arg12, arg13);
    }

    fun instant_craft_2_res_tato<T0, T1>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::kiosk::KioskOwnerCap, arg13: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_tato(arg0, get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<T0>(arg1, arg5, arg6, arg13);
        validate_and_consume_coin<T1>(arg1, arg7, arg8, arg13);
        complete_instant_craft(arg0, arg2, arg4, v0, arg9, arg10, arg11, arg12, arg13);
    }

    fun instant_craft_3_res<T0, T1, T2>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg12: &0x2::random::Random, arg13: &mut 0x2::kiosk::Kiosk, arg14: &0x2::kiosk::KioskOwnerCap, arg15: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_sui(get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<T0>(arg1, arg5, arg6, arg15);
        validate_and_consume_coin<T1>(arg1, arg7, arg8, arg15);
        validate_and_consume_coin<T2>(arg1, arg9, arg10, arg15);
        complete_instant_craft(arg0, arg2, arg4, v0, arg11, arg12, arg13, arg14, arg15);
    }

    fun instant_craft_3_res_tato<T0, T1, T2>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg12: &0x2::random::Random, arg13: &mut 0x2::kiosk::Kiosk, arg14: &0x2::kiosk::KioskOwnerCap, arg15: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_tato(arg0, get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<T0>(arg1, arg5, arg6, arg15);
        validate_and_consume_coin<T1>(arg1, arg7, arg8, arg15);
        validate_and_consume_coin<T2>(arg1, arg9, arg10, arg15);
        complete_instant_craft(arg0, arg2, arg4, v0, arg11, arg12, arg13, arg14, arg15);
    }

    fun instant_craft_4_res<T0, T1, T2, T3>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: 0x2::coin::Coin<T3>, arg12: u64, arg13: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg14: &0x2::random::Random, arg15: &mut 0x2::kiosk::Kiosk, arg16: &0x2::kiosk::KioskOwnerCap, arg17: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_sui(get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<T0>(arg1, arg5, arg6, arg17);
        validate_and_consume_coin<T1>(arg1, arg7, arg8, arg17);
        validate_and_consume_coin<T2>(arg1, arg9, arg10, arg17);
        validate_and_consume_coin<T3>(arg1, arg11, arg12, arg17);
        complete_instant_craft(arg0, arg2, arg4, v0, arg13, arg14, arg15, arg16, arg17);
    }

    fun instant_craft_4_res_tato<T0, T1, T2, T3>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: 0x2::coin::Coin<T3>, arg12: u64, arg13: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg14: &0x2::random::Random, arg15: &mut 0x2::kiosk::Kiosk, arg16: &0x2::kiosk::KioskOwnerCap, arg17: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_tato(arg0, get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<T0>(arg1, arg5, arg6, arg17);
        validate_and_consume_coin<T1>(arg1, arg7, arg8, arg17);
        validate_and_consume_coin<T2>(arg1, arg9, arg10, arg17);
        validate_and_consume_coin<T3>(arg1, arg11, arg12, arg17);
        complete_instant_craft(arg0, arg2, arg4, v0, arg13, arg14, arg15, arg16, arg17);
    }

    fun instant_craft_5_res<T0, T1, T2, T3, T4>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: 0x2::coin::Coin<T3>, arg12: u64, arg13: 0x2::coin::Coin<T4>, arg14: u64, arg15: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg16: &0x2::random::Random, arg17: &mut 0x2::kiosk::Kiosk, arg18: &0x2::kiosk::KioskOwnerCap, arg19: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_sui(get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<T0>(arg1, arg5, arg6, arg19);
        validate_and_consume_coin<T1>(arg1, arg7, arg8, arg19);
        validate_and_consume_coin<T2>(arg1, arg9, arg10, arg19);
        validate_and_consume_coin<T3>(arg1, arg11, arg12, arg19);
        validate_and_consume_coin<T4>(arg1, arg13, arg14, arg19);
        complete_instant_craft(arg0, arg2, arg4, v0, arg15, arg16, arg17, arg18, arg19);
    }

    fun instant_craft_5_res_tato<T0, T1, T2, T3, T4>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: 0x2::coin::Coin<T3>, arg12: u64, arg13: 0x2::coin::Coin<T4>, arg14: u64, arg15: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg16: &0x2::random::Random, arg17: &mut 0x2::kiosk::Kiosk, arg18: &0x2::kiosk::KioskOwnerCap, arg19: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = calculate_instant_fee_tato(arg0, get_crafting_duration(arg4));
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg3) >= v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<T0>(arg1, arg5, arg6, arg19);
        validate_and_consume_coin<T1>(arg1, arg7, arg8, arg19);
        validate_and_consume_coin<T2>(arg1, arg9, arg10, arg19);
        validate_and_consume_coin<T3>(arg1, arg11, arg12, arg19);
        validate_and_consume_coin<T4>(arg1, arg13, arg14, arg19);
        complete_instant_craft(arg0, arg2, arg4, v0, arg15, arg16, arg17, arg18, arg19);
    }

    public entry fun instant_craft_abacus(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_abacus(), arg4, 3000000000, arg5, 30000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_abacus_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_abacus(), arg4, 3000000000, arg5, 30000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_axe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe(), arg4, 5000000000, arg5, 1000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_axe_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe(), arg4, 5000000000, arg5, 1000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_banner_flag(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag(), arg4, 250000000000, arg5, 25000000000, arg6, 10000000000, arg7, 100000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_banner_flag_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag(), arg4, 250000000000, arg5, 25000000000, arg6, 10000000000, arg7, 100000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_basket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg7: &0x2::random::Random, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &mut 0x2::tx_context::TxContext) {
        instant_craft_2_res<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_basket(), arg4, 50000000000, arg5, 5000000000, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun instant_craft_basket_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg7: &0x2::random::Random, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &mut 0x2::tx_context::TxContext) {
        instant_craft_2_res_tato<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_basket(), arg4, 50000000000, arg5, 5000000000, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun instant_craft_bucket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket(), arg4, 5000000000, arg5, 1000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_bucket_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket(), arg4, 5000000000, arg5, 1000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_crystal_ball(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_crystal_ball(), arg4, 250000000, arg5, 3000000000, arg6, 10000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_crystal_ball_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_crystal_ball(), arg4, 250000000, arg5, 3000000000, arg6, 10000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_hammer_chisel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel(), arg4, 30000000000, arg5, 30000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_hammer_chisel_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel(), arg4, 30000000000, arg5, 30000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_handsaw(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw(), arg4, 30000000000, arg5, 30000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_handsaw_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw(), arg4, 30000000000, arg5, 30000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_idol_of_axomamma(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma(), arg4, 3000000000, arg5, 10000000000, arg6, 25000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_idol_of_axomamma_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma(), arg4, 3000000000, arg5, 10000000000, arg6, 25000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_iron_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_iron_runepen(), arg4, 10000000000, arg5, 3000000000, arg6, 1000000000, arg7, 25000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_iron_runepen_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res_tato<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_iron_runepen(), arg4, 10000000000, arg5, 3000000000, arg6, 1000000000, arg7, 25000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_kiln(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln(), arg4, 50000000000, arg5, 30000000000, arg6, 25000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_kiln_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln(), arg4, 50000000000, arg5, 30000000000, arg6, 25000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_magic_siphon(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg7: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg8: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg9: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::kiosk::KioskOwnerCap, arg13: &mut 0x2::tx_context::TxContext) {
        instant_craft_5_res<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon(), arg4, 10000000000, arg5, 25000000000, arg6, 100000000000, arg7, 250000000000, arg8, 250000000000, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun instant_craft_magic_siphon_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg7: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg8: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg9: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::kiosk::KioskOwnerCap, arg13: &mut 0x2::tx_context::TxContext) {
        instant_craft_5_res_tato<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon(), arg4, 10000000000, arg5, 25000000000, arg6, 100000000000, arg7, 250000000000, arg8, 250000000000, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun instant_craft_mould_deckle_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_mould_deckle(), arg4, 50000000000, arg5, 5000000000, arg6, 10000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_pickaxe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe(), arg4, 15000000000, arg5, 5000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_pickaxe_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe(), arg4, 15000000000, arg5, 5000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_runic_resonator(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>, arg8: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg9: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::kiosk::KioskOwnerCap, arg13: &mut 0x2::tx_context::TxContext) {
        instant_craft_5_res<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE, 0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_runic_resonator(), arg4, 25000000000, arg5, 25000000000, arg6, 10000000000, arg7, 1000000000, arg8, 1000000000, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun instant_craft_runic_resonator_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>, arg8: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg9: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::kiosk::KioskOwnerCap, arg13: &mut 0x2::tx_context::TxContext) {
        instant_craft_5_res_tato<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE, 0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_runic_resonator(), arg4, 25000000000, arg5, 25000000000, arg6, 10000000000, arg7, 1000000000, arg8, 1000000000, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun instant_craft_shovel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg6: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel(), arg4, 15000000000, arg5, 15000000000, arg6, 3000000000, arg7, 10000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_shovel_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg6: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel(), arg4, 15000000000, arg5, 15000000000, arg6, 3000000000, arg7, 10000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_signal_horn(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_signal_horn(), arg4, 25000000000, arg5, 1000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_signal_horn_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_signal_horn(), arg4, 25000000000, arg5, 1000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_sledgehammer_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_sledgehammer(), arg4, 25000000000, arg5, 25000000000, arg6, 10000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_stone_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_stone_runepen(), arg4, 15000000000, arg5, 5000000000, arg6, 1000000000, arg7, 25000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_stone_runepen_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res_tato<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_stone_runepen(), arg4, 15000000000, arg5, 5000000000, arg6, 1000000000, arg7, 25000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_wheelbarrow(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), arg4, 10000000000, arg5, 2000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_wheelbarrow_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        instant_craft_3_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), arg4, 10000000000, arg5, 2000000000, arg6, 5000000000, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun instant_craft_wooden_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wooden_runepen(), arg4, 15000000000, arg5, 5000000000, arg6, 1000000000, arg7, 25000000000, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun instant_craft_wooden_runepen_tato(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        instant_craft_4_res_tato<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wooden_runepen(), arg4, 15000000000, arg5, 5000000000, arg6, 1000000000, arg7, 25000000000, arg8, arg9, arg10, arg11, arg12);
    }

    fun is_user_in_crafters(arg0: &vector<address>, arg1: address) : bool {
        0x1::vector::contains<address>(arg0, &arg1)
    }

    fun mint_and_lock_tool(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: u8, arg3: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::mint_tool_secured(arg0, arg1, arg2, arg4, arg3, arg5, arg6, 0x1::string::utf8(b"crafting"), arg7)
    }

    fun peek_remaining_time(arg0: &CraftingToolQueue, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v2 = 0x2::table::borrow<address, vector<CraftingDetails>>(&arg0.users, v0);
        assert!(arg2 < 0x1::vector::length<CraftingDetails>(v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v3 = 0x1::vector::borrow<CraftingDetails>(v2, arg2);
        let v4 = v3.started_at + v3.duration;
        if (v1 >= v4) {
            0
        } else {
            v4 - v1
        }
    }

    fun remove_user_from_crafters(arg0: &mut vector<address>, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(arg0, &arg1);
        if (v0) {
            0x1::vector::remove<address>(arg0, v1);
        };
    }

    public entry fun set_paused(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_tato_instant_fee_per_hour(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: u64) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"tato_instant_fee_per_hour")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, b"tato_instant_fee_per_hour") = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"tato_instant_fee_per_hour", arg2);
        };
    }

    public entry fun start_crafting<T0, T1, T2, T3, T4, T5>(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<T2>, arg7: 0x2::coin::Coin<T3>, arg8: 0x2::coin::Coin<T4>, arg9: 0x2::coin::Coin<T5>, arg10: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        validate_and_consume_resources<T0, T1, T2, T3, T4, T5>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        start_crafting_internal(arg0, arg2, arg3, arg10);
    }

    public entry fun start_crafting_abacus(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_abacus(), arg3, 3000000000, arg4, 30000000000, arg5, 5000000000, arg6);
    }

    public entry fun start_crafting_axe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe(), arg3, 5000000000, arg4, 1000000000, arg5, 5000000000, arg6);
    }

    public entry fun start_crafting_banner_flag(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        craft_4_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_banner_flag(), arg3, 250000000000, arg4, 25000000000, arg5, 10000000000, arg6, 100000000000, arg7);
    }

    public entry fun start_crafting_basket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg5: &mut 0x2::tx_context::TxContext) {
        craft_2_res<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_basket(), arg3, 50000000000, arg4, 5000000000, arg5);
    }

    public entry fun start_crafting_bucket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket(), arg3, 5000000000, arg4, 1000000000, arg5, 5000000000, arg6);
    }

    public entry fun start_crafting_crystal_ball(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_crystal_ball(), arg3, 250000000, arg4, 3000000000, arg5, 10000000000, arg6);
    }

    public entry fun start_crafting_hammer_chisel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel(), arg3, 30000000000, arg4, 30000000000, arg5, 5000000000, arg6);
    }

    public entry fun start_crafting_handsaw(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw(), arg3, 30000000000, arg4, 30000000000, arg5, 5000000000, arg6);
    }

    public entry fun start_crafting_idol_of_axomamma(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma(), arg3, 3000000000, arg4, 10000000000, arg5, 25000000000, arg6);
    }

    fun start_crafting_internal(arg0: &mut CraftingToolQueue, arg1: &0x2::clock::Clock, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (!0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, v0)) {
            0x2::table::add<address, vector<CraftingDetails>>(&mut arg0.users, v0, 0x1::vector::empty<CraftingDetails>());
        };
        let v2 = 0x2::table::borrow_mut<address, vector<CraftingDetails>>(&mut arg0.users, v0);
        let v3 = &mut arg0.crafters;
        add_user_to_crafters(v3, v0);
        assert!(validate_slot_limit(v2, arg2, get_slot_limit(v0, arg2)), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_slot_limit_exceeded());
        let v4 = get_crafting_duration(arg2);
        let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(arg2);
        let v6 = CraftingDetails{
            item_type     : arg2,
            item_category : v5,
            started_at    : v1,
            duration      : v4,
        };
        0x1::vector::push_back<CraftingDetails>(v2, v6);
        let v7 = ToolCraftingStarted{
            user          : v0,
            item_type     : arg2,
            item_category : v5,
            index         : 0x1::vector::length<CraftingDetails>(v2),
            started_at    : v1,
            duration      : v4,
        };
        0x2::event::emit<ToolCraftingStarted>(v7);
    }

    public entry fun start_crafting_iron_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        craft_4_res<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_iron_runepen(), arg3, 10000000000, arg4, 3000000000, arg5, 1000000000, arg6, 25000000000, arg7);
    }

    public entry fun start_crafting_kiln(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg4: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln(), arg3, 50000000000, arg4, 30000000000, arg5, 25000000000, arg6);
    }

    public entry fun start_crafting_magic_siphon(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg7: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg8: &mut 0x2::tx_context::TxContext) {
        craft_5_res<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon(), arg3, 10000000000, arg4, 25000000000, arg5, 100000000000, arg6, 250000000000, arg7, 250000000000, arg8);
    }

    public entry fun start_crafting_mould_deckle(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_mould_deckle(), arg3, 50000000000, arg4, 5000000000, arg5, 10000000000, arg6);
    }

    public entry fun start_crafting_pickaxe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe(), arg3, 15000000000, arg4, 5000000000, arg5, 5000000000, arg6);
    }

    public entry fun start_crafting_runic_resonator(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>, arg7: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg8: &mut 0x2::tx_context::TxContext) {
        craft_5_res<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE, 0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_runic_resonator(), arg3, 25000000000, arg4, 25000000000, arg5, 10000000000, arg6, 1000000000, arg7, 1000000000, arg8);
    }

    public entry fun start_crafting_shovel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        craft_4_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_shovel(), arg3, 15000000000, arg4, 15000000000, arg5, 3000000000, arg6, 10000000000, arg7);
    }

    public entry fun start_crafting_signal_horn(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD, 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_signal_horn(), arg3, 25000000000, arg4, 1000000000, arg5, 5000000000, arg6);
    }

    public entry fun start_crafting_sledgehammer(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_sledgehammer(), arg3, 25000000000, arg4, 25000000000, arg5, 10000000000, arg6);
    }

    public entry fun start_crafting_stone_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        craft_4_res<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_stone_runepen(), arg3, 15000000000, arg4, 5000000000, arg5, 1000000000, arg6, 25000000000, arg7);
    }

    public entry fun start_crafting_wheelbarrow(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        craft_3_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), arg3, 10000000000, arg4, 2000000000, arg5, 5000000000, arg6);
    }

    public entry fun start_crafting_wooden_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        craft_4_res<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK, 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK, 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL, 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wooden_runepen(), arg3, 15000000000, arg4, 5000000000, arg5, 1000000000, arg6, 25000000000, arg7);
    }

    public entry fun update_treasury_address(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue) {
        assert!(arg1.version < 3, 13906847755029970943);
        arg1.version = 3;
    }

    fun validate_and_consume_coin<T0>(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_resources());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    fun validate_and_consume_resources<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: 0x2::coin::Coin<T5>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = get_tool_resource_costs(arg1);
        let v2 = 0x1::vector::length<ToolResourceCost>(&v1);
        if (v2 >= 1) {
            let v3 = 0x1::vector::borrow<ToolResourceCost>(&v1, 0);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::validate_coin_type<T0>(arg0, (v3.resource_type as u64));
            validate_and_consume_coin<T0>(arg0, arg2, v3.amount, arg8);
        } else if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        if (v2 >= 2) {
            let v4 = 0x1::vector::borrow<ToolResourceCost>(&v1, 1);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::validate_coin_type<T1>(arg0, (v4.resource_type as u64));
            validate_and_consume_coin<T1>(arg0, arg3, v4.amount, arg8);
        } else if (0x2::coin::value<T1>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
        if (v2 >= 3) {
            let v5 = 0x1::vector::borrow<ToolResourceCost>(&v1, 2);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::validate_coin_type<T2>(arg0, (v5.resource_type as u64));
            validate_and_consume_coin<T2>(arg0, arg4, v5.amount, arg8);
        } else if (0x2::coin::value<T2>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<T2>(arg4);
        };
        if (v2 >= 4) {
            let v6 = 0x1::vector::borrow<ToolResourceCost>(&v1, 3);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::validate_coin_type<T3>(arg0, (v6.resource_type as u64));
            validate_and_consume_coin<T3>(arg0, arg5, v6.amount, arg8);
        } else if (0x2::coin::value<T3>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(arg5, v0);
        } else {
            0x2::coin::destroy_zero<T3>(arg5);
        };
        if (v2 >= 5) {
            let v7 = 0x1::vector::borrow<ToolResourceCost>(&v1, 4);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::validate_coin_type<T4>(arg0, (v7.resource_type as u64));
            validate_and_consume_coin<T4>(arg0, arg6, v7.amount, arg8);
        } else if (0x2::coin::value<T4>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg6, v0);
        } else {
            0x2::coin::destroy_zero<T4>(arg6);
        };
        if (v2 >= 6) {
            let v8 = 0x1::vector::borrow<ToolResourceCost>(&v1, 5);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::validate_coin_type<T5>(arg0, (v8.resource_type as u64));
            validate_and_consume_coin<T5>(arg0, arg7, v8.amount, arg8);
        } else if (0x2::coin::value<T5>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(arg7, v0);
        } else {
            0x2::coin::destroy_zero<T5>(arg7);
        };
    }

    fun validate_slot_limit(arg0: &vector<CraftingDetails>, arg1: u8, arg2: u64) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<CraftingDetails>(arg0)) {
            if (0x1::vector::borrow<CraftingDetails>(arg0, v1).item_type == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0 < arg2
    }

    // decompiled from Move bytecode v6
}

