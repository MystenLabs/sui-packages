module 0xf1d7fd3a25da3bed67fda7a7469acaa4e814bf673246587a50c89e87cb3a815c::lootbox {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RollEntry has copy, drop, store {
        threshold: u64,
        value: u64,
    }

    struct TierConfig has copy, drop, store {
        bub_cost: u64,
        bublz_cost: u64,
        sui_cost: u64,
        jackpot_chance_bps: u64,
        jackpot_seed_bub: u64,
        jackpot_seed_bublz: u64,
        jackpot_seed_sui: u64,
        streak_interval: u64,
        streak_multiplier: u64,
        cosmetic_rate_bps: u64,
        bubbler_rate_bps: u64,
        cosmetic_streak_bps: u64,
        bubbler_streak_bps: u64,
        enabled: bool,
    }

    struct Jackpot has store {
        bub: u64,
        bublz: u64,
        sui: u64,
    }

    struct PlayerState has store {
        streak_counts: vector<u64>,
        total_opened: u64,
    }

    struct LootboxPool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        bub_pool: 0x2::balance::Balance<T0>,
        bublz_pool: 0x2::balance::Balance<T1>,
        bsgp_pool: 0x2::balance::Balance<T2>,
        sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        jackpots: vector<Jackpot>,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        burn_bps: u64,
        pool_bps: u64,
        jackpot_bps: u64,
        sui_treasury_bps: u64,
        sui_pool_bps: u64,
        sui_jackpot_bps: u64,
        tiers: vector<TierConfig>,
        roll_tables: vector<vector<vector<RollEntry>>>,
        bubbler_bag: 0x2::object_bag::ObjectBag,
        cosmetic_bag: 0x2::object_bag::ObjectBag,
        bubbler_keys: vector<vector<u64>>,
        cosmetic_keys: vector<vector<u64>>,
        next_nft_key: u64,
        players: 0x2::table::Table<address, PlayerState>,
        total_opened: u64,
        total_bub_burned: u64,
        total_bublz_burned: u64,
        total_jackpots_hit: u64,
    }

    struct BoxOpened has copy, drop {
        player: address,
        tier: u64,
        bub_won: u64,
        bublz_won: u64,
        bsgp_won: u64,
        sui_won: u64,
        cosmetic_rarity: u64,
        bubbler_tier: u64,
        is_streak: bool,
        jackpot_hit: bool,
        jackpot_bub: u64,
        jackpot_bublz: u64,
        jackpot_sui: u64,
    }

    struct JackpotHit has copy, drop {
        player: address,
        tier: u64,
        bub: u64,
        bublz: u64,
        sui: u64,
    }

    public entry fun create_pool<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Jackpot>();
        let v1 = 0x1::vector::empty<TierConfig>();
        let v2 = 0x1::vector::empty<vector<vector<RollEntry>>>();
        let v3 = 0;
        while (v3 < 3) {
            let v4 = Jackpot{
                bub   : 0,
                bublz : 0,
                sui   : 0,
            };
            0x1::vector::push_back<Jackpot>(&mut v0, v4);
            let v5 = TierConfig{
                bub_cost            : 0,
                bublz_cost          : 0,
                sui_cost            : 0,
                jackpot_chance_bps  : 50,
                jackpot_seed_bub    : 0,
                jackpot_seed_bublz  : 0,
                jackpot_seed_sui    : 0,
                streak_interval     : 10,
                streak_multiplier   : 2,
                cosmetic_rate_bps   : 0,
                bubbler_rate_bps    : 0,
                cosmetic_streak_bps : 0,
                bubbler_streak_bps  : 0,
                enabled             : false,
            };
            0x1::vector::push_back<TierConfig>(&mut v1, v5);
            let v6 = 0x1::vector::empty<vector<RollEntry>>();
            let v7 = 0;
            while (v7 < 6) {
                0x1::vector::push_back<vector<RollEntry>>(&mut v6, 0x1::vector::empty<RollEntry>());
                v7 = v7 + 1;
            };
            0x1::vector::push_back<vector<vector<RollEntry>>>(&mut v2, v6);
            v3 = v3 + 1;
        };
        let v8 = 0x1::vector::empty<vector<u64>>();
        let v9 = 0;
        while (v9 < 13) {
            0x1::vector::push_back<vector<u64>>(&mut v8, 0x1::vector::empty<u64>());
            v9 = v9 + 1;
        };
        let v10 = 0x1::vector::empty<vector<u64>>();
        let v11 = 0;
        while (v11 < 4) {
            0x1::vector::push_back<vector<u64>>(&mut v10, 0x1::vector::empty<u64>());
            v11 = v11 + 1;
        };
        let v12 = LootboxPool<T0, T1, T2>{
            id                 : 0x2::object::new(arg1),
            admin              : 0x2::tx_context::sender(arg1),
            paused             : false,
            bub_pool           : 0x2::balance::zero<T0>(),
            bublz_pool         : 0x2::balance::zero<T1>(),
            bsgp_pool          : 0x2::balance::zero<T2>(),
            sui_pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            jackpots           : v0,
            sui_treasury       : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_bps           : 2500,
            pool_bps           : 6500,
            jackpot_bps        : 1000,
            sui_treasury_bps   : 2500,
            sui_pool_bps       : 6500,
            sui_jackpot_bps    : 1000,
            tiers              : v1,
            roll_tables        : v2,
            bubbler_bag        : 0x2::object_bag::new(arg1),
            cosmetic_bag       : 0x2::object_bag::new(arg1),
            bubbler_keys       : v8,
            cosmetic_keys      : v10,
            next_nft_key       : 0,
            players            : 0x2::table::new<address, PlayerState>(arg1),
            total_opened       : 0,
            total_bub_burned   : 0,
            total_bublz_burned : 0,
            total_jackpots_hit : 0,
        };
        0x2::transfer::share_object<LootboxPool<T0, T1, T2>>(v12);
    }

    public entry fun deposit_bsgp<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<T2>(&mut arg0.bsgp_pool, 0x2::coin::into_balance<T2>(arg1));
    }

    public entry fun deposit_bub<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<T0>(&mut arg0.bub_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_bubbler<T0, T1, T2, T3: store + key>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: T3, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 < 13, 3);
        let v0 = arg0.next_nft_key;
        arg0.next_nft_key = v0 + 1;
        0x2::object_bag::add<u64, T3>(&mut arg0.bubbler_bag, v0, arg1);
        0x1::vector::push_back<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.bubbler_keys, arg2), v0);
    }

    public entry fun deposit_bublz<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<T1>(&mut arg0.bublz_pool, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun deposit_cosmetic<T0, T1, T2, T3: store + key>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: T3, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 < 4, 3);
        let v0 = arg0.next_nft_key;
        arg0.next_nft_key = v0 + 1;
        0x2::object_bag::add<u64, T3>(&mut arg0.cosmetic_bag, v0, arg1);
        0x1::vector::push_back<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.cosmetic_keys, arg2), v0);
    }

    public entry fun deposit_sui_pool<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun emergency_withdraw<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::balance::value<T0>(&arg0.bub_pool);
        let v2 = 0x2::balance::value<T1>(&arg0.bublz_pool);
        let v3 = 0x2::balance::value<T2>(&arg0.bsgp_pool);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bub_pool, v1), arg1), v0);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bublz_pool, v2), arg1), v0);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.bsgp_pool, v3), arg1), v0);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_pool, v4), arg1), v0);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v5), arg1), v0);
        };
        arg0.paused = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public entry fun open_box<T0, T1, T2, T3: store + key, T4: store + key>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg1 < 3, 3);
        let v0 = *0x1::vector::borrow<TierConfig>(&arg0.tiers, arg1);
        assert!(v0.enabled, 7);
        assert!(0x2::coin::value<T0>(&arg2) >= v0.bub_cost, 4);
        assert!(0x2::coin::value<T1>(&arg3) >= v0.bublz_cost, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0.sui_cost, 6);
        let v1 = if (v0.bub_cost > 0) {
            true
        } else if (v0.bublz_cost > 0) {
            true
        } else {
            v0.sui_cost > 0
        };
        assert!(v1, 10);
        let v2 = if (0x2::balance::value<T0>(&arg0.bub_pool) > 0) {
            true
        } else if (0x2::balance::value<T1>(&arg0.bublz_pool) > 0) {
            true
        } else if (0x2::balance::value<T2>(&arg0.bsgp_pool) > 0) {
            true
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) > 0
        };
        assert!(v2, 8);
        let v3 = 0x2::tx_context::sender(arg6);
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v3);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        if (0x2::coin::value<T1>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, v3);
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        let v4 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v0.bub_cost, arg6));
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = v5 * arg0.burn_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v6), arg6), @0x0);
        arg0.total_bub_burned = arg0.total_bub_burned + v6;
        0x1::vector::borrow_mut<Jackpot>(&mut arg0.jackpots, arg1).bub = 0x1::vector::borrow<Jackpot>(&arg0.jackpots, arg1).bub + v5 * arg0.jackpot_bps / 10000;
        0x2::balance::join<T0>(&mut arg0.bub_pool, v4);
        let v7 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v0.bublz_cost, arg6));
        let v8 = 0x2::balance::value<T1>(&v7);
        let v9 = v8 * arg0.burn_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v7, v9), arg6), @0x0);
        arg0.total_bublz_burned = arg0.total_bublz_burned + v9;
        0x1::vector::borrow_mut<Jackpot>(&mut arg0.jackpots, arg1).bublz = 0x1::vector::borrow<Jackpot>(&arg0.jackpots, arg1).bublz + v8 * arg0.jackpot_bps / 10000;
        0x2::balance::join<T1>(&mut arg0.bublz_pool, v7);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0.sui_cost, arg6));
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, 0x2::balance::split<0x2::sui::SUI>(&mut v10, v11 * arg0.sui_treasury_bps / 10000));
        0x1::vector::borrow_mut<Jackpot>(&mut arg0.jackpots, arg1).sui = 0x1::vector::borrow<Jackpot>(&arg0.jackpots, arg1).sui + v11 * arg0.sui_jackpot_bps / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_pool, v10);
        if (!0x2::table::contains<address, PlayerState>(&arg0.players, v3)) {
            let v12 = PlayerState{
                streak_counts : zeros(),
                total_opened  : 0,
            };
            0x2::table::add<address, PlayerState>(&mut arg0.players, v3, v12);
        };
        let v13 = 0x2::table::borrow_mut<address, PlayerState>(&mut arg0.players, v3);
        let v14 = 0x1::vector::borrow_mut<u64>(&mut v13.streak_counts, arg1);
        *v14 = *v14 + 1;
        v13.total_opened = v13.total_opened + 1;
        arg0.total_opened = arg0.total_opened + 1;
        let v15 = v0.streak_interval > 0 && *0x1::vector::borrow<u64>(&v13.streak_counts, arg1) >= v0.streak_interval;
        if (v15) {
            *0x1::vector::borrow_mut<u64>(&mut v13.streak_counts, arg1) = 0;
        };
        let v16 = if (v15) {
            v0.streak_multiplier
        } else {
            1
        };
        let v17 = 0x2::random::new_generator(arg5, arg6);
        let v18 = 0x1::vector::borrow<vector<vector<RollEntry>>>(&arg0.roll_tables, arg1);
        let v19 = min(safe_mul(roll_lookup(0x1::vector::borrow<vector<RollEntry>>(v18, 0), 0x2::random::generate_u64_in_range(&mut v17, 0, 9999)), v16), 0x2::balance::value<T0>(&arg0.bub_pool));
        let v20 = min(safe_mul(roll_lookup(0x1::vector::borrow<vector<RollEntry>>(v18, 1), 0x2::random::generate_u64_in_range(&mut v17, 0, 9999)), v16), 0x2::balance::value<T1>(&arg0.bublz_pool));
        let v21 = min(safe_mul(roll_lookup(0x1::vector::borrow<vector<RollEntry>>(v18, 2), 0x2::random::generate_u64_in_range(&mut v17, 0, 9999)), v16), 0x2::balance::value<T2>(&arg0.bsgp_pool));
        let v22 = min(safe_mul(roll_lookup(0x1::vector::borrow<vector<RollEntry>>(v18, 3), 0x2::random::generate_u64_in_range(&mut v17, 0, 9999)), v16), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool));
        if (v19 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bub_pool, v19), arg6), v3);
        };
        if (v20 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bublz_pool, v20), arg6), v3);
        };
        if (v21 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.bsgp_pool, v21), arg6), v3);
        };
        if (v22 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_pool, v22), arg6), v3);
        };
        let v23 = if (v15) {
            v0.cosmetic_streak_bps
        } else {
            v0.cosmetic_rate_bps
        };
        let v24 = 0;
        if (0x2::random::generate_u64_in_range(&mut v17, 0, 9999) < v23) {
            let v25 = roll_lookup(0x1::vector::borrow<vector<RollEntry>>(v18, 4), 0x2::random::generate_u64_in_range(&mut v17, 0, 9999));
            if (v25 >= 1 && v25 <= 4) {
                let v26 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.cosmetic_keys, v25 - 1);
                if (0x1::vector::length<u64>(v26) > 0) {
                    0x2::transfer::public_transfer<T4>(0x2::object_bag::remove<u64, T4>(&mut arg0.cosmetic_bag, 0x1::vector::pop_back<u64>(v26)), v3);
                    v24 = v25;
                };
            };
        };
        let v27 = if (v15) {
            v0.bubbler_streak_bps
        } else {
            v0.bubbler_rate_bps
        };
        let v28 = 0;
        if (0x2::random::generate_u64_in_range(&mut v17, 0, 9999) < v27) {
            let v29 = roll_lookup(0x1::vector::borrow<vector<RollEntry>>(v18, 5), 0x2::random::generate_u64_in_range(&mut v17, 0, 9999));
            if (v29 >= 1 && v29 <= 13) {
                let v30 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.bubbler_keys, v29 - 1);
                if (0x1::vector::length<u64>(v30) > 0) {
                    0x2::transfer::public_transfer<T3>(0x2::object_bag::remove<u64, T3>(&mut arg0.bubbler_bag, 0x1::vector::pop_back<u64>(v30)), v3);
                    v28 = v29;
                };
            };
        };
        let v31 = false;
        let v32 = 0;
        let v33 = 0;
        let v34 = 0;
        if (0x2::random::generate_u64_in_range(&mut v17, 0, 9999) < v0.jackpot_chance_bps) {
            v31 = true;
            let v35 = 0x1::vector::borrow<Jackpot>(&arg0.jackpots, arg1);
            let v36 = min(v35.bub, 0x2::balance::value<T0>(&arg0.bub_pool));
            v32 = v36;
            let v37 = min(v35.bublz, 0x2::balance::value<T1>(&arg0.bublz_pool));
            v33 = v37;
            let v38 = min(v35.sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool));
            v34 = v38;
            if (v36 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bub_pool, v36), arg6), v3);
            };
            if (v37 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bublz_pool, v37), arg6), v3);
            };
            if (v38 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_pool, v38), arg6), v3);
            };
            let v39 = 0x1::vector::borrow_mut<Jackpot>(&mut arg0.jackpots, arg1);
            v39.bub = v0.jackpot_seed_bub;
            v39.bublz = v0.jackpot_seed_bublz;
            v39.sui = v0.jackpot_seed_sui;
            arg0.total_jackpots_hit = arg0.total_jackpots_hit + 1;
            let v40 = JackpotHit{
                player : v3,
                tier   : arg1,
                bub    : v36,
                bublz  : v37,
                sui    : v38,
            };
            0x2::event::emit<JackpotHit>(v40);
        };
        let v41 = BoxOpened{
            player          : v3,
            tier            : arg1,
            bub_won         : v19,
            bublz_won       : v20,
            bsgp_won        : v21,
            sui_won         : v22,
            cosmetic_rarity : v24,
            bubbler_tier    : v28,
            is_streak       : v15,
            jackpot_hit     : v31,
            jackpot_bub     : v32,
            jackpot_bublz   : v33,
            jackpot_sui     : v34,
        };
        0x2::event::emit<BoxOpened>(v41);
    }

    public entry fun pause<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        arg0.paused = true;
    }

    fun roll_lookup(arg0: &vector<RollEntry>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<RollEntry>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<RollEntry>(arg0, v1);
            if (arg1 <= v2.threshold) {
                return v2.value
            };
            v1 = v1 + 1;
        };
        0x1::vector::borrow<RollEntry>(arg0, v0 - 1).value
    }

    fun safe_mul(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        if (arg0 > 18446744073709551615 / arg1) {
            return 18446744073709551615
        };
        arg0 * arg1
    }

    public entry fun set_jackpot<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg5), 1);
        assert!(arg1 < 3, 3);
        let v0 = 0x1::vector::borrow_mut<Jackpot>(&mut arg0.jackpots, arg1);
        v0.bub = arg2;
        v0.bublz = arg3;
        v0.sui = arg4;
    }

    public entry fun set_roll_table<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg5), 1);
        assert!(arg1 < 3, 3);
        assert!(arg2 < 6, 11);
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4) && v0 > 0, 11);
        let v1 = 0x1::vector::empty<RollEntry>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = RollEntry{
                threshold : *0x1::vector::borrow<u64>(&arg3, v2),
                value     : *0x1::vector::borrow<u64>(&arg4, v2),
            };
            0x1::vector::push_back<RollEntry>(&mut v1, v3);
            v2 = v2 + 1;
        };
        *0x1::vector::borrow_mut<vector<RollEntry>>(0x1::vector::borrow_mut<vector<vector<RollEntry>>>(&mut arg0.roll_tables, arg1), arg2) = v1;
    }

    public entry fun set_splits<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg7), 1);
        assert!(arg1 + arg2 + arg3 == 10000, 10);
        assert!(arg4 + arg5 + arg6 == 10000, 10);
        arg0.burn_bps = arg1;
        arg0.pool_bps = arg2;
        arg0.jackpot_bps = arg3;
        arg0.sui_treasury_bps = arg4;
        arg0.sui_pool_bps = arg5;
        arg0.sui_jackpot_bps = arg6;
    }

    public entry fun set_tier_config<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg15), 1);
        assert!(arg1 < 3, 3);
        let v0 = 0x1::vector::borrow_mut<TierConfig>(&mut arg0.tiers, arg1);
        v0.bub_cost = arg2;
        v0.bublz_cost = arg3;
        v0.sui_cost = arg4;
        v0.jackpot_chance_bps = arg5;
        v0.jackpot_seed_bub = arg6;
        v0.jackpot_seed_bublz = arg7;
        v0.jackpot_seed_sui = arg8;
        v0.streak_interval = arg9;
        v0.streak_multiplier = arg10;
        v0.cosmetic_rate_bps = arg11;
        v0.bubbler_rate_bps = arg12;
        v0.cosmetic_streak_bps = arg13;
        v0.bubbler_streak_bps = arg14;
        v0.enabled = true;
    }

    public entry fun unpause<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        arg0.paused = false;
    }

    public entry fun withdraw_bubbler<T0, T1, T2, T3: store + key>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 < 13, 3);
        let v0 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.bubbler_keys, arg1);
        assert!(0x1::vector::length<u64>(v0) > 0, 9);
        0x2::transfer::public_transfer<T3>(0x2::object_bag::remove<u64, T3>(&mut arg0.bubbler_bag, 0x1::vector::pop_back<u64>(v0)), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_cosmetic<T0, T1, T2, T3: store + key>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 < 4, 3);
        let v0 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.cosmetic_keys, arg1);
        assert!(0x1::vector::length<u64>(v0) > 0, 9);
        0x2::transfer::public_transfer<T3>(0x2::object_bag::remove<u64, T3>(&mut arg0.cosmetic_bag, 0x1::vector::pop_back<u64>(v0)), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_treasury<T0, T1, T2>(arg0: &mut LootboxPool<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0), arg1), 0x2::tx_context::sender(arg1));
        };
    }

    fun zeros() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 3) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

