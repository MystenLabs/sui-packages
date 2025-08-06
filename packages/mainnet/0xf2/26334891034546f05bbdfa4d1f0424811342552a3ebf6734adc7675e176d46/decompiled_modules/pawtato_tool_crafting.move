module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_crafting {
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
    }

    struct CraftingDetails has copy, drop, store {
        item_type: u8,
        item_category: u8,
        started_at: u64,
        duration: u64,
    }

    struct CraftingAdminCap has key {
        id: 0x2::object::UID,
    }

    fun add_user_to_crafters(arg0: &mut vector<address>, arg1: address) {
        if (!is_user_in_crafters(arg0, arg1)) {
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

    public fun check_version(arg0: &CraftingToolQueue) {
        assert!(arg0.version == 2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    public entry fun claim(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v1 = 0x2::table::borrow_mut<address, vector<CraftingDetails>>(&mut arg0.users, v0);
        assert!(arg3 < 0x1::vector::length<CraftingDetails>(v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v2 = 0x1::vector::borrow<CraftingDetails>(v1, arg3);
        assert!(0x2::clock::timestamp_ms(arg2) >= v2.started_at + v2.duration, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_ready_yet());
        let v3 = v2.item_type;
        0x1::vector::remove<CraftingDetails>(v1, arg3);
        if (0x1::vector::is_empty<CraftingDetails>(v1)) {
            let v4 = &mut arg0.crafters;
            remove_user_from_crafters(v4, v0);
        };
        let v5 = ToolCraftingClaimed{
            user          : v0,
            item_type     : v3,
            item_category : v2.item_category,
            index         : arg3,
            nft_id        : mint_and_lock_tool(arg1, v3, arg4, arg5, arg6, arg7, arg8),
        };
        0x2::event::emit<ToolCraftingClaimed>(v5);
    }

    public entry fun claim_instant(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: &0x2::random::Random, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v2 = 0x2::table::borrow_mut<address, vector<CraftingDetails>>(&mut arg0.users, v0);
        assert!(arg3 < 0x1::vector::length<CraftingDetails>(v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_job_not_found());
        let v3 = 0x1::vector::borrow<CraftingDetails>(v2, arg3);
        let v4 = v3.started_at + v3.duration;
        let v5 = if (v1 >= v4) {
            0
        } else {
            v4 - v1
        };
        let v6 = calculate_instant_fee(v5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v6, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.treasury_address);
        let v7 = v3.item_type;
        0x1::vector::remove<CraftingDetails>(v2, arg3);
        if (0x1::vector::is_empty<CraftingDetails>(v2)) {
            let v8 = &mut arg0.crafters;
            remove_user_from_crafters(v8, v0);
        };
        let v9 = ToolCraftingInstant{
            user          : v0,
            item_type     : v7,
            item_category : v3.item_category,
            nft_id        : mint_and_lock_tool(arg1, v7, arg5, arg6, arg7, arg8, arg9),
            instant_fee   : v6,
        };
        0x2::event::emit<ToolCraftingInstant>(v9);
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
        } else {
            assert!(arg0 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            1209600000
        }
    }

    fun get_slot_limit(arg0: address, arg1: u8) : u64 {
        1
    }

    public fun get_user_jobs(arg0: &CraftingToolQueue, arg1: address) : vector<CraftingDetails> {
        if (!0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, arg1)) {
            return 0x1::vector::empty<CraftingDetails>()
        };
        *0x2::table::borrow<address, vector<CraftingDetails>>(&arg0.users, arg1)
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CraftingAdminCap{id: 0x2::object::new(arg1)};
        let v1 = CraftingToolQueue{
            id               : 0x2::object::new(arg1),
            treasury_address : @0xcd3fdfe7af0dfffe74d9581b148f82355c11c0ba143fdc91bcddc74d798333d0,
            users            : 0x2::table::new<address, vector<CraftingDetails>>(arg1),
            crafters         : 0x1::vector::empty<address>(),
            version          : 2,
            paused           : false,
        };
        0x2::transfer::transfer<CraftingAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<CraftingToolQueue>(v1);
    }

    public entry fun instant_craft_abacus(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_abacus();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg4, 3000000000, arg11);
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg1, arg5, 30000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 5000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_axe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg4, 5000000000, arg11);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg5, 1000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 5000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_bucket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg4, 5000000000, arg11);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg5, 1000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 5000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_crystal_ball(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_crystal_ball();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg1, arg4, 250000000, arg11);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg5, 3000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 10000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_hammer_chisel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg1, arg4, 30000000000, arg11);
        validate_and_consume_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg1, arg5, 30000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 5000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_handsaw(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg1, arg4, 30000000000, arg11);
        validate_and_consume_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg1, arg5, 30000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 5000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_idol_of_axomamma(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg1, arg4, 3000000000, arg11);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg5, 10000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 25000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_kiln(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg1, arg4, 50000000000, arg11);
        validate_and_consume_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg1, arg5, 30000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 25000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_magic_siphon(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg7: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg8: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg9: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::kiosk::KioskOwnerCap, arg13: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg1, arg4, 10000000000, arg13);
        validate_and_consume_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg1, arg5, 25000000000, arg13);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg6, 100000000000, arg13);
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg7, 250000000000, arg13);
        validate_and_consume_coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg1, arg8, 250000000000, arg13);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg9, arg10, arg11, arg12, arg13),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_pickaxe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg4, 15000000000, arg11);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg5, 5000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 5000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_signal_horn(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_signal_horn();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg1, arg4, 25000000000, arg11);
        validate_and_consume_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg1, arg5, 1000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 5000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    public entry fun instant_craft_wheelbarrow(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow();
        let v2 = calculate_instant_fee(get_crafting_duration(v1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg4, 10000000000, arg11);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg5, 2000000000, arg11);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg6, 5000000000, arg11);
        let v3 = ToolCraftingInstant{
            user          : v0,
            item_type     : v1,
            item_category : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::get_item_category_by_type(v1),
            nft_id        : mint_and_lock_tool(arg2, v1, arg7, arg8, arg9, arg10, arg11),
            instant_fee   : v2,
        };
        0x2::event::emit<ToolCraftingInstant>(v3);
    }

    fun is_user_in_crafters(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun mint_and_lock_tool(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg1: u8, arg2: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg3: &0x2::random::Random, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::internal_mint_tool(arg0, arg1, arg3, 0x1::string::utf8(b"crafting"), arg6);
        0x2::kiosk::lock<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg4, arg5, arg2, v0);
        0x2::object::id<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&v0)
    }

    fun remove_user_from_crafters(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_paused(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun start_crafting_abacus(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg3, 3000000000, arg6);
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg1, arg4, 30000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 5000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_abacus(), arg6);
    }

    public entry fun start_crafting_axe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg3, 5000000000, arg6);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg4, 1000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 5000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_axe(), arg6);
    }

    public entry fun start_crafting_bucket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg3, 5000000000, arg6);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg4, 1000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 5000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_bucket(), arg6);
    }

    public entry fun start_crafting_crystal_ball(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg1, arg3, 250000000, arg6);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg4, 3000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 10000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_crystal_ball(), arg6);
    }

    public entry fun start_crafting_hammer_chisel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg1, arg3, 30000000000, arg6);
        validate_and_consume_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg1, arg4, 30000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 5000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_hammer_chisel(), arg6);
    }

    public entry fun start_crafting_handsaw(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg1, arg3, 30000000000, arg6);
        validate_and_consume_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg1, arg4, 30000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 5000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_handsaw(), arg6);
    }

    public entry fun start_crafting_idol_of_axomamma(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg1, arg3, 3000000000, arg6);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg4, 10000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 25000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_idol_of_axomamma(), arg6);
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

    public entry fun start_crafting_kiln(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg4: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg1, arg3, 50000000000, arg6);
        validate_and_consume_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg1, arg4, 30000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 25000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_kiln(), arg6);
    }

    public entry fun start_crafting_magic_siphon(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg7: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg8: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg1, arg3, 10000000000, arg8);
        validate_and_consume_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg1, arg4, 25000000000, arg8);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg5, 100000000000, arg8);
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg6, 250000000000, arg8);
        validate_and_consume_coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg1, arg7, 250000000000, arg8);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_magic_siphon(), arg8);
    }

    public entry fun start_crafting_pickaxe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg3, 15000000000, arg6);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg4, 5000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 5000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_pickaxe(), arg6);
    }

    public entry fun start_crafting_signal_horn(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg1, arg3, 25000000000, arg6);
        validate_and_consume_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg1, arg4, 1000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 5000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_signal_horn(), arg6);
    }

    public entry fun start_crafting_wheelbarrow(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_and_consume_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg1, arg3, 10000000000, arg6);
        validate_and_consume_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg1, arg4, 2000000000, arg6);
        validate_and_consume_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg1, arg5, 5000000000, arg6);
        start_crafting_internal(arg0, arg2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items::item_type_wheelbarrow(), arg6);
    }

    public entry fun update_treasury_address(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 2, 13906841282514255871);
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

