module 0x6f13fefeb11114a97c3177b7d4a8cfdacd5b40174ab3f80b07420b456d469a2b::arboretum {
    struct Registry has key {
        id: 0x2::object::UID,
        admin: address,
        current_season_id: u64,
        season_start_ms: u64,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_seeds: u64,
        total_growth_points: u64,
        paused: bool,
        seeds_by_owner: 0x2::table::Table<address, vector<0x2::object::ID>>,
        referrers: 0x2::table::Table<address, address>,
        referral_earnings: 0x2::table::Table<address, u64>,
        player_growth: 0x2::table::Table<address, u64>,
        player_growth_season: 0x2::table::Table<address, u64>,
        planted_saplings: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct Sapling has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        cycle_count: u64,
        total_sui_harvested: u64,
    }

    struct Seed has key {
        id: 0x2::object::UID,
        sapling_id: 0x2::object::ID,
        season_id: u64,
        owner: address,
        planted_at_ms: u64,
        last_watered_ms: u64,
        watering_streak: u64,
        growth_points: u64,
        state: u8,
        fertilizer_charges: u8,
        miracle_grow_applied: bool,
        revival_charges: u8,
        bottomless_can_expiry_ms: u64,
        permanent_gp_bonus: u64,
    }

    struct Tool has store, key {
        id: 0x2::object::UID,
        kind: 0x1::string::String,
        charges: u8,
        rarity: u8,
    }

    struct Crate has store, key {
        id: 0x2::object::UID,
        tier: u8,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SeedPlanted has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
        sapling_id: 0x2::object::ID,
    }

    struct SeedWatered has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
        streak: u64,
        growth_points: u64,
    }

    struct SeedDied has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
    }

    struct SeedRevived has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
    }

    struct SeedAbandoned has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
        sapling_id: 0x2::object::ID,
    }

    struct CratePurchased has copy, drop {
        crate_id: 0x2::object::ID,
        buyer: address,
        tier: u8,
    }

    struct CrateOpened has copy, drop {
        crate_id: 0x2::object::ID,
        opener: address,
        tool_kind: 0x1::string::String,
        rarity: u8,
    }

    struct RewardClaimed has copy, drop {
        owner: address,
        amount_mist: u64,
    }

    struct ReferralPaid has copy, drop {
        referrer: address,
        referee: address,
        amount_mist: u64,
    }

    struct SaplingMinted has copy, drop {
        sapling_id: 0x2::object::ID,
        owner: address,
    }

    struct SeasonStarted has copy, drop {
        season_id: u64,
        start_ms: u64,
    }

    struct SeasonReset has copy, drop {
        season_id: u64,
    }

    entry fun abandon_seed(arg0: &mut Registry, arg1: Seed, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        assert_seed_owner(&arg1, arg3);
        assert_seed_current(arg0, &arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg1.state != 2 && seed_is_dead_by_time(&arg1, assert_season_active(arg0, arg2))) {
            let v1 = &mut arg1;
            mark_seed_dead(arg0, v1, v0);
        };
        assert!(arg1.state == 2, 10);
        let v2 = 0x2::object::id<Seed>(&arg1);
        let v3 = arg1.sapling_id;
        let v4 = &mut arg1;
        remove_seed_growth_points(arg0, v4, v0);
        remove_seed_from_owner(arg0, v0, v2);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.planted_saplings, v3) && *0x2::table::borrow<0x2::object::ID, u64>(&arg0.planted_saplings, v3) == arg0.current_season_id) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.planted_saplings, v3);
        };
        let v5 = if (arg0.total_seeds > 0) {
            arg0.total_seeds - 1
        } else {
            0
        };
        arg0.total_seeds = v5;
        let v6 = SeedAbandoned{
            seed_id    : v2,
            owner      : v0,
            sapling_id : v3,
        };
        0x2::event::emit<SeedAbandoned>(v6);
        let Seed {
            id                       : v7,
            sapling_id               : _,
            season_id                : _,
            owner                    : _,
            planted_at_ms            : _,
            last_watered_ms          : _,
            watering_streak          : _,
            growth_points            : _,
            state                    : _,
            fertilizer_charges       : _,
            miracle_grow_applied     : _,
            revival_charges          : _,
            bottomless_can_expiry_ms : _,
            permanent_gp_bonus       : _,
        } = arg1;
        0x2::object::delete(v7);
    }

    fun add_growth_points(arg0: &mut Registry, arg1: &mut Seed, arg2: address, arg3: u64) {
        arg1.growth_points = arg1.growth_points + arg3;
        if (0x2::table::contains<address, u64>(&arg0.player_growth, arg2)) {
            if (*0x2::table::borrow<address, u64>(&arg0.player_growth_season, arg2) == arg0.current_season_id) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.player_growth, arg2) = *0x2::table::borrow<address, u64>(&arg0.player_growth, arg2) + arg3;
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.player_growth, arg2) = arg3;
                *0x2::table::borrow_mut<address, u64>(&mut arg0.player_growth_season, arg2) = arg0.current_season_id;
            };
        } else {
            0x2::table::add<address, u64>(&mut arg0.player_growth, arg2, arg3);
            0x2::table::add<address, u64>(&mut arg0.player_growth_season, arg2, arg0.current_season_id);
        };
        arg0.total_growth_points = arg0.total_growth_points + arg3;
    }

    entry fun apply_tool(arg0: &mut Registry, arg1: &mut Seed, arg2: Tool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        assert_seed_owner(arg1, arg4);
        assert_seed_current(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = assert_season_active(arg0, arg3);
        assert!(arg1.state != 2, 2);
        assert!(!seed_is_dead_by_time(arg1, v1), 2);
        assert!(arg2.charges > 0, 19);
        let v2 = *0x1::string::as_bytes(&arg2.kind);
        if (v2 == b"fertilizer") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 3;
        } else if (v2 == b"watering_boost") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 1;
        } else if (v2 == b"compost") {
            arg1.watering_streak = arg1.watering_streak + 1;
        } else if (v2 == b"growth_tonic") {
            add_growth_points(arg0, arg1, v0, 20);
        } else if (v2 == b"miracle_grow") {
            arg1.miracle_grow_applied = true;
        } else if (v2 == b"mulch") {
            arg1.bottomless_can_expiry_ms = v1 + 3 * 86400000;
        } else if (v2 == b"rain_barrel") {
            arg1.last_watered_ms = v1;
        } else if (v2 == b"super_soil") {
            arg1.watering_streak = arg1.watering_streak + 3;
        } else if (v2 == b"sunstone") {
            add_growth_points(arg0, arg1, v0, 30);
        } else if (v2 == b"revival_kit") {
            arg1.revival_charges = arg1.revival_charges + 1;
        } else if (v2 == b"double_dose") {
            arg1.miracle_grow_applied = true;
            arg1.fertilizer_charges = arg1.fertilizer_charges + 2;
        } else if (v2 == b"drought_shield") {
            arg1.bottomless_can_expiry_ms = v1 + 7 * 86400000;
        } else if (v2 == b"ancient_bark") {
            add_growth_points(arg0, arg1, v0, 50);
        } else if (v2 == b"moon_water") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 5;
        } else if (v2 == b"earth_core") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 5;
        } else if (v2 == b"bottomless_can") {
            arg1.bottomless_can_expiry_ms = v1 + 8640000000;
        } else if (v2 == b"philosophers_soil") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 10;
        } else if (v2 == b"timeless_seed") {
            arg1.watering_streak = arg1.watering_streak + 5;
            arg1.last_watered_ms = v1;
        } else if (v2 == b"crystal_water") {
            arg1.miracle_grow_applied = true;
            arg1.fertilizer_charges = arg1.fertilizer_charges + 9;
        } else {
            assert!(v2 == b"forest_heart", 20);
            arg1.permanent_gp_bonus = arg1.permanent_gp_bonus + 5;
        };
        arg2.charges = arg2.charges - 1;
        return_or_delete_tool(arg2, v0);
    }

    fun assert_admin(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    fun assert_season_active(arg0: &Registry, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.season_start_ms > 0, 13);
        assert!(v0 - arg0.season_start_ms < 8640000000, 6);
        v0
    }

    fun assert_seed_current(arg0: &Registry, arg1: &Seed) {
        assert!(arg1.season_id == arg0.current_season_id, 15);
    }

    fun assert_seed_owner(arg0: &Seed, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
    }

    entry fun buy_crate(arg0: &mut Registry, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        assert!(arg1 <= 4, 8);
        let v0 = if (arg1 == 0) {
            10000000
        } else if (arg1 == 1) {
            10000000
        } else if (arg1 == 2) {
            10000000
        } else if (arg1 == 3) {
            10000000
        } else {
            10000000
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3)));
        let v1 = 0x2::tx_context::sender(arg3);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v2 = Crate{
            id   : 0x2::object::new(arg3),
            tier : arg1,
        };
        let v3 = CratePurchased{
            crate_id : 0x2::object::id<Crate>(&v2),
            buyer    : v1,
            tier     : arg1,
        };
        0x2::event::emit<CratePurchased>(v3);
        0x2::transfer::transfer<Crate>(v2, v1);
    }

    entry fun claim_reward(arg0: &mut Registry, arg1: &mut Seed, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        let v0 = 0x2::tx_context::sender(arg3);
        assert_seed_owner(arg1, arg3);
        assert_seed_current(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.season_start_ms > 0, 13);
        assert!(v1 - arg0.season_start_ms >= 8640000000, 6);
        if (arg1.state == 2) {
            remove_seed_growth_points(arg0, arg1, v0);
            return
        };
        let v2 = (v1 - arg1.last_watered_ms) / 86400000;
        if (v2 >= 10 && arg1.bottomless_can_expiry_ms < v1) {
            mark_seed_dead(arg0, arg1, v0);
            return
        };
        let v3 = if (v2 >= 7) {
            1
        } else {
            0
        };
        arg1.state = v3;
        let v4 = arg1.growth_points;
        assert!(v4 > 0, 7);
        let v5 = arg0.total_growth_points;
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool);
        if (v6 == 0 || v5 == 0) {
            remove_seed_growth_points(arg0, arg1, v0);
            return
        };
        let v7 = v4 * v6 / v5;
        remove_seed_growth_points(arg0, arg1, v0);
        let v8 = RewardClaimed{
            owner       : v0,
            amount_mist : v7,
        };
        0x2::event::emit<RewardClaimed>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_pool, v7), arg3), v0);
    }

    entry fun deposit_to_pool(arg0: &AdminCap, arg1: &mut Registry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Registry{
            id                   : 0x2::object::new(arg0),
            admin                : v0,
            current_season_id    : 0,
            season_start_ms      : 0,
            reward_pool          : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_seeds          : 0,
            total_growth_points  : 0,
            paused               : false,
            seeds_by_owner       : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            referrers            : 0x2::table::new<address, address>(arg0),
            referral_earnings    : 0x2::table::new<address, u64>(arg0),
            player_growth        : 0x2::table::new<address, u64>(arg0),
            player_growth_season : 0x2::table::new<address, u64>(arg0),
            planted_saplings     : 0x2::table::new<0x2::object::ID, u64>(arg0),
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    fun mark_seed_dead(arg0: &mut Registry, arg1: &mut Seed, arg2: address) {
        arg1.state = 2;
        arg1.watering_streak = 0;
        remove_seed_growth_points(arg0, arg1, arg2);
        let v0 = SeedDied{
            seed_id : 0x2::object::id<Seed>(arg1),
            owner   : arg2,
        };
        0x2::event::emit<SeedDied>(v0);
    }

    fun mint_crate_tool(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CrateOpened{
            crate_id  : arg0,
            opener    : arg1,
            tool_kind : 0x1::string::utf8(arg2),
            rarity    : arg4,
        };
        0x2::event::emit<CrateOpened>(v0);
        let v1 = Tool{
            id      : 0x2::object::new(arg5),
            kind    : 0x1::string::utf8(arg2),
            charges : arg3,
            rarity  : arg4,
        };
        0x2::transfer::transfer<Tool>(v1, arg1);
    }

    entry fun mint_sapling(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Sapling{
            id                  : 0x2::object::new(arg1),
            name                : 0x1::string::utf8(arg0),
            cycle_count         : 0,
            total_sui_harvested : 0,
        };
        let v2 = SaplingMinted{
            sapling_id : 0x2::object::id<Sapling>(&v1),
            owner      : v0,
        };
        0x2::event::emit<SaplingMinted>(v2);
        0x2::transfer::transfer<Sapling>(v1, v0);
    }

    entry fun open_crate(arg0: &Registry, arg1: Crate, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<Crate>(&arg1);
        let Crate {
            id   : v2,
            tier : v3,
        } = arg1;
        0x2::object::delete(v2);
        let v4 = 0x2::random::new_generator(arg2, arg3);
        if (v3 == 0) {
            let v5 = &mut v4;
            mint_crate_tool(v1, v0, roll_common(v5), 2, 0, arg3);
        } else if (v3 == 1) {
            let v6 = &mut v4;
            let v7 = &mut v4;
            mint_crate_tool(v1, v0, roll_common(v6), 2, 0, arg3);
            mint_crate_tool(v1, v0, roll_common(v7), 2, 0, arg3);
            if (0x2::random::generate_u64_in_range(&mut v4, 0, 9999) == 0) {
                let v8 = &mut v4;
                mint_crate_tool(v1, v0, roll_legendary(v8), 1, 3, arg3);
            };
        } else if (v3 == 2) {
            let v9 = &mut v4;
            let v10 = &mut v4;
            let v11 = &mut v4;
            mint_crate_tool(v1, v0, roll_uncommon(v9), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_common(v10), 2, 0, arg3);
            mint_crate_tool(v1, v0, roll_common(v11), 2, 0, arg3);
            if (0x2::random::generate_u8_in_range(&mut v4, 0, 99) < 5) {
                let v12 = &mut v4;
                mint_crate_tool(v1, v0, roll_legendary(v12), 1, 3, arg3);
            };
        } else if (v3 == 3) {
            let v13 = &mut v4;
            let v14 = &mut v4;
            let v15 = &mut v4;
            let v16 = &mut v4;
            let v17 = &mut v4;
            mint_crate_tool(v1, v0, roll_rare(v13), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_rare(v14), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v15), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v16), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_common(v17), 2, 0, arg3);
            if (0x2::random::generate_u8_in_range(&mut v4, 0, 1) == 0) {
                let v18 = &mut v4;
                mint_crate_tool(v1, v0, roll_legendary(v18), 1, 3, arg3);
            };
        } else {
            let v19 = &mut v4;
            let v20 = &mut v4;
            let v21 = &mut v4;
            let v22 = &mut v4;
            let v23 = &mut v4;
            let v24 = &mut v4;
            let v25 = &mut v4;
            let v26 = &mut v4;
            let v27 = &mut v4;
            mint_crate_tool(v1, v0, roll_legendary(v19), 1, 3, arg3);
            mint_crate_tool(v1, v0, roll_rare(v20), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_rare(v21), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_rare(v22), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v23), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v24), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v25), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_common(v26), 2, 0, arg3);
            mint_crate_tool(v1, v0, roll_common(v27), 2, 0, arg3);
            if (0x2::random::generate_u8_in_range(&mut v4, 0, 9) < 3) {
                let v28 = &mut v4;
                mint_crate_tool(v1, v0, roll_legendary(v28), 1, 3, arg3);
            };
        };
    }

    entry fun plant_seed(arg0: &mut Registry, arg1: Sapling, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = assert_season_active(arg0, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 10000000, 4);
        let v2 = 0x2::object::id<Sapling>(&arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.planted_saplings, v2)) {
            assert!(*0x2::table::borrow<0x2::object::ID, u64>(&arg0.planted_saplings, v2) != arg0.current_season_id, 14);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.planted_saplings, v2) = arg0.current_season_id;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.planted_saplings, v2, arg0.current_season_id);
        };
        arg1.cycle_count = arg1.cycle_count + 1;
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, 10000000, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        if (0x1::option::is_some<address>(&arg3)) {
            let v4 = *0x1::option::borrow<address>(&arg3);
            if (v4 != v0 && !0x2::table::contains<address, address>(&arg0.referrers, v0)) {
                0x2::table::add<address, address>(&mut arg0.referrers, v0, v4);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 1000000, arg5), v4);
                if (0x2::table::contains<address, u64>(&arg0.referral_earnings, v4)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.referral_earnings, v4) = *0x2::table::borrow<address, u64>(&arg0.referral_earnings, v4) + 1000000;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.referral_earnings, v4, 1000000);
                };
                let v5 = ReferralPaid{
                    referrer    : v4,
                    referee     : v0,
                    amount_mist : 1000000,
                };
                0x2::event::emit<ReferralPaid>(v5);
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 0x2::coin::value<0x2::sui::SUI>(&v3) * 70 / 100, arg5)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        let v6 = Seed{
            id                       : 0x2::object::new(arg5),
            sapling_id               : v2,
            season_id                : arg0.current_season_id,
            owner                    : v0,
            planted_at_ms            : v1,
            last_watered_ms          : v1,
            watering_streak          : 1,
            growth_points            : 0,
            state                    : 0,
            fertilizer_charges       : 0,
            miracle_grow_applied     : false,
            revival_charges          : 0,
            bottomless_can_expiry_ms : 0,
            permanent_gp_bonus       : 0,
        };
        let v7 = 0x2::object::id<Seed>(&v6);
        arg0.total_seeds = arg0.total_seeds + 1;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seeds_by_owner, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, v0), v7);
        let v8 = &mut v6;
        add_growth_points(arg0, v8, v0, 10);
        let v9 = SeedPlanted{
            seed_id    : v7,
            owner      : v0,
            sapling_id : v2,
        };
        0x2::event::emit<SeedPlanted>(v9);
        0x2::transfer::transfer<Sapling>(arg1, v0);
        0x2::transfer::transfer<Seed>(v6, v0);
    }

    entry fun plant_seed_with_nftree<T0: key>(arg0: &mut Registry, arg1: &T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = assert_season_active(arg0, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 10000000, 4);
        let v2 = 0x2::object::id<T0>(arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.planted_saplings, v2)) {
            assert!(*0x2::table::borrow<0x2::object::ID, u64>(&arg0.planted_saplings, v2) != arg0.current_season_id, 14);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.planted_saplings, v2) = arg0.current_season_id;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.planted_saplings, v2, arg0.current_season_id);
        };
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, 10000000, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        if (0x1::option::is_some<address>(&arg3)) {
            let v4 = *0x1::option::borrow<address>(&arg3);
            if (v4 != v0 && !0x2::table::contains<address, address>(&arg0.referrers, v0)) {
                0x2::table::add<address, address>(&mut arg0.referrers, v0, v4);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 1000000, arg5), v4);
                if (0x2::table::contains<address, u64>(&arg0.referral_earnings, v4)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.referral_earnings, v4) = *0x2::table::borrow<address, u64>(&arg0.referral_earnings, v4) + 1000000;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.referral_earnings, v4, 1000000);
                };
                let v5 = ReferralPaid{
                    referrer    : v4,
                    referee     : v0,
                    amount_mist : 1000000,
                };
                0x2::event::emit<ReferralPaid>(v5);
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 0x2::coin::value<0x2::sui::SUI>(&v3) * 70 / 100, arg5)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        let v6 = Seed{
            id                       : 0x2::object::new(arg5),
            sapling_id               : v2,
            season_id                : arg0.current_season_id,
            owner                    : v0,
            planted_at_ms            : v1,
            last_watered_ms          : v1,
            watering_streak          : 1,
            growth_points            : 0,
            state                    : 0,
            fertilizer_charges       : 0,
            miracle_grow_applied     : false,
            revival_charges          : 0,
            bottomless_can_expiry_ms : 0,
            permanent_gp_bonus       : 0,
        };
        let v7 = 0x2::object::id<Seed>(&v6);
        arg0.total_seeds = arg0.total_seeds + 1;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seeds_by_owner, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, v0), v7);
        let v8 = &mut v6;
        add_growth_points(arg0, v8, v0, 10);
        let v9 = SeedPlanted{
            seed_id    : v7,
            owner      : v0,
            sapling_id : v2,
        };
        0x2::event::emit<SeedPlanted>(v9);
        0x2::transfer::transfer<Seed>(v6, v0);
    }

    public fun player_growth_points(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.player_growth, arg1) && *0x2::table::borrow<address, u64>(&arg0.player_growth_season, arg1) == arg0.current_season_id) {
            *0x2::table::borrow<address, u64>(&arg0.player_growth, arg1)
        } else {
            0
        }
    }

    public fun player_referral_earnings(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.referral_earnings, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.referral_earnings, arg1)
        } else {
            0
        }
    }

    public fun registry_claim_deadline_ms(arg0: &Registry) : u64 {
        if (arg0.season_start_ms == 0) {
            0
        } else {
            arg0.season_start_ms + 8640000000 + 604800000
        }
    }

    public fun registry_is_paused(arg0: &Registry) : bool {
        arg0.paused
    }

    public fun registry_pool_size(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool)
    }

    public fun registry_season_end_ms(arg0: &Registry) : u64 {
        if (arg0.season_start_ms == 0) {
            0
        } else {
            arg0.season_start_ms + 8640000000
        }
    }

    public fun registry_total_gp(arg0: &Registry) : u64 {
        arg0.total_growth_points
    }

    public fun registry_total_seeds(arg0: &Registry) : u64 {
        arg0.total_seeds
    }

    fun remove_seed_from_owner(arg0: &mut Registry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seeds_by_owner, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                0x1::vector::remove<0x2::object::ID>(v0, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    fun remove_seed_growth_points(arg0: &mut Registry, arg1: &mut Seed, arg2: address) {
        let v0 = arg1.growth_points;
        if (v0 == 0) {
            return
        };
        if (0x2::table::contains<address, u64>(&arg0.player_growth, arg2) && *0x2::table::borrow<address, u64>(&arg0.player_growth_season, arg2) == arg0.current_season_id) {
            let v1 = *0x2::table::borrow<address, u64>(&arg0.player_growth, arg2);
            let v2 = if (v1 > v0) {
                v1 - v0
            } else {
                0
            };
            *0x2::table::borrow_mut<address, u64>(&mut arg0.player_growth, arg2) = v2;
        };
        let v3 = if (arg0.total_growth_points > v0) {
            arg0.total_growth_points - v0
        } else {
            0
        };
        arg0.total_growth_points = v3;
        arg1.growth_points = 0;
    }

    entry fun reset_season(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(arg1.season_start_ms > 0, 13);
        assert!(0x2::clock::timestamp_ms(arg2) - arg1.season_start_ms >= 8640000000 + 604800000, 21);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.reward_pool, v0));
        };
        arg1.total_growth_points = 0;
        arg1.season_start_ms = 0;
        arg1.total_seeds = 0;
        let v1 = SeasonReset{season_id: arg1.current_season_id};
        0x2::event::emit<SeasonReset>(v1);
    }

    fun return_or_delete_tool(arg0: Tool, arg1: address) {
        if (arg0.charges > 0) {
            0x2::transfer::public_transfer<Tool>(arg0, arg1);
        } else {
            let Tool {
                id      : v0,
                kind    : _,
                charges : _,
                rarity  : _,
            } = arg0;
            0x2::object::delete(v0);
        };
    }

    entry fun revive_seed(arg0: &Registry, arg1: &mut Seed, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        assert_seed_owner(arg1, arg3);
        assert_seed_current(arg0, arg1);
        assert!(arg1.state == 2, 10);
        assert!(arg1.revival_charges > 0, 11);
        arg1.revival_charges = arg1.revival_charges - 1;
        arg1.state = 0;
        arg1.last_watered_ms = assert_season_active(arg0, arg2);
        arg1.watering_streak = 1;
        let v0 = SeedRevived{
            seed_id : 0x2::object::id<Seed>(arg1),
            owner   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SeedRevived>(v0);
    }

    entry fun revive_seed_with_tool(arg0: &mut Registry, arg1: &mut Seed, arg2: Tool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        assert_seed_owner(arg1, arg4);
        assert_seed_current(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2.charges > 0, 19);
        assert!(*0x1::string::as_bytes(&arg2.kind) == b"revival_kit", 18);
        let v1 = assert_season_active(arg0, arg3);
        if (arg1.state != 2 && seed_is_dead_by_time(arg1, v1)) {
            mark_seed_dead(arg0, arg1, v0);
        };
        assert!(arg1.state == 2, 10);
        arg1.state = 0;
        arg1.last_watered_ms = v1;
        arg1.watering_streak = 1;
        let v2 = SeedRevived{
            seed_id : 0x2::object::id<Seed>(arg1),
            owner   : v0,
        };
        0x2::event::emit<SeedRevived>(v2);
        arg2.charges = arg2.charges - 1;
        return_or_delete_tool(arg2, v0);
    }

    fun roll_common(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 3);
        if (v0 == 0) {
            b"fertilizer"
        } else if (v0 == 1) {
            b"watering_boost"
        } else if (v0 == 2) {
            b"compost"
        } else {
            b"growth_tonic"
        }
    }

    fun roll_legendary(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 4);
        if (v0 == 0) {
            b"bottomless_can"
        } else if (v0 == 1) {
            b"philosophers_soil"
        } else if (v0 == 2) {
            b"timeless_seed"
        } else if (v0 == 3) {
            b"crystal_water"
        } else {
            b"forest_heart"
        }
    }

    fun roll_rare(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 5);
        if (v0 == 0) {
            b"revival_kit"
        } else if (v0 == 1) {
            b"double_dose"
        } else if (v0 == 2) {
            b"drought_shield"
        } else if (v0 == 3) {
            b"ancient_bark"
        } else if (v0 == 4) {
            b"moon_water"
        } else {
            b"earth_core"
        }
    }

    fun roll_uncommon(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 4);
        if (v0 == 0) {
            b"miracle_grow"
        } else if (v0 == 1) {
            b"mulch"
        } else if (v0 == 2) {
            b"rain_barrel"
        } else if (v0 == 3) {
            b"super_soil"
        } else {
            b"sunstone"
        }
    }

    public fun sapling_is_planted(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u64>(&arg0.planted_saplings, arg1) && *0x2::table::borrow<0x2::object::ID, u64>(&arg0.planted_saplings, arg1) == arg0.current_season_id
    }

    public fun seed_bottomless_expiry(arg0: &Seed) : u64 {
        arg0.bottomless_can_expiry_ms
    }

    public fun seed_fertilizer_charges(arg0: &Seed) : u8 {
        arg0.fertilizer_charges
    }

    public fun seed_growth_points(arg0: &Seed) : u64 {
        arg0.growth_points
    }

    fun seed_is_dead_by_time(arg0: &Seed, arg1: u64) : bool {
        (arg1 - arg0.last_watered_ms) / 86400000 >= 10 && arg0.bottomless_can_expiry_ms < arg1
    }

    public fun seed_revival_charges(arg0: &Seed) : u8 {
        arg0.revival_charges
    }

    public fun seed_state_live(arg0: &Seed, arg1: &0x2::clock::Clock) : u8 {
        if (arg0.state == 2) {
            return 2
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = (v0 - arg0.last_watered_ms) / 86400000;
        if (arg0.bottomless_can_expiry_ms >= v0) {
            0
        } else if (v1 >= 10) {
            2
        } else if (v1 >= 7) {
            1
        } else {
            0
        }
    }

    public fun seed_streak(arg0: &Seed) : u64 {
        arg0.watering_streak
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut Registry, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        arg1.paused = arg2;
    }

    entry fun start_season(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(arg1.season_start_ms == 0, 17);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg1.current_season_id = arg1.current_season_id + 1;
        arg1.season_start_ms = v0;
        let v1 = SeasonStarted{
            season_id : arg1.current_season_id,
            start_ms  : v0,
        };
        0x2::event::emit<SeasonStarted>(v1);
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut Registry, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg2, arg3);
        arg2.admin = arg1;
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    entry fun water_seed(arg0: &mut Registry, arg1: &mut Seed, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 12);
        assert_seed_owner(arg1, arg3);
        assert_seed_current(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = assert_season_active(arg0, arg2);
        assert!(arg1.state != 2, 2);
        let v2 = v1 - arg1.last_watered_ms;
        let v3 = v2 / 86400000;
        if (v3 >= 10 && arg1.bottomless_can_expiry_ms < v1) {
            mark_seed_dead(arg0, arg1, v0);
            return
        };
        assert!(v2 >= 86400000 - 86400000 / 10 || arg1.bottomless_can_expiry_ms >= v1, 5);
        let v4 = if (v3 >= 7) {
            1
        } else {
            0
        };
        arg1.state = v4;
        if (v3 >= 2) {
            arg1.watering_streak = 1;
        } else {
            arg1.watering_streak = arg1.watering_streak + 1;
        };
        let v5 = if (arg1.watering_streak > 25) {
            50
        } else {
            arg1.watering_streak * 2
        };
        let v6 = 10 + arg1.permanent_gp_bonus + v5;
        let v7 = v6;
        if (arg1.miracle_grow_applied) {
            v7 = v6 * 2;
            arg1.miracle_grow_applied = false;
        };
        if (arg1.fertilizer_charges > 0) {
            let v8 = v7 / 2;
            v7 = v7 + v8;
            arg1.fertilizer_charges = arg1.fertilizer_charges - 1;
        };
        add_growth_points(arg0, arg1, v0, v7);
        arg1.last_watered_ms = v1;
        let v9 = SeedWatered{
            seed_id       : 0x2::object::id<Seed>(arg1),
            owner         : v0,
            streak        : arg1.watering_streak,
            growth_points : arg1.growth_points,
        };
        0x2::event::emit<SeedWatered>(v9);
    }

    entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

