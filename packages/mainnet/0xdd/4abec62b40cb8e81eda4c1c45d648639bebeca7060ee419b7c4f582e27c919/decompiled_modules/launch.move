module 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch {
    struct LaunchCreatorCap has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
    }

    struct VaultLaunch has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        website_url: 0x1::string::String,
        twitter_url: 0x1::string::String,
        quote_coin: u8,
        mint_price: u64,
        max_supply: u64,
        goal: u64,
        vesting_duration_ms: u64,
        status: u8,
        total_raised: u64,
        nft_count: u64,
        last_mint_time_ms: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        lp_position_id: 0x1::option::Option<0x2::object::ID>,
        trait_collection_id: 0x1::option::Option<0x2::object::ID>,
        wallet_mints: 0x2::table::Table<address, u64>,
        vault_balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_token_allocation: u64,
        yield_pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_yield_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_activated_at_ms: u64,
        whitelist_enabled: bool,
        whitelist: 0x2::table::Table<address, bool>,
    }

    public fun max_supply(arg0: &VaultLaunch) : u64 {
        arg0.max_supply
    }

    public entry fun activate_pool(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.pool_id), 106);
        assert!(arg1.status == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_awakened(), 105);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg1.pool_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg1.lp_position_id = 0x1::option::some<0x2::object::ID>(arg3);
        arg1.pool_activated_at_ms = v0;
        arg1.status = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_vesting();
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_pool_activated(0x2::object::uid_to_inner(&arg1.id), arg2, arg3, v0);
    }

    public entry fun add_to_whitelist(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: vector<address>) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.whitelist, v1)) {
                0x2::table::add<address, bool>(&mut arg1.whitelist, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun cap_launch_id(arg0: &LaunchCreatorCap) : 0x2::object::ID {
        arg0.launch_id
    }

    public entry fun claim_creator_yield(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.creator_yield_sui) > 0, 107);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.creator_yield_sui), arg2), arg1.creator);
    }

    public entry fun create_launch(arg0: &mut 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::GlobalConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 >= 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::min_mint_price_mist(), 100);
        assert!(arg7 <= 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::max_supply(), 101);
        if (arg5 == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::quote_coin_sui()) {
            assert!(arg8 >= 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::min_goal_sui(), 102);
        } else {
            assert!(arg8 >= 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::min_goal_usdc(), 102);
        };
        let v0 = 0x2::object::new(arg11);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg11);
        let v3 = VaultLaunch{
            id                     : v0,
            creator                : v2,
            name                   : 0x1::string::utf8(arg1),
            description            : 0x1::string::utf8(arg2),
            website_url            : 0x1::string::utf8(arg3),
            twitter_url            : 0x1::string::utf8(arg4),
            quote_coin             : arg5,
            mint_price             : arg6,
            max_supply             : arg7,
            goal                   : arg8,
            vesting_duration_ms    : arg9,
            status                 : 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_genesis(),
            total_raised           : 0,
            nft_count              : 0,
            last_mint_time_ms      : 0,
            pool_id                : 0x1::option::none<0x2::object::ID>(),
            lp_position_id         : 0x1::option::none<0x2::object::ID>(),
            trait_collection_id    : 0x1::option::none<0x2::object::ID>(),
            wallet_mints           : 0x2::table::new<address, u64>(arg11),
            vault_balance_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_token_allocation : 0,
            yield_pool_sui         : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_yield_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_activated_at_ms   : 0,
            whitelist_enabled      : arg10,
            whitelist              : 0x2::table::new<address, bool>(arg11),
        };
        let v4 = LaunchCreatorCap{
            id        : 0x2::object::new(arg11),
            launch_id : v1,
        };
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_launch_created(v1, v2, arg1, arg6, arg7, arg8, arg5);
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::increment_launches(arg0);
        0x2::transfer::share_object<VaultLaunch>(v3);
        0x2::transfer::transfer<LaunchCreatorCap>(v4, v2);
    }

    public fun creator(arg0: &VaultLaunch) : address {
        arg0.creator
    }

    public fun description_ref(arg0: &VaultLaunch) : &0x1::string::String {
        &arg0.description
    }

    public fun drain_vault_for_pool(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        assert!(arg1.total_raised >= arg1.goal, 105);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.vault_balance_sui), arg2)
    }

    public fun goal(arg0: &VaultLaunch) : u64 {
        arg0.goal
    }

    public fun id(arg0: &VaultLaunch) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_whitelisted(arg0: &VaultLaunch, arg1: address) : bool {
        if (!arg0.whitelist_enabled) {
            return true
        };
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun last_mint_time_ms(arg0: &VaultLaunch) : u64 {
        arg0.last_mint_time_ms
    }

    public fun lp_position_id(arg0: &VaultLaunch) : &0x1::option::Option<0x2::object::ID> {
        &arg0.lp_position_id
    }

    public fun mint_price(arg0: &VaultLaunch) : u64 {
        arg0.mint_price
    }

    public fun name(arg0: &VaultLaunch) : &0x1::string::String {
        &arg0.name
    }

    public fun nft_count(arg0: &VaultLaunch) : u64 {
        arg0.nft_count
    }

    public fun pool_activated_at_ms(arg0: &VaultLaunch) : u64 {
        arg0.pool_activated_at_ms
    }

    public fun pool_id(arg0: &VaultLaunch) : &0x1::option::Option<0x2::object::ID> {
        &arg0.pool_id
    }

    public fun quote_coin(arg0: &VaultLaunch) : u8 {
        arg0.quote_coin
    }

    public entry fun receive_swap_fees(arg0: &mut VaultLaunch, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = v0 * 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::creator_swap_bps() / 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::bps_denominator();
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_yield_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.yield_pool_sui, v2);
    }

    public fun record_mint(arg0: &mut VaultLaunch, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        arg0.nft_count = arg0.nft_count + 1;
        arg0.total_raised = arg0.total_raised + arg2;
        arg0.last_mint_time_ms = v0;
        arg0.total_token_allocation = arg0.total_token_allocation + arg3;
        let v1 = if (0x2::table::contains<address, u64>(&arg0.wallet_mints, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.wallet_mints, arg1)
        } else {
            0
        };
        assert!(v1 < arg0.max_supply * 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::max_wallet_bps() / 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::bps_denominator(), 108);
        if (0x2::table::contains<address, u64>(&arg0.wallet_mints, arg1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.wallet_mints, arg1);
            *v2 = *v2 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.wallet_mints, arg1, 1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault_balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        if (arg0.total_raised >= arg0.goal && arg0.status == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_genesis()) {
            arg0.status = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_awakened();
            0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_goal_reached(0x2::object::uid_to_inner(&arg0.id), arg0.total_raised, arg0.nft_count, v0);
        };
    }

    public entry fun remove_from_whitelist(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: address) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        if (0x2::table::contains<address, bool>(&arg1.whitelist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.whitelist, arg2);
        };
    }

    public fun set_creator(arg0: &mut VaultLaunch, arg1: address) {
        arg0.creator = arg1;
    }

    public fun set_status(arg0: &mut VaultLaunch, arg1: u8) {
        arg0.status = arg1;
    }

    public entry fun set_trait_collection(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: 0x2::object::ID) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        arg1.trait_collection_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public fun status(arg0: &VaultLaunch) : u8 {
        arg0.status
    }

    public fun total_raised(arg0: &VaultLaunch) : u64 {
        arg0.total_raised
    }

    public fun total_token_allocation(arg0: &VaultLaunch) : u64 {
        arg0.total_token_allocation
    }

    public fun trait_collection_id(arg0: &VaultLaunch) : &0x1::option::Option<0x2::object::ID> {
        &arg0.trait_collection_id
    }

    public fun vault_balance(arg0: &VaultLaunch) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault_balance_sui)
    }

    public fun vesting_duration_ms(arg0: &VaultLaunch) : u64 {
        arg0.vesting_duration_ms
    }

    public fun whitelist_enabled(arg0: &VaultLaunch) : bool {
        arg0.whitelist_enabled
    }

    public fun withdraw_yield(arg0: &mut VaultLaunch, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.yield_pool_sui, arg1), arg2)
    }

    public fun yield_pool_balance(arg0: &VaultLaunch) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.yield_pool_sui)
    }

    // decompiled from Move bytecode v7
}

