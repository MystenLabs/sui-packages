module 0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::duck_nft {
    struct DUCK_NFT has drop {
        dummy_field: bool,
    }

    struct HatchCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        team_mint_initialized: bool,
    }

    struct TeamMintCap has key {
        id: 0x2::object::UID,
        team_wallet: address,
        minted: bool,
    }

    struct PackSupply has key {
        id: 0x2::object::UID,
        total_packs_remaining: u64,
        last_refresh_time: u64,
        start_time: u64,
        basic_egg_sht_cost: u64,
        basic_egg_sui_cost: u64,
        rare_egg_sht_cost: u64,
        rare_egg_sui_cost: u64,
        golden_egg_sht_cost: u64,
        golden_egg_sui_cost: u64,
        genesis_whitelist_basic_sui_cost: u64,
        genesis_whitelist_rare_sui_cost: u64,
        genesis_whitelist_golden_sui_cost: u64,
        genesis_public_basic_sui_cost: u64,
        genesis_public_rare_sui_cost: u64,
        genesis_public_golden_sui_cost: u64,
        is_genesis_batch: bool,
        genesis_batch_start_time: u64,
        whitelist_packs_sold: u64,
        whitelist_phase_active: bool,
        user_whitelist_purchases: 0x2::table::Table<address, u64>,
        current_batch_number: u64,
        display_batch_number: u64,
        previous_batch_completed: bool,
        total_nfts_minted_globally: u64,
        in_cooldown: bool,
        cooldown_end_time: u64,
        last_sellout_time: u64,
        batch_transition_lock: bool,
        user_last_purchase_time: 0x2::table::Table<address, u64>,
    }

    struct PerTypeSupply has key {
        id: 0x2::object::UID,
        basic_packs_remaining: u64,
        rare_packs_remaining: u64,
        golden_packs_remaining: u64,
        max_basic_per_batch: u64,
        max_rare_per_batch: u64,
        max_golden_per_batch: u64,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        addresses: 0x2::vec_set::VecSet<address>,
    }

    struct TreasuryConfig has key {
        id: 0x2::object::UID,
        treasury_wallet: address,
    }

    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        referrers: 0x2::table::Table<address, address>,
    }

    struct PackPurchased has copy, drop {
        pack_type: u8,
        buyer: address,
        sht_cost: u64,
        sui_cost: u64,
        rarity: u8,
        remaining_packs: u64,
    }

    struct SupplyRefreshed has copy, drop {
        refresh_time: u64,
        total_packs_available: u64,
    }

    struct PriceUpdated has copy, drop {
        pack_type: u8,
        old_sht_cost: u64,
        new_sht_cost: u64,
        old_sui_cost: u64,
        new_sui_cost: u64,
    }

    struct TeamMintCompleted has copy, drop {
        minter: address,
        quantity: u64,
        remaining_mints: u64,
    }

    struct GenesisBatchStarted has copy, drop {
        start_time: u64,
        total_supply: u64,
        whitelist_allocation: u64,
    }

    struct WhitelistPhaseEnded has copy, drop {
        end_time: u64,
        whitelist_packs_sold: u64,
        remaining_for_public: u64,
    }

    struct GenesisBatchCompleted has copy, drop {
        end_time: u64,
        total_packs_sold: u64,
    }

    struct AddressWhitelisted has copy, drop {
        address: address,
        added_by: address,
    }

    struct AddressRemovedFromWhitelist has copy, drop {
        address: address,
        removed_by: address,
    }

    struct BatchWhitelisted has copy, drop {
        count: u64,
        added_by: address,
    }

    struct ReferralReward has copy, drop {
        pack_type: u8,
        buyer: address,
        referrer: address,
        sht_amount: u64,
        timestamp: u64,
    }

    struct TreasuryWalletUpdated has copy, drop {
        old_wallet: address,
        new_wallet: address,
    }

    struct ReferrerSet has copy, drop {
        user: address,
        referrer: address,
        timestamp: u64,
    }

    struct CooldownStarted has copy, drop {
        batch_number: u64,
        sellout_time: u64,
        cooldown_end_time: u64,
    }

    struct BatchStarted has copy, drop {
        batch_number: u64,
        start_time: u64,
        packs_available: u64,
    }

    struct LastMintOfBatch has copy, drop {
        completed_batch_number: u64,
        next_batch_number: u64,
        cooldown_end_time: u64,
        final_nfts_minted: u64,
    }

    struct PackTypeLimitUpdated has copy, drop {
        pack_type: u8,
        old_limit: u64,
        new_limit: u64,
        updated_by: address,
    }

    struct CooldownDurationUpdated has copy, drop {
        old_duration_ms: u64,
        new_duration_ms: u64,
        updated_by: address,
    }

    struct GlobalStats has key {
        id: 0x2::object::UID,
        common_minted: u64,
        queen_minted: u64,
        king_minted: u64,
        golden_minted: u64,
        total_sht_burned: u64,
        sht_burned_today: u64,
        last_burn_reset_day: u64,
    }

    struct UserStats has copy, drop, store {
        lifetime_sht_earned: u64,
        total_harvest_attempts: u64,
        successful_harvests: u64,
        total_sht_burned: u64,
        packs_bought: u64,
        sht_earned_today: u64,
        last_activity_day: u64,
    }

    struct UserStatsRegistry has key {
        id: 0x2::object::UID,
    }

    struct DuckNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        number: u64,
        rarity: u8,
        rarity_name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        mint_timestamp: u64,
        owner: address,
        luck: 0x1::string::String,
        multiplier: 0x1::string::String,
        batch: 0x1::string::String,
        is_staked: bool,
        staked_at: u64,
        last_harvest_time: u64,
        nest_level: u8,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct DuckVirtuallyStaked has copy, drop {
        duck_id: 0x2::object::ID,
        owner: address,
        nest_level: u8,
        staked_at: u64,
    }

    struct DuckVirtuallyUnstaked has copy, drop {
        duck_id: 0x2::object::ID,
        owner: address,
        total_time_staked: u64,
    }

    struct HarvestTimeUpdated has copy, drop {
        duck_id: 0x2::object::ID,
        new_harvest_time: u64,
    }

    public entry fun admin_add_batch_to_whitelist(arg0: &AdminCap, arg1: &mut Whitelist, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::vec_set::contains<address>(&arg1.addresses, &v1)) {
                0x2::vec_set::insert<address>(&mut arg1.addresses, v1);
                let v2 = AddressWhitelisted{
                    address  : v1,
                    added_by : 0x2::tx_context::sender(arg3),
                };
                0x2::event::emit<AddressWhitelisted>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun admin_add_batch_to_whitelist_efficient(arg0: &AdminCap, arg1: &mut Whitelist, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::vec_set::contains<address>(&arg1.addresses, &v2)) {
                0x2::vec_set::insert<address>(&mut arg1.addresses, v2);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        if (v1 > 0) {
            let v3 = BatchWhitelisted{
                count    : v1,
                added_by : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<BatchWhitelisted>(v3);
        };
    }

    public entry fun admin_add_to_whitelist(arg0: &AdminCap, arg1: &mut Whitelist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<address>(&mut arg1.addresses, arg2);
        let v0 = AddressWhitelisted{
            address  : arg2,
            added_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddressWhitelisted>(v0);
    }

    public entry fun admin_refresh_supply(arg0: &AdminCap, arg1: &mut PackSupply, arg2: &mut PerTypeSupply, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.total_packs_remaining = 300;
        arg1.last_refresh_time = v0;
        let v1 = if (arg2.max_basic_per_batch > 0) {
            arg2.max_basic_per_batch
        } else {
            300
        };
        arg2.basic_packs_remaining = v1;
        let v2 = if (arg2.max_rare_per_batch > 0) {
            arg2.max_rare_per_batch
        } else {
            300
        };
        arg2.rare_packs_remaining = v2;
        let v3 = if (arg2.max_golden_per_batch > 0) {
            arg2.max_golden_per_batch
        } else {
            300
        };
        arg2.golden_packs_remaining = v3;
        let v4 = SupplyRefreshed{
            refresh_time          : v0,
            total_packs_available : 300,
        };
        0x2::event::emit<SupplyRefreshed>(v4);
    }

    public entry fun admin_remove_from_whitelist(arg0: &AdminCap, arg1: &mut Whitelist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::remove<address>(&mut arg1.addresses, &arg2);
        let v0 = AddressRemovedFromWhitelist{
            address    : arg2,
            removed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddressRemovedFromWhitelist>(v0);
    }

    public entry fun admin_update_basic_price(arg0: &AdminCap, arg1: &mut PackSupply, arg2: u64, arg3: u64) {
        arg1.basic_egg_sht_cost = arg2;
        arg1.basic_egg_sui_cost = arg3;
        let v0 = PriceUpdated{
            pack_type    : 0,
            old_sht_cost : arg1.basic_egg_sht_cost,
            new_sht_cost : arg2,
            old_sui_cost : arg1.basic_egg_sui_cost,
            new_sui_cost : arg3,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun admin_update_cooldown_duration(arg0: &AdminCap, arg1: &mut PackSupply, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.in_cooldown, 13);
        let v0 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"cooldown_duration")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg1.id, b"cooldown_duration")
        } else {
            300000
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"cooldown_duration")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, b"cooldown_duration") = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"cooldown_duration", arg2);
        };
        let v1 = CooldownDurationUpdated{
            old_duration_ms : v0,
            new_duration_ms : arg2,
            updated_by      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CooldownDurationUpdated>(v1);
    }

    public entry fun admin_update_genesis_public_prices(arg0: &AdminCap, arg1: &mut PackSupply, arg2: u64, arg3: u64, arg4: u64) {
        arg1.genesis_public_basic_sui_cost = arg2;
        arg1.genesis_public_rare_sui_cost = arg3;
        arg1.genesis_public_golden_sui_cost = arg4;
    }

    public entry fun admin_update_genesis_whitelist_prices(arg0: &AdminCap, arg1: &mut PackSupply, arg2: u64, arg3: u64, arg4: u64) {
        arg1.genesis_whitelist_basic_sui_cost = arg2;
        arg1.genesis_whitelist_rare_sui_cost = arg3;
        arg1.genesis_whitelist_golden_sui_cost = arg4;
    }

    public entry fun admin_update_golden_price(arg0: &AdminCap, arg1: &mut PackSupply, arg2: u64, arg3: u64) {
        arg1.golden_egg_sht_cost = arg2;
        arg1.golden_egg_sui_cost = arg3;
        let v0 = PriceUpdated{
            pack_type    : 2,
            old_sht_cost : arg1.golden_egg_sht_cost,
            new_sht_cost : arg2,
            old_sui_cost : arg1.golden_egg_sui_cost,
            new_sui_cost : arg3,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun admin_update_pack_limits(arg0: &AdminCap, arg1: &PackSupply, arg2: &mut PerTypeSupply, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(!is_mint_running(arg1), 19);
        let v0 = if (arg3 > 0) {
            if (arg4 > 0) {
                arg5 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            let v1 = if (arg1.start_time == 0) {
                600
            } else {
                300
            };
            assert!(arg3 + arg4 + arg5 == v1, 20);
        };
        let v2 = arg2.max_basic_per_batch;
        let v3 = arg2.max_rare_per_batch;
        let v4 = arg2.max_golden_per_batch;
        arg2.max_basic_per_batch = arg3;
        arg2.max_rare_per_batch = arg4;
        arg2.max_golden_per_batch = arg5;
        let v5 = if (arg3 > 0) {
            arg3
        } else {
            300
        };
        arg2.basic_packs_remaining = v5;
        let v6 = if (arg4 > 0) {
            arg4
        } else {
            300
        };
        arg2.rare_packs_remaining = v6;
        let v7 = if (arg5 > 0) {
            arg5
        } else {
            300
        };
        arg2.golden_packs_remaining = v7;
        let v8 = 0x2::tx_context::sender(arg6);
        if (v2 != arg3) {
            let v9 = PackTypeLimitUpdated{
                pack_type  : 0,
                old_limit  : v2,
                new_limit  : arg3,
                updated_by : v8,
            };
            0x2::event::emit<PackTypeLimitUpdated>(v9);
        };
        if (v3 != arg4) {
            let v10 = PackTypeLimitUpdated{
                pack_type  : 1,
                old_limit  : v3,
                new_limit  : arg4,
                updated_by : v8,
            };
            0x2::event::emit<PackTypeLimitUpdated>(v10);
        };
        if (v4 != arg5) {
            let v11 = PackTypeLimitUpdated{
                pack_type  : 2,
                old_limit  : v4,
                new_limit  : arg5,
                updated_by : v8,
            };
            0x2::event::emit<PackTypeLimitUpdated>(v11);
        };
    }

    public entry fun admin_update_rare_price(arg0: &AdminCap, arg1: &mut PackSupply, arg2: u64, arg3: u64) {
        arg1.rare_egg_sht_cost = arg2;
        arg1.rare_egg_sui_cost = arg3;
        let v0 = PriceUpdated{
            pack_type    : 1,
            old_sht_cost : arg1.rare_egg_sht_cost,
            new_sht_cost : arg2,
            old_sui_cost : arg1.rare_egg_sui_cost,
            new_sui_cost : arg3,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun admin_update_treasury_wallet(arg0: &AdminCap, arg1: &mut TreasuryConfig, arg2: address) {
        arg1.treasury_wallet = arg2;
        let v0 = TreasuryWalletUpdated{
            old_wallet : arg1.treasury_wallet,
            new_wallet : arg2,
        };
        0x2::event::emit<TreasuryWalletUpdated>(v0);
    }

    fun apply_genesis_purchase(arg0: &mut PackSupply, arg1: &Whitelist, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        if (!arg0.is_genesis_batch) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg0.whitelist_phase_active) {
            if (v0 >= arg0.genesis_batch_start_time + 300000) {
                arg0.whitelist_phase_active = false;
                let v1 = WhitelistPhaseEnded{
                    end_time             : v0,
                    whitelist_packs_sold : arg0.whitelist_packs_sold,
                    remaining_for_public : arg0.total_packs_remaining,
                };
                0x2::event::emit<WhitelistPhaseEnded>(v1);
            };
        };
        if (arg0.whitelist_phase_active) {
            if (0x2::table::contains<address, u64>(&arg0.user_whitelist_purchases, arg2)) {
                let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_whitelist_purchases, arg2);
                *v2 = *v2 + arg3;
            } else {
                0x2::table::add<address, u64>(&mut arg0.user_whitelist_purchases, arg2, arg3);
            };
            arg0.whitelist_packs_sold = arg0.whitelist_packs_sold + arg3;
            if (arg0.whitelist_packs_sold >= 575) {
                arg0.whitelist_phase_active = false;
                let v3 = WhitelistPhaseEnded{
                    end_time             : v0,
                    whitelist_packs_sold : arg0.whitelist_packs_sold,
                    remaining_for_public : arg0.total_packs_remaining,
                };
                0x2::event::emit<WhitelistPhaseEnded>(v3);
            };
        };
    }

    public fun can_set_referrer(arg0: &ReferralRegistry, arg1: &PackSupply, arg2: address) : bool {
        !0x2::table::contains<address, address>(&arg0.referrers, arg2)
    }

    fun check_and_start_new_batch_if_ready(arg0: &mut PackSupply, arg1: &mut PerTypeSupply, arg2: &0x2::clock::Clock) {
        if (!arg0.in_cooldown) {
            return
        };
        assert!(!arg0.batch_transition_lock, 15);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 >= arg0.cooldown_end_time) {
            arg0.batch_transition_lock = true;
            arg0.in_cooldown = false;
            arg0.total_packs_remaining = 300;
            arg0.last_refresh_time = v0;
            let v1 = if (arg1.max_basic_per_batch > 0) {
                arg1.max_basic_per_batch
            } else {
                300
            };
            arg1.basic_packs_remaining = v1;
            let v2 = if (arg1.max_rare_per_batch > 0) {
                arg1.max_rare_per_batch
            } else {
                300
            };
            arg1.rare_packs_remaining = v2;
            let v3 = if (arg1.max_golden_per_batch > 0) {
                arg1.max_golden_per_batch
            } else {
                300
            };
            arg1.golden_packs_remaining = v3;
            arg0.display_batch_number = arg0.current_batch_number;
            arg0.previous_batch_completed = false;
            let v4 = BatchStarted{
                batch_number    : arg0.current_batch_number,
                start_time      : v0,
                packs_available : 300,
            };
            0x2::event::emit<BatchStarted>(v4);
            arg0.batch_transition_lock = false;
        };
    }

    fun check_genesis_batch_completion(arg0: &mut PackSupply, arg1: &0x2::clock::Clock) {
        if (!arg0.is_genesis_batch) {
            return
        };
        if (arg0.total_packs_remaining == 0) {
            let v0 = 0x2::clock::timestamp_ms(arg1);
            arg0.is_genesis_batch = false;
            arg0.whitelist_phase_active = false;
            arg0.in_cooldown = true;
            arg0.last_sellout_time = v0;
            let v1 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"cooldown_duration")) {
                *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"cooldown_duration")
            } else {
                300000
            };
            arg0.cooldown_end_time = v0 + v1;
            arg0.current_batch_number = 1;
            arg0.display_batch_number = 0;
            arg0.previous_batch_completed = true;
            let v2 = GenesisBatchCompleted{
                end_time         : v0,
                total_packs_sold : 600,
            };
            0x2::event::emit<GenesisBatchCompleted>(v2);
            let v3 = LastMintOfBatch{
                completed_batch_number : 0,
                next_batch_number      : 1,
                cooldown_end_time      : arg0.cooldown_end_time,
                final_nfts_minted      : arg0.total_nfts_minted_globally,
            };
            0x2::event::emit<LastMintOfBatch>(v3);
            let v4 = CooldownStarted{
                batch_number      : 0,
                sellout_time      : v0,
                cooldown_end_time : arg0.cooldown_end_time,
            };
            0x2::event::emit<CooldownStarted>(v4);
        };
    }

    fun create_duck_nft(arg0: u8, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : DuckNFT {
        let v0 = 0x1::string::utf8(b"Duck Dynasty #");
        0x1::string::append(&mut v0, u64_to_string(arg2));
        let (v1, v2) = get_duck_stats(arg0);
        let (v3, v4) = get_duck_stats(arg0);
        let v5 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Rarity"), get_rarity_name(arg0));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Luck"), v3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Multiplier"), v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Batch"), get_batch_name(arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Staked"), 0x1::string::utf8(b"No"));
        DuckNFT{
            id                : 0x2::object::new(arg4),
            name              : v0,
            number            : arg2,
            rarity            : arg0,
            rarity_name       : get_rarity_name(arg0),
            image_url         : get_rarity_image_url(arg0),
            description       : get_rarity_description(arg0),
            mint_timestamp    : 0x2::clock::timestamp_ms(arg3),
            owner             : 0x2::tx_context::sender(arg4),
            luck              : v1,
            multiplier        : v2,
            batch             : get_batch_name(arg1),
            is_staked         : false,
            staked_at         : 0,
            last_harvest_time : 0,
            nest_level        : 0,
            attributes        : v5,
        }
    }

    fun enforce_public_rate_limit(arg0: &mut PackSupply, arg1: bool, arg2: address, arg3: u64, arg4: u64) {
        if (!arg1) {
            assert!(arg3 <= 20, 16);
            if (0x2::table::contains<address, u64>(&arg0.user_last_purchase_time, arg2)) {
                assert!(arg4 - *0x2::table::borrow<address, u64>(&arg0.user_last_purchase_time, arg2) >= 1000, 17);
            };
            if (0x2::table::contains<address, u64>(&arg0.user_last_purchase_time, arg2)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.user_last_purchase_time, arg2) = arg4;
            } else {
                0x2::table::add<address, u64>(&mut arg0.user_last_purchase_time, arg2, arg4);
            };
        };
    }

    public fun get_available_harvest_cycles(arg0: &DuckNFT, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (!arg0.is_staked) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 < arg0.last_harvest_time + arg1) {
            return 0
        };
        let v1 = (v0 - arg0.last_harvest_time) / arg1;
        if (v1 > arg2) {
            arg2
        } else {
            v1
        }
    }

    public fun get_batch_display_info(arg0: &PackSupply) : (u64, u64, bool) {
        (arg0.current_batch_number, arg0.display_batch_number, arg0.previous_batch_completed)
    }

    fun get_batch_name(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Genesis Batch")
        } else {
            let v1 = 0x1::string::utf8(b"Batch #");
            0x1::string::append(&mut v1, u64_to_string(arg0 + 1));
            v1
        }
    }

    public fun get_batch_number(arg0: &PackSupply) : u64 {
        arg0.current_batch_number
    }

    public fun get_cooldown_duration(arg0: &PackSupply) : u64 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"cooldown_duration")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"cooldown_duration")
        } else {
            300000
        }
    }

    public fun get_cooldown_status(arg0: &PackSupply, arg1: &0x2::clock::Clock) : (bool, u64, u64) {
        let v0 = if (arg0.in_cooldown) {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            if (v1 >= arg0.cooldown_end_time) {
                0
            } else {
                arg0.cooldown_end_time - v1
            }
        } else {
            0
        };
        let v2 = arg0.in_cooldown && v0 > 0;
        let v3 = if (arg0.in_cooldown && v0 == 0) {
            300
        } else {
            arg0.total_packs_remaining
        };
        (v2, v0, v3)
    }

    public fun get_current_batch(arg0: &PackSupply) : (u64, bool) {
        (arg0.current_batch_number, arg0.is_genesis_batch)
    }

    public fun get_current_pack_prices(arg0: &PackSupply) : (u64, u64, u64, u64, u64, u64) {
        (arg0.basic_egg_sht_cost, arg0.basic_egg_sui_cost, arg0.rare_egg_sht_cost, arg0.rare_egg_sui_cost, arg0.golden_egg_sht_cost, arg0.golden_egg_sui_cost)
    }

    public fun get_duck_staking_info(arg0: &DuckNFT) : (bool, u64, u64, u8) {
        (arg0.is_staked, arg0.staked_at, arg0.last_harvest_time, arg0.nest_level)
    }

    fun get_duck_stats(arg0: u8) : (0x1::string::String, 0x1::string::String) {
        if (arg0 == 3) {
            (0x1::string::utf8(b"85%"), 0x1::string::utf8(b"7x"))
        } else if (arg0 == 2) {
            (0x1::string::utf8(b"60%"), 0x1::string::utf8(b"5x"))
        } else if (arg0 == 1) {
            (0x1::string::utf8(b"50%"), 0x1::string::utf8(b"3x"))
        } else {
            (0x1::string::utf8(b"40%"), 0x1::string::utf8(b"1x"))
        }
    }

    public fun get_genesis_batch_total_supply(arg0: &PackSupply) : u64 {
        600
    }

    public fun get_genesis_pack_prices(arg0: &PackSupply) : (u64, u64, u64, u64, u64, u64) {
        (arg0.genesis_whitelist_basic_sui_cost, arg0.genesis_whitelist_rare_sui_cost, arg0.genesis_whitelist_golden_sui_cost, arg0.genesis_public_basic_sui_cost, arg0.genesis_public_rare_sui_cost, arg0.genesis_public_golden_sui_cost)
    }

    public fun get_global_stats(arg0: &GlobalStats) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.common_minted, arg0.queen_minted, arg0.king_minted, arg0.golden_minted, arg0.total_sht_burned, arg0.sht_burned_today, arg0.last_burn_reset_day)
    }

    public fun get_max_total_supply(arg0: &PackSupply) : u64 {
        5555
    }

    public fun get_pack_supply_status(arg0: &PackSupply) : (u64, u64, u64, u64, bool) {
        let v0 = if (arg0.is_genesis_batch) {
            600
        } else {
            300
        };
        (v0 - arg0.total_packs_remaining, v0, arg0.last_refresh_time, arg0.start_time, arg0.is_genesis_batch)
    }

    public fun get_per_type_supply_status(arg0: &PerTypeSupply) : (u64, u64, u64, u64, u64, u64) {
        (arg0.basic_packs_remaining, arg0.rare_packs_remaining, arg0.golden_packs_remaining, arg0.max_basic_per_batch, arg0.max_rare_per_batch, arg0.max_golden_per_batch)
    }

    public fun get_public_phase_allocation(arg0: &PackSupply) : u64 {
        600 - 575
    }

    fun get_rarity_description(arg0: u8) : 0x1::string::String {
        0x1::string::utf8(b"Duck Dynasty is a feathery force of nature generating SHT day in, day out.")
    }

    public fun get_rarity_distribution(arg0: &GlobalStats) : (u64, u64, u64, u64) {
        let v0 = arg0.common_minted + arg0.queen_minted + arg0.king_minted + arg0.golden_minted;
        if (v0 == 0) {
            return (0, 0, 0, 0)
        };
        (arg0.common_minted * 10000 / v0, arg0.queen_minted * 10000 / v0, arg0.king_minted * 10000 / v0, arg0.golden_minted * 10000 / v0)
    }

    fun get_rarity_image_url(arg0: u8) : 0x1::string::String {
        if (arg0 == 3) {
            0x1::string::utf8(b"https://gateway.lighthouse.storage/ipfs/bafybeignzuwwl5bn2q7jv6lwkoy5cfeusjtq4mepwtbbiob3lcajnx4t3q/Golden.png")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"https://gateway.lighthouse.storage/ipfs/bafybeignzuwwl5bn2q7jv6lwkoy5cfeusjtq4mepwtbbiob3lcajnx4t3q/King.png")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"https://gateway.lighthouse.storage/ipfs/bafybeignzuwwl5bn2q7jv6lwkoy5cfeusjtq4mepwtbbiob3lcajnx4t3q/Queen.png")
        } else {
            0x1::string::utf8(b"https://gateway.lighthouse.storage/ipfs/bafybeignzuwwl5bn2q7jv6lwkoy5cfeusjtq4mepwtbbiob3lcajnx4t3q/Common.png")
        }
    }

    public fun get_rarity_level(arg0: &DuckNFT) : u8 {
        arg0.rarity
    }

    fun get_rarity_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 3) {
            0x1::string::utf8(b"Golden")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"King")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Queen")
        } else {
            0x1::string::utf8(b"Common")
        }
    }

    public fun get_referrer(arg0: &ReferralRegistry, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referrers, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrers, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_regular_batch_supply(arg0: &PackSupply) : u64 {
        300
    }

    public fun get_supply_constants(arg0: &PackSupply) : (u64, u64, u64, u64, u64, u64) {
        (5555, 600, 575, 600 - 575, 300, arg0.total_nfts_minted_globally)
    }

    public fun get_supply_refresh_interval() : u64 {
        300000
    }

    public fun get_team_mint_status(arg0: &TeamMintCap) : (address, bool) {
        (arg0.team_wallet, arg0.minted)
    }

    public fun get_time_until_harvest(arg0: &DuckNFT, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (!arg0.is_staked) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.last_harvest_time + arg1;
        if (v0 >= v1) {
            0
        } else {
            v1 - v0
        }
    }

    public fun get_time_until_refresh(arg0: &PackSupply, arg1: &0x2::clock::Clock) : u64 {
        if (!arg0.in_cooldown) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.cooldown_end_time) {
            0
        } else {
            arg0.cooldown_end_time - v0
        }
    }

    public fun get_total_minted(arg0: &PackSupply) : u64 {
        arg0.total_nfts_minted_globally
    }

    public fun get_treasury_wallet(arg0: &TreasuryConfig) : address {
        arg0.treasury_wallet
    }

    public fun get_user_stats(arg0: &UserStatsRegistry, arg1: address) : (u64, u64, u64, u64, u64, u64) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v6 = 0x2::dynamic_field::borrow<address, UserStats>(&arg0.id, arg1);
            (v6.lifetime_sht_earned, v6.total_harvest_attempts, v6.successful_harvests, v6.total_sht_burned, v6.packs_bought, v6.sht_earned_today)
        } else {
            (0, 0, 0, 0, 0, 0)
        }
    }

    public fun get_whitelist_allocation(arg0: &PackSupply) : u64 {
        575
    }

    public fun get_whitelist_per_wallet_limit() : u64 {
        10
    }

    public fun get_whitelist_period_duration() : u64 {
        300000
    }

    public fun get_whitelist_size(arg0: &Whitelist) : u64 {
        0x2::vec_set::length<address>(&arg0.addresses)
    }

    public fun has_user_stats(arg0: &UserStatsRegistry, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&arg0.id, arg1)
    }

    public entry fun hatch_basic_egg(arg0: &HatchCap, arg1: &mut PackSupply, arg2: &mut PerTypeSupply, arg3: &Whitelist, arg4: &TreasuryConfig, arg5: &ReferralRegistry, arg6: &mut GlobalStats, arg7: &mut UserStatsRegistry, arg8: &mut 0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SharedTreasury, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &0x2::transfer_policy::TransferPolicy<DuckNFT>, arg12: 0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: u64, arg15: &0x2::random::Random, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg16);
        let v1 = 0x2::tx_context::sender(arg17);
        let v2 = get_referrer(arg5, v1);
        assert!(arg1.start_time > 0 && v0 >= arg1.start_time, 5);
        assert!(!arg1.is_genesis_batch, 12);
        check_and_start_new_batch_if_ready(arg1, arg2, arg16);
        assert!(!arg1.in_cooldown, 13);
        enforce_public_rate_limit(arg1, false, v1, arg14, v0);
        assert!(arg1.total_packs_remaining >= arg14, 3);
        if (arg2.max_basic_per_batch > 0) {
            assert!(arg2.basic_packs_remaining >= arg14, 18);
        };
        assert!(arg1.total_nfts_minted_globally + arg14 <= 5555, 14);
        let v3 = arg1.basic_egg_sht_cost;
        let v4 = arg1.basic_egg_sui_cost;
        let v5 = v3 * arg14;
        let v6 = v4 * arg14;
        assert!(0x2::coin::value<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&arg12) >= v5, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg13) >= v6, 2);
        arg1.total_packs_remaining = arg1.total_packs_remaining - arg14;
        if (arg2.max_basic_per_batch > 0) {
            arg2.basic_packs_remaining = arg2.basic_packs_remaining - arg14;
        };
        let v7 = v5 * 80 / 100;
        let v8 = v5 * 10 / 100;
        let v9 = 0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut arg12, v5, arg17);
        0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::burn(arg8, 0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v7, arg17));
        update_burn_stats(arg6, v7, arg16);
        update_user_pack_stats(arg7, v1, v7, arg14, arg16);
        if (0x1::option::is_some<address>(&v2)) {
            let v10 = *0x1::option::borrow<address>(&v2);
            assert!(v10 != v1, 9);
            let v11 = ReferralReward{
                pack_type  : 0,
                buyer      : v1,
                referrer   : v10,
                sht_amount : v8,
                timestamp  : v0,
            };
            0x2::event::emit<ReferralReward>(v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v8, arg17), v10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v8, arg17), arg4.treasury_wallet);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(v9, arg4.treasury_wallet);
        if (0x2::coin::value<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&arg12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(arg12, 0x2::tx_context::sender(arg17));
        } else {
            0x2::coin::destroy_zero<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(arg12);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg13, v6, arg17), arg4.treasury_wallet);
        if (0x2::coin::value<0x2::sui::SUI>(&arg13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg13, 0x2::tx_context::sender(arg17));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg13);
        };
        let v12 = 0;
        while (v12 < arg14) {
            let v13 = roll_basic_egg_rarity(arg15, arg17);
            let v14 = create_duck_nft(v13, arg1.current_batch_number, arg1.total_nfts_minted_globally + v12 + 1, arg16, arg17);
            update_rarity_stats(arg6, v13);
            let v15 = PackPurchased{
                pack_type       : 0,
                buyer           : 0x2::tx_context::sender(arg17),
                sht_cost        : v3,
                sui_cost        : v4,
                rarity          : v13,
                remaining_packs : arg1.total_packs_remaining,
            };
            0x2::event::emit<PackPurchased>(v15);
            0x2::kiosk::lock<DuckNFT>(arg9, arg10, arg11, v14);
            v12 = v12 + 1;
        };
        arg1.total_nfts_minted_globally = arg1.total_nfts_minted_globally + arg14;
        check_genesis_batch_completion(arg1, arg16);
        if (!arg1.is_genesis_batch) {
            start_cooldown_if_sold_out(arg1, arg2, arg16);
        };
    }

    public entry fun hatch_genesis_basic_egg(arg0: &HatchCap, arg1: &mut PackSupply, arg2: &mut PerTypeSupply, arg3: &Whitelist, arg4: &TreasuryConfig, arg5: &mut GlobalStats, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<DuckNFT>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = 0x2::tx_context::sender(arg13);
        assert!(arg1.is_genesis_batch, 7);
        assert!(arg1.start_time > 0 && v0 >= arg1.start_time, 5);
        assert!(arg1.total_packs_remaining >= arg10, 3);
        if (arg2.max_basic_per_batch > 0) {
            assert!(arg2.basic_packs_remaining >= arg10, 18);
        };
        assert!(arg1.total_nfts_minted_globally + arg10 <= 5555, 14);
        let v2 = arg1.whitelist_phase_active;
        let v3 = if (v2) {
            arg1.genesis_whitelist_basic_sui_cost
        } else {
            arg1.genesis_public_basic_sui_cost
        };
        let v4 = v3 * arg10;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= v4, 2);
        validate_genesis_purchase(arg1, arg3, v1, arg10, arg12);
        if (!v2) {
            validate_public_rate_limit(arg1, v1, arg10, v0);
        };
        apply_genesis_purchase(arg1, arg3, v1, arg10, arg12);
        if (!v2) {
            update_public_rate_limit(arg1, v1, v0);
        };
        arg1.total_packs_remaining = arg1.total_packs_remaining - arg10;
        if (arg2.max_basic_per_batch > 0) {
            arg2.basic_packs_remaining = arg2.basic_packs_remaining - arg10;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, v4, arg13), arg4.treasury_wallet);
        if (0x2::coin::value<0x2::sui::SUI>(&arg9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
        };
        let v5 = 0;
        while (v5 < arg10) {
            let v6 = roll_basic_egg_rarity(arg11, arg13);
            let v7 = create_duck_nft(v6, 0, arg1.total_nfts_minted_globally + v5 + 1, arg12, arg13);
            update_rarity_stats(arg5, v6);
            let v8 = PackPurchased{
                pack_type       : 0,
                buyer           : 0x2::tx_context::sender(arg13),
                sht_cost        : 0,
                sui_cost        : v3,
                rarity          : v6,
                remaining_packs : arg1.total_packs_remaining,
            };
            0x2::event::emit<PackPurchased>(v8);
            0x2::kiosk::lock<DuckNFT>(arg6, arg7, arg8, v7);
            v5 = v5 + 1;
        };
        arg1.total_nfts_minted_globally = arg1.total_nfts_minted_globally + arg10;
        check_genesis_batch_completion(arg1, arg12);
    }

    public entry fun hatch_genesis_golden_egg(arg0: &HatchCap, arg1: &mut PackSupply, arg2: &mut PerTypeSupply, arg3: &Whitelist, arg4: &TreasuryConfig, arg5: &mut GlobalStats, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<DuckNFT>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = 0x2::tx_context::sender(arg13);
        assert!(arg1.is_genesis_batch, 7);
        assert!(arg1.start_time > 0 && v0 >= arg1.start_time, 5);
        assert!(arg1.total_packs_remaining >= arg10, 3);
        if (arg2.max_golden_per_batch > 0) {
            assert!(arg2.golden_packs_remaining >= arg10, 18);
        };
        assert!(arg1.total_nfts_minted_globally + arg10 <= 5555, 14);
        let v2 = arg1.whitelist_phase_active;
        let v3 = if (v2) {
            arg1.genesis_whitelist_golden_sui_cost
        } else {
            arg1.genesis_public_golden_sui_cost
        };
        let v4 = v3 * arg10;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= v4, 2);
        validate_genesis_purchase(arg1, arg3, v1, arg10, arg12);
        if (!v2) {
            validate_public_rate_limit(arg1, v1, arg10, v0);
        };
        apply_genesis_purchase(arg1, arg3, v1, arg10, arg12);
        if (!v2) {
            update_public_rate_limit(arg1, v1, v0);
        };
        arg1.total_packs_remaining = arg1.total_packs_remaining - arg10;
        if (arg2.max_golden_per_batch > 0) {
            arg2.golden_packs_remaining = arg2.golden_packs_remaining - arg10;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, v4, arg13), arg4.treasury_wallet);
        if (0x2::coin::value<0x2::sui::SUI>(&arg9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
        };
        let v5 = 0;
        while (v5 < arg10) {
            let v6 = roll_golden_egg_rarity(arg11, arg13);
            let v7 = create_duck_nft(v6, 0, arg1.total_nfts_minted_globally + v5 + 1, arg12, arg13);
            update_rarity_stats(arg5, v6);
            let v8 = PackPurchased{
                pack_type       : 2,
                buyer           : 0x2::tx_context::sender(arg13),
                sht_cost        : 0,
                sui_cost        : v3,
                rarity          : v6,
                remaining_packs : arg1.total_packs_remaining,
            };
            0x2::event::emit<PackPurchased>(v8);
            0x2::kiosk::lock<DuckNFT>(arg6, arg7, arg8, v7);
            v5 = v5 + 1;
        };
        arg1.total_nfts_minted_globally = arg1.total_nfts_minted_globally + arg10;
        check_genesis_batch_completion(arg1, arg12);
    }

    public entry fun hatch_genesis_rare_egg(arg0: &HatchCap, arg1: &mut PackSupply, arg2: &mut PerTypeSupply, arg3: &Whitelist, arg4: &TreasuryConfig, arg5: &mut GlobalStats, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<DuckNFT>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = 0x2::tx_context::sender(arg13);
        assert!(arg1.is_genesis_batch, 7);
        assert!(arg1.start_time > 0 && v0 >= arg1.start_time, 5);
        assert!(arg1.total_packs_remaining >= arg10, 3);
        if (arg2.max_rare_per_batch > 0) {
            assert!(arg2.rare_packs_remaining >= arg10, 18);
        };
        assert!(arg1.total_nfts_minted_globally + arg10 <= 5555, 14);
        let v2 = arg1.whitelist_phase_active;
        let v3 = if (v2) {
            arg1.genesis_whitelist_rare_sui_cost
        } else {
            arg1.genesis_public_rare_sui_cost
        };
        let v4 = v3 * arg10;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= v4, 2);
        validate_genesis_purchase(arg1, arg3, v1, arg10, arg12);
        if (!v2) {
            validate_public_rate_limit(arg1, v1, arg10, v0);
        };
        apply_genesis_purchase(arg1, arg3, v1, arg10, arg12);
        if (!v2) {
            update_public_rate_limit(arg1, v1, v0);
        };
        arg1.total_packs_remaining = arg1.total_packs_remaining - arg10;
        if (arg2.max_rare_per_batch > 0) {
            arg2.rare_packs_remaining = arg2.rare_packs_remaining - arg10;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, v4, arg13), arg4.treasury_wallet);
        if (0x2::coin::value<0x2::sui::SUI>(&arg9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
        };
        let v5 = 0;
        while (v5 < arg10) {
            let v6 = roll_rare_egg_rarity(arg11, arg13);
            let v7 = create_duck_nft(v6, 0, arg1.total_nfts_minted_globally + v5 + 1, arg12, arg13);
            update_rarity_stats(arg5, v6);
            let v8 = PackPurchased{
                pack_type       : 1,
                buyer           : 0x2::tx_context::sender(arg13),
                sht_cost        : 0,
                sui_cost        : v3,
                rarity          : v6,
                remaining_packs : arg1.total_packs_remaining,
            };
            0x2::event::emit<PackPurchased>(v8);
            0x2::kiosk::lock<DuckNFT>(arg6, arg7, arg8, v7);
            v5 = v5 + 1;
        };
        arg1.total_nfts_minted_globally = arg1.total_nfts_minted_globally + arg10;
        check_genesis_batch_completion(arg1, arg12);
    }

    public entry fun hatch_golden_egg(arg0: &HatchCap, arg1: &mut PackSupply, arg2: &mut PerTypeSupply, arg3: &Whitelist, arg4: &TreasuryConfig, arg5: &ReferralRegistry, arg6: &mut GlobalStats, arg7: &mut UserStatsRegistry, arg8: &mut 0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SharedTreasury, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &0x2::transfer_policy::TransferPolicy<DuckNFT>, arg12: 0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: u64, arg15: &0x2::random::Random, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg16);
        let v1 = 0x2::tx_context::sender(arg17);
        let v2 = get_referrer(arg5, v1);
        assert!(arg1.start_time > 0 && v0 >= arg1.start_time, 5);
        assert!(!arg1.is_genesis_batch, 12);
        check_and_start_new_batch_if_ready(arg1, arg2, arg16);
        assert!(!arg1.in_cooldown, 13);
        enforce_public_rate_limit(arg1, false, v1, arg14, v0);
        assert!(arg1.total_packs_remaining >= arg14, 3);
        if (arg2.max_golden_per_batch > 0) {
            assert!(arg2.golden_packs_remaining >= arg14, 18);
        };
        assert!(arg1.total_nfts_minted_globally + arg14 <= 5555, 14);
        let v3 = arg1.golden_egg_sht_cost;
        let v4 = arg1.golden_egg_sui_cost;
        let v5 = v3 * arg14;
        let v6 = v4 * arg14;
        assert!(0x2::coin::value<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&arg12) >= v5, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg13) >= v6, 2);
        arg1.total_packs_remaining = arg1.total_packs_remaining - arg14;
        if (arg2.max_golden_per_batch > 0) {
            arg2.golden_packs_remaining = arg2.golden_packs_remaining - arg14;
        };
        let v7 = v5 * 80 / 100;
        let v8 = v5 * 10 / 100;
        let v9 = 0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut arg12, v5, arg17);
        0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::burn(arg8, 0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v7, arg17));
        update_burn_stats(arg6, v7, arg16);
        update_user_pack_stats(arg7, v1, v7, arg14, arg16);
        if (0x1::option::is_some<address>(&v2)) {
            let v10 = *0x1::option::borrow<address>(&v2);
            assert!(v10 != v1, 9);
            let v11 = ReferralReward{
                pack_type  : 2,
                buyer      : v1,
                referrer   : v10,
                sht_amount : v8,
                timestamp  : v0,
            };
            0x2::event::emit<ReferralReward>(v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v8, arg17), v10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v8, arg17), arg4.treasury_wallet);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(v9, arg4.treasury_wallet);
        if (0x2::coin::value<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&arg12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(arg12, 0x2::tx_context::sender(arg17));
        } else {
            0x2::coin::destroy_zero<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(arg12);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg13, v6, arg17), arg4.treasury_wallet);
        if (0x2::coin::value<0x2::sui::SUI>(&arg13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg13, 0x2::tx_context::sender(arg17));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg13);
        };
        let v12 = 0;
        while (v12 < arg14) {
            let v13 = roll_golden_egg_rarity(arg15, arg17);
            let v14 = create_duck_nft(v13, arg1.current_batch_number, arg1.total_nfts_minted_globally + v12 + 1, arg16, arg17);
            update_rarity_stats(arg6, v13);
            let v15 = PackPurchased{
                pack_type       : 2,
                buyer           : 0x2::tx_context::sender(arg17),
                sht_cost        : v3,
                sui_cost        : v4,
                rarity          : v13,
                remaining_packs : arg1.total_packs_remaining,
            };
            0x2::event::emit<PackPurchased>(v15);
            0x2::kiosk::lock<DuckNFT>(arg9, arg10, arg11, v14);
            v12 = v12 + 1;
        };
        arg1.total_nfts_minted_globally = arg1.total_nfts_minted_globally + arg14;
        check_genesis_batch_completion(arg1, arg16);
        if (!arg1.is_genesis_batch) {
            start_cooldown_if_sold_out(arg1, arg2, arg16);
        };
    }

    public entry fun hatch_rare_egg(arg0: &HatchCap, arg1: &mut PackSupply, arg2: &mut PerTypeSupply, arg3: &Whitelist, arg4: &TreasuryConfig, arg5: &ReferralRegistry, arg6: &mut GlobalStats, arg7: &mut UserStatsRegistry, arg8: &mut 0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SharedTreasury, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &0x2::transfer_policy::TransferPolicy<DuckNFT>, arg12: 0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: u64, arg15: &0x2::random::Random, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg16);
        let v1 = 0x2::tx_context::sender(arg17);
        let v2 = get_referrer(arg5, v1);
        assert!(arg1.start_time > 0 && v0 >= arg1.start_time, 5);
        assert!(!arg1.is_genesis_batch, 12);
        check_and_start_new_batch_if_ready(arg1, arg2, arg16);
        assert!(!arg1.in_cooldown, 13);
        enforce_public_rate_limit(arg1, false, v1, arg14, v0);
        assert!(arg1.total_packs_remaining >= arg14, 3);
        if (arg2.max_rare_per_batch > 0) {
            assert!(arg2.rare_packs_remaining >= arg14, 18);
        };
        assert!(arg1.total_nfts_minted_globally + arg14 <= 5555, 14);
        let v3 = arg1.rare_egg_sht_cost;
        let v4 = arg1.rare_egg_sui_cost;
        let v5 = v3 * arg14;
        let v6 = v4 * arg14;
        assert!(0x2::coin::value<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&arg12) >= v5, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg13) >= v6, 2);
        arg1.total_packs_remaining = arg1.total_packs_remaining - arg14;
        if (arg2.max_rare_per_batch > 0) {
            arg2.rare_packs_remaining = arg2.rare_packs_remaining - arg14;
        };
        let v7 = v5 * 80 / 100;
        let v8 = v5 * 10 / 100;
        let v9 = 0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut arg12, v5, arg17);
        0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::burn(arg8, 0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v7, arg17));
        update_burn_stats(arg6, v7, arg16);
        update_user_pack_stats(arg7, v1, v7, arg14, arg16);
        if (0x1::option::is_some<address>(&v2)) {
            let v10 = *0x1::option::borrow<address>(&v2);
            assert!(v10 != v1, 9);
            let v11 = ReferralReward{
                pack_type  : 1,
                buyer      : v1,
                referrer   : v10,
                sht_amount : v8,
                timestamp  : v0,
            };
            0x2::event::emit<ReferralReward>(v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v8, arg17), v10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(0x2::coin::split<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&mut v9, v8, arg17), arg4.treasury_wallet);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(v9, arg4.treasury_wallet);
        if (0x2::coin::value<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(&arg12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>>(arg12, 0x2::tx_context::sender(arg17));
        } else {
            0x2::coin::destroy_zero<0xff48d9a27c71f9e882852ab5c37cf59195bb93aa2709761e84e86afe1d3168ba::shttoken::SHTTOKEN>(arg12);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg13, v6, arg17), arg4.treasury_wallet);
        if (0x2::coin::value<0x2::sui::SUI>(&arg13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg13, 0x2::tx_context::sender(arg17));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg13);
        };
        let v12 = 0;
        while (v12 < arg14) {
            let v13 = roll_rare_egg_rarity(arg15, arg17);
            let v14 = create_duck_nft(v13, arg1.current_batch_number, arg1.total_nfts_minted_globally + v12 + 1, arg16, arg17);
            update_rarity_stats(arg6, v13);
            let v15 = PackPurchased{
                pack_type       : 1,
                buyer           : 0x2::tx_context::sender(arg17),
                sht_cost        : v3,
                sui_cost        : v4,
                rarity          : v13,
                remaining_packs : arg1.total_packs_remaining,
            };
            0x2::event::emit<PackPurchased>(v15);
            0x2::kiosk::lock<DuckNFT>(arg9, arg10, arg11, v14);
            v12 = v12 + 1;
        };
        arg1.total_nfts_minted_globally = arg1.total_nfts_minted_globally + arg14;
        check_genesis_batch_completion(arg1, arg16);
        if (!arg1.is_genesis_batch) {
            start_cooldown_if_sold_out(arg1, arg2, arg16);
        };
    }

    fun init(arg0: DUCK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<DUCK_NFT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"number"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"luck"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"multiplier"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"batch"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{number}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{rarity_name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{luck}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{multiplier}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{batch}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes}"));
        let v6 = 0x2::display::new_with_fields<DuckNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<DuckNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<DuckNFT>>(v6, v0);
        let (v7, v8) = 0x2::transfer_policy::new<DuckNFT>(&v1, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DuckNFT>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DuckNFT>>(v8, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        let v9 = HatchCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<HatchCap>(v9);
        let v10 = AdminCap{
            id                    : 0x2::object::new(arg1),
            team_mint_initialized : false,
        };
        0x2::transfer::transfer<AdminCap>(v10, v0);
        let v11 = PackSupply{
            id                                : 0x2::object::new(arg1),
            total_packs_remaining             : 0,
            last_refresh_time                 : 0,
            start_time                        : 0,
            basic_egg_sht_cost                : 100000000000,
            basic_egg_sui_cost                : 100000000,
            rare_egg_sht_cost                 : 200000000000,
            rare_egg_sui_cost                 : 200000000,
            golden_egg_sht_cost               : 300000000000,
            golden_egg_sui_cost               : 300000000,
            genesis_whitelist_basic_sui_cost  : 100000000,
            genesis_whitelist_rare_sui_cost   : 200000000,
            genesis_whitelist_golden_sui_cost : 300000000,
            genesis_public_basic_sui_cost     : 100000000,
            genesis_public_rare_sui_cost      : 200000000,
            genesis_public_golden_sui_cost    : 300000000,
            is_genesis_batch                  : false,
            genesis_batch_start_time          : 0,
            whitelist_packs_sold              : 0,
            whitelist_phase_active            : false,
            user_whitelist_purchases          : 0x2::table::new<address, u64>(arg1),
            current_batch_number              : 0,
            display_batch_number              : 0,
            previous_batch_completed          : false,
            total_nfts_minted_globally        : 0,
            in_cooldown                       : false,
            cooldown_end_time                 : 0,
            last_sellout_time                 : 0,
            batch_transition_lock             : false,
            user_last_purchase_time           : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<PackSupply>(v11);
        let v12 = PerTypeSupply{
            id                     : 0x2::object::new(arg1),
            basic_packs_remaining  : 0,
            rare_packs_remaining   : 0,
            golden_packs_remaining : 0,
            max_basic_per_batch    : 0,
            max_rare_per_batch     : 0,
            max_golden_per_batch   : 0,
        };
        0x2::transfer::share_object<PerTypeSupply>(v12);
        let v13 = TreasuryConfig{
            id              : 0x2::object::new(arg1),
            treasury_wallet : v0,
        };
        0x2::transfer::share_object<TreasuryConfig>(v13);
        let v14 = Whitelist{
            id        : 0x2::object::new(arg1),
            addresses : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Whitelist>(v14);
        let v15 = ReferralRegistry{
            id        : 0x2::object::new(arg1),
            referrers : 0x2::table::new<address, address>(arg1),
        };
        0x2::transfer::share_object<ReferralRegistry>(v15);
        let v16 = GlobalStats{
            id                  : 0x2::object::new(arg1),
            common_minted       : 0,
            queen_minted        : 0,
            king_minted         : 0,
            golden_minted       : 0,
            total_sht_burned    : 0,
            sht_burned_today    : 0,
            last_burn_reset_day : 0,
        };
        0x2::transfer::share_object<GlobalStats>(v16);
        let v17 = UserStatsRegistry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<UserStatsRegistry>(v17);
    }

    public entry fun initialize_game_start(arg0: &AdminCap, arg1: &mut PackSupply, arg2: &mut PerTypeSupply, arg3: &0x2::clock::Clock) {
        assert!(arg1.start_time == 0, 11);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.is_genesis_batch = true;
        arg1.genesis_batch_start_time = v0;
        arg1.total_packs_remaining = 600;
        arg1.whitelist_packs_sold = 0;
        arg1.whitelist_phase_active = true;
        arg1.start_time = v0;
        arg1.last_refresh_time = v0;
        arg1.current_batch_number = 0;
        arg1.display_batch_number = 0;
        arg1.previous_batch_completed = false;
        let v1 = if (arg2.max_basic_per_batch > 0) {
            arg2.max_basic_per_batch
        } else {
            600
        };
        arg2.basic_packs_remaining = v1;
        let v2 = if (arg2.max_rare_per_batch > 0) {
            arg2.max_rare_per_batch
        } else {
            600
        };
        arg2.rare_packs_remaining = v2;
        let v3 = if (arg2.max_golden_per_batch > 0) {
            arg2.max_golden_per_batch
        } else {
            600
        };
        arg2.golden_packs_remaining = v3;
        let v4 = GenesisBatchStarted{
            start_time           : v0,
            total_supply         : 600,
            whitelist_allocation : 575,
        };
        0x2::event::emit<GenesisBatchStarted>(v4);
    }

    public entry fun initialize_team_mint(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.team_mint_initialized, 11);
        let v0 = TeamMintCap{
            id          : 0x2::object::new(arg2),
            team_wallet : arg1,
            minted      : false,
        };
        0x2::transfer::transfer<TeamMintCap>(v0, arg1);
        arg0.team_mint_initialized = true;
    }

    public fun is_duck_staked(arg0: &DuckNFT) : bool {
        arg0.is_staked
    }

    public fun is_game_started(arg0: &PackSupply, arg1: &0x2::clock::Clock) : bool {
        arg0.start_time > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.start_time
    }

    public fun is_in_cooldown(arg0: &PackSupply) : bool {
        arg0.in_cooldown
    }

    fun is_mint_running(arg0: &PackSupply) : bool {
        if (arg0.start_time == 0) {
            return false
        };
        if (arg0.in_cooldown) {
            return false
        };
        if (arg0.is_genesis_batch) {
            return true
        };
        true
    }

    public fun is_whitelisted(arg0: &Whitelist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.addresses, &arg1)
    }

    public entry fun lock_duck_in_kiosk(arg0: DuckNFT, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<DuckNFT>) {
        0x2::kiosk::lock<DuckNFT>(arg1, arg2, arg3, arg0);
    }

    public fun mark_as_staked(arg0: &mut DuckNFT, arg1: u64, arg2: u8) {
        arg0.is_staked = true;
        arg0.staked_at = arg1;
        arg0.last_harvest_time = arg1;
        arg0.nest_level = arg2;
        update_staked_attribute(arg0, true);
    }

    public fun mark_as_unstaked(arg0: &mut DuckNFT) {
        arg0.is_staked = false;
        arg0.staked_at = 0;
        arg0.last_harvest_time = 0;
        arg0.nest_level = 0;
        update_staked_attribute(arg0, false);
    }

    fun roll_basic_egg_rarity(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, 100);
        if (v1 < 70) {
            0
        } else if (v1 < 95) {
            1
        } else {
            2
        }
    }

    fun roll_golden_egg_rarity(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, 100);
        if (v1 < 30) {
            1
        } else if (v1 < 80) {
            2
        } else {
            3
        }
    }

    fun roll_rare_egg_rarity(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, 100);
        if (v1 < 40) {
            0
        } else if (v1 < 80) {
            1
        } else if (v1 < 95) {
            2
        } else {
            3
        }
    }

    public entry fun set_referrer(arg0: &mut ReferralRegistry, arg1: &PackSupply, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 != v0, 9);
        assert!(!0x2::table::contains<address, address>(&arg0.referrers, v0), 10);
        0x2::table::add<address, address>(&mut arg0.referrers, v0, arg2);
        let v1 = ReferrerSet{
            user      : v0,
            referrer  : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferrerSet>(v1);
    }

    public(friend) fun stake_duck_virtual(arg0: &mut DuckNFT, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_staked, 21);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.is_staked = true;
        arg0.staked_at = v0;
        arg0.last_harvest_time = v0;
        arg0.nest_level = arg1;
        update_staked_attribute(arg0, true);
        let v1 = DuckVirtuallyStaked{
            duck_id    : 0x2::object::id<DuckNFT>(arg0),
            owner      : 0x2::tx_context::sender(arg3),
            nest_level : arg1,
            staked_at  : v0,
        };
        0x2::event::emit<DuckVirtuallyStaked>(v1);
    }

    fun start_cooldown_if_sold_out(arg0: &mut PackSupply, arg1: &mut PerTypeSupply, arg2: &0x2::clock::Clock) {
        if (arg0.total_packs_remaining == 0 && !arg0.in_cooldown) {
            let v0 = 0x2::clock::timestamp_ms(arg2);
            let v1 = if (arg1.max_basic_per_batch > 0) {
                arg1.max_basic_per_batch
            } else {
                300
            };
            arg1.basic_packs_remaining = v1;
            let v2 = if (arg1.max_rare_per_batch > 0) {
                arg1.max_rare_per_batch
            } else {
                300
            };
            arg1.rare_packs_remaining = v2;
            let v3 = if (arg1.max_golden_per_batch > 0) {
                arg1.max_golden_per_batch
            } else {
                300
            };
            arg1.golden_packs_remaining = v3;
            let v4 = arg0.current_batch_number;
            arg0.current_batch_number = arg0.current_batch_number + 1;
            arg0.display_batch_number = v4;
            arg0.previous_batch_completed = true;
            arg0.in_cooldown = true;
            arg0.last_sellout_time = v0;
            let v5 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"cooldown_duration")) {
                *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"cooldown_duration")
            } else {
                300000
            };
            arg0.cooldown_end_time = v0 + v5;
            let v6 = LastMintOfBatch{
                completed_batch_number : v4,
                next_batch_number      : arg0.current_batch_number,
                cooldown_end_time      : arg0.cooldown_end_time,
                final_nfts_minted      : arg0.total_nfts_minted_globally,
            };
            0x2::event::emit<LastMintOfBatch>(v6);
            let v7 = CooldownStarted{
                batch_number      : v4,
                sellout_time      : v0,
                cooldown_end_time : arg0.cooldown_end_time,
            };
            0x2::event::emit<CooldownStarted>(v7);
        };
    }

    public entry fun team_mint(arg0: &mut TeamMintCap, arg1: &mut PackSupply, arg2: &mut GlobalStats, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<DuckNFT>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg0.team_wallet, 4);
        assert!(!arg0.minted, 3);
        let v1 = 200;
        assert!(arg1.total_nfts_minted_globally + v1 <= 5555, 14);
        let v2 = 0;
        while (v2 < 100) {
            let v3 = create_duck_nft(3, 0, arg1.total_nfts_minted_globally + v2 + 1, arg6, arg7);
            update_rarity_stats(arg2, 3);
            0x2::kiosk::lock<DuckNFT>(arg3, arg4, arg5, v3);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < 100) {
            update_rarity_stats(arg2, 2);
            0x2::kiosk::lock<DuckNFT>(arg3, arg4, arg5, create_duck_nft(2, 0, arg1.total_nfts_minted_globally + 100 + v4 + 1, arg6, arg7));
            v4 = v4 + 1;
        };
        arg0.minted = true;
        arg1.total_nfts_minted_globally = arg1.total_nfts_minted_globally + v1;
        let v5 = TeamMintCompleted{
            minter          : v0,
            quantity        : v1,
            remaining_mints : 0,
        };
        0x2::event::emit<TeamMintCompleted>(v5);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public(friend) fun unstake_duck_virtual(arg0: &mut DuckNFT, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.is_staked, 22);
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.staked_at;
        arg0.is_staked = false;
        arg0.staked_at = 0;
        arg0.nest_level = 0;
        update_staked_attribute(arg0, false);
        let v1 = DuckVirtuallyUnstaked{
            duck_id           : 0x2::object::id<DuckNFT>(arg0),
            owner             : 0x2::tx_context::sender(arg2),
            total_time_staked : v0,
        };
        0x2::event::emit<DuckVirtuallyUnstaked>(v1);
    }

    fun update_burn_stats(arg0: &mut GlobalStats, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 86400000;
        if (v0 > arg0.last_burn_reset_day) {
            arg0.sht_burned_today = 0;
            arg0.last_burn_reset_day = v0;
        };
        arg0.total_sht_burned = arg0.total_sht_burned + arg1;
        arg0.sht_burned_today = arg0.sht_burned_today + arg1;
    }

    public(friend) fun update_duck_nest_level(arg0: &mut DuckNFT, arg1: u8) {
        assert!(arg0.is_staked, 22);
        arg0.nest_level = arg1;
    }

    public(friend) fun update_harvest_time(arg0: &mut DuckNFT, arg1: &0x2::clock::Clock) {
        assert!(arg0.is_staked, 22);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.last_harvest_time = v0;
        let v1 = HarvestTimeUpdated{
            duck_id          : 0x2::object::id<DuckNFT>(arg0),
            new_harvest_time : v0,
        };
        0x2::event::emit<HarvestTimeUpdated>(v1);
    }

    fun update_public_rate_limit(arg0: &mut PackSupply, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.user_last_purchase_time, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_last_purchase_time, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_last_purchase_time, arg1, arg2);
        };
    }

    fun update_rarity_stats(arg0: &mut GlobalStats, arg1: u8) {
        if (arg1 == 0) {
            arg0.common_minted = arg0.common_minted + 1;
        } else if (arg1 == 1) {
            arg0.queen_minted = arg0.queen_minted + 1;
        } else if (arg1 == 2) {
            arg0.king_minted = arg0.king_minted + 1;
        } else if (arg1 == 3) {
            arg0.golden_minted = arg0.golden_minted + 1;
        };
    }

    fun update_staked_attribute(arg0: &mut DuckNFT, arg1: bool) {
        let v0 = 0x1::string::utf8(b"Staked");
        let v1 = if (arg1) {
            0x1::string::utf8(b"Yes")
        } else {
            0x1::string::utf8(b"No")
        };
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, v1);
    }

    fun update_user_pack_stats(arg0: &mut UserStatsRegistry, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, UserStats>(&mut arg0.id, arg1);
            v0.total_sht_burned = v0.total_sht_burned + arg2;
            v0.packs_bought = v0.packs_bought + arg3;
            v0.last_activity_day = 0x2::clock::timestamp_ms(arg4) / 86400000;
        } else {
            let v1 = UserStats{
                lifetime_sht_earned    : 0,
                total_harvest_attempts : 0,
                successful_harvests    : 0,
                total_sht_burned       : arg2,
                packs_bought           : arg3,
                sht_earned_today       : 0,
                last_activity_day      : 0x2::clock::timestamp_ms(arg4) / 86400000,
            };
            0x2::dynamic_field::add<address, UserStats>(&mut arg0.id, arg1, v1);
        };
    }

    fun validate_genesis_purchase(arg0: &PackSupply, arg1: &Whitelist, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        if (!arg0.is_genesis_batch) {
            return
        };
        if (arg0.whitelist_phase_active && !(0x2::clock::timestamp_ms(arg4) >= arg0.genesis_batch_start_time + 300000)) {
            assert!(0x2::vec_set::contains<address>(&arg1.addresses, &arg2), 8);
            let v0 = if (0x2::table::contains<address, u64>(&arg0.user_whitelist_purchases, arg2)) {
                *0x2::table::borrow<address, u64>(&arg0.user_whitelist_purchases, arg2)
            } else {
                0
            };
            assert!(v0 + arg3 <= 10, 6);
        };
    }

    fun validate_public_rate_limit(arg0: &PackSupply, arg1: address, arg2: u64, arg3: u64) {
        assert!(arg2 <= 20, 16);
        if (0x2::table::contains<address, u64>(&arg0.user_last_purchase_time, arg1)) {
            assert!(arg3 - *0x2::table::borrow<address, u64>(&arg0.user_last_purchase_time, arg1) >= 1000, 17);
        };
    }

    // decompiled from Move bytecode v6
}

