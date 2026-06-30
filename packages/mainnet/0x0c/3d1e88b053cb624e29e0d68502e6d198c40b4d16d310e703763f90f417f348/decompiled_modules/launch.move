module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch {
    struct LaunchCreatorCap has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
    }

    struct Launch<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        quote_coin: u8,
        mint_price: u64,
        max_supply: u64,
        goal: u64,
        vesting_duration_ms: u64,
        stage: u8,
        milestone_liq_target: u64,
        milestone_vol_target: u64,
        cumulative_fees_sui: u64,
        pool_sui_seeded: u64,
        total_raised: u64,
        nft_count: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        lp_position_id: 0x1::option::Option<0x2::object::ID>,
        lp_lock_id: 0x1::option::Option<0x2::object::ID>,
        trait_collection_id: 0x1::option::Option<0x2::object::ID>,
        wallet_mints: 0x2::table::Table<address, u64>,
        raised_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        yield_pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_yield_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_activated_at_ms: u64,
        whitelist_enabled: bool,
        whitelist: 0x2::table::Table<address, bool>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        token_total_supply: u64,
        holder_token_balance: 0x2::balance::Balance<T0>,
        pool_token_balance: 0x2::balance::Balance<T0>,
        token_per_nft: u64,
    }

    public fun id<T0>(arg0: &Launch<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun max_supply<T0>(arg0: &Launch<T0>) : u64 {
        arg0.max_supply
    }

    entry fun add_to_whitelist<T0>(arg0: &LaunchCreatorCap, arg1: &mut Launch<T0>, arg2: vector<address>) {
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

    entry fun claim_creator_yield<T0>(arg0: &LaunchCreatorCap, arg1: &mut Launch<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.creator_yield_sui) > 0, 107);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.creator_yield_sui), arg2), arg1.creator);
    }

    entry fun create_launch<T0>(arg0: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::GlobalConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 >= 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::min_mint_price_mist(), 100);
        assert!(arg10 > 0 && arg10 <= 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::max_supply(), 101);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 109);
        0x2::coin::update_name<T0>(&arg1, arg2, 0x1::string::utf8(arg3));
        0x2::coin::update_symbol<T0>(&arg1, arg2, 0x1::ascii::string(arg5));
        0x2::coin::update_description<T0>(&arg1, arg2, 0x1::string::utf8(arg4));
        let v0 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::total_supply();
        let v1 = v0 / 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::bps_denominator() * 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::token_split_bps();
        let v2 = 0x2::coin::mint<T0>(&mut arg1, v0, arg16);
        let v3 = 0x2::object::new(arg16);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::tx_context::sender(arg16);
        let v6 = 0x1::string::utf8(arg3);
        let v7 = Launch<T0>{
            id                   : v3,
            creator              : v5,
            name                 : v6,
            description          : 0x1::string::utf8(arg4),
            quote_coin           : arg8,
            mint_price           : arg9,
            max_supply           : arg10,
            goal                 : arg11,
            vesting_duration_ms  : arg12,
            stage                : 0,
            milestone_liq_target : arg14,
            milestone_vol_target : arg15,
            cumulative_fees_sui  : 0,
            pool_sui_seeded      : 0,
            total_raised         : 0,
            nft_count            : 0,
            pool_id              : 0x1::option::none<0x2::object::ID>(),
            lp_position_id       : 0x1::option::none<0x2::object::ID>(),
            lp_lock_id           : 0x1::option::none<0x2::object::ID>(),
            trait_collection_id  : 0x1::option::none<0x2::object::ID>(),
            wallet_mints         : 0x2::table::new<address, u64>(arg16),
            raised_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            yield_pool_sui       : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_yield_sui    : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_activated_at_ms : 0,
            whitelist_enabled    : arg13,
            whitelist            : 0x2::table::new<address, bool>(arg16),
            treasury_cap         : arg1,
            token_total_supply   : v0,
            holder_token_balance : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, v1, arg16)),
            pool_token_balance   : 0x2::coin::into_balance<T0>(v2),
            token_per_nft        : v1 / arg10,
        };
        let v8 = LaunchCreatorCap{
            id        : 0x2::object::new(arg16),
            launch_id : v4,
        };
        let v9 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_launch_created(v4, v5, v6, 0x1::string::utf8(*0x1::ascii::as_bytes(&v9)), arg9, arg10, arg11, arg8);
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::increment_launches(arg0);
        0x2::transfer::share_object<Launch<T0>>(v7);
        0x2::transfer::transfer<LaunchCreatorCap>(v8, v5);
    }

    entry fun create_trait_collection<T0>(arg0: &LaunchCreatorCap, arg1: &mut Launch<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.trait_collection_id), 111);
        let v0 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::create_collection(0x2::object::uid_to_inner(&arg1.id), arg2);
        arg1.trait_collection_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitCollection>(&v0));
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::share_collection(v0);
    }

    public fun creator<T0>(arg0: &Launch<T0>) : address {
        arg0.creator
    }

    public fun cumulative_fees_sui<T0>(arg0: &Launch<T0>) : u64 {
        arg0.cumulative_fees_sui
    }

    public fun description_ref<T0>(arg0: &Launch<T0>) : &0x1::string::String {
        &arg0.description
    }

    entry fun finalize_launch<T0>(arg0: &LaunchCreatorCap, arg1: &Launch<T0>, arg2: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitCollection, arg3: &mut 0x2::coin::CoinMetadata<T0>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::launch_id(arg2) == 0x2::object::uid_to_inner(&arg1.id), 113);
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::finalize_internal(arg2);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::num_categories(arg2)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::get_svg_layer(arg2, v2, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::num_options_in_category(arg2, v2) - 1), 0));
            v2 = v2 + 1;
        };
        let v3 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::svg::compose_nft_svg(v1, 0, &arg1.name, 0, 0, 0);
        0x2::coin::update_icon_url<T0>(&arg1.treasury_cap, arg3, 0x1::ascii::string(*0x1::string::as_bytes(&v3)));
    }

    public fun goal<T0>(arg0: &Launch<T0>) : u64 {
        arg0.goal
    }

    public fun holder_token_balance<T0>(arg0: &Launch<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.holder_token_balance)
    }

    public fun is_whitelisted<T0>(arg0: &Launch<T0>, arg1: address) : bool {
        if (!arg0.whitelist_enabled) {
            return true
        };
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun lp_lock_id<T0>(arg0: &Launch<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.lp_lock_id
    }

    public fun lp_position_id<T0>(arg0: &Launch<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.lp_position_id
    }

    public fun milestone_liq_target<T0>(arg0: &Launch<T0>) : u64 {
        arg0.milestone_liq_target
    }

    public fun milestone_vol_target<T0>(arg0: &Launch<T0>) : u64 {
        arg0.milestone_vol_target
    }

    public fun mint_price<T0>(arg0: &Launch<T0>) : u64 {
        arg0.mint_price
    }

    public fun name<T0>(arg0: &Launch<T0>) : &0x1::string::String {
        &arg0.name
    }

    public fun nft_count<T0>(arg0: &Launch<T0>) : u64 {
        arg0.nft_count
    }

    public fun pool_activated_at_ms<T0>(arg0: &Launch<T0>) : u64 {
        arg0.pool_activated_at_ms
    }

    public fun pool_id<T0>(arg0: &Launch<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.pool_id
    }

    public fun pool_sui_seeded<T0>(arg0: &Launch<T0>) : u64 {
        arg0.pool_sui_seeded
    }

    public fun pool_token_balance<T0>(arg0: &Launch<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool_token_balance)
    }

    public fun quote_coin<T0>(arg0: &Launch<T0>) : u8 {
        arg0.quote_coin
    }

    public fun raised_balance<T0>(arg0: &Launch<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.raised_balance)
    }

    public(friend) fun receive_swap_fees<T0>(arg0: &mut Launch<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_yield_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 * 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::creator_lp_share_bps() / 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::bps_denominator()));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.yield_pool_sui, v1);
        arg0.cumulative_fees_sui = arg0.cumulative_fees_sui + v0;
        if (arg0.stage == 2 && arg0.cumulative_fees_sui >= arg0.milestone_vol_target) {
            arg0.stage = 3;
            0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_stage_legendary(0x2::object::uid_to_inner(&arg0.id), 3);
        };
    }

    public(friend) fun record_mint<T0>(arg0: &mut Launch<T0>, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock) : u64 {
        let v0 = arg0.max_supply * 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::max_wallet_bps() / 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::bps_denominator();
        let v1 = v0;
        if (v0 == 0) {
            v1 = 1;
        };
        let v2 = if (0x2::table::contains<address, u64>(&arg0.wallet_mints, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.wallet_mints, arg1)
        } else {
            0
        };
        assert!(v2 < v1, 108);
        arg0.nft_count = arg0.nft_count + 1;
        arg0.total_raised = arg0.total_raised + arg2;
        if (0x2::table::contains<address, u64>(&arg0.wallet_mints, arg1)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.wallet_mints, arg1);
            *v3 = *v3 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.wallet_mints, arg1, 1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.raised_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (arg0.nft_count == arg0.max_supply && arg0.stage == 0) {
            arg0.stage = 1;
            0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_stage_awakened(0x2::object::uid_to_inner(&arg0.id), 1);
        };
        arg0.token_per_nft
    }

    public(friend) fun record_pool_activation<T0>(arg0: &mut Launch<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pool_id), 106);
        assert!(arg0.nft_count == arg0.max_supply, 105);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.lp_position_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg0.lp_lock_id = 0x1::option::some<0x2::object::ID>(arg3);
        arg0.pool_activated_at_ms = v0;
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_pool_activated(0x2::object::uid_to_inner(&arg0.id), arg1, arg2, v0);
    }

    entry fun remove_from_whitelist<T0>(arg0: &LaunchCreatorCap, arg1: &mut Launch<T0>, arg2: address) {
        assert!(arg0.launch_id == 0x2::object::uid_to_inner(&arg1.id), 104);
        if (0x2::table::contains<address, bool>(&arg1.whitelist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.whitelist, arg2);
        };
    }

    public(friend) fun return_pool_leftovers<T0>(arg0: &mut Launch<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.raised_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::balance::join<T0>(&mut arg0.pool_token_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun stage<T0>(arg0: &Launch<T0>) : u8 {
        arg0.stage
    }

    public(friend) fun take_pool_reserves<T0>(arg0: &mut Launch<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pool_id), 106);
        assert!(arg0.nft_count == arg0.max_supply, 105);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.raised_balance);
        assert!(v0 > 0 && 0x2::balance::value<T0>(&arg0.pool_token_balance) > 0, 112);
        arg0.pool_sui_seeded = arg0.pool_sui_seeded + v0;
        if (arg0.pool_sui_seeded >= arg0.milestone_liq_target && arg0.stage == 1) {
            arg0.stage = 2;
            0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_stage_evolved(0x2::object::uid_to_inner(&arg0.id), 2);
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.raised_balance), arg1), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pool_token_balance), arg1))
    }

    public fun token_per_nft<T0>(arg0: &Launch<T0>) : u64 {
        arg0.token_per_nft
    }

    public fun token_total_supply<T0>(arg0: &Launch<T0>) : u64 {
        arg0.token_total_supply
    }

    public fun total_raised<T0>(arg0: &Launch<T0>) : u64 {
        arg0.total_raised
    }

    public fun total_token_allocation<T0>(arg0: &Launch<T0>) : u64 {
        arg0.token_per_nft * arg0.nft_count
    }

    public fun trait_collection_id<T0>(arg0: &Launch<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.trait_collection_id
    }

    public fun vesting_duration_ms<T0>(arg0: &Launch<T0>) : u64 {
        arg0.vesting_duration_ms
    }

    public fun whitelist_enabled<T0>(arg0: &Launch<T0>) : bool {
        arg0.whitelist_enabled
    }

    public(friend) fun withdraw_holder_tokens<T0>(arg0: &mut Launch<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.holder_token_balance) >= arg1, 110);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.holder_token_balance, arg1), arg2)
    }

    public(friend) fun withdraw_yield<T0>(arg0: &mut Launch<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.yield_pool_sui, arg1), arg2)
    }

    public fun yield_pool_balance<T0>(arg0: &Launch<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.yield_pool_sui)
    }

    // decompiled from Move bytecode v7
}

