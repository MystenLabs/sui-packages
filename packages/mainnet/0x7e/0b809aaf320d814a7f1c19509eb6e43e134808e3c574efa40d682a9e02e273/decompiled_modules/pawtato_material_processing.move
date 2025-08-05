module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_material_processing {
    struct MaterialProcessingStarted has copy, drop {
        user: address,
        coin_type: 0x1::string::String,
        amount: u64,
        index: u64,
        started_at: u64,
        duration: u64,
        tool_nft_id: 0x2::object::ID,
    }

    struct MaterialProcessingClaimed has copy, drop {
        user: address,
        coin_type: 0x1::string::String,
        amount: u64,
        index: u64,
    }

    struct MaterialProcessingInstant has copy, drop {
        user: address,
        coin_type: 0x1::string::String,
        amount: u64,
        instant_fee: u64,
    }

    struct MaterialProcessingQueue has key {
        id: 0x2::object::UID,
        treasury_address: address,
        users: 0x2::table::Table<address, vector<ProcessingDetails>>,
        processors: vector<address>,
        version: u64,
        paused: bool,
    }

    struct ProcessingDetails has copy, drop, store {
        resource_type: u8,
        amount: u64,
        started_at: u64,
        duration: u64,
        tool_nft_id: 0x2::object::ID,
    }

    struct ProcessingAdminCap has key {
        id: 0x2::object::UID,
    }

    fun add_user_to_processors(arg0: &mut vector<address>, arg1: address) {
        if (!is_user_in_processors(arg0, arg1)) {
            0x1::vector::push_back<address>(arg0, arg1);
        };
    }

    fun calculate_instant_fee(arg0: u64) : u64 {
        let v0 = arg0 / 3600000;
        let v1 = v0;
        if (arg0 % 3600000 > 0) {
            v1 = v0 + 1;
        };
        v1 * 50000000
    }

    public fun check_version(arg0: &MaterialProcessingQueue) {
        assert!(arg0.version == 2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    public entry fun claim(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, vector<ProcessingDetails>>(&arg0.users, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v1 = 0x2::table::borrow_mut<address, vector<ProcessingDetails>>(&mut arg0.users, v0);
        assert!(arg4 < 0x1::vector::length<ProcessingDetails>(v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v2 = 0x1::vector::borrow<ProcessingDetails>(v1, arg4);
        assert!(0x2::clock::timestamp_ms(arg3) >= v2.started_at + v2.duration, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_ready_yet());
        let v3 = v2.resource_type;
        let v4 = v2.amount;
        0x1::vector::remove<ProcessingDetails>(v1, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::clear_item_cooldown(arg1, v0, v2.tool_nft_id);
        if (0x1::vector::is_empty<ProcessingDetails>(v1)) {
            let v5 = &mut arg0.processors;
            remove_user_from_processors(v5, v0);
        };
        if (v3 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
            mint_and_transfer_wooden_plank(arg2, arg0, v4 * 1000000000, v0, arg5);
        } else if (v3 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
            mint_and_transfer_stone_block(arg2, arg0, v4 * 1000000000, v0, arg5);
        } else if (v3 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar()) {
            mint_and_transfer_iron_bar(arg2, arg0, v4 * 1000000000, v0, arg5);
        } else if (v3 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar()) {
            mint_and_transfer_gold_bar(arg2, arg0, v4 * 1000000000, v0, arg5);
        };
        let v6 = MaterialProcessingClaimed{
            user      : v0,
            coin_type : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::get_coin_type_by_resource_type(v3),
            amount    : v4,
            index     : arg4,
        };
        0x2::event::emit<MaterialProcessingClaimed>(v6);
    }

    public entry fun claim_instant(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<address, vector<ProcessingDetails>>(&arg0.users, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v2 = 0x2::table::borrow_mut<address, vector<ProcessingDetails>>(&mut arg0.users, v0);
        assert!(arg4 < 0x1::vector::length<ProcessingDetails>(v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v3 = 0x1::vector::borrow<ProcessingDetails>(v2, arg4);
        let v4 = v3.started_at + v3.duration;
        let v5 = if (v1 >= v4) {
            0
        } else {
            v4 - v1
        };
        let v6 = calculate_instant_fee(v5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v6, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.treasury_address);
        let v7 = v3.resource_type;
        let v8 = v3.amount;
        0x1::vector::remove<ProcessingDetails>(v2, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::clear_item_cooldown(arg1, v0, v3.tool_nft_id);
        if (0x1::vector::is_empty<ProcessingDetails>(v2)) {
            let v9 = &mut arg0.processors;
            remove_user_from_processors(v9, v0);
        };
        if (v7 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
            mint_and_transfer_wooden_plank(arg2, arg0, v8 * 1000000000, v0, arg6);
        } else if (v7 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
            mint_and_transfer_stone_block(arg2, arg0, v8 * 1000000000, v0, arg6);
        } else if (v7 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar()) {
            mint_and_transfer_iron_bar(arg2, arg0, v8 * 1000000000, v0, arg6);
        } else if (v7 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar()) {
            mint_and_transfer_gold_bar(arg2, arg0, v8 * 1000000000, v0, arg6);
        };
        let v10 = MaterialProcessingInstant{
            user        : v0,
            coin_type   : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::get_coin_type_by_resource_type(v7),
            amount      : v8,
            instant_fee : v6,
        };
        0x2::event::emit<MaterialProcessingInstant>(v10);
    }

    fun find_available_tool(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &MaterialProcessingQueue, arg2: address, arg3: u8) : 0x2::object::ID {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg0, arg2, get_required_tool_type(arg3));
        assert!(0x1::vector::length<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0) > 0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_missing_required_tool());
        let v1 = if (0x2::table::contains<address, vector<ProcessingDetails>>(&arg1.users, arg2)) {
            0x2::table::borrow<address, vector<ProcessingDetails>>(&arg1.users, arg2)
        } else {
            let v2 = 0x1::vector::empty<ProcessingDetails>();
            &v2
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0)) {
            let v4 = 0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0, v3);
            let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_cooldown_ts(v4);
            let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(v4);
            if (0x1::option::is_none<u64>(&v5) && !is_tool_in_use(v1, v6)) {
                return v6
            };
            v3 = v3 + 1;
        };
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_missing_required_tool()
    }

    fun get_base_resource_cost(arg0: u8, arg1: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: 0x2::object::ID) : u64 {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg1, arg2, get_required_tool_type(arg0));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0)) {
            let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v0, v1));
            if (v2 == arg3) {
                let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_processing(arg1, arg2, v2);
                let v4 = if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
                    1000000000
                } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
                    1000000000
                } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar()) {
                    1000000000
                } else {
                    assert!(arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
                    1000000000
                };
                let v5 = if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
                    0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_handsaw_resource_multiplier(v3)
                } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
                    0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_hammer_chisel_resource_multiplier(v3)
                } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar() || arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar()) {
                    0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_kiln_resource_multiplier(v3)
                } else {
                    10000
                };
                return v4 * v5 / 10000
            };
            v1 = v1 + 1;
        };
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_missing_required_tool()
    }

    fun get_processing_duration(arg0: u8, arg1: u64, arg2: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: address, arg4: 0x2::object::ID) : u64 {
        let v0 = if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
            120000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
            120000
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar()) {
            240000
        } else {
            assert!(arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            240000
        };
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_items_by_type(arg2, arg3, get_required_tool_type(arg0));
        let v2 = 0;
        let v3 = false;
        let v4 = 10000;
        while (v2 < 0x1::vector::length<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v1) && !v3) {
            let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_item_info_nft_id(0x1::vector::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::ItemInfoDto>(&v1, v2));
            if (v5 == arg4) {
                v3 = true;
                let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_processing(arg2, arg3, v5);
                let v7 = if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
                    0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_handsaw_time_multiplier(v6)
                } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
                    0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_hammer_chisel_time_multiplier(v6)
                } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar() || arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar()) {
                    0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_kiln_time_multiplier(v6)
                } else {
                    10000
                };
                v4 = v7;
            };
            v2 = v2 + 1;
        };
        v0 * arg1 * v4 / 10000
    }

    fun get_required_tool_type(arg0: u8) : u8 {
        if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw()
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel()
        } else if (arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar()) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln()
        } else {
            assert!(arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln()
        }
    }

    fun get_slot_limit(arg0: address, arg1: u8) : u64 {
        1
    }

    public fun get_user_jobs(arg0: &MaterialProcessingQueue, arg1: address) : vector<ProcessingDetails> {
        if (!0x2::table::contains<address, vector<ProcessingDetails>>(&arg0.users, arg1)) {
            return 0x1::vector::empty<ProcessingDetails>()
        };
        *0x2::table::borrow<address, vector<ProcessingDetails>>(&arg0.users, arg1)
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProcessingAdminCap{id: 0x2::object::new(arg1)};
        let v1 = MaterialProcessingQueue{
            id               : 0x2::object::new(arg1),
            treasury_address : @0xcd3fdfe7af0dfffe74d9581b148f82355c11c0ba143fdc91bcddc74d798333d0,
            users            : 0x2::table::new<address, vector<ProcessingDetails>>(arg1),
            processors       : 0x1::vector::empty<address>(),
            version          : 2,
            paused           : false,
        };
        0x2::transfer::transfer<ProcessingAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MaterialProcessingQueue>(v1);
    }

    public entry fun instant_process_gold_bar(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = find_available_tool(arg1, arg0, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar());
        validate_and_consume_coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(arg2, arg5, get_base_resource_cost(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(), arg1, v0, v1) * arg3, arg8);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg2, arg6, 1000000000 * arg3, arg8);
        validate_and_consume_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg2, arg7, 2000000000 * arg3, arg8);
        let v2 = calculate_instant_fee(get_processing_duration(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(), arg3, arg1, v0, v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.treasury_address);
        mint_and_transfer_gold_bar(arg2, arg0, arg3 * 1000000000, v0, arg8);
        let v3 = MaterialProcessingInstant{
            user        : v0,
            coin_type   : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::get_coin_type_by_resource_type(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar()),
            amount      : arg3,
            instant_fee : v2,
        };
        0x2::event::emit<MaterialProcessingInstant>(v3);
    }

    public entry fun instant_process_iron_bar(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = find_available_tool(arg1, arg0, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar());
        validate_and_consume_coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(arg2, arg5, get_base_resource_cost(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(), arg1, v0, v1) * arg3, arg8);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg2, arg6, 1000000000 * arg3, arg8);
        validate_and_consume_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg2, arg7, 2000000000 * arg3, arg8);
        let v2 = calculate_instant_fee(get_processing_duration(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(), arg3, arg1, v0, v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.treasury_address);
        mint_and_transfer_iron_bar(arg2, arg0, arg3 * 1000000000, v0, arg8);
        let v3 = MaterialProcessingInstant{
            user        : v0,
            coin_type   : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::get_coin_type_by_resource_type(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar()),
            amount      : arg3,
            instant_fee : v2,
        };
        0x2::event::emit<MaterialProcessingInstant>(v3);
    }

    public entry fun instant_process_stone_block(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = find_available_tool(arg1, arg0, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block());
        validate_and_consume_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg2, arg5, get_base_resource_cost(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(), arg1, v0, v1) * arg3, arg7);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg2, arg6, 1000000000 * arg3, arg7);
        let v2 = calculate_instant_fee(get_processing_duration(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(), arg3, arg1, v0, v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.treasury_address);
        mint_and_transfer_stone_block(arg2, arg0, arg3 * 1000000000, v0, arg7);
        let v3 = MaterialProcessingInstant{
            user        : v0,
            coin_type   : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::get_coin_type_by_resource_type(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()),
            amount      : arg3,
            instant_fee : v2,
        };
        0x2::event::emit<MaterialProcessingInstant>(v3);
    }

    public entry fun instant_process_wooden_plank(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = find_available_tool(arg1, arg0, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank());
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg2, arg5, get_base_resource_cost(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(), arg1, v0, v1) * arg3, arg7);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg2, arg6, 1000000000 * arg3, arg7);
        let v2 = calculate_instant_fee(get_processing_duration(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(), arg3, arg1, v0, v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.treasury_address);
        mint_and_transfer_wooden_plank(arg2, arg0, arg3 * 1000000000, v0, arg7);
        let v3 = MaterialProcessingInstant{
            user        : v0,
            coin_type   : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::get_coin_type_by_resource_type(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()),
            amount      : arg3,
            instant_fee : v2,
        };
        0x2::event::emit<MaterialProcessingInstant>(v3);
    }

    fun is_tool_in_use(arg0: &vector<ProcessingDetails>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ProcessingDetails>(arg0)) {
            if (0x1::vector::borrow<ProcessingDetails>(arg0, v0).tool_nft_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_user_in_processors(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun mint_and_transfer_gold_bar(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg1: &MaterialProcessingQueue, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_gold_bar_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_gold_bar_new(arg0, 0x2::object::id<MaterialProcessingQueue>(arg1), arg2, arg4), arg3);
    }

    fun mint_and_transfer_iron_bar(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg1: &MaterialProcessingQueue, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_iron_bar_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_iron_bar_new(arg0, 0x2::object::id<MaterialProcessingQueue>(arg1), arg2, arg4), arg3);
    }

    fun mint_and_transfer_stone_block(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg1: &MaterialProcessingQueue, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_stone_block_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_stone_block_new(arg0, 0x2::object::id<MaterialProcessingQueue>(arg1), arg2, arg4), arg3);
    }

    fun mint_and_transfer_wooden_plank(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg1: &MaterialProcessingQueue, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::transfer_wooden_plank_new(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_wooden_plank_new(arg0, 0x2::object::id<MaterialProcessingQueue>(arg1), arg2, arg4), arg3);
    }

    fun remove_user_from_processors(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_paused(arg0: &ProcessingAdminCap, arg1: &mut MaterialProcessingQueue, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun start_processing_gold_bar(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = find_available_tool(arg1, arg0, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar());
        validate_and_consume_coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(arg2, arg5, get_base_resource_cost(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(), arg1, v0, v1) * arg4, arg8);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg2, arg6, 1000000000 * arg4, arg8);
        validate_and_consume_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg2, arg7, 2000000000 * arg4, arg8);
        start_processing_internal(arg0, arg1, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(), arg4, v1, arg8);
    }

    fun start_processing_internal(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &0x2::clock::Clock, arg3: u8, arg4: u64, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!0x2::table::contains<address, vector<ProcessingDetails>>(&arg0.users, v0)) {
            0x2::table::add<address, vector<ProcessingDetails>>(&mut arg0.users, v0, 0x1::vector::empty<ProcessingDetails>());
        };
        let v2 = 0x2::table::borrow_mut<address, vector<ProcessingDetails>>(&mut arg0.users, v0);
        let v3 = &mut arg0.processors;
        add_user_to_processors(v3, v0);
        assert!(validate_slot_limit(v2, arg3, get_slot_limit(v0, arg3)), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_slot_limit_exceeded());
        let v4 = get_processing_duration(arg3, arg4, arg1, v0, arg5);
        let v5 = ProcessingDetails{
            resource_type : arg3,
            amount        : arg4,
            started_at    : v1,
            duration      : v4,
            tool_nft_id   : arg5,
        };
        0x1::vector::push_back<ProcessingDetails>(v2, v5);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_item_cooldown(arg1, v0, arg5, v1 + v4 + 604800000);
        let v6 = MaterialProcessingStarted{
            user        : v0,
            coin_type   : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::get_coin_type_by_resource_type(arg3),
            amount      : arg4,
            index       : 0x1::vector::length<ProcessingDetails>(v2),
            started_at  : v1,
            duration    : v4,
            tool_nft_id : arg5,
        };
        0x2::event::emit<MaterialProcessingStarted>(v6);
    }

    public entry fun start_processing_iron_bar(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = find_available_tool(arg1, arg0, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar());
        validate_and_consume_coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(arg2, arg5, get_base_resource_cost(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(), arg1, v0, v1) * arg4, arg8);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg2, arg6, 1000000000 * arg4, arg8);
        validate_and_consume_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg2, arg7, 2000000000 * arg4, arg8);
        start_processing_internal(arg0, arg1, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar(), arg4, v1, arg8);
    }

    public entry fun start_processing_stone_block(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = find_available_tool(arg1, arg0, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block());
        validate_and_consume_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg2, arg5, get_base_resource_cost(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(), arg1, v0, v1) * arg4, arg7);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg2, arg6, 1000000000 * arg4, arg7);
        start_processing_internal(arg0, arg1, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block(), arg4, v1, arg7);
    }

    public entry fun start_processing_wooden_plank(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = find_available_tool(arg1, arg0, v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank());
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg2, arg5, get_base_resource_cost(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(), arg1, v0, v1) * arg4, arg7);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg2, arg6, 1000000000 * arg4, arg7);
        start_processing_internal(arg0, arg1, arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank(), arg4, v1, arg7);
    }

    public entry fun update_treasury_address(arg0: &ProcessingAdminCap, arg1: &mut MaterialProcessingQueue, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &ProcessingAdminCap, arg1: &mut MaterialProcessingQueue, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 2, 13906838727008714751);
        arg1.version = 2;
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

    fun validate_slot_limit(arg0: &vector<ProcessingDetails>, arg1: u8, arg2: u64) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<ProcessingDetails>(arg0)) {
            if (0x1::vector::borrow<ProcessingDetails>(arg0, v1).resource_type == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0 < arg2
    }

    // decompiled from Move bytecode v6
}

