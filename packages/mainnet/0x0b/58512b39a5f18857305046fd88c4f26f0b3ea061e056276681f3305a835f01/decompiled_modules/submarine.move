module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::submarine {
    struct SubmarineRegistry has key {
        id: 0x2::object::UID,
        purchased_users: 0x2::table::Table<address, bool>,
    }

    struct SubmarineRegistryV2 has key {
        id: 0x2::object::UID,
        purchased_users: 0x2::table::Table<address, bool>,
    }

    struct Submarine has key {
        id: 0x2::object::UID,
        level: u64,
        owner: address,
        upgrade_materials_bag: vector<u64>,
        team_slots: vector<Team>,
        is_exploring: bool,
        exploration_end_time: u64,
        exploration_total_times: u64,
    }

    struct Team has store {
        diver: 0x1::option::Option<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>,
        fishes: vector<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>,
    }

    struct ExplorationLoot has key {
        id: 0x2::object::UID,
        has_reward: u8,
        submarine_level: u64,
        pearl_amount_r_v: u64,
        upgrade_materials_reward_counts: vector<u64>,
    }

    struct PurchaseSubmarineEvent has copy, drop {
        submarine_id: 0x2::object::ID,
    }

    struct UpgradeSubmarineEvent has copy, drop {
        submarine_id: 0x2::object::ID,
        level_before: u64,
        dive_token_cost: u64,
        pearl_token_cost: u64,
        upgrade_materials_costs: vector<u64>,
    }

    struct SubmarineExplorationEvent has copy, drop {
        submarine_id: 0x2::object::ID,
        dive_token_payment: u64,
        exploration_duration_ms: u64,
        teams_count: u64,
    }

    struct FinishExplorationEvent has copy, drop {
        submarine_id: 0x2::object::ID,
        total_probability: u64,
        pearl_amount_r_v: u64,
        team_index: u64,
        upgrade_materials_reward_counts: vector<u64>,
    }

    struct OpenExplorationLootEvent has copy, drop {
        submarine_id: 0x2::object::ID,
        pearl_token_reward: u64,
        upgrade_materials_reward_counts: vector<u64>,
    }

    public fun admin_init_submarine_registry(arg0: &mut 0x2::tx_context::TxContext) {
        abort 19
    }

    public fun admin_init_submarine_registry_v2(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg1: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg0, arg1);
        let v0 = SubmarineRegistryV2{
            id              : 0x2::object::new(arg2),
            purchased_users : 0x2::table::new<address, bool>(arg2),
        };
        0x2::transfer::share_object<SubmarineRegistryV2>(v0);
    }

    fun calc_upgrade_cost(arg0: u64) : (u64, u64, u64, u64, u64) {
        assert!(arg0 >= 1, 2);
        assert!(arg0 < 50, 1);
        let v0 = 500000000;
        let v1 = 250000000;
        let v2 = 20;
        let v3 = 15;
        let v4 = 30;
        let v5 = 1;
        let v6 = 108;
        let v7 = 100;
        while (v5 < arg0) {
            let v8 = v0 * v6;
            v0 = v8 / v7;
            let v9 = v1 * v6;
            v1 = v9 / v7;
            let v10 = v2 * v6;
            v2 = v10 / v7;
            let v11 = v3 * v6;
            v3 = v11 / v7;
            let v12 = v4 * v6;
            v4 = v12 / v7;
            v5 = v5 + 1;
        };
        (v0, v1, v2, v3, v4)
    }

    fun exploration_duration_ms(arg0: &Submarine) : u64 {
        let v0 = vector[21600000, 28800000, 43200000, 64800000, 86400000];
        *0x1::vector::borrow<u64>(&v0, 4 - (arg0.level - 1) / 10)
    }

    fun exploration_payment(arg0: &Submarine) : u64 {
        let v0 = vector[4000000000, 3000000000, 2000000000, 1500000000, 1000000000];
        *0x1::vector::borrow<u64>(&v0, 4 - (arg0.level - 1) / 10)
    }

    public fun explore(arg0: &mut Submarine, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg3: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg6);
        assert!(!arg0.is_exploring, 8);
        assert!(arg0.owner == 0x2::tx_context::sender(arg8), 13);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg0.exploration_end_time, 9);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Team>(&arg0.team_slots)) {
            if (0x1::option::is_some<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&0x1::vector::borrow<Team>(&arg0.team_slots, v1).diver)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 16);
        let v2 = 0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg3);
        assert!(v2 == exploration_payment(arg0), 0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg4, arg3, arg5, arg6, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_submarine_exploration(), arg7, arg8);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg1, v2, arg2);
        let v3 = exploration_duration_ms(arg0);
        arg0.is_exploring = true;
        arg0.exploration_end_time = 0x2::clock::timestamp_ms(arg7) + v3;
        let v4 = SubmarineExplorationEvent{
            submarine_id            : 0x2::object::id<Submarine>(arg0),
            dive_token_payment      : v2,
            exploration_duration_ms : v3,
            teams_count             : v0,
        };
        0x2::event::emit<SubmarineExplorationEvent>(v4);
    }

    entry fun finish_exploration(arg0: &mut Submarine, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        assert!(arg0.is_exploring, 10);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 13);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.exploration_end_time, 9);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::has_fish_probability();
        let v1 = vector[vector[20, 17, 14, 12, 10], vector[17, 14, 12, 9, 7], vector[14, 11, 9, 7, 5], vector[12, 9, 7, 5, 3], vector[10, 7, 5, 3, 1]];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Team>(&arg0.team_slots)) {
            let v3 = 0x1::vector::borrow<Team>(&arg0.team_slots, v2);
            if (0x1::option::is_some<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&v3.diver)) {
                let v4 = 0x1::option::borrow<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&v3.diver);
                let v5 = 0;
                let v6 = 0;
                while (v6 < 0x1::vector::length<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&v3.fishes)) {
                    let v7 = 0x1::vector::borrow<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&v3.fishes, v6);
                    v5 = v5 + *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v1, (0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::fish_size(v7) as u64)), (0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::fish_rarity(v7) as u64));
                    v6 = v6 + 1;
                };
                let v8 = (((*0x1::vector::borrow<u8>(&v0, (0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_rarity(v4) as u64)) + (0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_level(v4) as u8)) as u64) + v5) / 2;
                let v9 = 0x2::random::new_generator(arg1, arg4);
                let v10 = 0x2::random::generate_u64_in_range(&mut v9, 0, 10000 - 1);
                let v11 = 0x2::random::generate_u8_in_range(&mut v9, 1, 20);
                let v12 = 0x2::random::generate_u8_in_range(&mut v9, 1, 20);
                let v13 = 0x2::random::generate_u8_in_range(&mut v9, 1, 20);
                let v14 = 0x1::vector::empty<u64>();
                let v15 = &mut v14;
                0x1::vector::push_back<u64>(v15, (v11 as u64));
                0x1::vector::push_back<u64>(v15, (v12 as u64));
                0x1::vector::push_back<u64>(v15, (v13 as u64));
                let v16 = ExplorationLoot{
                    id                              : 0x2::object::new(arg4),
                    has_reward                      : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::arithmetic_is_less_than_u16((0x2::random::generate_u8_in_range(&mut v9, 1, 100) as u16), (v8 as u16), 100),
                    submarine_level                 : arg0.level,
                    pearl_amount_r_v                : v10,
                    upgrade_materials_reward_counts : v14,
                };
                0x2::transfer::transfer<ExplorationLoot>(v16, 0x2::tx_context::sender(arg4));
                let v17 = 0x1::vector::empty<u64>();
                let v18 = &mut v17;
                0x1::vector::push_back<u64>(v18, (v11 as u64));
                0x1::vector::push_back<u64>(v18, (v12 as u64));
                0x1::vector::push_back<u64>(v18, (v13 as u64));
                let v19 = FinishExplorationEvent{
                    submarine_id                    : 0x2::object::id<Submarine>(arg0),
                    total_probability               : v8,
                    pearl_amount_r_v                : v10,
                    team_index                      : (v2 as u64),
                    upgrade_materials_reward_counts : v17,
                };
                0x2::event::emit<FinishExplorationEvent>(v19);
            };
            v2 = v2 + 1;
        };
        arg0.is_exploring = false;
        arg0.exploration_end_time = 0;
        arg0.exploration_total_times = arg0.exploration_total_times + 1;
    }

    public fun open_exploration_loot(arg0: &mut Submarine, arg1: ExplorationLoot, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PearlTokenTreasuryCap, arg3: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 13);
        let ExplorationLoot {
            id                              : v0,
            has_reward                      : v1,
            submarine_level                 : v2,
            pearl_amount_r_v                : v3,
            upgrade_materials_reward_counts : v4,
        } = arg1;
        let v5 = v4;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.upgrade_materials_bag, v6) = *0x1::vector::borrow<u64>(&arg0.upgrade_materials_bag, v6) + *0x1::vector::borrow<u64>(&v5, v6);
            v6 = v6 + 1;
        };
        let v7 = 0;
        if (v1 == 1) {
            if (v2 <= 11) {
                let v8 = vector[10000, 9500, 9000, 8800, 8500, 8200, 8000, 7700, 7500, 7200, 7000];
                if (v3 < 10000 - *0x1::vector::borrow<u64>(&v8, v2 - 1)) {
                    let v9 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v9, 3);
                } else {
                    let v10 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v10, 4);
                };
            } else if (v2 <= 21) {
                let v11 = vector[6950, 6900, 6800, 6700, 6600, 6500, 6400, 6300, 6200, 6100];
                let v12 = 3000;
                let v13 = 10000 - *0x1::vector::borrow<u64>(&v11, v2 - 1 - 11) - v12;
                if (v3 < v13) {
                    let v14 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v14, 2);
                } else if (v3 < v13 + v12) {
                    let v15 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v15, 3);
                } else {
                    let v16 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v16, 4);
                };
            } else if (v2 <= 31) {
                let v17 = vector[6050, 6020, 6000, 5980, 5950, 5920, 5900, 5870, 5850, 5820, 5800];
                let v18 = 3000;
                let v19 = 900;
                let v20 = 10000 - *0x1::vector::borrow<u64>(&v17, v2 - 1 - 21) - v18 - v19;
                if (v3 < v20) {
                    let v21 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v21, 1);
                } else if (v3 < v20 + v19) {
                    let v22 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v22, 2);
                } else if (v3 < v20 + v19 + v18) {
                    let v23 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v23, 3);
                } else {
                    let v24 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v24, 4);
                };
            } else {
                let v25 = vector[5819, 5818, 5817, 5816, 5815, 5814, 5813, 5812, 5811, 5810, 5809, 5808, 5807, 5806, 5805, 5804, 5803, 5802, 5800];
                let v26 = 3000;
                let v27 = 900;
                let v28 = 280;
                let v29 = 10000 - *0x1::vector::borrow<u64>(&v25, v2 - 1 - 31) - v26 - v27 - v28;
                if (v3 < v29) {
                    let v30 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v30, 0);
                } else if (v3 < v29 + v28) {
                    let v31 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v31, 1);
                } else if (v3 < v29 + v28 + v27) {
                    let v32 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v32, 2);
                } else if (v3 < v29 + v28 + v27 + v26) {
                    let v33 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v33, 3);
                } else {
                    let v34 = vector[10000000000, 1500000000, 160000000, 60000000, 40000000];
                    v7 = *0x1::vector::borrow<u64>(&v34, 4);
                };
            };
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::mint_pearl_token(arg2, v7, 0x2::tx_context::sender(arg4), 0, arg4);
        };
        let v35 = OpenExplorationLootEvent{
            submarine_id                    : 0x2::object::id<Submarine>(arg0),
            pearl_token_reward              : v7,
            upgrade_materials_reward_counts : v5,
        };
        0x2::event::emit<OpenExplorationLootEvent>(v35);
        0x2::object::delete(v0);
    }

    public fun purchase_submarine(arg0: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg1: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PEARL_TOKEN>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg7: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PearlTokenTreasuryCap, arg8: &mut SubmarineRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg0) == 10000000000, 0);
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PEARL_TOKEN>(&arg1) == 500000000, 0);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::user_address(arg2) == 0x2::tx_context::sender(arg10), 13);
        abort 19
    }

    public fun purchase_submarine_v2(arg0: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg1: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PEARL_TOKEN>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg7: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PearlTokenTreasuryCap, arg8: &mut SubmarineRegistryV2, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg0) == 10000000000, 0);
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PEARL_TOKEN>(&arg1) == 500000000, 0);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::user_address(arg2) == 0x2::tx_context::sender(arg10), 13);
        assert!(!0x2::table::contains<address, bool>(&arg8.purchased_users, 0x2::tx_context::sender(arg10)), 14);
        0x2::table::add<address, bool>(&mut arg8.purchased_users, 0x2::tx_context::sender(arg10), true);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::burn_pearl_token(arg7, arg1, 0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg5, arg0, arg6, arg4, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_purchase_submarine(), arg9, arg10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg2, 10000000000, arg3);
        let v0 = Team{
            diver  : 0x1::option::none<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(),
            fishes : 0x1::vector::empty<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(),
        };
        let v1 = 0x1::vector::empty<Team>();
        0x1::vector::push_back<Team>(&mut v1, v0);
        let v2 = Submarine{
            id                      : 0x2::object::new(arg10),
            level                   : 1,
            owner                   : 0x2::tx_context::sender(arg10),
            upgrade_materials_bag   : vector[0, 0, 0],
            team_slots              : v1,
            is_exploring            : false,
            exploration_end_time    : 0,
            exploration_total_times : 0,
        };
        0x2::transfer::transfer<Submarine>(v2, 0x2::tx_context::sender(arg10));
        let v3 = PurchaseSubmarineEvent{submarine_id: 0x2::object::id<Submarine>(&v2)};
        0x2::event::emit<PurchaseSubmarineEvent>(v3);
    }

    fun submarine_team_slots_count(arg0: u64) : u64 {
        assert!(arg0 > 0 && arg0 <= 50, 15);
        if (arg0 <= 20) {
            (arg0 + 4) / 5
        } else if (arg0 <= 40) {
            if (arg0 <= 23) {
                5
            } else if (arg0 <= 27) {
                6
            } else if (arg0 <= 30) {
                7
            } else if (arg0 <= 33) {
                8
            } else if (arg0 <= 37) {
                9
            } else {
                10
            }
        } else {
            arg0 - 30
        }
    }

    public fun team_add_diver(arg0: &mut Submarine, arg1: u64, arg2: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 13);
        assert!(!arg0.is_exploring, 12);
        assert!(arg1 < 0x1::vector::length<Team>(&arg0.team_slots), 17);
        let v0 = 0x1::vector::borrow_mut<Team>(&mut arg0.team_slots, arg1);
        assert!(0x1::option::is_none<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&v0.diver), 4);
        0x1::option::fill<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&mut v0.diver, arg2);
    }

    public fun team_add_fish(arg0: &mut Submarine, arg1: u64, arg2: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        assert!(!arg0.is_exploring, 12);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 13);
        assert!(arg1 < 0x1::vector::length<Team>(&arg0.team_slots), 17);
        let v0 = 0x1::vector::borrow_mut<Team>(&mut arg0.team_slots, arg1);
        assert!(0x1::option::is_some<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&v0.diver), 6);
        assert!(0x1::vector::length<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&v0.fishes) < team_fish_slot(v0), 5);
        0x1::vector::push_back<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&mut v0.fishes, arg2);
    }

    fun team_fish_slot(arg0: &Team) : u64 {
        if (0x1::option::is_none<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&arg0.diver)) {
            return 0
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_duration_ms(0x1::option::borrow<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&arg0.diver)) / 1000 / 60 / 10
    }

    public fun team_remove_diver(arg0: &mut Submarine, arg1: u64, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x2::tx_context::TxContext) : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        assert!(!arg0.is_exploring, 12);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 13);
        assert!(arg1 < 0x1::vector::length<Team>(&arg0.team_slots), 17);
        let v0 = 0x1::vector::borrow_mut<Team>(&mut arg0.team_slots, arg1);
        assert!(0x1::option::is_some<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&v0.diver), 6);
        assert!(0x1::vector::length<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&v0.fishes) == 0, 11);
        0x1::option::extract<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&mut v0.diver)
    }

    public fun team_remove_fish(arg0: &mut Submarine, arg1: u64, arg2: 0x2::object::ID, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x2::tx_context::TxContext) : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 13);
        assert!(!arg0.is_exploring, 12);
        assert!(arg1 < 0x1::vector::length<Team>(&arg0.team_slots), 17);
        let v0 = &mut 0x1::vector::borrow_mut<Team>(&mut arg0.team_slots, arg1).fishes;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(v0)) {
            if (0x2::object::id<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(0x1::vector::borrow<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(v0, v1)) == arg2) {
                return 0x1::vector::remove<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(v0, v1)
            };
            v1 = v1 + 1;
        };
        abort 7
    }

    public fun upgrade_submarine(arg0: &mut Submarine, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg2: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg3: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PEARL_TOKEN>, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PearlTokenTreasuryCap, arg7: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg8: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg8);
        assert!(!arg0.is_exploring, 12);
        assert!(arg0.level < 50, 1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg10), 13);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::user_address(arg1) == 0x2::tx_context::sender(arg10), 13);
        let (v0, v1, v2, v3, v4) = calc_upgrade_cost(arg0.level);
        let v5 = 0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg2);
        assert!(v5 == v0, 0);
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::PEARL_TOKEN>(&arg3) == v1, 0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::pearl_token::burn_pearl_token(arg6, arg3, 1);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg4, arg2, arg5, arg8, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_upgrade_submarine(), arg9, arg10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg1, v5, arg7);
        let v6 = &mut arg0.upgrade_materials_bag;
        assert!(0x1::vector::length<u64>(v6) == 3, 18);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = &mut v7;
        0x1::vector::push_back<u64>(v8, v2);
        0x1::vector::push_back<u64>(v8, v3);
        0x1::vector::push_back<u64>(v8, v4);
        let v9 = 0;
        while (v9 < 3) {
            let v10 = 0x1::vector::borrow_mut<u64>(v6, v9);
            let v11 = *0x1::vector::borrow<u64>(&v7, v9);
            assert!(*v10 >= v11, 3);
            *v10 = *v10 - v11;
            v9 = v9 + 1;
        };
        arg0.level = arg0.level + 1;
        assert!(arg0.level <= 50, 1);
        while (0x1::vector::length<Team>(&arg0.team_slots) < submarine_team_slots_count(arg0.level)) {
            let v12 = Team{
                diver  : 0x1::option::none<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(),
                fishes : 0x1::vector::empty<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(),
            };
            0x1::vector::push_back<Team>(&mut arg0.team_slots, v12);
        };
        let v13 = UpgradeSubmarineEvent{
            submarine_id            : 0x2::object::id<Submarine>(arg0),
            level_before            : arg0.level,
            dive_token_cost         : v0,
            pearl_token_cost        : v1,
            upgrade_materials_costs : v7,
        };
        0x2::event::emit<UpgradeSubmarineEvent>(v13);
    }

    // decompiled from Move bytecode v6
}

