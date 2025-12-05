module 0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::nest {
    struct NestAdminCap has key {
        id: 0x2::object::UID,
    }

    struct NestRegistry has key {
        id: 0x2::object::UID,
        user_nests: 0x2::table::Table<address, 0x2::table::Table<u8, 0x2::object::ID>>,
        is_initialized: bool,
    }

    struct Nest has key {
        id: 0x2::object::UID,
        owner: address,
        nest_index: u8,
        level: u8,
        staked_duck_id: 0x1::option::Option<0x2::object::ID>,
        staked_at: u64,
        last_harvest_time: u64,
        duck_rarity: u8,
        duck_multiplier: u8,
    }

    struct HarvestStats has key {
        id: 0x2::object::UID,
        total_sht_harvested: u64,
        total_harvest_attempts: u64,
        total_successful_harvests: u64,
        active_ducks_staked: u64,
        sht_harvested_today: u64,
        last_harvest_reset_day: u64,
        leaderboard: vector<LeaderboardEntry>,
    }

    struct LeaderboardEntry has copy, drop, store {
        user: address,
        total_harvested: u64,
    }

    struct UserHarvestStats has copy, drop, store {
        lifetime_sht_earned: u64,
        total_harvest_attempts: u64,
        successful_harvests: u64,
        current_ducks_staked: u64,
        sht_earned_today: u64,
        last_activity_day: u64,
    }

    struct DuckStaked has copy, drop {
        nest_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        owner: address,
        slot_index: u8,
    }

    struct DuckUnstaked has copy, drop {
        nest_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        owner: address,
        slot_index: u8,
    }

    struct HarvestAttempted has copy, drop {
        nest_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        owner: address,
        success: bool,
        sht_earned: u64,
        luck_used: u8,
    }

    struct SlotUpgraded has copy, drop {
        nest_id: 0x2::object::ID,
        owner: address,
        slot_index: u8,
        old_level: u8,
        new_level: u8,
        sht_cost: u64,
    }

    struct AccumulatedHarvest has copy, drop {
        nest_id: 0x2::object::ID,
        duck_id: 0x2::object::ID,
        owner: address,
        cycles_harvested: u64,
        total_sht_earned: u64,
        harvest_results: vector<HarvestResult>,
    }

    struct HarvestResult has copy, drop {
        cycle_number: u64,
        success: bool,
        sht_earned: u64,
        luck_used: u8,
    }

    struct NestCreated has copy, drop {
        nest_id: 0x2::object::ID,
        owner: address,
    }

    public entry fun clear_stale_stake(arg0: &mut Nest, arg1: &0x2::kiosk::Kiosk, arg2: &mut HarvestStats, arg3: &mut 0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::staking_lock_rule::StakingRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.owner == v0, 6);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.staked_duck_id), 13);
        let v1 = *0x1::option::borrow<0x2::object::ID>(&arg0.staked_duck_id);
        assert!(!0x2::kiosk::has_item_with_type<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::duck_nft::DuckNFT>(arg1, v1), 1);
        0x1::option::extract<0x2::object::ID>(&mut arg0.staked_duck_id);
        arg0.staked_at = 0;
        arg0.last_harvest_time = 0;
        arg0.duck_rarity = 0;
        arg0.duck_multiplier = 0;
        0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::staking_lock_rule::remove_staked_duck(arg3, v1);
        if (arg2.active_ducks_staked > 0) {
            arg2.active_ducks_staked = arg2.active_ducks_staked - 1;
        };
        update_user_stake_stats(arg2, v0, false, arg4);
        let v2 = DuckUnstaked{
            nest_id    : 0x2::object::id<Nest>(arg0),
            duck_id    : v1,
            owner      : v0,
            slot_index : arg0.nest_index,
        };
        0x2::event::emit<DuckUnstaked>(v2);
    }

    public entry fun create_nest(arg0: &mut NestRegistry, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 10);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 < 5, 9);
        if (!0x2::table::contains<address, 0x2::table::Table<u8, 0x2::object::ID>>(&arg0.user_nests, v0)) {
            0x2::table::add<address, 0x2::table::Table<u8, 0x2::object::ID>>(&mut arg0.user_nests, v0, 0x2::table::new<u8, 0x2::object::ID>(arg2));
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::table::Table<u8, 0x2::object::ID>>(&mut arg0.user_nests, v0);
        assert!(0x2::table::length<u8, 0x2::object::ID>(v1) < (5 as u64), 7);
        assert!(!0x2::table::contains<u8, 0x2::object::ID>(v1, arg1), 8);
        let v2 = 0x2::object::new(arg2);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Nest{
            id                : v2,
            owner             : v0,
            nest_index        : arg1,
            level             : 1,
            staked_duck_id    : 0x1::option::none<0x2::object::ID>(),
            staked_at         : 0,
            last_harvest_time : 0,
            duck_rarity       : 0,
            duck_multiplier   : 0,
        };
        0x2::table::add<u8, 0x2::object::ID>(v1, arg1, v3);
        let v5 = NestCreated{
            nest_id : v3,
            owner   : v0,
        };
        0x2::event::emit<NestCreated>(v5);
        0x2::transfer::transfer<Nest>(v4, v0);
    }

    fun get_duck_base_luck(arg0: u8) : u8 {
        if (arg0 == 3) {
            85
        } else if (arg0 == 2) {
            60
        } else if (arg0 == 1) {
            50
        } else {
            40
        }
    }

    fun get_duck_multiplier(arg0: u8) : u8 {
        if (arg0 == 3) {
            7
        } else if (arg0 == 2) {
            5
        } else if (arg0 == 1) {
            3
        } else {
            1
        }
    }

    public fun get_harvest_stats(arg0: &HarvestStats) : (u64, u64, u64, u64, u64) {
        (arg0.total_sht_harvested, arg0.total_harvest_attempts, arg0.total_successful_harvests, arg0.active_ducks_staked, arg0.sht_harvested_today)
    }

    public fun get_leaderboard(arg0: &HarvestStats) : vector<LeaderboardEntry> {
        arg0.leaderboard
    }

    public fun get_leaderboard_entry(arg0: &HarvestStats, arg1: u64) : (address, u64) {
        let v0 = 0x1::vector::borrow<LeaderboardEntry>(&arg0.leaderboard, arg1);
        (v0.user, v0.total_harvested)
    }

    public fun get_leaderboard_length(arg0: &HarvestStats) : u64 {
        0x1::vector::length<LeaderboardEntry>(&arg0.leaderboard)
    }

    public fun get_nest_info(arg0: &Nest) : (u8, u8, bool, address) {
        (arg0.nest_index, arg0.level, 0x1::option::is_some<0x2::object::ID>(&arg0.staked_duck_id), arg0.owner)
    }

    public fun get_nest_level(arg0: &Nest) : u8 {
        arg0.level
    }

    fun get_nest_luck_bonus(arg0: u8) : u8 {
        if (arg0 == 4) {
            15
        } else if (arg0 == 3) {
            10
        } else if (arg0 == 2) {
            5
        } else {
            0
        }
    }

    public fun get_nest_staking_info(arg0: &Nest) : (bool, u64, u64, u8, u8) {
        (0x1::option::is_some<0x2::object::ID>(&arg0.staked_duck_id), arg0.staked_at, arg0.last_harvest_time, arg0.duck_rarity, arg0.duck_multiplier)
    }

    public fun get_staked_duck_id(arg0: &Nest) : 0x1::option::Option<0x2::object::ID> {
        arg0.staked_duck_id
    }

    fun get_upgrade_cost(arg0: u8) : u64 {
        if (arg0 == 2) {
            4000000000000
        } else if (arg0 == 3) {
            6000000000000
        } else if (arg0 == 4) {
            10000000000000
        } else {
            0
        }
    }

    public fun get_user_harvest_stats(arg0: &HarvestStats, arg1: address) : (u64, u64, u64, u64, u64) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v5 = 0x2::dynamic_field::borrow<address, UserHarvestStats>(&arg0.id, arg1);
            (v5.lifetime_sht_earned, v5.total_harvest_attempts, v5.successful_harvests, v5.current_ducks_staked, v5.sht_earned_today)
        } else {
            (0, 0, 0, 0, 0)
        }
    }

    public entry fun harvest_duck(arg0: &mut Nest, arg1: &0x2::kiosk::Kiosk, arg2: &mut HarvestStats, arg3: &0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::NestMintCap, arg4: &mut 0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::SharedTreasury, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.owner == v0, 6);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.staked_duck_id), 13);
        let v1 = *0x1::option::borrow<0x2::object::ID>(&arg0.staked_duck_id);
        assert!(0x2::kiosk::has_item_with_type<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::duck_nft::DuckNFT>(arg1, v1), 2);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = arg0.last_harvest_time;
        assert!(v2 >= v3 + 180000, 3);
        let v4 = (v2 - v3) / 180000;
        let v5 = if (v4 > 30) {
            30
        } else {
            v4
        };
        let v6 = get_duck_base_luck(arg0.duck_rarity);
        let v7 = get_nest_luck_bonus(arg0.level);
        let v8 = if (v6 + v7 > 100) {
            100
        } else {
            v6 + v7
        };
        let v9 = 0x2::random::new_generator(arg5, arg7);
        let v10 = 0;
        let v11 = 0x1::vector::empty<HarvestResult>();
        let v12 = 1;
        while (v12 <= v5) {
            let v13 = 0x2::random::generate_u64_in_range(&mut v9, 1, 101) <= (v8 as u64);
            let v14 = if (v13) {
                100000000000 * (arg0.duck_multiplier as u64)
            } else {
                0
            };
            v10 = v10 + v14;
            let v15 = HarvestResult{
                cycle_number : v12,
                success      : v13,
                sht_earned   : v14,
                luck_used    : v8,
            };
            0x1::vector::push_back<HarvestResult>(&mut v11, v15);
            v12 = v12 + 1;
        };
        let v16 = 0;
        let v17 = 0;
        while (v17 < 0x1::vector::length<HarvestResult>(&v11)) {
            if (0x1::vector::borrow<HarvestResult>(&v11, v17).success) {
                v16 = v16 + 1;
            };
            v17 = v17 + 1;
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::SHTTOKEN>>(0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::mint_for_nest(arg3, arg4, v10, arg7), v0);
        };
        update_harvest_stats(arg2, v0, v5, v16, v10, arg6);
        arg0.last_harvest_time = v3 + v5 * 180000;
        if (v5 > 1) {
            let v18 = AccumulatedHarvest{
                nest_id          : 0x2::object::id<Nest>(arg0),
                duck_id          : v1,
                owner            : v0,
                cycles_harvested : v5,
                total_sht_earned : v10,
                harvest_results  : v11,
            };
            0x2::event::emit<AccumulatedHarvest>(v18);
        } else {
            let v19 = 0x1::vector::borrow<HarvestResult>(&v11, 0);
            let v20 = HarvestAttempted{
                nest_id    : 0x2::object::id<Nest>(arg0),
                duck_id    : v1,
                owner      : v0,
                success    : v19.success,
                sht_earned : v19.sht_earned,
                luck_used  : v19.luck_used,
            };
            0x2::event::emit<HarvestAttempted>(v20);
        };
    }

    public fun has_user_harvest_stats(arg0: &HarvestStats, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NestAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<NestAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = NestRegistry{
            id             : 0x2::object::new(arg0),
            user_nests     : 0x2::table::new<address, 0x2::table::Table<u8, 0x2::object::ID>>(arg0),
            is_initialized : false,
        };
        0x2::transfer::share_object<NestRegistry>(v1);
        let v2 = HarvestStats{
            id                        : 0x2::object::new(arg0),
            total_sht_harvested       : 0,
            total_harvest_attempts    : 0,
            total_successful_harvests : 0,
            active_ducks_staked       : 0,
            sht_harvested_today       : 0,
            last_harvest_reset_day    : 0,
            leaderboard               : 0x1::vector::empty<LeaderboardEntry>(),
        };
        0x2::transfer::share_object<HarvestStats>(v2);
    }

    public entry fun initialize_nest(arg0: &NestAdminCap, arg1: &mut NestRegistry) {
        assert!(!arg1.is_initialized, 11);
        arg1.is_initialized = true;
    }

    public fun is_nest_initialized(arg0: &NestRegistry) : bool {
        arg0.is_initialized
    }

    public fun is_staked_duck_in_kiosk(arg0: &Nest, arg1: &0x2::kiosk::Kiosk) : (bool, bool) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.staked_duck_id)) {
            (false, false)
        } else {
            (true, 0x2::kiosk::has_item_with_type<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::duck_nft::DuckNFT>(arg1, *0x1::option::borrow<0x2::object::ID>(&arg0.staked_duck_id)))
        }
    }

    public entry fun stake_duck(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut Nest, arg4: &mut HarvestStats, arg5: &mut 0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::staking_lock_rule::StakingRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg3.owner == v0, 6);
        if (0x1::option::is_some<0x2::object::ID>(&arg3.staked_duck_id)) {
            let v1 = *0x1::option::borrow<0x2::object::ID>(&arg3.staked_duck_id);
            if (0x2::kiosk::has_item_with_type<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::duck_nft::DuckNFT>(arg0, v1)) {
                abort 12
            };
            0x1::option::extract<0x2::object::ID>(&mut arg3.staked_duck_id);
            arg3.staked_at = 0;
            arg3.last_harvest_time = 0;
            arg3.duck_rarity = 0;
            arg3.duck_multiplier = 0;
            0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::staking_lock_rule::remove_staked_duck(arg5, v1);
            if (arg4.active_ducks_staked > 0) {
                arg4.active_ducks_staked = arg4.active_ducks_staked - 1;
            };
            update_user_stake_stats(arg4, v0, false, arg6);
        };
        let v2 = 0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::duck_nft::get_rarity_level(0x2::kiosk::borrow<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::duck_nft::DuckNFT>(arg0, arg1, arg2));
        let v3 = 0x2::clock::timestamp_ms(arg6);
        0x1::option::fill<0x2::object::ID>(&mut arg3.staked_duck_id, arg2);
        arg3.staked_at = v3;
        arg3.last_harvest_time = v3;
        arg3.duck_rarity = v2;
        arg3.duck_multiplier = get_duck_multiplier(v2);
        0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::staking_lock_rule::add_staked_duck(arg5, arg2, v0);
        arg4.active_ducks_staked = arg4.active_ducks_staked + 1;
        update_user_stake_stats(arg4, v0, true, arg6);
        let v4 = DuckStaked{
            nest_id    : 0x2::object::id<Nest>(arg3),
            duck_id    : arg2,
            owner      : v0,
            slot_index : arg3.nest_index,
        };
        0x2::event::emit<DuckStaked>(v4);
    }

    public entry fun unstake_duck(arg0: &mut Nest, arg1: &0x2::kiosk::Kiosk, arg2: &mut HarvestStats, arg3: &mut 0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::staking_lock_rule::StakingRegistry, arg4: &0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::NestMintCap, arg5: &mut 0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::SharedTreasury, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg0.owner == v0, 6);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.staked_duck_id), 13);
        let v1 = *0x1::option::borrow<0x2::object::ID>(&arg0.staked_duck_id);
        let v2 = 0x2::object::id<Nest>(arg0);
        if (0x2::kiosk::has_item_with_type<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::duck_nft::DuckNFT>(arg1, v1)) {
            let v3 = (0x2::clock::timestamp_ms(arg7) - arg0.last_harvest_time) / 180000;
            if (v3 > 0) {
                let v4 = if (v3 > 30) {
                    30
                } else {
                    v3
                };
                let v5 = get_duck_base_luck(arg0.duck_rarity);
                let v6 = get_nest_luck_bonus(arg0.level);
                let v7 = if (v5 + v6 > 100) {
                    100
                } else {
                    v5 + v6
                };
                let v8 = 0x2::random::new_generator(arg6, arg8);
                let v9 = 0;
                let v10 = 0x1::vector::empty<HarvestResult>();
                let v11 = 1;
                let v12 = 0;
                while (v11 <= v4) {
                    let v13 = 0x2::random::generate_u64_in_range(&mut v8, 1, 101) <= (v7 as u64);
                    let v14 = if (v13) {
                        v12 = v12 + 1;
                        100000000000 * (arg0.duck_multiplier as u64)
                    } else {
                        0
                    };
                    v9 = v9 + v14;
                    let v15 = HarvestResult{
                        cycle_number : v11,
                        success      : v13,
                        sht_earned   : v14,
                        luck_used    : v7,
                    };
                    0x1::vector::push_back<HarvestResult>(&mut v10, v15);
                    v11 = v11 + 1;
                };
                if (v9 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::SHTTOKEN>>(0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::mint_for_nest(arg4, arg5, v9, arg8), v0);
                };
                update_harvest_stats(arg2, v0, v4, v12, v9, arg7);
                let v16 = AccumulatedHarvest{
                    nest_id          : v2,
                    duck_id          : v1,
                    owner            : v0,
                    cycles_harvested : v4,
                    total_sht_earned : v9,
                    harvest_results  : v10,
                };
                0x2::event::emit<AccumulatedHarvest>(v16);
            };
        };
        0x1::option::extract<0x2::object::ID>(&mut arg0.staked_duck_id);
        arg0.staked_at = 0;
        arg0.last_harvest_time = 0;
        arg0.duck_rarity = 0;
        arg0.duck_multiplier = 0;
        0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::staking_lock_rule::remove_staked_duck(arg3, v1);
        if (arg2.active_ducks_staked > 0) {
            arg2.active_ducks_staked = arg2.active_ducks_staked - 1;
        };
        update_user_stake_stats(arg2, v0, false, arg7);
        let v17 = DuckUnstaked{
            nest_id    : v2,
            duck_id    : v1,
            owner      : v0,
            slot_index : arg0.nest_index,
        };
        0x2::event::emit<DuckUnstaked>(v17);
    }

    fun update_harvest_stats(arg0: &mut HarvestStats, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 86400000;
        if (v0 > arg0.last_harvest_reset_day) {
            arg0.sht_harvested_today = 0;
            arg0.last_harvest_reset_day = v0;
        };
        arg0.total_harvest_attempts = arg0.total_harvest_attempts + arg2;
        arg0.total_successful_harvests = arg0.total_successful_harvests + arg3;
        arg0.total_sht_harvested = arg0.total_sht_harvested + arg4;
        arg0.sht_harvested_today = arg0.sht_harvested_today + arg4;
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v1 = 0x2::dynamic_field::borrow_mut<address, UserHarvestStats>(&mut arg0.id, arg1);
            if (v0 > v1.last_activity_day) {
                v1.sht_earned_today = 0;
            };
            v1.lifetime_sht_earned = v1.lifetime_sht_earned + arg4;
            v1.total_harvest_attempts = v1.total_harvest_attempts + arg2;
            v1.successful_harvests = v1.successful_harvests + arg3;
            v1.sht_earned_today = v1.sht_earned_today + arg4;
            v1.last_activity_day = v0;
        } else {
            let v2 = UserHarvestStats{
                lifetime_sht_earned    : arg4,
                total_harvest_attempts : arg2,
                successful_harvests    : arg3,
                current_ducks_staked   : 0,
                sht_earned_today       : arg4,
                last_activity_day      : v0,
            };
            0x2::dynamic_field::add<address, UserHarvestStats>(&mut arg0.id, arg1, v2);
        };
        if (arg4 > 0) {
            update_leaderboard(arg0, arg1);
        };
    }

    fun update_leaderboard(arg0: &mut HarvestStats, arg1: address) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_field::borrow<address, UserHarvestStats>(&arg0.id, arg1).lifetime_sht_earned;
            let v1 = 0x1::option::none<u64>();
            let v2 = 0;
            let v3 = 0x1::vector::length<LeaderboardEntry>(&arg0.leaderboard);
            while (v2 < v3) {
                if (0x1::vector::borrow<LeaderboardEntry>(&arg0.leaderboard, v2).user == arg1) {
                    v1 = 0x1::option::some<u64>(v2);
                    break
                };
                v2 = v2 + 1;
            };
            if (0x1::option::is_some<u64>(&v1)) {
                0x1::vector::borrow_mut<LeaderboardEntry>(&mut arg0.leaderboard, *0x1::option::borrow<u64>(&v1)).total_harvested = v0;
            } else if (v3 < 10) {
                let v4 = LeaderboardEntry{
                    user            : arg1,
                    total_harvested : v0,
                };
                0x1::vector::push_back<LeaderboardEntry>(&mut arg0.leaderboard, v4);
            } else {
                let v5 = 0x1::vector::borrow<LeaderboardEntry>(&arg0.leaderboard, 0).total_harvested;
                let v6 = 1;
                while (v6 < v3) {
                    let v7 = 0x1::vector::borrow<LeaderboardEntry>(&arg0.leaderboard, v6).total_harvested;
                    if (v7 < v5) {
                        v5 = v7;
                    };
                    v6 = v6 + 1;
                };
                if (v0 > v5) {
                    let v8 = 0x1::vector::borrow_mut<LeaderboardEntry>(&mut arg0.leaderboard, 0);
                    v8.user = arg1;
                    v8.total_harvested = v0;
                };
            };
            let v9 = 0x1::vector::length<LeaderboardEntry>(&arg0.leaderboard);
            if (v9 > 1) {
                let v10 = 0;
                while (v10 < v9 - 1) {
                    let v11 = 0;
                    while (v11 < v9 - v10 - 1) {
                        if (0x1::vector::borrow<LeaderboardEntry>(&arg0.leaderboard, v11).total_harvested < 0x1::vector::borrow<LeaderboardEntry>(&arg0.leaderboard, v11 + 1).total_harvested) {
                            0x1::vector::swap<LeaderboardEntry>(&mut arg0.leaderboard, v11, v11 + 1);
                        };
                        v11 = v11 + 1;
                    };
                    v10 = v10 + 1;
                };
            };
            return
        };
    }

    fun update_user_stake_stats(arg0: &mut HarvestStats, arg1: address, arg2: bool, arg3: &0x2::clock::Clock) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, UserHarvestStats>(&mut arg0.id, arg1);
            if (arg2) {
                v0.current_ducks_staked = v0.current_ducks_staked + 1;
            } else if (v0.current_ducks_staked > 0) {
                v0.current_ducks_staked = v0.current_ducks_staked - 1;
            };
            v0.last_activity_day = 0x2::clock::timestamp_ms(arg3) / 86400000;
        } else {
            let v1 = if (arg2) {
                1
            } else {
                0
            };
            let v2 = UserHarvestStats{
                lifetime_sht_earned    : 0,
                total_harvest_attempts : 0,
                successful_harvests    : 0,
                current_ducks_staked   : v1,
                sht_earned_today       : 0,
                last_activity_day      : 0x2::clock::timestamp_ms(arg3) / 86400000,
            };
            0x2::dynamic_field::add<address, UserHarvestStats>(&mut arg0.id, arg1, v2);
        };
    }

    public entry fun upgrade_nest(arg0: &mut Nest, arg1: &mut 0x2::coin::Coin<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::SHTTOKEN>, arg2: &mut 0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::SharedTreasury, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 6);
        let v1 = arg0.level;
        assert!(v1 < 4, 4);
        let v2 = v1 + 1;
        let v3 = get_upgrade_cost(v2);
        assert!(0x2::coin::value<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::SHTTOKEN>(arg1) >= v3, 5);
        0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::burn(arg2, 0x2::coin::split<0x357837afaa2c4eb84122c2ed88b1d51581bfaa3e9707989e91f3134b14746cef::shttoken::SHTTOKEN>(arg1, v3, arg3));
        arg0.level = v2;
        let v4 = SlotUpgraded{
            nest_id    : 0x2::object::id<Nest>(arg0),
            owner      : v0,
            slot_index : arg0.nest_index,
            old_level  : v1,
            new_level  : v2,
            sht_cost   : v3,
        };
        0x2::event::emit<SlotUpgraded>(v4);
    }

    // decompiled from Move bytecode v6
}

