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

    public fun check_version(arg0: &MaterialProcessingQueue) {
        assert!(arg0.version == 3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    public entry fun claim(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_instant(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun extract_processing_details(arg0: &ProcessingDetails) : (u8, u64, u64, u64, 0x2::object::ID) {
        (arg0.resource_type, arg0.amount, arg0.started_at, arg0.duration, arg0.tool_nft_id)
    }

    public fun get_all_processors(arg0: &MaterialProcessingQueue) : vector<address> {
        arg0.processors
    }

    public fun get_user_jobs(arg0: &MaterialProcessingQueue, arg1: address) : vector<ProcessingDetails> {
        if (!0x2::table::contains<address, vector<ProcessingDetails>>(&arg0.users, arg1)) {
            return 0x1::vector::empty<ProcessingDetails>()
        };
        *0x2::table::borrow<address, vector<ProcessingDetails>>(&arg0.users, arg1)
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun instant_process_gilded_prism(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun instant_process_gold_bar(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun instant_process_iron_bar(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun instant_process_iron_q_rune(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun instant_process_stone_block(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun instant_process_stone_q_rune(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun instant_process_wooden_plank(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun instant_process_wooden_q_rune(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun set_paused(arg0: &ProcessingAdminCap, arg1: &mut MaterialProcessingQueue, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun start_processing_gilded_prism(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun start_processing_gold_bar(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun start_processing_iron_bar(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun start_processing_iron_q_rune(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun start_processing_stone_block(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun start_processing_stone_q_rune(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun start_processing_wooden_plank(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun start_processing_wooden_q_rune(arg0: &mut MaterialProcessingQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg6: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_treasury_address(arg0: &ProcessingAdminCap, arg1: &mut MaterialProcessingQueue, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &ProcessingAdminCap, arg1: &mut MaterialProcessingQueue, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 3, 13906836347596832767);
        arg1.version = 3;
    }

    // decompiled from Move bytecode v6
}

