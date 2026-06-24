module 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch {
    struct LaunchCreatorCap has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
    }

    struct VaultLaunch has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        website_url: 0x1::string::String,
        twitter_url: 0x1::string::String,
        quote_coin: u8,
        goal: u64,
        nft_type: u8,
        vesting_duration_ms: u64,
        status: u8,
        total_raised: u64,
        nft_count: u64,
        last_deposit_time_ms: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        lp_position_id: 0x1::option::Option<0x2::object::ID>,
        wallet_allocations: 0x2::table::Table<address, u64>,
        whitelist_enabled: bool,
        whitelist: 0x2::table::Table<address, bool>,
        vault_balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_token_allocation: u64,
        yield_pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_yield_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_activated_at_ms: u64,
    }

    public entry fun activate_pool(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 103);
        assert!(arg1.status == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::status_funding(), 105);
        assert!(arg1.total_raised >= arg1.goal, 106);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.pool_id), 111);
        arg1.pool_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg1.lp_position_id = 0x1::option::some<0x2::object::ID>(arg3);
        arg1.status = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::status_live();
        arg1.pool_activated_at_ms = 0x2::clock::timestamp_ms(arg4);
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events::emit_pool_activated(0x2::object::uid_to_inner(&arg1.id), arg2, arg3);
    }

    public entry fun add_to_whitelist(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: vector<address>) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 103);
        assert!(arg1.status == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::status_funding(), 104);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.whitelist, v1)) {
                0x2::table::add<address, bool>(&mut arg1.whitelist, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun claim_creator_yield(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 103);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.creator_yield_sui);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.creator_yield_sui, v0), arg2), arg1.creator);
        };
    }

    public entry fun create_launch(arg0: &mut 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::GlobalConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: u8, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(!0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::is_paused(arg0), 109);
        assert!(arg6 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::quote_sui() || arg6 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::quote_usdc(), 100);
        assert!(arg8 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::nft_type_regular() || arg8 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::nft_type_dynamic(), 110);
        if (arg6 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::quote_usdc()) {
            assert!(arg7 >= 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::min_goal_usdc(), 101);
        } else {
            assert!(arg7 >= 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::min_goal_sui(), 101);
        };
        let v0 = if (arg9 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::vesting_7()) {
            true
        } else if (arg9 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::vesting_30()) {
            true
        } else if (arg9 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::vesting_90()) {
            true
        } else {
            arg9 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::vesting_120()
        };
        assert!(v0, 102);
        let v1 = 0x2::tx_context::sender(arg12);
        let v2 = 0x2::object::new(arg12);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = VaultLaunch{
            id                     : v2,
            creator                : v1,
            name                   : 0x1::string::utf8(arg1),
            description            : 0x1::string::utf8(arg2),
            image_url              : 0x1::string::utf8(arg3),
            website_url            : 0x1::string::utf8(arg4),
            twitter_url            : 0x1::string::utf8(arg5),
            quote_coin             : arg6,
            goal                   : arg7,
            nft_type               : arg8,
            vesting_duration_ms    : arg9,
            status                 : 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::status_funding(),
            total_raised           : 0,
            nft_count              : 0,
            last_deposit_time_ms   : 0x2::clock::timestamp_ms(arg11),
            pool_id                : 0x1::option::none<0x2::object::ID>(),
            lp_position_id         : 0x1::option::none<0x2::object::ID>(),
            wallet_allocations     : 0x2::table::new<address, u64>(arg12),
            whitelist_enabled      : arg10,
            whitelist              : 0x2::table::new<address, bool>(arg12),
            vault_balance_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_token_allocation : 0,
            yield_pool_sui         : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_yield_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_activated_at_ms   : 0,
        };
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::increment_launches(arg0);
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events::emit_launch_created(v3, v1, arg1, arg6, arg7, arg8, arg9);
        0x2::transfer::share_object<VaultLaunch>(v4);
        let v5 = LaunchCreatorCap{
            id        : 0x2::object::new(arg12),
            launch_id : v3,
        };
        0x2::transfer::transfer<LaunchCreatorCap>(v5, v1);
    }

    public fun creator(arg0: &VaultLaunch) : address {
        arg0.creator
    }

    public fun drain_vault_for_pool(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 103);
        assert!(arg1.total_raised >= arg1.goal, 106);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault_balance_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.vault_balance_sui)), arg2)
    }

    public fun goal(arg0: &VaultLaunch) : u64 {
        arg0.goal
    }

    public fun id(arg0: &VaultLaunch) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_whitelisted(arg0: &VaultLaunch, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun last_deposit_time_ms(arg0: &VaultLaunch) : u64 {
        arg0.last_deposit_time_ms
    }

    public fun lp_position_id(arg0: &VaultLaunch) : &0x1::option::Option<0x2::object::ID> {
        &arg0.lp_position_id
    }

    public fun name(arg0: &VaultLaunch) : &0x1::string::String {
        &arg0.name
    }

    public fun nft_count(arg0: &VaultLaunch) : u64 {
        arg0.nft_count
    }

    public fun nft_type(arg0: &VaultLaunch) : u8 {
        arg0.nft_type
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
        assert!(arg0.status == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::status_live(), 104);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_yield_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::creator_swap_bps() / 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::bps_denominator()));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.yield_pool_sui, v0);
    }

    public fun record_mint(arg0: &mut VaultLaunch, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        if (0x2::table::contains<address, u64>(&arg0.wallet_allocations, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.wallet_allocations, arg1) = *0x2::table::borrow<address, u64>(&arg0.wallet_allocations, arg1) + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.wallet_allocations, arg1, arg3);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault_balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        arg0.total_raised = arg0.total_raised + arg2;
        arg0.total_token_allocation = arg0.total_token_allocation + arg3;
        arg0.nft_count = arg0.nft_count + 1;
        arg0.last_deposit_time_ms = 0x2::clock::timestamp_ms(arg5);
        if (arg0.total_raised >= arg0.goal && arg0.total_raised - arg2 < arg0.goal) {
            0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events::emit_goal_reached(0x2::object::uid_to_inner(&arg0.id), arg0.total_raised, arg0.nft_count);
        };
    }

    public entry fun remove_from_whitelist(arg0: &LaunchCreatorCap, arg1: &mut VaultLaunch, arg2: address) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 103);
        if (0x2::table::contains<address, bool>(&arg1.whitelist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.whitelist, arg2);
        };
    }

    public fun set_creator(arg0: &mut VaultLaunch, arg1: address) {
        arg0.creator = arg1;
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

    public fun vault_balance(arg0: &VaultLaunch) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault_balance_sui)
    }

    public fun vesting_duration_ms(arg0: &VaultLaunch) : u64 {
        arg0.vesting_duration_ms
    }

    public fun wallet_allocation(arg0: &VaultLaunch, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.wallet_allocations, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.wallet_allocations, arg1)
        } else {
            0
        }
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

