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

    struct ToolResourceCost has copy, drop {
        resource_type: u8,
        amount: u64,
    }

    public fun check_version(arg0: &CraftingToolQueue) {
        assert!(arg0.version == 3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    public entry fun claim(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun claim_instant(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: &0x2::random::Random, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun extract_crafting_details_fields(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &CraftingDetails) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, (arg1.item_type as u64));
        0x1::vector::push_back<u64>(v1, (arg1.item_category as u64));
        0x1::vector::push_back<u64>(v1, arg1.started_at);
        0x1::vector::push_back<u64>(v1, arg1.duration);
        v0
    }

    public fun get_all_crafters(arg0: &CraftingToolQueue) : vector<address> {
        arg0.crafters
    }

    public fun get_amount(arg0: &ToolResourceCost) : u64 {
        arg0.amount
    }

    public fun get_resource_type(arg0: &ToolResourceCost) : u8 {
        arg0.resource_type
    }

    public fun get_tool_resource_costs(arg0: u8) : vector<ToolResourceCost> {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public fun get_user_jobs(arg0: &CraftingToolQueue, arg1: address) : vector<CraftingDetails> {
        if (!0x2::table::contains<address, vector<CraftingDetails>>(&arg0.users, arg1)) {
            return 0x1::vector::empty<CraftingDetails>()
        };
        *0x2::table::borrow<address, vector<CraftingDetails>>(&arg0.users, arg1)
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_abacus(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_axe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_banner_flag(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_basket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg7: &0x2::random::Random, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_bucket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_crystal_ball(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_hammer_chisel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_handsaw(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_idol_of_axomamma(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_iron_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_kiln(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_magic_siphon(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg7: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg8: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg9: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::kiosk::KioskOwnerCap, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_pickaxe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_shovel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg6: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_signal_horn(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_stone_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_wheelbarrow(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun instant_craft_wooden_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg5: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun set_paused(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun start_crafting_abacus(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_axe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_banner_flag(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_basket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_bucket(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_crystal_ball(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_hammer_chisel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_handsaw(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_idol_of_axomamma(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_iron_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_kiln(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg4: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_magic_siphon(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg7: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_pickaxe(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_shovel(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_signal_horn(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_stone_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_wheelbarrow(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun start_crafting_wooden_runepen(arg0: &mut CraftingToolQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg4: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg5: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun update_treasury_address(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &CraftingAdminCap, arg1: &mut CraftingToolQueue, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 3, 13906837661856825343);
        arg1.version = 3;
    }

    // decompiled from Move bytecode v6
}

