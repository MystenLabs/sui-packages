module 0xe39b9ba59dd4c523df7a3a8d0eacf0e18576a88b38138b58ccbf1f0daa8aa64d::game {
    struct FeeTableKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DefaultFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GAME has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintVault<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct GameState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        total_network_pressure: u64,
        total_players: u64,
        total_minted: u64,
        total_burned: u64,
        total_bublz_burned: u64,
        game_start: u64,
        paused: bool,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_recipient: address,
        bublz_cost: u64,
        sui_costs: vector<u64>,
        cosmetic_types: 0x2::table::Table<u64, CosmeticType>,
        next_cosmetic_id: u64,
        player_tanks: 0x2::table::Table<address, PlayerTank>,
        staked_bubblers: 0x2::table::Table<u64, StakedBubblerInfo>,
        staked_bubbler_objects: 0x2::table::Table<u64, BubbleGenerator>,
        displayed_cosmetics: 0x2::table::Table<u64, DisplayedCosmeticInfo>,
        next_bubbler_id: u64,
        next_cosmetic_instance_id: u64,
    }

    struct PlayerTank has store {
        tier: u8,
        last_upgrade_time: u64,
        staked_bubbler_ids: vector<u64>,
        displayed_cosmetic_ids: vector<u64>,
        total_pressure: u64,
        total_tank_pressure: u64,
        upgrade_levels: vector<u8>,
        last_claim_time: u64,
        total_earned: u64,
        unclaimed_rewards: u64,
        referrer: address,
        has_referrer: bool,
    }

    struct StakedBubblerInfo has drop, store {
        owner: address,
        tier: u8,
        bubble_pressure: u64,
        tank_pressure: u64,
    }

    struct DisplayedCosmeticInfo has drop, store {
        owner: address,
        cosmetic_type_id: u64,
        bubble_pressure: u64,
    }

    struct BubbleGenerator has store, key {
        id: 0x2::object::UID,
        bubbler_id: u64,
        tier: u8,
        name: 0x1::string::String,
        bubble_pressure: u64,
        tank_pressure: u64,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct BubbleCosmetic has store, key {
        id: 0x2::object::UID,
        cosmetic_instance_id: u64,
        cosmetic_type_id: u64,
        name: 0x1::string::String,
        bubble_pressure: u64,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct CosmeticType has store {
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        bub_cost: u64,
        bublz_cost: u64,
        sui_cost: u64,
        bubble_pressure: u64,
        max_supply: u64,
        minted: u64,
        per_facility: u64,
        disabled: bool,
    }

    struct TankCreated has copy, drop {
        player: address,
    }

    struct TankUpgraded has copy, drop {
        player: address,
        new_tier: u8,
    }

    struct BubblerMinted has copy, drop {
        owner: address,
        bubbler_id: u64,
        tier: u8,
        bubble_pressure: u64,
    }

    struct BubblerStaked has copy, drop {
        owner: address,
        bubbler_id: u64,
        tier: u8,
    }

    struct BubblerUnstaked has copy, drop {
        owner: address,
        bubbler_id: u64,
        tier: u8,
    }

    struct RewardsClaimed has copy, drop {
        player: address,
        amount: u64,
        burned: u64,
        referrer_reward: u64,
    }

    struct StatUpgraded has copy, drop {
        player: address,
        upgrade_type: u8,
        new_level: u8,
    }

    struct CosmeticMinted has copy, drop {
        owner: address,
        cosmetic_type_id: u64,
        name: 0x1::string::String,
    }

    struct BubblerFused has copy, drop {
        player: address,
        from_tier: u8,
        to_tier: u8,
        new_bubbler_id: u64,
    }

    struct CosmeticVault has key {
        id: 0x2::object::UID,
        cosmetics: 0x2::table::Table<u64, BubbleCosmetic>,
    }

    struct RepTableKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RepConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RepProfile has store {
        rep: u64,
        streak: u64,
        best_streak: u64,
        last_checkin_ms: u64,
        rep_added_today: u64,
        day_start_ms: u64,
        streak_fee_locked: bool,
    }

    struct RepConfig has store {
        daily_rep_cap: u64,
        checkin_rep: u64,
        checkin_cooldown_ms: u64,
        streak_window_ms: u64,
        base_fee_bps: u64,
        streak_reduction_per_day_bps: u64,
        max_streak_reduction_bps: u64,
        streak_lock_days: u64,
    }

    struct RepAdded has copy, drop {
        player: address,
        amount: u64,
        new_total: u64,
    }

    struct StreakUpdated has copy, drop {
        player: address,
        streak: u64,
        best_streak: u64,
        locked: bool,
    }

    struct PlayerCheckedIn has copy, drop {
        player: address,
        rep: u64,
        streak: u64,
    }

    fun add_rep_capped(arg0: &mut RepProfile, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 >= arg0.day_start_ms + 86400000) {
            arg0.rep_added_today = 0;
            arg0.day_start_ms = arg2;
        };
        let v0 = if (arg3 > arg0.rep_added_today) {
            arg3 - arg0.rep_added_today
        } else {
            0
        };
        let v1 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        if (v1 > 0) {
            arg0.rep = arg0.rep + v1;
            arg0.rep_added_today = arg0.rep_added_today + v1;
        };
        v1
    }

    entry fun admin_add_rep<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = RepConfigKey{dummy_field: false};
        let v1 = RepTableKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<RepTableKey, 0x2::table::Table<address, RepProfile>>(&mut arg0.id, v1);
        assert!(0x2::table::contains<address, RepProfile>(v2, arg2), 102);
        let v3 = 0x2::table::borrow_mut<address, RepProfile>(v2, arg2);
        let v4 = add_rep_capped(v3, arg3, 0x2::clock::timestamp_ms(arg4), 0x2::dynamic_field::borrow<RepConfigKey, RepConfig>(&arg0.id, v0).daily_rep_cap);
        if (v4 > 0) {
            let v5 = RepAdded{
                player    : arg2,
                amount    : v4,
                new_total : v3.rep,
            };
            0x2::event::emit<RepAdded>(v5);
        };
    }

    entry fun admin_clear_cosmetic<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, arg2), 18);
        let v0 = 0x2::table::remove<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, arg2);
        let v1 = v0.owner;
        let v2 = 0x2::clock::timestamp_ms(arg3);
        if (0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v1)) {
            let v3 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v1), v2);
            let v4 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v1);
            if (v3 > 0) {
                v4.unclaimed_rewards = v4.unclaimed_rewards + v3;
            };
            v4.last_claim_time = v2;
            let v5 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v1);
            let v6 = 0;
            let v7 = 0x1::vector::length<u64>(&v5.displayed_cosmetic_ids);
            while (v6 < v7) {
                if (*0x1::vector::borrow<u64>(&v5.displayed_cosmetic_ids, v6) == arg2) {
                    0x1::vector::swap_remove<u64>(&mut v5.displayed_cosmetic_ids, v6);
                    v6 = v7;
                };
                v6 = v6 + 1;
            };
            v5.total_pressure = v5.total_pressure - v0.bubble_pressure;
            arg0.total_network_pressure = arg0.total_network_pressure - v0.bubble_pressure;
        };
    }

    entry fun admin_init_rep_system<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = RepConfigKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<RepConfigKey>(&arg0.id, v0), 101);
        assert!(arg6 <= 10000, 7);
        assert!(arg7 <= 10000, 7);
        assert!(arg7 >= arg6, 7);
        assert!(arg2 <= 500, 7);
        assert!(arg3 <= 50, 7);
        assert!(arg10 >= 2, 7);
        assert!(arg9 <= arg6, 7);
        let v1 = RepConfigKey{dummy_field: false};
        let v2 = RepConfig{
            daily_rep_cap                : arg2,
            checkin_rep                  : arg3,
            checkin_cooldown_ms          : arg4,
            streak_window_ms             : arg5,
            base_fee_bps                 : arg6,
            streak_reduction_per_day_bps : arg8,
            max_streak_reduction_bps     : arg9,
            streak_lock_days             : arg10,
        };
        0x2::dynamic_field::add<RepConfigKey, RepConfig>(&mut arg0.id, v1, v2);
        let v3 = RepTableKey{dummy_field: false};
        0x2::dynamic_field::add<RepTableKey, 0x2::table::Table<address, RepProfile>>(&mut arg0.id, v3, 0x2::table::new<address, RepProfile>(arg11));
        let v4 = FeeTableKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FeeTableKey>(&arg0.id, v4)) {
            let v5 = FeeTableKey{dummy_field: false};
            0x2::dynamic_field::add<FeeTableKey, 0x2::table::Table<address, u64>>(&mut arg0.id, v5, 0x2::table::new<address, u64>(arg11));
        };
        let v6 = DefaultFeeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<DefaultFeeKey>(&arg0.id, v6)) {
            let v7 = DefaultFeeKey{dummy_field: false};
            0x2::dynamic_field::add<DefaultFeeKey, u64>(&mut arg0.id, v7, arg7);
        } else {
            let v8 = DefaultFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<DefaultFeeKey, u64>(&mut arg0.id, v8) = arg7;
        };
    }

    entry fun admin_mint_bubbler_to<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!((arg2 as u64) < 13, 1);
        let (v0, v1, _, v3, v4) = get_bubbler_stats(arg2);
        let v5 = arg0.next_bubbler_id;
        arg0.next_bubbler_id = v5 + 1;
        let v6 = BubbleGenerator{
            id              : 0x2::object::new(arg4),
            bubbler_id      : v5,
            tier            : arg2,
            name            : v3,
            bubble_pressure : v0,
            tank_pressure   : v1,
            image_url       : v4,
            attributes      : make_bubbler_attrs(arg2, v3),
        };
        0x2::transfer::public_transfer<BubbleGenerator>(v6, arg3);
        let v7 = BubblerMinted{
            owner           : arg3,
            bubbler_id      : v5,
            tier            : arg2,
            bubble_pressure : v0,
        };
        0x2::event::emit<BubblerMinted>(v7);
    }

    entry fun admin_mint_cosmetic_to<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, CosmeticType>(&arg0.cosmetic_types, arg2), 1);
        let v0 = 0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg2);
        let v1 = v0.name;
        let v2 = v0.bubble_pressure;
        v0.minted = v0.minted + 1;
        let v3 = arg0.next_cosmetic_instance_id;
        arg0.next_cosmetic_instance_id = v3 + 1;
        let v4 = BubbleCosmetic{
            id                   : 0x2::object::new(arg4),
            cosmetic_instance_id : v3,
            cosmetic_type_id     : arg2,
            name                 : v1,
            bubble_pressure      : v2,
            image_url            : v0.image_url,
            attributes           : make_cosmetic_attrs(v1),
        };
        0x2::transfer::public_transfer<BubbleCosmetic>(v4, arg3);
        let v5 = CosmeticMinted{
            owner            : arg3,
            cosmetic_type_id : arg2,
            name             : v1,
        };
        0x2::event::emit<CosmeticMinted>(v5);
    }

    entry fun admin_remove_player_fee<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: address) {
        let v0 = FeeTableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<FeeTableKey, 0x2::table::Table<address, u64>>(&mut arg0.id, v0);
        if (0x2::table::contains<address, u64>(v1, arg2)) {
            0x2::table::remove<address, u64>(v1, arg2);
        };
    }

    entry fun admin_set_player_fee<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: address, arg3: u64) {
        assert!(arg3 <= 10000, 7);
        let v0 = FeeTableKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<FeeTableKey, 0x2::table::Table<address, u64>>(&mut arg0.id, v0);
        if (0x2::table::contains<address, u64>(v1, arg2)) {
            *0x2::table::borrow_mut<address, u64>(v1, arg2) = arg3;
        } else {
            0x2::table::add<address, u64>(v1, arg2, arg3);
        };
    }

    entry fun admin_set_rep_config<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg6 <= 10000, 7);
        assert!(arg2 <= 500, 7);
        assert!(arg3 <= 50, 7);
        assert!(arg9 >= 2, 7);
        assert!(arg8 <= arg6, 7);
        let v0 = RepConfigKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<RepConfigKey, RepConfig>(&mut arg0.id, v0);
        v1.daily_rep_cap = arg2;
        v1.checkin_rep = arg3;
        v1.checkin_cooldown_ms = arg4;
        v1.streak_window_ms = arg5;
        v1.base_fee_bps = arg6;
        v1.streak_reduction_per_day_bps = arg7;
        v1.max_streak_reduction_bps = arg8;
        v1.streak_lock_days = arg9;
    }

    entry fun admin_set_unregistered_fee<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 7);
        let v0 = DefaultFeeKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<DefaultFeeKey, u64>(&mut arg0.id, v0) = arg2;
    }

    entry fun admin_upgrade_tank<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: address, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, arg2), 10);
        let v0 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, arg2);
        assert!(arg3 <= 8, 1);
        assert!(arg3 > v0.tier, 1);
        v0.tier = arg3;
        v0.last_upgrade_time = 0x2::clock::timestamp_ms(arg4);
        let v1 = TankUpgraded{
            player   : arg2,
            new_tier : arg3,
        };
        0x2::event::emit<TankUpgraded>(v1);
    }

    entry fun admin_vault_force_return(arg0: &mut CosmeticVault, arg1: &AdminCap, arg2: u64, arg3: address) {
        assert!(0x2::table::contains<u64, BubbleCosmetic>(&arg0.cosmetics, arg2), 18);
        0x2::transfer::public_transfer<BubbleCosmetic>(0x2::table::remove<u64, BubbleCosmetic>(&mut arg0.cosmetics, arg2), arg3);
    }

    entry fun admin_vault_return<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut CosmeticVault, arg2: &AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, arg3), 18);
        let v0 = 0x2::table::remove<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, arg3);
        let v1 = v0.owner;
        let v2 = 0x2::clock::timestamp_ms(arg4);
        if (0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v1)) {
            let v3 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v1), v2);
            let v4 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v1);
            if (v3 > 0) {
                v4.unclaimed_rewards = v4.unclaimed_rewards + v3;
            };
            v4.last_claim_time = v2;
            let v5 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v1);
            let v6 = 0;
            let v7 = 0x1::vector::length<u64>(&v5.displayed_cosmetic_ids);
            while (v6 < v7) {
                if (*0x1::vector::borrow<u64>(&v5.displayed_cosmetic_ids, v6) == arg3) {
                    0x1::vector::swap_remove<u64>(&mut v5.displayed_cosmetic_ids, v6);
                    v6 = v7;
                };
                v6 = v6 + 1;
            };
            v5.total_pressure = v5.total_pressure - v0.bubble_pressure;
            arg0.total_network_pressure = arg0.total_network_pressure - v0.bubble_pressure;
        };
        0x2::transfer::public_transfer<BubbleCosmetic>(0x2::table::remove<u64, BubbleCosmetic>(&mut arg1.cosmetics, arg3), v1);
    }

    fun apply_cooling_bonus(arg0: &PlayerTank, arg1: u64) : u64 {
        let v0 = (((arg1 as u128) * (((*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 1) as u64) * 200 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 4) as u64) * 100) as u128) / 10000) as u64);
        if (v0 >= arg1) {
            1
        } else {
            arg1 - v0
        }
    }

    fun apply_upgrade_bonus(arg0: &PlayerTank, arg1: u64) : u64 {
        (((arg1 as u128) * ((10000 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 0) as u64) * 200 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 2) as u64) * 100 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 3) as u64) * 300 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 4) as u64) * 100) as u128) / 10000) as u64)
    }

    fun burn_bub_payment<T0, T1, T2>(arg0: 0x2::balance::Balance<T0>, arg1: &mut GameState<T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::balance::value<T0>(&arg0) as u128) * (8500 as u128) / (10000 as u128)) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0, v0), arg2), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1.treasury_recipient);
        arg1.total_burned = arg1.total_burned + v0;
    }

    fun calculate_current_emission<T0, T1>(arg0: &GameState<T0, T1>, arg1: u64) : u64 {
        let v0 = 200000000000000;
        let v1 = 0;
        while (v1 < (arg1 - arg0.game_start) / 4320000000 && v0 > 0) {
            v0 = v0 / 2;
            v1 = v1 + 1;
        };
        v0
    }

    fun calculate_pending_rewards<T0, T1>(arg0: &GameState<T0, T1>, arg1: &PlayerTank, arg2: u64) : u64 {
        if (arg1.total_pressure == 0 || arg0.total_network_pressure == 0) {
            return 0
        };
        let v0 = ((((((calculate_current_emission<T0, T1>(arg0, arg2) as u128) * ((arg2 - arg1.last_claim_time) as u128) / (86400000 as u128)) as u64) as u128) * (arg1.total_pressure as u128) / (arg0.total_network_pressure as u128)) as u64);
        let v1 = 20000000000000000 - arg0.total_minted;
        if (v0 > v1) {
            v1
        } else {
            v0
        }
    }

    entry fun claim_rewards<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut MintVault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        let v3 = calculate_pending_rewards<T0, T1>(arg0, v2, v1) + v2.unclaimed_rewards;
        assert!(v3 > 0, 20);
        let v4 = 20000000000000000 - arg0.total_minted;
        let v5 = if (v3 > v4) {
            v4
        } else {
            v3
        };
        let v6 = get_player_fee_bps<T0, T1>(arg0, v0, v1);
        let v7 = if (v2.has_referrer && v6 > 250) {
            250
        } else {
            0
        };
        let v8 = (((v5 as u128) * ((v6 - v7) as u128) / (10000 as u128)) as u64);
        let v9 = (((v5 as u128) * (v7 as u128) / (10000 as u128)) as u64);
        let v10 = v5 - v8 - v9;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, v8, arg3), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, v10, arg3), v0);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, v9, arg3), v2.referrer);
        };
        arg0.total_minted = arg0.total_minted + v5;
        arg0.total_burned = arg0.total_burned + v8;
        let v11 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        v11.last_claim_time = v1;
        v11.total_earned = v11.total_earned + v10;
        v11.unclaimed_rewards = 0;
        let v12 = RewardsClaimed{
            player          : v0,
            amount          : v10,
            burned          : v8,
            referrer_reward : v9,
        };
        0x2::event::emit<RewardsClaimed>(v12);
    }

    fun compute_fee_from_rep(arg0: &RepProfile, arg1: &RepConfig, arg2: u64) : u64 {
        let v0 = arg1.base_fee_bps;
        let v1 = v0;
        if (arg0.streak_fee_locked) {
            let v2 = if (v0 > arg1.max_streak_reduction_bps) {
                v0 - arg1.max_streak_reduction_bps
            } else {
                0
            };
            v1 = v2;
        } else if (arg0.last_checkin_ms > 0 && arg2 <= arg0.last_checkin_ms + arg1.streak_window_ms) {
            let v3 = arg0.streak * arg1.streak_reduction_per_day_bps;
            let v4 = if (v3 > arg1.max_streak_reduction_bps) {
                arg1.max_streak_reduction_bps
            } else {
                v3
            };
            let v5 = if (v0 > v4) {
                v0 - v4
            } else {
                0
            };
            v1 = v5;
        };
        v1
    }

    entry fun create_cosmetic_type<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg9 > 0, 1);
        assert!(arg8 > 0, 1);
        let v0 = arg0.next_cosmetic_id;
        arg0.next_cosmetic_id = v0 + 1;
        let v1 = CosmeticType{
            name            : 0x1::string::utf8(arg2),
            image_url       : 0x1::string::utf8(arg3),
            bub_cost        : arg4,
            bublz_cost      : arg5,
            sui_cost        : arg6,
            bubble_pressure : arg7,
            max_supply      : arg8,
            minted          : 0,
            per_facility    : arg9,
            disabled        : false,
        };
        0x2::table::add<u64, CosmeticType>(&mut arg0.cosmetic_types, v0, v1);
    }

    entry fun create_cosmetic_vault(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CosmeticVault{
            id        : 0x2::object::new(arg1),
            cosmetics : 0x2::table::new<u64, BubbleCosmetic>(arg1),
        };
        0x2::transfer::share_object<CosmeticVault>(v0);
    }

    entry fun create_game<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 1000000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000000);
        0x1::vector::push_back<u64>(&mut v0, 1500000000);
        0x1::vector::push_back<u64>(&mut v0, 1500000000);
        0x1::vector::push_back<u64>(&mut v0, 2000000000);
        0x1::vector::push_back<u64>(&mut v0, 2000000000);
        0x1::vector::push_back<u64>(&mut v0, 2500000000);
        0x1::vector::push_back<u64>(&mut v0, 3000000000);
        0x1::vector::push_back<u64>(&mut v0, 3500000000);
        0x1::vector::push_back<u64>(&mut v0, 4000000000);
        0x1::vector::push_back<u64>(&mut v0, 5000000000);
        0x1::vector::push_back<u64>(&mut v0, 6000000000);
        let v1 = GameState<T0, T1>{
            id                        : 0x2::object::new(arg4),
            total_network_pressure    : 0,
            total_players             : 0,
            total_minted              : 0,
            total_burned              : 0,
            total_bublz_burned        : 0,
            game_start                : 0x2::clock::timestamp_ms(arg3),
            paused                    : false,
            sui_treasury              : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_recipient        : arg2,
            bublz_cost                : arg1,
            sui_costs                 : v0,
            cosmetic_types            : 0x2::table::new<u64, CosmeticType>(arg4),
            next_cosmetic_id          : 0,
            player_tanks              : 0x2::table::new<address, PlayerTank>(arg4),
            staked_bubblers           : 0x2::table::new<u64, StakedBubblerInfo>(arg4),
            staked_bubbler_objects    : 0x2::table::new<u64, BubbleGenerator>(arg4),
            displayed_cosmetics       : 0x2::table::new<u64, DisplayedCosmeticInfo>(arg4),
            next_bubbler_id           : 0,
            next_cosmetic_instance_id : 0,
        };
        0x2::transfer::share_object<GameState<T0, T1>>(v1);
    }

    entry fun create_tank<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 25);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 5) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = PlayerTank{
            tier                   : 0,
            last_upgrade_time      : 0,
            staked_bubbler_ids     : 0x1::vector::empty<u64>(),
            displayed_cosmetic_ids : 0x1::vector::empty<u64>(),
            total_pressure         : 0,
            total_tank_pressure    : 0,
            upgrade_levels         : v1,
            last_claim_time        : 0x2::clock::timestamp_ms(arg1),
            total_earned           : 0,
            unclaimed_rewards      : 0,
            referrer               : @0x0,
            has_referrer           : false,
        };
        0x2::table::add<address, PlayerTank>(&mut arg0.player_tanks, v0, v3);
        arg0.total_players = arg0.total_players + 1;
        let v4 = TankCreated{player: v0};
        0x2::event::emit<TankCreated>(v4);
    }

    entry fun daily_checkin<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = RepConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<RepConfigKey>(&arg0.id, v0), 100);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = RepConfigKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow<RepConfigKey, RepConfig>(&arg0.id, v3);
        let v5 = v4.streak_window_ms;
        let v6 = v4.daily_rep_cap;
        let v7 = RepTableKey{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<RepTableKey, 0x2::table::Table<address, RepProfile>>(&mut arg0.id, v7);
        assert!(0x2::table::contains<address, RepProfile>(v8, v1), 102);
        let v9 = 0x2::table::borrow_mut<address, RepProfile>(v8, v1);
        assert!(v9.last_checkin_ms == 0 || v2 >= v9.last_checkin_ms + v4.checkin_cooldown_ms, 103);
        if (v9.last_checkin_ms == 0) {
            v9.streak = 1;
        } else if (v2 <= v9.last_checkin_ms + v5) {
            v9.streak = v9.streak + 1;
        } else {
            v9.streak = 1;
        };
        if (v9.streak > v9.best_streak) {
            v9.best_streak = v9.streak;
        };
        if (!v9.streak_fee_locked && v9.streak >= v4.streak_lock_days) {
            v9.streak_fee_locked = true;
        };
        v9.last_checkin_ms = v2;
        let v10 = add_rep_capped(v9, v4.checkin_rep, v2, v6);
        let v11 = PlayerCheckedIn{
            player : v1,
            rep    : v10,
            streak : v9.streak,
        };
        0x2::event::emit<PlayerCheckedIn>(v11);
        let v12 = StreakUpdated{
            player      : v1,
            streak      : v9.streak,
            best_streak : v9.best_streak,
            locked      : v9.streak_fee_locked,
        };
        0x2::event::emit<StreakUpdated>(v12);
    }

    entry fun deposit_treasury_cap<T0>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintVault<T0>{
            id           : 0x2::object::new(arg2),
            treasury_cap : arg1,
        };
        0x2::transfer::share_object<MintVault<T0>>(v0);
    }

    entry fun disable_cosmetic<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64) {
        0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg2).disabled = true;
    }

    entry fun display_cosmetic<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &BubbleCosmetic, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0), v1);
        let v3 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        if (v2 > 0) {
            v3.unclaimed_rewards = v3.unclaimed_rewards + v2;
        };
        v3.last_claim_time = v1;
        let v4 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        assert!(0x1::vector::length<u64>(&v4.displayed_cosmetic_ids) < get_tank_cosmetic_slots(v4.tier), 16);
        let v5 = arg1.cosmetic_instance_id;
        assert!(!0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v5), 19);
        if (0x2::table::contains<u64, CosmeticType>(&arg0.cosmetic_types, arg1.cosmetic_type_id)) {
            let v6 = 0;
            let v7 = 0;
            while (v7 < 0x1::vector::length<u64>(&v4.displayed_cosmetic_ids)) {
                let v8 = *0x1::vector::borrow<u64>(&v4.displayed_cosmetic_ids, v7);
                if (0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v8)) {
                    if (0x2::table::borrow<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v8).cosmetic_type_id == arg1.cosmetic_type_id) {
                        v6 = v6 + 1;
                    };
                };
                v7 = v7 + 1;
            };
            assert!(v6 < 0x2::table::borrow<u64, CosmeticType>(&arg0.cosmetic_types, arg1.cosmetic_type_id).per_facility, 17);
        };
        let v9 = DisplayedCosmeticInfo{
            owner            : v0,
            cosmetic_type_id : arg1.cosmetic_type_id,
            bubble_pressure  : arg1.bubble_pressure,
        };
        0x2::table::add<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, v5, v9);
        let v10 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        0x1::vector::push_back<u64>(&mut v10.displayed_cosmetic_ids, v5);
        v10.total_pressure = v10.total_pressure + arg1.bubble_pressure;
        arg0.total_network_pressure = arg0.total_network_pressure + arg1.bubble_pressure;
    }

    entry fun display_cosmetic_v2<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &BubbleCosmetic, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0), v1);
        let v3 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        if (v2 > 0) {
            v3.unclaimed_rewards = v3.unclaimed_rewards + v2;
        };
        v3.last_claim_time = v1;
        let v4 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        assert!(0x1::vector::length<u64>(&v4.displayed_cosmetic_ids) < get_tank_cosmetic_slots(v4.tier), 16);
        let v5 = arg1.cosmetic_instance_id;
        assert!(!0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v5), 19);
        let v6 = if (0x2::table::contains<u64, CosmeticType>(&arg0.cosmetic_types, arg1.cosmetic_type_id)) {
            let v7 = 0x2::table::borrow<u64, CosmeticType>(&arg0.cosmetic_types, arg1.cosmetic_type_id);
            let v8 = 0;
            let v9 = 0;
            while (v9 < 0x1::vector::length<u64>(&v4.displayed_cosmetic_ids)) {
                let v10 = *0x1::vector::borrow<u64>(&v4.displayed_cosmetic_ids, v9);
                if (0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v10)) {
                    if (0x2::table::borrow<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v10).cosmetic_type_id == arg1.cosmetic_type_id) {
                        v8 = v8 + 1;
                    };
                };
                v9 = v9 + 1;
            };
            assert!(v8 < v7.per_facility, 17);
            v7.bubble_pressure
        } else {
            arg1.bubble_pressure
        };
        let v11 = DisplayedCosmeticInfo{
            owner            : v0,
            cosmetic_type_id : arg1.cosmetic_type_id,
            bubble_pressure  : v6,
        };
        0x2::table::add<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, v5, v11);
        let v12 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        0x1::vector::push_back<u64>(&mut v12.displayed_cosmetic_ids, v5);
        v12.total_pressure = v12.total_pressure + v6;
        arg0.total_network_pressure = arg0.total_network_pressure + v6;
    }

    entry fun display_cosmetic_v3<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut CosmeticVault, arg2: BubbleCosmetic, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0), v1);
        let v3 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        if (v2 > 0) {
            v3.unclaimed_rewards = v3.unclaimed_rewards + v2;
        };
        v3.last_claim_time = v1;
        let v4 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        assert!(0x1::vector::length<u64>(&v4.displayed_cosmetic_ids) < get_tank_cosmetic_slots(v4.tier), 16);
        let v5 = arg2.cosmetic_instance_id;
        assert!(!0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v5), 19);
        let v6 = if (0x2::table::contains<u64, CosmeticType>(&arg0.cosmetic_types, arg2.cosmetic_type_id)) {
            let v7 = 0x2::table::borrow<u64, CosmeticType>(&arg0.cosmetic_types, arg2.cosmetic_type_id);
            let v8 = 0;
            let v9 = 0;
            while (v9 < 0x1::vector::length<u64>(&v4.displayed_cosmetic_ids)) {
                let v10 = *0x1::vector::borrow<u64>(&v4.displayed_cosmetic_ids, v9);
                if (0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v10)) {
                    if (0x2::table::borrow<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v10).cosmetic_type_id == arg2.cosmetic_type_id) {
                        v8 = v8 + 1;
                    };
                };
                v9 = v9 + 1;
            };
            assert!(v8 < v7.per_facility, 17);
            v7.bubble_pressure
        } else {
            arg2.bubble_pressure
        };
        let v11 = DisplayedCosmeticInfo{
            owner            : v0,
            cosmetic_type_id : arg2.cosmetic_type_id,
            bubble_pressure  : v6,
        };
        0x2::table::add<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, v5, v11);
        0x2::table::add<u64, BubbleCosmetic>(&mut arg1.cosmetics, v5, arg2);
        let v12 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        0x1::vector::push_back<u64>(&mut v12.displayed_cosmetic_ids, v5);
        v12.total_pressure = v12.total_pressure + v6;
        arg0.total_network_pressure = arg0.total_network_pressure + v6;
    }

    entry fun emergency_withdraw<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 22);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    entry fun enable_cosmetic<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64) {
        0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg2).disabled = false;
    }

    entry fun fuse_bubblers<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: BubbleGenerator, arg2: BubbleGenerator, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = arg1.tier;
        assert!(arg1.tier == arg2.tier, 1);
        let v2 = v1 + 1;
        assert!((v2 as u64) < 13, 1);
        let (v3, v4, v5) = get_fusion_costs(v1);
        if (v3 > 0) {
            let v6 = process_bub_payment<T0>(arg3, v3, arg6);
            burn_bub_payment<T0, T0, T1>(v6, arg0, arg6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        };
        process_bublz_payment<T1, T0, T1>(arg4, v4, arg0, arg6);
        process_sui_payment<T0, T1>(arg5, v5, arg0, arg6);
        let BubbleGenerator {
            id              : v7,
            bubbler_id      : _,
            tier            : _,
            name            : _,
            bubble_pressure : _,
            tank_pressure   : _,
            image_url       : _,
            attributes      : _,
        } = arg1;
        0x2::object::delete(v7);
        let BubbleGenerator {
            id              : v15,
            bubbler_id      : _,
            tier            : _,
            name            : _,
            bubble_pressure : _,
            tank_pressure   : _,
            image_url       : _,
            attributes      : _,
        } = arg2;
        0x2::object::delete(v15);
        let (v23, v24, _, v26, v27) = get_bubbler_stats(v2);
        let v28 = arg0.next_bubbler_id;
        arg0.next_bubbler_id = v28 + 1;
        let v29 = BubbleGenerator{
            id              : 0x2::object::new(arg6),
            bubbler_id      : v28,
            tier            : v2,
            name            : v26,
            bubble_pressure : v23,
            tank_pressure   : v24,
            image_url       : v27,
            attributes      : make_bubbler_attrs(v2, v26),
        };
        0x2::transfer::public_transfer<BubbleGenerator>(v29, v0);
        arg0.total_burned = arg0.total_burned + 2;
        let v30 = BubblerFused{
            player         : v0,
            from_tier      : v1,
            to_tier        : v2,
            new_bubbler_id : v28,
        };
        0x2::event::emit<BubblerFused>(v30);
    }

    fun get_bubbler_stats(arg0: u8) : (u64, u64, u64, 0x1::string::String, 0x1::string::String) {
        if (arg0 == 0) {
            (100, 1, 0, 0x1::string::utf8(b"Droplet"), 0x1::string::utf8(b"https://bublz.fun/bubblers/droplet.png"))
        } else if (arg0 == 1) {
            (180, 6, 4000000000, 0x1::string::utf8(b"Fizzer"), 0x1::string::utf8(b"https://bublz.fun/bubblers/fizzer.png"))
        } else if (arg0 == 2) {
            (420, 8, 8000000000, 0x1::string::utf8(b"Trickler"), 0x1::string::utf8(b"https://bublz.fun/bubblers/trickler.png"))
        } else if (arg0 == 3) {
            (1000, 10, 12000000000, 0x1::string::utf8(b"Streamer"), 0x1::string::utf8(b"https://bublz.fun/bubblers/streamer.png"))
        } else if (arg0 == 4) {
            (5000, 30, 34000000000, 0x1::string::utf8(b"Pumper"), 0x1::string::utf8(b"https://bublz.fun/bubblers/pumper.png"))
        } else if (arg0 == 5) {
            (15000, 50, 75000000000, 0x1::string::utf8(b"Jet"), 0x1::string::utf8(b"https://bublz.fun/bubblers/jet.png"))
        } else if (arg0 == 6) {
            (20000, 90, 127000000000, 0x1::string::utf8(b"Blaster"), 0x1::string::utf8(b"https://bublz.fun/bubblers/blaster.png"))
        } else if (arg0 == 7) {
            (60000, 200, 297000000000, 0x1::string::utf8(b"Geyser"), 0x1::string::utf8(b"https://bublz.fun/bubblers/geyser.png"))
        } else if (arg0 == 8) {
            (120000, 400, 586000000000, 0x1::string::utf8(b"Eruption"), 0x1::string::utf8(b"https://bublz.fun/bubblers/eruption.png"))
        } else if (arg0 == 9) {
            (200000, 600, 1020000000000, 0x1::string::utf8(b"Torrent"), 0x1::string::utf8(b"https://bublz.fun/bubblers/torrent.png"))
        } else {
            let (v5, v6, v7, v8, v9) = if (arg0 == 10) {
                (0x1::string::utf8(b"https://bublz.fun/bubblers/tsunami.png"), 800000, 2000, 2550000000000, 0x1::string::utf8(b"Tsunami"))
            } else {
                let (v10, v11, v12, v13, v14) = if (arg0 == 11) {
                    (1336000, 3000, 3400000000000, 0x1::string::utf8(b"Cyclone"), 0x1::string::utf8(b"https://bublz.fun/bubblers/cyclone.png"))
                } else {
                    (2508000, 5000, 5100000000000, 0x1::string::utf8(b"Rift"), 0x1::string::utf8(b"https://bublz.fun/bubblers/rift.png"))
                };
                (v14, v10, v11, v12, v13)
            };
            (v6, v7, v8, v9, v5)
        }
    }

    fun get_bubbler_sui_cost(arg0: u8, arg1: &vector<u64>) : u64 {
        *0x1::vector::borrow<u64>(arg1, (arg0 as u64))
    }

    fun get_fusion_costs(arg0: u8) : (u64, u64, u64) {
        if (arg0 == 0) {
            (2000000000, 25000000000000, 500000000)
        } else if (arg0 == 1) {
            (4000000000, 25000000000000, 500000000)
        } else if (arg0 == 2) {
            (6000000000, 25000000000000, 750000000)
        } else if (arg0 == 3) {
            (17000000000, 25000000000000, 750000000)
        } else if (arg0 == 4) {
            (37000000000, 25000000000000, 1000000000)
        } else if (arg0 == 5) {
            (63000000000, 25000000000000, 1000000000)
        } else if (arg0 == 6) {
            (148000000000, 25000000000000, 1250000000)
        } else if (arg0 == 7) {
            (293000000000, 25000000000000, 1500000000)
        } else if (arg0 == 8) {
            (510000000000, 25000000000000, 1750000000)
        } else if (arg0 == 9) {
            (1275000000000, 25000000000000, 2000000000)
        } else if (arg0 == 10) {
            (1700000000000, 50000000000000, 2500000000)
        } else {
            (2550000000000, 100000000000000, 3000000000)
        }
    }

    public fun get_game_start<T0, T1>(arg0: &GameState<T0, T1>) : u64 {
        arg0.game_start
    }

    fun get_player_fee_bps<T0, T1>(arg0: &GameState<T0, T1>, arg1: address, arg2: u64) : u64 {
        let v0 = FeeTableKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<FeeTableKey>(&arg0.id, v0)) {
            let v1 = FeeTableKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow<FeeTableKey, 0x2::table::Table<address, u64>>(&arg0.id, v1);
            if (0x2::table::contains<address, u64>(v2, arg1)) {
                return *0x2::table::borrow<address, u64>(v2, arg1)
            };
        };
        let v3 = RepConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RepConfigKey>(&arg0.id, v3)) {
            let v4 = RepConfigKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::borrow<RepConfigKey, RepConfig>(&arg0.id, v4);
            let v6 = RepTableKey{dummy_field: false};
            if (0x2::dynamic_field::exists_<RepTableKey>(&arg0.id, v6)) {
                let v7 = RepTableKey{dummy_field: false};
                let v8 = 0x2::dynamic_field::borrow<RepTableKey, 0x2::table::Table<address, RepProfile>>(&arg0.id, v7);
                if (0x2::table::contains<address, RepProfile>(v8, arg1)) {
                    return compute_fee_from_rep(0x2::table::borrow<address, RepProfile>(v8, arg1), v5, arg2)
                };
            };
            let v9 = DefaultFeeKey{dummy_field: false};
            if (0x2::dynamic_field::exists_<DefaultFeeKey>(&arg0.id, v9)) {
                let v10 = DefaultFeeKey{dummy_field: false};
                return *0x2::dynamic_field::borrow<DefaultFeeKey, u64>(&arg0.id, v10)
            };
            return v5.base_fee_bps
        };
        1500
    }

    fun get_skip_cumulative(arg0: u8) : (u64, u64, u64) {
        if (arg0 == 0) {
            (0, 0, 0)
        } else if (arg0 == 1) {
            (2000000000, 84000000000, 100000000000000)
        } else if (arg0 == 2) {
            (4000000000, 296000000000, 200000000000000)
        } else if (arg0 == 3) {
            (6000000000, 676000000000, 300000000000000)
        } else if (arg0 == 4) {
            (8000000000, 1136000000000, 400000000000000)
        } else {
            (11000000000, 1686000000000, 500000000000000)
        }
    }

    fun get_tank_bub_cost(arg0: u8) : u64 {
        if (arg0 == 1) {
            42000000000
        } else if (arg0 == 2) {
            106000000000
        } else if (arg0 == 3) {
            190000000000
        } else if (arg0 == 4) {
            230000000000
        } else if (arg0 == 5) {
            275000000000
        } else if (arg0 == 6) {
            295000000000
        } else if (arg0 == 7) {
            850000000000
        } else {
            1020000000000
        }
    }

    fun get_tank_cosmetic_slots(arg0: u8) : u64 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            2
        } else if (arg0 == 2) {
            3
        } else if (arg0 == 3) {
            4
        } else if (arg0 == 4) {
            5
        } else if (arg0 == 5) {
            6
        } else if (arg0 == 6) {
            8
        } else if (arg0 == 7) {
            10
        } else {
            12
        }
    }

    fun get_tank_max_bubblers(arg0: u8) : u64 {
        if (arg0 == 0) {
            4
        } else if (arg0 == 1) {
            8
        } else if (arg0 == 2) {
            12
        } else if (arg0 == 3) {
            16
        } else if (arg0 == 4) {
            20
        } else if (arg0 == 5) {
            20
        } else if (arg0 == 6) {
            24
        } else if (arg0 == 7) {
            42
        } else {
            42
        }
    }

    fun get_tank_pressure_capacity(arg0: u8) : u64 {
        if (arg0 == 0) {
            28
        } else if (arg0 == 1) {
            168
        } else if (arg0 == 2) {
            420
        } else if (arg0 == 3) {
            1120
        } else if (arg0 == 4) {
            7000
        } else if (arg0 == 5) {
            13125
        } else if (arg0 == 6) {
            20000
        } else if (arg0 == 7) {
            40000
        } else {
            65000
        }
    }

    fun get_tank_sui_cost(arg0: u8) : u64 {
        if (arg0 == 1) {
            1000000000
        } else if (arg0 == 2) {
            1000000000
        } else if (arg0 == 3) {
            1000000000
        } else if (arg0 == 4) {
            1000000000
        } else if (arg0 == 5) {
            1500000000
        } else if (arg0 == 6) {
            2000000000
        } else if (arg0 == 7) {
            3000000000
        } else {
            4000000000
        }
    }

    public fun get_total_bublz_burned<T0, T1>(arg0: &GameState<T0, T1>) : u64 {
        arg0.total_bublz_burned
    }

    public fun get_total_burned<T0, T1>(arg0: &GameState<T0, T1>) : u64 {
        arg0.total_burned
    }

    public fun get_total_minted<T0, T1>(arg0: &GameState<T0, T1>) : u64 {
        arg0.total_minted
    }

    public fun get_total_network_pressure<T0, T1>(arg0: &GameState<T0, T1>) : u64 {
        arg0.total_network_pressure
    }

    public fun get_total_players<T0, T1>(arg0: &GameState<T0, T1>) : u64 {
        arg0.total_players
    }

    fun get_upgrade_base_bub(arg0: u8) : u64 {
        if (arg0 == 0) {
            50000000000
        } else if (arg0 == 1) {
            50000000000
        } else if (arg0 == 2) {
            75000000000
        } else if (arg0 == 3) {
            150000000000
        } else {
            200000000000
        }
    }

    fun get_upgrade_bub_cost(arg0: u8, arg1: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * 2;
            v1 = v1 + 1;
        };
        get_upgrade_base_bub(arg0) * v0
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GAME>(arg0, arg1);
        let v1 = 0x2::display::new<BubbleGenerator>(&v0, arg1);
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"427562636f696e20427562626c657220e28094207b627562626c655f70726573737572657d204250204d696e696e6720506f776572"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bublz.fun/bubcoin"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Bubcoin Bubblers"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"BUBLZ"));
        0x2::display::update_version<BubbleGenerator>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<BubbleGenerator>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::display::new<BubbleCosmetic>(&v0, arg1);
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"427562636f696e20436f736d6574696320e28094202b7b627562626c655f70726573737572657d20425020426f6e7573"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bublz.fun/bubcoin"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Bubcoin Cosmetics"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"BUBLZ"));
        0x2::display::update_version<BubbleCosmetic>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<BubbleCosmetic>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    fun make_bubbler_attrs(arg0: u8, arg1: 0x1::string::String) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Type"), 0x1::string::utf8(b"Bubbler"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Name"), arg1);
        let v1 = if (arg0 == 0) {
            b"0"
        } else if (arg0 == 1) {
            b"1"
        } else if (arg0 == 2) {
            b"2"
        } else if (arg0 == 3) {
            b"3"
        } else if (arg0 == 4) {
            b"4"
        } else if (arg0 == 5) {
            b"5"
        } else if (arg0 == 6) {
            b"6"
        } else if (arg0 == 7) {
            b"7"
        } else if (arg0 == 8) {
            b"8"
        } else if (arg0 == 9) {
            b"9"
        } else if (arg0 == 10) {
            b"10"
        } else if (arg0 == 11) {
            b"11"
        } else {
            b"12"
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Tier"), 0x1::string::utf8(v1));
        let v2 = if (arg0 <= 2) {
            b"Common"
        } else if (arg0 <= 5) {
            b"Uncommon"
        } else if (arg0 <= 8) {
            b"Rare"
        } else if (arg0 <= 10) {
            b"Epic"
        } else {
            b"Legendary"
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), 0x1::string::utf8(v2));
        v0
    }

    fun make_cosmetic_attrs(arg0: 0x1::string::String) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Type"), 0x1::string::utf8(b"Cosmetic"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Name"), arg0);
        v0
    }

    entry fun mint_bubbler<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!((arg1 as u64) < 13, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let (v1, v2, v3, v4, v5) = get_bubbler_stats(arg1);
        if (v3 > 0) {
            let v6 = process_bub_payment<T0>(arg2, v3, arg5);
            burn_bub_payment<T0, T0, T1>(v6, arg0, arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        };
        let v7 = if (arg1 == 0) {
            arg0.bublz_cost * 2
        } else {
            arg0.bublz_cost
        };
        process_bublz_payment<T1, T0, T1>(arg3, v7, arg0, arg5);
        let v8 = get_bubbler_sui_cost(arg1, &arg0.sui_costs);
        process_sui_payment<T0, T1>(arg4, v8, arg0, arg5);
        let v9 = arg0.next_bubbler_id;
        arg0.next_bubbler_id = v9 + 1;
        let v10 = BubbleGenerator{
            id              : 0x2::object::new(arg5),
            bubbler_id      : v9,
            tier            : arg1,
            name            : v4,
            bubble_pressure : v1,
            tank_pressure   : v2,
            image_url       : v5,
            attributes      : make_bubbler_attrs(arg1, v4),
        };
        0x2::transfer::public_transfer<BubbleGenerator>(v10, v0);
        let v11 = BubblerMinted{
            owner           : v0,
            bubbler_id      : v9,
            tier            : arg1,
            bubble_pressure : v1,
        };
        0x2::event::emit<BubblerMinted>(v11);
    }

    entry fun mint_cosmetic<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(0x2::table::contains<u64, CosmeticType>(&arg0.cosmetic_types, arg1), 1);
        let v0 = 0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg1);
        assert!(!v0.disabled, 14);
        assert!(v0.minted < v0.max_supply, 15);
        let v1 = v0.bub_cost;
        let v2 = v0.name;
        let v3 = v0.bubble_pressure;
        v0.minted = v0.minted + 1;
        if (v1 > 0) {
            let v4 = process_bub_payment<T0>(arg2, v1, arg5);
            burn_bub_payment<T0, T0, T1>(v4, arg0, arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
        };
        process_bublz_payment<T1, T0, T1>(arg3, v0.bublz_cost, arg0, arg5);
        process_sui_payment<T0, T1>(arg4, v0.sui_cost, arg0, arg5);
        let v5 = arg0.next_cosmetic_instance_id;
        arg0.next_cosmetic_instance_id = v5 + 1;
        let v6 = BubbleCosmetic{
            id                   : 0x2::object::new(arg5),
            cosmetic_instance_id : v5,
            cosmetic_type_id     : arg1,
            name                 : v2,
            bubble_pressure      : v3,
            image_url            : v0.image_url,
            attributes           : make_cosmetic_attrs(v2),
        };
        0x2::transfer::public_transfer<BubbleCosmetic>(v6, 0x2::tx_context::sender(arg5));
        let v7 = CosmeticMinted{
            owner            : 0x2::tx_context::sender(arg5),
            cosmetic_type_id : arg1,
            name             : v2,
        };
        0x2::event::emit<CosmeticMinted>(v7);
    }

    fun process_bub_payment<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 7);
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        if (v0 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v0 - arg1), arg2), 0x2::tx_context::sender(arg2));
        };
        v1
    }

    fun process_bublz_payment<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut GameState<T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 7);
        if (v0 > arg1) {
            let v1 = 0x2::coin::into_balance<T0>(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v0 - arg1), arg3), 0x2::tx_context::sender(arg3));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), @0x0);
            arg2.total_bublz_burned = arg2.total_bublz_burned + arg1;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
            arg2.total_bublz_burned = arg2.total_bublz_burned + v0;
        };
    }

    fun process_sui_payment<T0, T1>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut GameState<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= arg1, 7);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        if (v0 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 - arg1), arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.sui_treasury, v1);
    }

    entry fun refresh_cosmetic_metadata<T0, T1>(arg0: &GameState<T0, T1>, arg1: &mut BubbleCosmetic) {
        let v0 = arg1.cosmetic_type_id;
        assert!(0x2::table::contains<u64, CosmeticType>(&arg0.cosmetic_types, v0), 1);
        let v1 = 0x2::table::borrow<u64, CosmeticType>(&arg0.cosmetic_types, v0);
        arg1.name = v1.name;
        arg1.image_url = v1.image_url;
    }

    entry fun remove_cosmetic<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &BubbleCosmetic, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = arg1.cosmetic_instance_id;
        assert!(0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v0), 18);
        assert!(0x2::table::borrow<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v0).owner == 0x2::tx_context::sender(arg3), 4);
        let v1 = 0x2::table::remove<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, v0);
        let v2 = v1.owner;
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v2), v3);
        let v5 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v2);
        if (v4 > 0) {
            v5.unclaimed_rewards = v5.unclaimed_rewards + v4;
        };
        v5.last_claim_time = v3;
        let v6 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v2);
        let v7 = 0;
        let v8 = 0x1::vector::length<u64>(&v6.displayed_cosmetic_ids);
        while (v7 < v8) {
            if (*0x1::vector::borrow<u64>(&v6.displayed_cosmetic_ids, v7) == v0) {
                0x1::vector::swap_remove<u64>(&mut v6.displayed_cosmetic_ids, v7);
                v7 = v8;
            };
            v7 = v7 + 1;
        };
        v6.total_pressure = v6.total_pressure - v1.bubble_pressure;
        arg0.total_network_pressure = arg0.total_network_pressure - v1.bubble_pressure;
    }

    entry fun remove_cosmetic_v2<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut CosmeticVault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, arg2), 18);
        assert!(0x2::table::borrow<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, arg2).owner == v0, 4);
        let v1 = 0x2::table::remove<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, arg2);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0), v2);
        let v4 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        if (v3 > 0) {
            v4.unclaimed_rewards = v4.unclaimed_rewards + v3;
        };
        v4.last_claim_time = v2;
        let v5 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        let v6 = 0;
        let v7 = 0x1::vector::length<u64>(&v5.displayed_cosmetic_ids);
        while (v6 < v7) {
            if (*0x1::vector::borrow<u64>(&v5.displayed_cosmetic_ids, v6) == arg2) {
                0x1::vector::swap_remove<u64>(&mut v5.displayed_cosmetic_ids, v6);
                v6 = v7;
            };
            v6 = v6 + 1;
        };
        v5.total_pressure = v5.total_pressure - v1.bubble_pressure;
        arg0.total_network_pressure = arg0.total_network_pressure - v1.bubble_pressure;
        if (0x2::table::contains<u64, BubbleCosmetic>(&arg1.cosmetics, arg2)) {
            0x2::transfer::public_transfer<BubbleCosmetic>(0x2::table::remove<u64, BubbleCosmetic>(&mut arg1.cosmetics, arg2), v0);
        };
    }

    entry fun rep_register<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = RepTableKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<RepTableKey>(&arg0.id, v0), 100);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v1), 10);
        let v2 = RepTableKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<RepTableKey, 0x2::table::Table<address, RepProfile>>(&mut arg0.id, v2);
        assert!(!0x2::table::contains<address, RepProfile>(v3, v1), 109);
        let v4 = RepProfile{
            rep               : 0,
            streak            : 0,
            best_streak       : 0,
            last_checkin_ms   : 0,
            rep_added_today   : 0,
            day_start_ms      : 0x2::clock::timestamp_ms(arg1),
            streak_fee_locked : false,
        };
        0x2::table::add<address, RepProfile>(v3, v1, v4);
    }

    entry fun set_bublz_cost<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64) {
        arg0.bublz_cost = arg2;
    }

    entry fun set_cosmetic_bp<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg2).bubble_pressure = arg3;
    }

    entry fun set_cosmetic_costs<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg2);
        v0.bub_cost = arg3;
        v0.bublz_cost = arg4;
        v0.sui_cost = arg5;
    }

    entry fun set_cosmetic_metadata<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = 0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg2);
        v0.name = 0x1::string::utf8(arg3);
        v0.image_url = 0x1::string::utf8(arg4);
    }

    entry fun set_paused<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    entry fun set_referral<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 9);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, arg1), 24);
        let v1 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        assert!(!v1.has_referrer, 8);
        v1.referrer = arg1;
        v1.has_referrer = true;
    }

    entry fun set_sui_costs<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 13, 1);
        arg0.sui_costs = arg2;
    }

    entry fun set_treasury_recipient<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: address) {
        arg0.treasury_recipient = arg2;
    }

    entry fun skip_to_tier<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        assert!(arg1 <= 5, 1);
        assert!(arg1 > v1.tier, 1);
        assert!(0x1::vector::length<u64>(&v1.staked_bubbler_ids) == 0, 23);
        assert!(0x1::vector::length<u64>(&v1.displayed_cosmetic_ids) == 0, 23);
        let (v2, v3, v4) = get_skip_cumulative(arg1);
        let (v5, v6, v7) = get_skip_cumulative(v1.tier);
        let v8 = process_bub_payment<T0>(arg2, v3 - v6, arg6);
        burn_bub_payment<T0, T0, T1>(v8, arg0, arg6);
        process_bublz_payment<T1, T0, T1>(arg3, v4 - v7, arg0, arg6);
        process_sui_payment<T0, T1>(arg4, v2 - v5, arg0, arg6);
        let v9 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        v9.tier = arg1;
        v9.last_upgrade_time = 0x2::clock::timestamp_ms(arg5);
        let v10 = TankUpgraded{
            player   : v0,
            new_tier : arg1,
        };
        0x2::event::emit<TankUpgraded>(v10);
    }

    entry fun stake_bubbler<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: BubbleGenerator, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.bubbler_id;
        let v2 = arg1.tier;
        assert!(!0x2::table::contains<u64, StakedBubblerInfo>(&arg0.staked_bubblers, v1), 19);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0), v3);
        let v5 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        if (v4 > 0) {
            v5.unclaimed_rewards = v5.unclaimed_rewards + v4;
        };
        v5.last_claim_time = v3;
        let v6 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        assert!(0x1::vector::length<u64>(&v6.staked_bubbler_ids) < get_tank_max_bubblers(v6.tier), 2);
        let v7 = apply_upgrade_bonus(v6, arg1.bubble_pressure);
        let v8 = apply_cooling_bonus(v6, arg1.tank_pressure);
        assert!(v6.total_tank_pressure + v8 <= get_tank_pressure_capacity(v6.tier), 3);
        let v9 = StakedBubblerInfo{
            owner           : v0,
            tier            : v2,
            bubble_pressure : v7,
            tank_pressure   : v8,
        };
        0x2::table::add<u64, StakedBubblerInfo>(&mut arg0.staked_bubblers, v1, v9);
        0x2::table::add<u64, BubbleGenerator>(&mut arg0.staked_bubbler_objects, v1, arg1);
        let v10 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        0x1::vector::push_back<u64>(&mut v10.staked_bubbler_ids, v1);
        v10.total_pressure = v10.total_pressure + v7;
        v10.total_tank_pressure = v10.total_tank_pressure + v8;
        arg0.total_network_pressure = arg0.total_network_pressure + v7;
        let v11 = BubblerStaked{
            owner      : v0,
            bubbler_id : v1,
            tier       : v2,
        };
        0x2::event::emit<BubblerStaked>(v11);
    }

    entry fun unstake_all_bubblers<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0), v1);
        let v3 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        if (v2 > 0) {
            v3.unclaimed_rewards = v3.unclaimed_rewards + v2;
        };
        v3.last_claim_time = v1;
        let v4 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        let v5 = v4.staked_bubbler_ids;
        v4.staked_bubbler_ids = 0x1::vector::empty<u64>();
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&v5)) {
            let v9 = *0x1::vector::borrow<u64>(&v5, v8);
            if (0x2::table::contains<u64, StakedBubblerInfo>(&arg0.staked_bubblers, v9)) {
                let v10 = 0x2::table::remove<u64, StakedBubblerInfo>(&mut arg0.staked_bubblers, v9);
                v6 = v6 + v10.bubble_pressure;
                v7 = v7 + v10.tank_pressure;
                0x2::transfer::public_transfer<BubbleGenerator>(0x2::table::remove<u64, BubbleGenerator>(&mut arg0.staked_bubbler_objects, v9), v0);
                let v11 = BubblerUnstaked{
                    owner      : v0,
                    bubbler_id : v9,
                    tier       : v10.tier,
                };
                0x2::event::emit<BubblerUnstaked>(v11);
            };
            v8 = v8 + 1;
        };
        let v12 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        v12.total_pressure = v12.total_pressure - v6;
        v12.total_tank_pressure = v12.total_tank_pressure - v7;
        arg0.total_network_pressure = arg0.total_network_pressure - v6;
    }

    entry fun unstake_bubbler<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<u64, StakedBubblerInfo>(&arg0.staked_bubblers, arg1), 18);
        assert!(0x2::table::borrow<u64, StakedBubblerInfo>(&arg0.staked_bubblers, arg1).owner == v0, 4);
        let v1 = 0x2::table::remove<u64, StakedBubblerInfo>(&mut arg0.staked_bubblers, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = calculate_pending_rewards<T0, T1>(arg0, 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0), v2);
        let v4 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        if (v3 > 0) {
            v4.unclaimed_rewards = v4.unclaimed_rewards + v3;
        };
        v4.last_claim_time = v2;
        let v5 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        let v6 = 0;
        let v7 = 0x1::vector::length<u64>(&v5.staked_bubbler_ids);
        while (v6 < v7) {
            if (*0x1::vector::borrow<u64>(&v5.staked_bubbler_ids, v6) == arg1) {
                0x1::vector::swap_remove<u64>(&mut v5.staked_bubbler_ids, v6);
                v6 = v7;
            };
            v6 = v6 + 1;
        };
        v5.total_pressure = v5.total_pressure - v1.bubble_pressure;
        v5.total_tank_pressure = v5.total_tank_pressure - v1.tank_pressure;
        arg0.total_network_pressure = arg0.total_network_pressure - v1.bubble_pressure;
        0x2::transfer::public_transfer<BubbleGenerator>(0x2::table::remove<u64, BubbleGenerator>(&mut arg0.staked_bubbler_objects, arg1), v0);
        let v8 = BubblerUnstaked{
            owner      : v0,
            bubbler_id : arg1,
            tier       : v1.tier,
        };
        0x2::event::emit<BubblerUnstaked>(v8);
    }

    entry fun upgrade_stat<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg1 < 5, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = *0x1::vector::borrow<u8>(&0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0).upgrade_levels, (arg1 as u64));
        assert!(v1 < 5, 13);
        let v2 = process_bub_payment<T0>(arg2, get_upgrade_bub_cost(arg1, v1), arg5);
        burn_bub_payment<T0, T0, T1>(v2, arg0, arg5);
        process_bublz_payment<T1, T0, T1>(arg3, 25000000000000, arg0, arg5);
        process_sui_payment<T0, T1>(arg4, 2000000000, arg0, arg5);
        let v3 = 0x1::vector::borrow_mut<u8>(&mut 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0).upgrade_levels, (arg1 as u64));
        *v3 = *v3 + 1;
        let v4 = StatUpgraded{
            player       : v0,
            upgrade_type : arg1,
            new_level    : *v3,
        };
        0x2::event::emit<StatUpgraded>(v4);
    }

    entry fun upgrade_tank<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1.tier < 8, 1);
        assert!(v2 >= v1.last_upgrade_time + 86400000, 12);
        assert!(0x1::vector::length<u64>(&v1.staked_bubbler_ids) == 0, 23);
        assert!(0x1::vector::length<u64>(&v1.displayed_cosmetic_ids) == 0, 23);
        let v3 = v1.tier + 1;
        let v4 = process_bub_payment<T0>(arg1, get_tank_bub_cost(v3), arg5);
        burn_bub_payment<T0, T0, T1>(v4, arg0, arg5);
        let v5 = arg0.bublz_cost;
        process_bublz_payment<T1, T0, T1>(arg2, v5, arg0, arg5);
        process_sui_payment<T0, T1>(arg3, get_tank_sui_cost(v3), arg0, arg5);
        let v6 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        v6.tier = v3;
        v6.last_upgrade_time = v2;
        let v7 = TankUpgraded{
            player   : v0,
            new_tier : v3,
        };
        0x2::event::emit<TankUpgraded>(v7);
    }

    entry fun withdraw_sui_treasury<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

