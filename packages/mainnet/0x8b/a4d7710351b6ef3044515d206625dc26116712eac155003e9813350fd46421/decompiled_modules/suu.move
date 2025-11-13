module 0x8ba4d7710351b6ef3044515d206625dc26116712eac155003e9813350fd46421::suu {
    struct GameConfig has copy, drop, store {
        min_golden_monster_reward: u64,
        max_golden_monster_reward: u64,
        golden_monster_base_prob: u64,
        golden_monster_max_prob: u64,
    }

    struct EnemyInfo has copy, drop, store {
        name: vector<u8>,
        level: u8,
        element: u8,
        monster_type: u8,
        is_golden_monster: bool,
        generated_at: u64,
    }

    struct HealthNFT has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: vector<u8>,
        element: u8,
        monster_type: u8,
        level: u8,
        experience: u64,
        mint_time: u64,
        defeated_golden_monster: bool,
        current_enemy: 0x1::option::Option<EnemyInfo>,
        last_enemy_generated_at: u64,
        is_listed: bool,
        has_active_commitment: bool,
    }

    struct NFTGameContract has store, key {
        id: 0x2::object::UID,
        banker: address,
        locked_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        withdrawable_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        nft_table: 0x2::object_table::ObjectTable<u64, HealthNFT>,
        total_minted: u64,
        nft_counter: u64,
        config: GameConfig,
        listing_table: 0x2::table::Table<u64, ListingInfo>,
        listed_ids: vector<u64>,
        id_to_index: 0x2::table::Table<u64, u64>,
        owner_to_ids: 0x2::table::Table<address, vector<u64>>,
        active_nft: 0x2::table::Table<address, u64>,
        trade_counter: u64,
        trade_table: 0x2::table::Table<u64, TradeRecord>,
        trade_ids: vector<u64>,
        seller_to_trades: 0x2::table::Table<address, vector<u64>>,
        buyer_to_trades: 0x2::table::Table<address, vector<u64>>,
        nft_to_trades: 0x2::table::Table<u64, vector<u64>>,
        battle_commitment_table: 0x2::object_table::ObjectTable<u64, BattleCommitment>,
        battle_commitment_counter: u64,
        battle_commit_addr_to_id: 0x2::table::Table<address, u64>,
        capture_commitment_table: 0x2::object_table::ObjectTable<u64, CaptureCommitment>,
        capture_commitment_counter: u64,
        capture_commit_addr_to_id: 0x2::table::Table<address, u64>,
    }

    struct ListingInfo has copy, drop, store {
        seller: address,
        price: u64,
        listed_at: u64,
    }

    struct ListingCreatedEvent has copy, drop {
        nft_id: u64,
        seller: address,
        price: u64,
        timestamp: u64,
    }

    struct ListingCancelledEvent has copy, drop {
        nft_id: u64,
        seller: address,
        timestamp: u64,
    }

    struct ListingPurchasedEvent has copy, drop {
        nft_id: u64,
        seller: address,
        buyer: address,
        price: u64,
        fee: u64,
        seller_amount: u64,
        timestamp: u64,
    }

    struct TradeRecord has copy, drop, store {
        trade_id: u64,
        nft_id: u64,
        seller: address,
        buyer: address,
        price: u64,
        fee: u64,
        seller_amount: u64,
        timestamp: u64,
    }

    struct NFTMintedEvent has copy, drop {
        nft_id: u64,
        owner: address,
        element: u8,
        monster_type: u8,
        level: u8,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        banker: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        banker: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct BattleCommitment has store, key {
        id: 0x2::object::UID,
        player: address,
        nft_id: u64,
        commitment_hash: vector<u8>,
        enemy_info: EnemyInfo,
        player_level: u8,
        player_element: u8,
        committed_at: u64,
        is_revealed: bool,
        golden_min_reward_snapshot: u64,
        golden_max_reward_snapshot: u64,
    }

    struct CaptureCommitment has store, key {
        id: 0x2::object::UID,
        player: address,
        nft_id: u64,
        commitment_hash: vector<u8>,
        enemy_info: EnemyInfo,
        player_level: u8,
        player_element: u8,
        player_monster_type: u8,
        committed_at: u64,
        is_revealed: bool,
    }

    struct BattleEvent has copy, drop {
        nft_id: u64,
        player: address,
        is_golden_monster: bool,
        enemy_level: u8,
        enemy_element: u8,
        player_level: u8,
        player_element: u8,
        is_win: bool,
        experience_gained: u64,
        level_increased: bool,
        reward_amount: u64,
        timestamp: u64,
    }

    struct BattleCommitmentCreatedEvent has copy, drop {
        commitment_id: address,
        player: address,
        nft_id: u64,
        timestamp: u64,
    }

    struct CaptureCommitmentCreatedEvent has copy, drop {
        commitment_id: address,
        player: address,
        nft_id: u64,
        timestamp: u64,
    }

    struct CaptureAttemptEvent has copy, drop {
        player: address,
        source_nft_id: u64,
        captured_nft_id: 0x1::option::Option<u64>,
        is_success: bool,
        capture_probability: u64,
        timestamp: u64,
    }

    fun add_experience(arg0: u64, arg1: u8, arg2: u64) : (u64, u8, bool) {
        let v0 = arg0 + arg2;
        if (arg2 >= 100) {
            let v4 = if (arg1 < 10) {
                arg1 + 1
            } else {
                10
            };
            (0, v4, true)
        } else if (v0 >= 100) {
            let v5 = if (arg1 < 10) {
                arg1 + 1
            } else {
                10
            };
            (0, v5, true)
        } else {
            (v0, arg1, false)
        }
    }

    fun add_nft_to_owner_index(arg0: &mut NFTGameContract, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, vector<u64>>(&arg0.owner_to_ids, arg1)) {
            0x2::table::add<address, vector<u64>>(&mut arg0.owner_to_ids, arg1, 0x1::vector::empty<u64>());
        };
        0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.owner_to_ids, arg1), arg2);
    }

    fun append_u64_vec_in_table<T0: copy + drop + store>(arg0: &mut 0x2::table::Table<T0, vector<u64>>, arg1: T0, arg2: u64) {
        if (!0x2::table::contains<T0, vector<u64>>(arg0, arg1)) {
            0x2::table::add<T0, vector<u64>>(arg0, arg1, 0x1::vector::empty<u64>());
        };
        0x1::vector::push_back<u64>(0x2::table::borrow_mut<T0, vector<u64>>(arg0, arg1), arg2);
    }

    fun assign_new_enemy(arg0: &mut HealthNFT, arg1: u8, arg2: bool, arg3: &mut 0x2::random::RandomGenerator, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: bool) {
        let v0 = if (arg5 && arg0.level < 10) {
            let v1 = if (arg2) {
                2
            } else {
                1
            };
            0x2::random::generate_u64(arg3) % 10000 < get_golden_monster_probability_from_values(arg0.level, arg6, arg7) * v1
        } else {
            false
        };
        let v2 = generate_monster_type(arg3, arg0.level);
        if (v0) {
            let v3 = EnemyInfo{
                name              : 0x8ba4d7710351b6ef3044515d206625dc26116712eac155003e9813350fd46421::name::generate_full_name(arg3),
                level             : 0,
                element           : 0,
                monster_type      : v2,
                is_golden_monster : true,
                generated_at      : arg4,
            };
            arg0.current_enemy = 0x1::option::some<EnemyInfo>(v3);
        } else {
            let v4 = (arg0.level as u64);
            let v5 = if (v4 > 1) {
                v4 - 1
            } else {
                1
            };
            let v6 = if (v4 > 2) {
                v4 - 2
            } else {
                1
            };
            let v7 = v4 + 1;
            let v8 = if (v7 > (10 as u64)) {
                (10 as u64)
            } else {
                v7
            };
            let v9 = v4 + 2;
            let v10 = if (v9 > (10 as u64)) {
                (10 as u64)
            } else {
                v9
            };
            let v11 = if (v5 == v4) {
                25
            } else {
                0
            };
            let v12 = if (v6 == v4) {
                10
            } else {
                0
            };
            let v13 = if (v8 == v4) {
                10
            } else {
                0
            };
            let v14 = if (v10 == v4) {
                5
            } else {
                0
            };
            let v15 = 50 + v11 + v12 + v13 + v14;
            let v16 = if (v5 == v4) {
                0
            } else {
                25
            };
            let v17 = if (v6 == v5) {
                10
            } else {
                0
            };
            let v18 = if (v8 == v5) {
                10
            } else {
                0
            };
            let v19 = if (v10 == v5) {
                5
            } else {
                0
            };
            let v20 = v16 + v17 + v18 + v19;
            let v21 = if (v6 == v4) {
                0
            } else if (v6 == v5) {
                0
            } else {
                10
            };
            let v22 = if (v8 == v6) {
                10
            } else {
                0
            };
            let v23 = if (v10 == v6) {
                5
            } else {
                0
            };
            let v24 = v21 + v22 + v23;
            let v25 = if (v8 == v4) {
                0
            } else if (v8 == v5) {
                0
            } else if (v8 == v6) {
                0
            } else {
                10
            };
            let v26 = if (v10 == v8) {
                5
            } else {
                0
            };
            let v27 = v25 + v26;
            let v28 = if (v10 == v4) {
                0
            } else if (v10 == v5) {
                0
            } else if (v10 == v6) {
                0
            } else if (v10 == v8) {
                0
            } else {
                5
            };
            let v29 = 0x2::random::generate_u64(arg3) % (v15 + v20 + v24 + v27 + v28);
            let v30 = if (v29 < v15) {
                v4
            } else if (v29 < v15 + v20) {
                v5
            } else if (v29 < v15 + v20 + v24) {
                v6
            } else if (v29 < v15 + v20 + v24 + v27) {
                v8
            } else {
                v10
            };
            let v31 = EnemyInfo{
                name              : 0x8ba4d7710351b6ef3044515d206625dc26116712eac155003e9813350fd46421::name::generate_full_name(arg3),
                level             : (v30 as u8),
                element           : select_element_by_linear_probability(arg4, 0x2::random::generate_u64(arg3)),
                monster_type      : v2,
                is_golden_monster : false,
                generated_at      : arg4,
            };
            arg0.current_enemy = 0x1::option::some<EnemyInfo>(v31);
        };
        if (arg8) {
            arg0.last_enemy_generated_at = arg4;
        };
    }

    public entry fun battle_commit(arg0: &mut NFTGameContract, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg1);
        assert!(v2.owner == v0, 105);
        assert!(!v2.is_listed, 200);
        assert!(0x1::option::is_some<EnemyInfo>(&v2.current_enemy), 108);
        let v3 = *0x1::option::borrow<EnemyInfo>(&v2.current_enemy);
        if (v3.is_golden_monster) {
            assert!(v1 - v3.generated_at <= 600000, 206);
        };
        assert!(0x1::vector::length<u8>(&arg2) == 32, 110);
        let v4 = v2.element;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance);
        let v6 = if (v3.is_golden_monster) {
            if (v5 <= 1000000000) {
                10000000
            } else {
                v5 * 100 / 10000
            }
        } else {
            0
        };
        let v7 = if (v3.is_golden_monster) {
            if (v5 <= 1000000000) {
                100000000
            } else {
                v5 * 5000 / 10000
            }
        } else {
            0
        };
        let v8 = 0x2::object::new(arg4);
        let v9 = 0x2::object::uid_to_address(&v8);
        let v10 = BattleCommitment{
            id                         : v8,
            player                     : v0,
            nft_id                     : arg1,
            commitment_hash            : arg2,
            enemy_info                 : v3,
            player_level               : v2.level,
            player_element             : v4,
            committed_at               : v1,
            is_revealed                : false,
            golden_min_reward_snapshot : v6,
            golden_max_reward_snapshot : v7,
        };
        let v11 = arg0.battle_commitment_counter + 1;
        arg0.battle_commitment_counter = v11;
        0x2::object_table::add<u64, BattleCommitment>(&mut arg0.battle_commitment_table, v11, v10);
        0x2::table::add<address, u64>(&mut arg0.battle_commit_addr_to_id, v9, v11);
        v2.has_active_commitment = true;
        let v12 = BattleCommitmentCreatedEvent{
            commitment_id : v9,
            player        : v0,
            nft_id        : arg1,
            timestamp     : v1,
        };
        0x2::event::emit<BattleCommitmentCreatedEvent>(v12);
    }

    public entry fun battle_reveal(arg0: &mut NFTGameContract, arg1: &mut BattleCommitment, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.player == 0x2::tx_context::sender(arg8), 113);
        assert!(!arg1.is_revealed, 111);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= arg1.committed_at + calculate_battle_reveal_delay(arg1.player_level), 112);
        assert!(arg2 == arg1.nft_id, 110);
        assert!(arg3 == arg1.enemy_info.level, 110);
        assert!(arg4 == arg1.enemy_info.element, 110);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 8) {
            0x1::vector::push_back<u8>(&mut v1, ((arg2 >> v2 * 8 & 255) as u8));
            v2 = v2 + 1;
        };
        0x1::vector::push_back<u8>(&mut v1, arg3);
        0x1::vector::push_back<u8>(&mut v1, arg4);
        0x1::vector::append<u8>(&mut v1, arg5);
        assert!(0x2::hash::keccak256(&v1) == arg1.commitment_hash, 110);
        assert!(!0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg2).is_listed, 200);
        if (arg1.enemy_info.is_golden_monster) {
            let v3 = 0x2::random::new_generator(arg6, arg8);
            let v4 = &mut v3;
            battle_with_golden_monster(arg0, arg2, arg1.player, arg1.player_level, arg1.player_element, v4, arg7, arg8, arg1.golden_min_reward_snapshot, arg1.golden_max_reward_snapshot);
        } else {
            let v5 = 0x2::random::new_generator(arg6, arg8);
            let v6 = &mut v5;
            let (v7, v8, _) = perform_battle(arg1.player_level, arg1.player_element, arg1.enemy_info.level, arg1.enemy_info.element, v6);
            if (v7) {
                let v10 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
                let (v11, v12, v13) = add_experience(v10.experience, v10.level, v8);
                v10.experience = v11;
                v10.level = v12;
                let v14 = BattleEvent{
                    nft_id            : arg2,
                    player            : arg1.player,
                    is_golden_monster : false,
                    enemy_level       : arg1.enemy_info.level,
                    enemy_element     : arg1.enemy_info.element,
                    player_level      : v10.level,
                    player_element    : v10.element,
                    is_win            : true,
                    experience_gained : v8,
                    level_increased   : v13,
                    reward_amount     : 0,
                    timestamp         : v0,
                };
                0x2::event::emit<BattleEvent>(v14);
                let v15 = get_season_element_by_solar_terms(v0);
                let v16 = is_element_counter_season(v10.element, v15);
                let v17 = !v10.defeated_golden_monster && 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) > 1000000000;
                let v18 = &mut v5;
                assign_new_enemy(v10, v15, v16, v18, v0, v17, arg0.config.golden_monster_base_prob, arg0.config.golden_monster_max_prob, false);
            } else {
                0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2).current_enemy = 0x1::option::none<EnemyInfo>();
                let v19 = BattleEvent{
                    nft_id            : arg2,
                    player            : arg1.player,
                    is_golden_monster : false,
                    enemy_level       : arg1.enemy_info.level,
                    enemy_element     : arg1.enemy_info.element,
                    player_level      : arg1.player_level,
                    player_element    : arg1.player_element,
                    is_win            : false,
                    experience_gained : 0,
                    level_increased   : false,
                    reward_amount     : 0,
                    timestamp         : v0,
                };
                0x2::event::emit<BattleEvent>(v19);
            };
        };
        arg1.is_revealed = true;
        0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2).has_active_commitment = false;
    }

    public entry fun battle_reveal_by_address(arg0: &mut NFTGameContract, arg1: address, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<address, u64>(&arg0.battle_commit_addr_to_id, arg1);
        battle_reveal_by_id(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::table::remove<address, u64>(&mut arg0.battle_commit_addr_to_id, arg1);
    }

    public entry fun battle_reveal_by_id(arg0: &mut NFTGameContract, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow<u64, BattleCommitment>(&arg0.battle_commitment_table, arg1);
        assert!(v0.player == 0x2::tx_context::sender(arg8), 113);
        assert!(!v0.is_revealed, 111);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(v1 >= v0.committed_at + calculate_battle_reveal_delay(v0.player_level), 112);
        assert!(arg2 == v0.nft_id, 110);
        assert!(arg3 == v0.enemy_info.level, 110);
        assert!(arg4 == v0.enemy_info.element, 110);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 8) {
            0x1::vector::push_back<u8>(&mut v2, ((arg2 >> v3 * 8 & 255) as u8));
            v3 = v3 + 1;
        };
        0x1::vector::push_back<u8>(&mut v2, arg3);
        0x1::vector::push_back<u8>(&mut v2, arg4);
        0x1::vector::append<u8>(&mut v2, arg5);
        assert!(0x2::hash::keccak256(&v2) == v0.commitment_hash, 110);
        assert!(!0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg2).is_listed, 200);
        if (v0.enemy_info.is_golden_monster) {
            let v4 = 0x2::random::new_generator(arg6, arg8);
            let v5 = &mut v4;
            battle_with_golden_monster(arg0, arg2, v0.player, v0.player_level, v0.player_element, v5, arg7, arg8, v0.golden_min_reward_snapshot, v0.golden_max_reward_snapshot);
        } else {
            let v6 = 0x2::random::new_generator(arg6, arg8);
            let v7 = &mut v6;
            let (v8, v9, _) = perform_battle(v0.player_level, v0.player_element, v0.enemy_info.level, v0.enemy_info.element, v7);
            if (v8) {
                let v11 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
                let (v12, v13, v14) = add_experience(v11.experience, v11.level, v9);
                v11.experience = v12;
                v11.level = v13;
                let v15 = BattleEvent{
                    nft_id            : arg2,
                    player            : v0.player,
                    is_golden_monster : false,
                    enemy_level       : v0.enemy_info.level,
                    enemy_element     : v0.enemy_info.element,
                    player_level      : v11.level,
                    player_element    : v11.element,
                    is_win            : true,
                    experience_gained : v9,
                    level_increased   : v14,
                    reward_amount     : 0,
                    timestamp         : v1,
                };
                0x2::event::emit<BattleEvent>(v15);
                let v16 = get_season_element_by_solar_terms(v1);
                let v17 = is_element_counter_season(v11.element, v16);
                let v18 = !v11.defeated_golden_monster && 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) > 1000000000;
                let v19 = &mut v6;
                assign_new_enemy(v11, v16, v17, v19, v1, v18, arg0.config.golden_monster_base_prob, arg0.config.golden_monster_max_prob, false);
            } else {
                0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2).current_enemy = 0x1::option::none<EnemyInfo>();
                let v20 = BattleEvent{
                    nft_id            : arg2,
                    player            : v0.player,
                    is_golden_monster : false,
                    enemy_level       : v0.enemy_info.level,
                    enemy_element     : v0.enemy_info.element,
                    player_level      : v0.player_level,
                    player_element    : v0.player_element,
                    is_win            : false,
                    experience_gained : 0,
                    level_increased   : false,
                    reward_amount     : 0,
                    timestamp         : v1,
                };
                0x2::event::emit<BattleEvent>(v20);
            };
        };
        0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2).has_active_commitment = false;
        let BattleCommitment {
            id                         : v21,
            player                     : _,
            nft_id                     : _,
            commitment_hash            : _,
            enemy_info                 : _,
            player_level               : _,
            player_element             : _,
            committed_at               : _,
            is_revealed                : _,
            golden_min_reward_snapshot : _,
            golden_max_reward_snapshot : _,
        } = 0x2::object_table::remove<u64, BattleCommitment>(&mut arg0.battle_commitment_table, arg1);
        0x2::object::delete(v21);
    }

    fun battle_with_golden_monster(arg0: &mut NFTGameContract, arg1: u64, arg2: address, arg3: u8, arg4: u8, arg5: &mut 0x2::random::RandomGenerator, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext, arg8: u64, arg9: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (0x2::random::generate_u64(arg5) % 100 < get_golden_monster_win_prob(arg4)) {
            let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance);
            let v2 = if (v1 <= 1000000000) {
                10000000
            } else {
                v1 * 100 / 10000
            };
            let v3 = if (v1 <= 1000000000) {
                100000000
            } else {
                v1 * 5000 / 10000
            };
            let v4 = if (v3 <= v1) {
                v3
            } else {
                v1
            };
            let v5 = if (v2 <= v4) {
                v2
            } else {
                v4
            };
            let v6 = arg9 > v4;
            let v7 = if (v6) {
                v5
            } else {
                arg8
            };
            let v8 = if (v6) {
                v4
            } else {
                arg9
            };
            let v9 = if (v8 <= v1) {
                v8
            } else {
                v1
            };
            let v10 = if (v7 <= v9) {
                v7
            } else {
                v9
            };
            let v11 = v10 + 0x2::random::generate_u64(arg5) % (v9 - v10 + 1);
            assert!(v1 >= v11, 107);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.locked_balance, v11), arg7), arg2);
            let v12 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg1);
            v12.defeated_golden_monster = true;
            let v13 = BattleEvent{
                nft_id            : arg1,
                player            : arg2,
                is_golden_monster : true,
                enemy_level       : 0,
                enemy_element     : 0,
                player_level      : arg3,
                player_element    : arg4,
                is_win            : true,
                experience_gained : 0,
                level_increased   : false,
                reward_amount     : v11,
                timestamp         : v0,
            };
            0x2::event::emit<BattleEvent>(v13);
            let v14 = get_season_element_by_solar_terms(v0);
            let v15 = is_element_counter_season(v12.element, v14);
            assign_new_enemy(v12, v14, v15, arg5, v0, false, arg0.config.golden_monster_base_prob, arg0.config.golden_monster_max_prob, false);
        } else {
            0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg1).current_enemy = 0x1::option::none<EnemyInfo>();
            let v16 = BattleEvent{
                nft_id            : arg1,
                player            : arg2,
                is_golden_monster : true,
                enemy_level       : 0,
                enemy_element     : 0,
                player_level      : arg3,
                player_element    : arg4,
                is_win            : false,
                experience_gained : 0,
                level_increased   : false,
                reward_amount     : 0,
                timestamp         : v0,
            };
            0x2::event::emit<BattleEvent>(v16);
        };
    }

    public entry fun buy_listed_nft(arg0: &mut NFTGameContract, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow<u64, ListingInfo>(&arg0.listing_table, arg1);
        let v2 = v1.price;
        let v3 = v1.seller;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v2, 101);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v5 = v2 * 500 / 10000;
        let v6 = v2 - v5;
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut v4, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v5 * 9900 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.withdrawable_balance, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg4), v3);
        let v8 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg1);
        assert!(v8.is_listed, 201);
        v8.owner = v0;
        v8.defeated_golden_monster = false;
        v8.level = 3;
        v8.experience = 0;
        v8.current_enemy = 0x1::option::none<EnemyInfo>();
        v8.last_enemy_generated_at = 0;
        v8.is_listed = false;
        v8.has_active_commitment = false;
        remove_nft_from_owner_index(arg0, v3, arg1);
        add_nft_to_owner_index(arg0, v0, arg1);
        if (!0x2::table::contains<address, u64>(&arg0.active_nft, v0)) {
            0x2::table::add<address, u64>(&mut arg0.active_nft, v0, arg1);
        };
        let v9 = *0x2::table::borrow<u64, u64>(&arg0.id_to_index, arg1);
        let v10 = 0x1::vector::length<u64>(&arg0.listed_ids) - 1;
        if (v9 != v10) {
            0x1::vector::swap<u64>(&mut arg0.listed_ids, v9, v10);
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.id_to_index, *0x1::vector::borrow<u64>(&arg0.listed_ids, v10)) = v9;
        };
        0x1::vector::pop_back<u64>(&mut arg0.listed_ids);
        0x2::table::remove<u64, u64>(&mut arg0.id_to_index, arg1);
        0x2::table::remove<u64, ListingInfo>(&mut arg0.listing_table, arg1);
        let v11 = ListingPurchasedEvent{
            nft_id        : arg1,
            seller        : v3,
            buyer         : v0,
            price         : v2,
            fee           : v5,
            seller_amount : v6,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ListingPurchasedEvent>(v11);
        let v12 = arg0.trade_counter + 1;
        arg0.trade_counter = v12;
        let v13 = TradeRecord{
            trade_id      : v12,
            nft_id        : arg1,
            seller        : v3,
            buyer         : v0,
            price         : v2,
            fee           : v5,
            seller_amount : v6,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<u64, TradeRecord>(&mut arg0.trade_table, v12, v13);
        0x1::vector::push_back<u64>(&mut arg0.trade_ids, v12);
        let v14 = &mut arg0.seller_to_trades;
        append_u64_vec_in_table<address>(v14, v3, v12);
        let v15 = &mut arg0.buyer_to_trades;
        append_u64_vec_in_table<address>(v15, v0, v12);
        let v16 = &mut arg0.nft_to_trades;
        append_u64_vec_in_table<u64>(v16, arg1, v12);
    }

    public entry fun buy_nft(arg0: &mut NFTGameContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 101);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::random::new_generator(arg2, arg4);
        let v2 = select_element_by_linear_probability(v0, 0x2::random::generate_u64(&mut v1));
        let v3 = 3;
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = arg0.nft_counter + 1;
        arg0.nft_counter = v5;
        let v6 = HealthNFT{
            id                      : 0x2::object::new(arg4),
            owner                   : v4,
            name                    : 0x8ba4d7710351b6ef3044515d206625dc26116712eac155003e9813350fd46421::name::generate_full_name(&mut v1),
            element                 : v2,
            monster_type            : 0,
            level                   : v3,
            experience              : 0,
            mint_time               : v0,
            defeated_golden_monster : false,
            current_enemy           : 0x1::option::none<EnemyInfo>(),
            last_enemy_generated_at : 0,
            is_listed               : false,
            has_active_commitment   : false,
        };
        0x2::object_table::add<u64, HealthNFT>(&mut arg0.nft_table, v5, v6);
        add_nft_to_owner_index(arg0, v4, v5);
        if (!0x2::table::contains<address, u64>(&arg0.active_nft, v4)) {
            0x2::table::add<address, u64>(&mut arg0.active_nft, v4, v5);
        };
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v7, 1000000000 * 9900 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.withdrawable_balance, v7);
        arg0.total_minted = arg0.total_minted + 1;
        let v8 = NFTMintedEvent{
            nft_id       : v5,
            owner        : v4,
            element      : v2,
            monster_type : 0,
            level        : v3,
            timestamp    : v0,
        };
        0x2::event::emit<NFTMintedEvent>(v8);
        let v9 = get_season_element_by_solar_terms(v0);
        let v10 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, v5);
        let v11 = &mut v1;
        assign_new_enemy(v10, v9, is_element_counter_season(v2, v9), v11, v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) > 1000000000, arg0.config.golden_monster_base_prob, arg0.config.golden_monster_max_prob, true);
    }

    fun calculate_battle_reveal_delay(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 < (arg0 as u64)) {
            v0 = v0 * 2;
            v1 = v1 + 1;
        };
        30000 * v0
    }

    fun calculate_capture_level_penalty_factor(arg0: u8) : u64 {
        if (arg0 <= 1) {
            5000
        } else if (arg0 == 2) {
            4500
        } else if (arg0 == 3) {
            4000
        } else if (arg0 == 4) {
            3500
        } else if (arg0 == 5) {
            3000
        } else if (arg0 == 6) {
            2500
        } else if (arg0 == 7) {
            2000
        } else if (arg0 == 8) {
            1500
        } else if (arg0 == 9) {
            1000
        } else {
            10000
        }
    }

    fun calculate_enemy_rerandom_cooldown(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 < (arg0 as u64)) {
            v0 = v0 * 2;
            v1 = v1 + 1;
        };
        60000 * v0
    }

    fun calculate_experience_gain(arg0: u8, arg1: bool) : u64 {
        if (arg1) {
            if (arg0 == 2) {
                10
            } else if (arg0 == 1) {
                20
            } else {
                40
            }
        } else if (arg0 == 2) {
            100
        } else if (arg0 == 1) {
            80
        } else {
            40
        }
    }

    fun calculate_win_probability(arg0: u8, arg1: bool, arg2: bool, arg3: bool) : u64 {
        if (arg0 == 0) {
            if (arg2) {
                7500
            } else if (arg3) {
                2500
            } else {
                5000
            }
        } else if (arg0 == 1) {
            if (arg1) {
                if (arg2) {
                    7500
                } else if (arg3) {
                    5000
                } else {
                    7500
                }
            } else if (arg2) {
                5000
            } else if (arg3) {
                1250
            } else {
                2500
            }
        } else if (arg1) {
            if (arg2) {
                9375
            } else if (arg3) {
                7500
            } else {
                8750
            }
        } else if (arg2) {
            2500
        } else if (arg3) {
            625
        } else {
            1250
        }
    }

    public entry fun cancel_battle_commitment(arg0: &mut NFTGameContract, arg1: &mut BattleCommitment, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.player == v0, 113);
        assert!(!arg1.is_revealed, 111);
        assert!(arg2 == arg1.nft_id, 110);
        let v1 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
        assert!(v1.owner == v0, 105);
        v1.has_active_commitment = false;
        v1.current_enemy = 0x1::option::none<EnemyInfo>();
        arg1.is_revealed = true;
        let v2 = BattleEvent{
            nft_id            : arg2,
            player            : v0,
            is_golden_monster : false,
            enemy_level       : arg1.enemy_info.level,
            enemy_element     : arg1.enemy_info.element,
            player_level      : arg1.player_level,
            player_element    : arg1.player_element,
            is_win            : false,
            experience_gained : 0,
            level_increased   : false,
            reward_amount     : 0,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BattleEvent>(v2);
    }

    public entry fun cancel_battle_commitment_by_address(arg0: &mut NFTGameContract, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<address, u64>(&arg0.battle_commit_addr_to_id, arg1);
        cancel_battle_commitment_by_id(arg0, v0, arg2, arg3, arg4);
        0x2::table::remove<address, u64>(&mut arg0.battle_commit_addr_to_id, arg1);
    }

    public entry fun cancel_battle_commitment_by_id(arg0: &mut NFTGameContract, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow<u64, BattleCommitment>(&arg0.battle_commitment_table, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v0.player == v1, 113);
        assert!(!v0.is_revealed, 111);
        assert!(arg2 == v0.nft_id, 110);
        let v2 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
        assert!(v2.owner == v1, 105);
        v2.has_active_commitment = false;
        v2.current_enemy = 0x1::option::none<EnemyInfo>();
        let v3 = BattleEvent{
            nft_id            : arg2,
            player            : v1,
            is_golden_monster : false,
            enemy_level       : v0.enemy_info.level,
            enemy_element     : v0.enemy_info.element,
            player_level      : v0.player_level,
            player_element    : v0.player_element,
            is_win            : false,
            experience_gained : 0,
            level_increased   : false,
            reward_amount     : 0,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BattleEvent>(v3);
        let BattleCommitment {
            id                         : v4,
            player                     : _,
            nft_id                     : _,
            commitment_hash            : _,
            enemy_info                 : _,
            player_level               : _,
            player_element             : _,
            committed_at               : _,
            is_revealed                : _,
            golden_min_reward_snapshot : _,
            golden_max_reward_snapshot : _,
        } = 0x2::object_table::remove<u64, BattleCommitment>(&mut arg0.battle_commitment_table, arg1);
        0x2::object::delete(v4);
    }

    public entry fun cancel_capture_commitment(arg0: &mut NFTGameContract, arg1: &mut CaptureCommitment, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.player == v0, 113);
        assert!(!arg1.is_revealed, 111);
        assert!(arg2 == arg1.nft_id, 110);
        let v1 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
        assert!(v1.owner == v0, 105);
        v1.has_active_commitment = false;
        v1.current_enemy = 0x1::option::none<EnemyInfo>();
        arg1.is_revealed = true;
        let v2 = CaptureAttemptEvent{
            player              : v0,
            source_nft_id       : arg2,
            captured_nft_id     : 0x1::option::none<u64>(),
            is_success          : false,
            capture_probability : 0,
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CaptureAttemptEvent>(v2);
    }

    public entry fun cancel_capture_commitment_by_address(arg0: &mut NFTGameContract, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<address, u64>(&arg0.capture_commit_addr_to_id, arg1);
        cancel_capture_commitment_by_id(arg0, v0, arg2, arg3, arg4);
        0x2::table::remove<address, u64>(&mut arg0.capture_commit_addr_to_id, arg1);
    }

    public entry fun cancel_capture_commitment_by_id(arg0: &mut NFTGameContract, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow<u64, CaptureCommitment>(&arg0.capture_commitment_table, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v0.player == v1, 113);
        assert!(!v0.is_revealed, 111);
        assert!(arg2 == v0.nft_id, 110);
        let v2 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
        assert!(v2.owner == v1, 105);
        v2.has_active_commitment = false;
        v2.current_enemy = 0x1::option::none<EnemyInfo>();
        let v3 = CaptureAttemptEvent{
            player              : v1,
            source_nft_id       : arg2,
            captured_nft_id     : 0x1::option::none<u64>(),
            is_success          : false,
            capture_probability : 0,
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CaptureAttemptEvent>(v3);
        let CaptureCommitment {
            id                  : v4,
            player              : _,
            nft_id              : _,
            commitment_hash     : _,
            enemy_info          : _,
            player_level        : _,
            player_element      : _,
            player_monster_type : _,
            committed_at        : _,
            is_revealed         : _,
        } = 0x2::object_table::remove<u64, CaptureCommitment>(&mut arg0.capture_commitment_table, arg1);
        0x2::object::delete(v4);
    }

    public entry fun cancel_listing(arg0: &mut NFTGameContract, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::borrow<u64, ListingInfo>(&arg0.listing_table, arg1).seller == v0, 202);
        if (!0x2::table::contains<address, u64>(&arg0.active_nft, v0)) {
            0x2::table::add<address, u64>(&mut arg0.active_nft, v0, arg1);
        };
        add_nft_to_owner_index(arg0, v0, arg1);
        let v1 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg1);
        assert!(v1.is_listed, 201);
        v1.is_listed = false;
        let v2 = *0x2::table::borrow<u64, u64>(&arg0.id_to_index, arg1);
        let v3 = 0x1::vector::length<u64>(&arg0.listed_ids) - 1;
        if (v2 != v3) {
            0x1::vector::swap<u64>(&mut arg0.listed_ids, v2, v3);
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.id_to_index, *0x1::vector::borrow<u64>(&arg0.listed_ids, v3)) = v2;
        };
        0x1::vector::pop_back<u64>(&mut arg0.listed_ids);
        0x2::table::remove<u64, u64>(&mut arg0.id_to_index, arg1);
        0x2::table::remove<u64, ListingInfo>(&mut arg0.listing_table, arg1);
        let v4 = ListingCancelledEvent{
            nft_id    : arg1,
            seller    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ListingCancelledEvent>(v4);
    }

    public entry fun capture_commit(arg0: &mut NFTGameContract, arg1: u64, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 500000000, 101);
        let v2 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg1);
        assert!(v2.owner == v0, 105);
        assert!(!v2.is_listed, 200);
        assert!(0x1::option::is_some<EnemyInfo>(&v2.current_enemy), 108);
        let v3 = *0x1::option::borrow<EnemyInfo>(&v2.current_enemy);
        assert!(!v3.is_golden_monster, 205);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 110);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v4, 500000000 * 9900 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.withdrawable_balance, v4);
        let v5 = 0x2::object::new(arg5);
        let v6 = 0x2::object::uid_to_address(&v5);
        let v7 = CaptureCommitment{
            id                  : v5,
            player              : v0,
            nft_id              : arg1,
            commitment_hash     : arg2,
            enemy_info          : v3,
            player_level        : v2.level,
            player_element      : v2.element,
            player_monster_type : v2.monster_type,
            committed_at        : v1,
            is_revealed         : false,
        };
        let v8 = arg0.capture_commitment_counter + 1;
        arg0.capture_commitment_counter = v8;
        0x2::object_table::add<u64, CaptureCommitment>(&mut arg0.capture_commitment_table, v8, v7);
        0x2::table::add<address, u64>(&mut arg0.capture_commit_addr_to_id, v6, v8);
        v2.has_active_commitment = true;
        let v9 = CaptureCommitmentCreatedEvent{
            commitment_id : v6,
            player        : v0,
            nft_id        : arg1,
            timestamp     : v1,
        };
        0x2::event::emit<CaptureCommitmentCreatedEvent>(v9);
    }

    public entry fun capture_reveal(arg0: &mut NFTGameContract, arg1: &mut CaptureCommitment, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.player == 0x2::tx_context::sender(arg8), 113);
        assert!(!arg1.is_revealed, 111);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= arg1.committed_at + calculate_battle_reveal_delay(arg1.player_level), 112);
        assert!(arg2 == arg1.nft_id, 110);
        assert!(arg3 == arg1.enemy_info.level, 110);
        assert!(arg4 == arg1.enemy_info.element, 110);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 8) {
            0x1::vector::push_back<u8>(&mut v1, ((arg2 >> v2 * 8 & 255) as u8));
            v2 = v2 + 1;
        };
        0x1::vector::push_back<u8>(&mut v1, arg3);
        0x1::vector::push_back<u8>(&mut v1, arg4);
        0x1::vector::append<u8>(&mut v1, arg5);
        assert!(0x2::hash::keccak256(&v1) == arg1.commitment_hash, 110);
        assert!(!0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg2).is_listed, 200);
        let v3 = arg1.player;
        let v4 = arg1.enemy_info.monster_type;
        let v5 = if (arg1.player_level > arg3) {
            arg1.player_level - arg3
        } else {
            arg3 - arg1.player_level
        };
        let v6 = calculate_win_probability(v5, arg1.player_level > arg3, get_element_advantage(arg1.player_element, arg4), get_element_advantage(arg4, arg1.player_element)) / 2;
        let v7 = v6;
        if (arg1.player_monster_type == v4) {
            let v8 = v6 + 1000;
            v7 = v8;
            if (v8 > 10000) {
                v7 = 10000;
            };
        };
        let v9 = v7 * calculate_capture_level_penalty_factor(arg1.player_level) / 10000;
        let v10 = 0x2::random::new_generator(arg6, arg8);
        let v11 = 0x2::random::generate_u64(&mut v10) % 10000 < v9;
        let v12 = if (v11) {
            let v13 = arg0.nft_counter + 1;
            arg0.nft_counter = v13;
            let v14 = HealthNFT{
                id                      : 0x2::object::new(arg8),
                owner                   : v3,
                name                    : arg1.enemy_info.name,
                element                 : arg4,
                monster_type            : v4,
                level                   : 3,
                experience              : 0,
                mint_time               : v0,
                defeated_golden_monster : false,
                current_enemy           : 0x1::option::none<EnemyInfo>(),
                last_enemy_generated_at : 0,
                is_listed               : false,
                has_active_commitment   : false,
            };
            0x2::object_table::add<u64, HealthNFT>(&mut arg0.nft_table, v13, v14);
            add_nft_to_owner_index(arg0, v3, v13);
            arg0.total_minted = arg0.total_minted + 1;
            let v15 = NFTMintedEvent{
                nft_id       : v13,
                owner        : v3,
                element      : arg4,
                monster_type : v4,
                level        : 3,
                timestamp    : v0,
            };
            0x2::event::emit<NFTMintedEvent>(v15);
            let v16 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
            let v17 = get_season_element_by_solar_terms(v0);
            let v18 = is_element_counter_season(v16.element, v17);
            let v19 = !v16.defeated_golden_monster && 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) > 1000000000;
            let v20 = &mut v10;
            assign_new_enemy(v16, v17, v18, v20, v0, v19, arg0.config.golden_monster_base_prob, arg0.config.golden_monster_max_prob, true);
            0x1::option::some<u64>(v13)
        } else {
            0x1::option::none<u64>()
        };
        arg1.is_revealed = true;
        let v21 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
        v21.has_active_commitment = false;
        if (!v11) {
            v21.current_enemy = 0x1::option::none<EnemyInfo>();
        };
        let v22 = CaptureAttemptEvent{
            player              : v3,
            source_nft_id       : arg2,
            captured_nft_id     : v12,
            is_success          : v11,
            capture_probability : v9,
            timestamp           : v0,
        };
        0x2::event::emit<CaptureAttemptEvent>(v22);
    }

    public entry fun capture_reveal_by_address(arg0: &mut NFTGameContract, arg1: address, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<address, u64>(&arg0.capture_commit_addr_to_id, arg1);
        capture_reveal_by_id(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::table::remove<address, u64>(&mut arg0.capture_commit_addr_to_id, arg1);
    }

    public entry fun capture_reveal_by_id(arg0: &mut NFTGameContract, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow<u64, CaptureCommitment>(&arg0.capture_commitment_table, arg1);
        assert!(v0.player == 0x2::tx_context::sender(arg8), 113);
        assert!(!v0.is_revealed, 111);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(v1 >= v0.committed_at + calculate_battle_reveal_delay(v0.player_level), 112);
        assert!(arg2 == v0.nft_id, 110);
        assert!(arg3 == v0.enemy_info.level, 110);
        assert!(arg4 == v0.enemy_info.element, 110);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 8) {
            0x1::vector::push_back<u8>(&mut v2, ((arg2 >> v3 * 8 & 255) as u8));
            v3 = v3 + 1;
        };
        0x1::vector::push_back<u8>(&mut v2, arg3);
        0x1::vector::push_back<u8>(&mut v2, arg4);
        0x1::vector::append<u8>(&mut v2, arg5);
        assert!(0x2::hash::keccak256(&v2) == v0.commitment_hash, 110);
        assert!(!0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg2).is_listed, 200);
        let v4 = v0.player;
        let v5 = v0.enemy_info.monster_type;
        let v6 = v0.enemy_info.name;
        let v7 = if (v0.player_level > arg3) {
            v0.player_level - arg3
        } else {
            arg3 - v0.player_level
        };
        let v8 = calculate_win_probability(v7, v0.player_level > arg3, get_element_advantage(v0.player_element, arg4), get_element_advantage(arg4, v0.player_element)) / 2;
        let v9 = v8;
        if (v0.player_monster_type == v5) {
            let v10 = v8 + 1000;
            v9 = v10;
            if (v10 > 10000) {
                v9 = 10000;
            };
        };
        let v11 = v9 * calculate_capture_level_penalty_factor(v0.player_level) / 10000;
        let v12 = 0x2::random::new_generator(arg6, arg8);
        let v13 = 0x2::random::generate_u64(&mut v12) % 10000 < v11;
        let v14 = if (v13) {
            let v15 = arg0.nft_counter + 1;
            arg0.nft_counter = v15;
            let v16 = HealthNFT{
                id                      : 0x2::object::new(arg8),
                owner                   : v4,
                name                    : v6,
                element                 : arg4,
                monster_type            : v5,
                level                   : 3,
                experience              : 0,
                mint_time               : v1,
                defeated_golden_monster : false,
                current_enemy           : 0x1::option::none<EnemyInfo>(),
                last_enemy_generated_at : 0,
                is_listed               : false,
                has_active_commitment   : false,
            };
            0x2::object_table::add<u64, HealthNFT>(&mut arg0.nft_table, v15, v16);
            add_nft_to_owner_index(arg0, v4, v15);
            arg0.total_minted = arg0.total_minted + 1;
            let v17 = NFTMintedEvent{
                nft_id       : v15,
                owner        : v4,
                element      : arg4,
                monster_type : v5,
                level        : 3,
                timestamp    : v1,
            };
            0x2::event::emit<NFTMintedEvent>(v17);
            let v18 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
            let v19 = get_season_element_by_solar_terms(v1);
            let v20 = is_element_counter_season(v18.element, v19);
            let v21 = !v18.defeated_golden_monster && 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) > 1000000000;
            let v22 = &mut v12;
            assign_new_enemy(v18, v19, v20, v22, v1, v21, arg0.config.golden_monster_base_prob, arg0.config.golden_monster_max_prob, true);
            0x1::option::some<u64>(v15)
        } else {
            0x1::option::none<u64>()
        };
        let v23 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg2);
        v23.has_active_commitment = false;
        if (!v13) {
            v23.current_enemy = 0x1::option::none<EnemyInfo>();
        };
        let v24 = CaptureAttemptEvent{
            player              : v4,
            source_nft_id       : arg2,
            captured_nft_id     : v14,
            is_success          : v13,
            capture_probability : v11,
            timestamp           : v1,
        };
        0x2::event::emit<CaptureAttemptEvent>(v24);
        let CaptureCommitment {
            id                  : v25,
            player              : _,
            nft_id              : _,
            commitment_hash     : _,
            enemy_info          : _,
            player_level        : _,
            player_element      : _,
            player_monster_type : _,
            committed_at        : _,
            is_revealed         : _,
        } = 0x2::object_table::remove<u64, CaptureCommitment>(&mut arg0.capture_commitment_table, arg1);
        0x2::object::delete(v25);
    }

    fun day_of_year(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v0 < arg1) {
            v1 = v1 + days_in_month(arg0, v0);
            v0 = v0 + 1;
        };
        v1 + arg2
    }

    fun days_in_month(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 3) {
            true
        } else if (arg1 == 5) {
            true
        } else if (arg1 == 7) {
            true
        } else if (arg1 == 8) {
            true
        } else if (arg1 == 10) {
            true
        } else {
            arg1 == 12
        };
        if (v0) {
            31
        } else {
            let v2 = if (arg1 == 4) {
                true
            } else if (arg1 == 6) {
                true
            } else if (arg1 == 9) {
                true
            } else {
                arg1 == 11
            };
            if (v2) {
                30
            } else if (arg1 == 2) {
                if (is_leap_year(arg0)) {
                    29
                } else {
                    28
                }
            } else {
                30
            }
        }
    }

    fun days_in_year(arg0: u64) : u64 {
        if (is_leap_year(arg0)) {
            366
        } else {
            365
        }
    }

    public entry fun deposit(arg0: &mut NFTGameContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.banker, 100);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = DepositEvent{
            banker      : arg0.banker,
            amount      : v0,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) + 0x2::balance::value<0x2::sui::SUI>(&arg0.withdrawable_balance) + v0,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun generate_monster_type(arg0: &mut 0x2::random::RandomGenerator, arg1: u8) : u8 {
        let v0 = (arg1 as u64);
        let v1 = 400 + (v0 - 1) * 300 / 9;
        let v2 = v1 + 250 - (v0 - 1) * 50 / 9;
        let v3 = v2 + 150 - (v0 - 1) * 80 / 9;
        let v4 = v3 + 100 - (v0 - 1) * 80 / 9;
        let v5 = 0x2::random::generate_u64(arg0) % 1000;
        if (v5 < v1) {
            0
        } else if (v5 < v2) {
            4
        } else if (v5 < v3) {
            2
        } else if (v5 < v4) {
            3
        } else if (v5 < v4 + 60 - (v0 - 1) * 52 / 9) {
            5
        } else {
            1
        }
    }

    public fun get_active_nft(arg0: &NFTGameContract, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.active_nft, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.active_nft, arg1)
        } else {
            0
        }
    }

    public fun get_buyer_trade_count(arg0: &NFTGameContract, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<u64>>(&arg0.buyer_to_trades, arg1)) {
            0x1::vector::length<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.buyer_to_trades, arg1))
        } else {
            0
        }
    }

    public fun get_buyer_trade_id_at(arg0: &NFTGameContract, arg1: address, arg2: u64) : u64 {
        *0x1::vector::borrow<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.buyer_to_trades, arg1), arg2)
    }

    public fun get_contract_balances(arg0: &NFTGameContract) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.withdrawable_balance))
    }

    public fun get_contract_info(arg0: &NFTGameContract) : (address, u64, u64) {
        (arg0.banker, 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) + 0x2::balance::value<0x2::sui::SUI>(&arg0.withdrawable_balance), arg0.total_minted)
    }

    fun get_day_of_year_from_march_20(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = day_of_year(arg0, arg1, arg2);
        let v1 = day_of_year(arg0, 3, 20);
        if (v0 >= v1) {
            v0 - v1
        } else {
            let v3 = arg0 - 1;
            days_in_year(v3) - day_of_year(v3, 3, 20) + v0
        }
    }

    fun get_element_advantage(arg0: u8, arg1: u8) : bool {
        if (arg0 == arg1) {
            return false
        };
        if (arg0 == 0 && arg1 == 1) {
            return true
        };
        if (arg0 == 1 && arg1 == 4) {
            return true
        };
        if (arg0 == 4 && arg1 == 2) {
            return true
        };
        if (arg0 == 2 && arg1 == 3) {
            return true
        };
        if (arg0 == 3 && arg1 == 0) {
            return true
        };
        false
    }

    fun get_element_counter_status(arg0: u8, arg1: u8) : bool {
        if (arg0 == 0 && arg1 == 1) {
            return true
        };
        if (arg0 == 1 && arg1 == 4) {
            return true
        };
        if (arg0 == 4 && arg1 == 2) {
            return true
        };
        if (arg0 == 2 && arg1 == 3) {
            return true
        };
        if (arg0 == 3 && arg1 == 0) {
            return true
        };
        false
    }

    public fun get_game_config(arg0: &NFTGameContract) : GameConfig {
        arg0.config
    }

    public fun get_game_config_values(arg0: &NFTGameContract) : (u64, u64, u64, u64) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance);
        let v1 = if (v0 <= 1000000000) {
            10000000
        } else {
            v0 * 100 / 10000
        };
        let v2 = if (v0 <= 1000000000) {
            100000000
        } else {
            v0 * 5000 / 10000
        };
        (v1, v2, arg0.config.golden_monster_base_prob, arg0.config.golden_monster_max_prob)
    }

    fun get_golden_monster_probability(arg0: u8, arg1: &GameConfig) : u64 {
        get_golden_monster_probability_from_values(arg0, arg1.golden_monster_base_prob, arg1.golden_monster_max_prob)
    }

    fun get_golden_monster_probability_from_values(arg0: u8, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u64);
        if (v0 <= 1) {
            arg1
        } else if (v0 >= 9) {
            arg2
        } else {
            arg1 + (v0 - 1) * (arg2 - arg1) / 8
        }
    }

    fun get_golden_monster_win_prob(arg0: u8) : u64 {
        if (arg0 == 0) {
            50
        } else if (arg0 == 1) {
            55
        } else if (arg0 == 2) {
            60
        } else if (arg0 == 3) {
            65
        } else if (arg0 == 4) {
            70
        } else {
            50
        }
    }

    public fun get_listing_info(arg0: &NFTGameContract, arg1: u64) : (address, u64, u64) {
        let v0 = 0x2::table::borrow<u64, ListingInfo>(&arg0.listing_table, arg1);
        (v0.seller, v0.price, v0.listed_at)
    }

    public fun get_market_list_id_at(arg0: &NFTGameContract, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.listed_ids, arg1)
    }

    public fun get_market_list_len(arg0: &NFTGameContract) : u64 {
        0x1::vector::length<u64>(&arg0.listed_ids)
    }

    public fun get_next_enemy_random_time(arg0: &NFTGameContract, arg1: u64) : u64 {
        let v0 = 0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg1);
        if (v0.last_enemy_generated_at > 0) {
            v0.last_enemy_generated_at + calculate_enemy_rerandom_cooldown(v0.level)
        } else {
            0
        }
    }

    public fun get_nft(arg0: &NFTGameContract, arg1: u64) : &HealthNFT {
        0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg1)
    }

    public fun get_nft_current_enemy(arg0: &NFTGameContract, arg1: u64) : 0x1::option::Option<EnemyInfo> {
        0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg1).current_enemy
    }

    public fun get_nft_trade_count(arg0: &NFTGameContract, arg1: u64) : u64 {
        if (0x2::table::contains<u64, vector<u64>>(&arg0.nft_to_trades, arg1)) {
            0x1::vector::length<u64>(0x2::table::borrow<u64, vector<u64>>(&arg0.nft_to_trades, arg1))
        } else {
            0
        }
    }

    public fun get_nft_trade_id_at(arg0: &NFTGameContract, arg1: u64, arg2: u64) : u64 {
        *0x1::vector::borrow<u64>(0x2::table::borrow<u64, vector<u64>>(&arg0.nft_to_trades, arg1), arg2)
    }

    public fun get_owner_nft_count(arg0: &NFTGameContract, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<u64>>(&arg0.owner_to_ids, arg1)) {
            0x1::vector::length<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.owner_to_ids, arg1))
        } else {
            0
        }
    }

    public fun get_owner_nft_id_at(arg0: &NFTGameContract, arg1: address, arg2: u64) : u64 {
        *0x1::vector::borrow<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.owner_to_ids, arg1), arg2)
    }

    fun get_season_element_by_solar_terms(arg0: u64) : u8 {
        let (v0, v1, v2) = timestamp_to_date(arg0);
        let v3 = get_day_of_year_from_march_20(v0, v1, v2) % 360;
        if (v3 < 72) {
            return 1
        };
        if (v3 < 90) {
            return 4
        };
        if (v3 < 162) {
            return 3
        };
        if (v3 < 180) {
            return 4
        };
        if (v3 < 252) {
            return 0
        };
        if (v3 < 270) {
            return 4
        };
        if (v3 < 342) {
            return 2
        };
        4
    }

    fun get_season_hierarchy(arg0: u8) : (u8, u8, u8, u8) {
        let (v0, v1, v2, v3) = if (arg0 == 1) {
            (2, 3, 0, 1)
        } else {
            let (v4, v5, v6, v7) = if (arg0 == 3) {
                (3, 1, 0, 2)
            } else if (arg0 == 0) {
                (0, 3, 2, 1)
            } else {
                (2, 0, 1, 3)
            };
            (v5, v6, v7, v4)
        };
        (v3, v0, v1, v2)
    }

    fun get_season_info_by_day(arg0: u64) : (u8, u8, bool, u64) {
        let v0 = arg0 % 360;
        if (v0 < 72) {
            return (1, 0, false, v0)
        };
        if (v0 < 90) {
            return (1, 0, true, v0)
        };
        if (v0 < 162) {
            return (3, 2, false, v0 - 90)
        };
        if (v0 < 180) {
            return (3, 2, true, v0)
        };
        if (v0 < 252) {
            return (0, 1, false, v0 - 180)
        };
        if (v0 < 270) {
            return (0, 1, true, v0)
        };
        if (v0 < 342) {
            return (2, 3, false, v0 - 270)
        };
        (2, 3, true, v0)
    }

    public fun get_seller_trade_count(arg0: &NFTGameContract, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<u64>>(&arg0.seller_to_trades, arg1)) {
            0x1::vector::length<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.seller_to_trades, arg1))
        } else {
            0
        }
    }

    public fun get_seller_trade_id_at(arg0: &NFTGameContract, arg1: address, arg2: u64) : u64 {
        *0x1::vector::borrow<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.seller_to_trades, arg1), arg2)
    }

    public fun get_trade_by_id(arg0: &NFTGameContract, arg1: u64) : (u64, u64, address, address, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, TradeRecord>(&arg0.trade_table, arg1);
        (v0.trade_id, v0.nft_id, v0.seller, v0.buyer, v0.price, v0.fee, v0.seller_amount, v0.timestamp)
    }

    public fun get_trade_count(arg0: &NFTGameContract) : u64 {
        0x1::vector::length<u64>(&arg0.trade_ids)
    }

    public fun get_trade_id_at(arg0: &NFTGameContract, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.trade_ids, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameConfig{
            min_golden_monster_reward : 0,
            max_golden_monster_reward : 0,
            golden_monster_base_prob  : 50,
            golden_monster_max_prob   : 900,
        };
        let v1 = NFTGameContract{
            id                         : 0x2::object::new(arg0),
            banker                     : 0x2::tx_context::sender(arg0),
            locked_balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            withdrawable_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            nft_table                  : 0x2::object_table::new<u64, HealthNFT>(arg0),
            total_minted               : 0,
            nft_counter                : 0,
            config                     : v0,
            listing_table              : 0x2::table::new<u64, ListingInfo>(arg0),
            listed_ids                 : 0x1::vector::empty<u64>(),
            id_to_index                : 0x2::table::new<u64, u64>(arg0),
            owner_to_ids               : 0x2::table::new<address, vector<u64>>(arg0),
            active_nft                 : 0x2::table::new<address, u64>(arg0),
            trade_counter              : 0,
            trade_table                : 0x2::table::new<u64, TradeRecord>(arg0),
            trade_ids                  : 0x1::vector::empty<u64>(),
            seller_to_trades           : 0x2::table::new<address, vector<u64>>(arg0),
            buyer_to_trades            : 0x2::table::new<address, vector<u64>>(arg0),
            nft_to_trades              : 0x2::table::new<u64, vector<u64>>(arg0),
            battle_commitment_table    : 0x2::object_table::new<u64, BattleCommitment>(arg0),
            battle_commitment_counter  : 0,
            battle_commit_addr_to_id   : 0x2::table::new<address, u64>(arg0),
            capture_commitment_table   : 0x2::object_table::new<u64, CaptureCommitment>(arg0),
            capture_commitment_counter : 0,
            capture_commit_addr_to_id  : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::public_share_object<NFTGameContract>(v1);
    }

    fun is_element_counter_season(arg0: u8, arg1: u8) : bool {
        get_element_counter_status(arg0, arg1)
    }

    fun is_leap_year(arg0: u64) : bool {
        arg0 % 4 == 0 && arg0 % 100 != 0 || arg0 % 400 == 0
    }

    public entry fun list_nft(arg0: &mut NFTGameContract, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 > 0, 203);
        let v1 = 0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg1);
        assert!(v1.owner == v0, 105);
        assert!(!v1.is_listed, 200);
        assert!(!v1.has_active_commitment, 204);
        remove_nft_from_owner_index(arg0, v0, arg1);
        if (0x2::table::contains<address, u64>(&arg0.active_nft, v0)) {
            if (*0x2::table::borrow<address, u64>(&arg0.active_nft, v0) == arg1) {
                let v2 = 0x2::table::borrow<address, vector<u64>>(&arg0.owner_to_ids, v0);
                if (0x1::vector::length<u64>(v2) > 0) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.active_nft, v0) = *0x1::vector::borrow<u64>(v2, 0);
                } else {
                    0x2::table::remove<address, u64>(&mut arg0.active_nft, v0);
                };
            };
        };
        0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg1).is_listed = true;
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = ListingInfo{
            seller    : v0,
            price     : arg2,
            listed_at : v3,
        };
        0x2::table::add<u64, ListingInfo>(&mut arg0.listing_table, arg1, v4);
        0x1::vector::push_back<u64>(&mut arg0.listed_ids, arg1);
        0x2::table::add<u64, u64>(&mut arg0.id_to_index, arg1, 0x1::vector::length<u64>(&arg0.listed_ids));
        let v5 = ListingCreatedEvent{
            nft_id    : arg1,
            seller    : v0,
            price     : arg2,
            timestamp : v3,
        };
        0x2::event::emit<ListingCreatedEvent>(v5);
    }

    fun perform_battle(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0x2::random::RandomGenerator) : (bool, u64, bool) {
        let v0 = if (arg0 > arg2) {
            arg0 - arg2
        } else {
            arg2 - arg0
        };
        if (0x2::random::generate_u64(arg4) % 10000 < (calculate_win_probability(v0, arg0 > arg2, get_element_advantage(arg1, arg3), get_element_advantage(arg3, arg1)) as u64)) {
            (true, calculate_experience_gain(v0, arg0 > arg2), false)
        } else {
            (false, 0, false)
        }
    }

    public entry fun random_enemy(arg0: &mut NFTGameContract, arg1: u64, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<u64, HealthNFT>(&mut arg0.nft_table, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg4), 105);
        assert!(!v0.is_listed, 200);
        assert!(!v0.has_active_commitment, 204);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (v0.last_enemy_generated_at > 0) {
            assert!(v1 - v0.last_enemy_generated_at >= calculate_enemy_rerandom_cooldown(v0.level), 109);
        };
        let v2 = if (!v0.defeated_golden_monster) {
            if (v0.level < 10) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) > 1000000000
            } else {
                false
            }
        } else {
            false
        };
        let v3 = 0x2::random::new_generator(arg2, arg4);
        let v4 = if (v2) {
            let v5 = if (is_element_counter_season(v0.element, get_season_element_by_solar_terms(v1))) {
                2
            } else {
                1
            };
            0x2::random::generate_u64(&mut v3) % 10000 < get_golden_monster_probability(v0.level, &arg0.config) * v5
        } else {
            false
        };
        let v6 = &mut v3;
        if (v4) {
            let v7 = EnemyInfo{
                name              : 0x8ba4d7710351b6ef3044515d206625dc26116712eac155003e9813350fd46421::name::generate_full_name(&mut v3),
                level             : 0,
                element           : 0,
                monster_type      : generate_monster_type(v6, v0.level),
                is_golden_monster : true,
                generated_at      : v1,
            };
            v0.current_enemy = 0x1::option::some<EnemyInfo>(v7);
        } else {
            let v8 = (v0.level as u64);
            let v9 = if (v8 > 2) {
                v8 - 2
            } else {
                1
            };
            let v10 = v8 + 2;
            let v11 = if (v10 > (10 as u64)) {
                (10 as u64)
            } else {
                v10
            };
            let v12 = EnemyInfo{
                name              : 0x8ba4d7710351b6ef3044515d206625dc26116712eac155003e9813350fd46421::name::generate_full_name(&mut v3),
                level             : ((0x2::random::generate_u64(&mut v3) % (v11 - v9 + 1) + v9) as u8),
                element           : select_element_by_linear_probability(v1, 0x2::random::generate_u64(&mut v3)),
                monster_type      : generate_monster_type(v6, v0.level),
                is_golden_monster : false,
                generated_at      : v1,
            };
            v0.current_enemy = 0x1::option::some<EnemyInfo>(v12);
        };
        v0.last_enemy_generated_at = v1;
    }

    fun remove_nft_from_owner_index(arg0: &mut NFTGameContract, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.owner_to_ids, arg1);
        let v1 = 0x1::vector::length<u64>(v0);
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow_mut<u64>(v0, v2) == arg2) {
                let v3 = v1 - 1;
                if (v2 != v3) {
                    0x1::vector::swap<u64>(v0, v2, v3);
                };
                0x1::vector::pop_back<u64>(v0);
                break
            };
            v2 = v2 + 1;
        };
    }

    fun select_element_by_linear_probability(arg0: u64, arg1: u64) : u8 {
        let (v0, v1, v2) = timestamp_to_date(arg0);
        let (v3, _, v5, v6) = get_season_info_by_day(get_day_of_year_from_march_20(v0, v1, v2));
        if (v5) {
            return select_element_during_earth_period(v3, arg1)
        };
        select_element_during_main_period(v3, v6, arg1)
    }

    fun select_element_during_earth_period(arg0: u8, arg1: u64) : u8 {
        let v0 = arg1 % 10000;
        if (v0 < 5000) {
            return 4
        };
        let v1 = (v0 - 5000) / 1250;
        if (v1 == 0) {
            0
        } else if (v1 == 1) {
            1
        } else if (v1 == 2) {
            2
        } else {
            3
        }
    }

    fun select_element_during_main_period(arg0: u8, arg1: u64, arg2: u64) : u8 {
        let v0 = 36;
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            v0 - arg1
        };
        let v2 = 1000 + 1250 * v1 / 36;
        let v3 = arg2 % 10000;
        let (v4, v5, v6, v7) = get_season_hierarchy(arg0);
        let v8 = 0 + 7000 - 3000 * v1 / 36;
        if (v3 < v8) {
            return v4
        };
        let v9 = v8 + v2;
        if (v3 < v9) {
            return v5
        };
        let v10 = v9 + v2;
        if (v3 < v10) {
            return v6
        };
        if (v3 < v10 + 500 + 500 * v1 / 36) {
            return v7
        };
        4
    }

    public entry fun set_active_nft(arg0: &mut NFTGameContract, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::borrow<u64, HealthNFT>(&arg0.nft_table, arg1).owner == v0, 105);
        if (0x2::table::contains<address, u64>(&arg0.active_nft, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.active_nft, v0) = arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.active_nft, v0, arg1);
        };
    }

    fun timestamp_to_date(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 86400000;
        let v1 = v0 % 365;
        let v2 = v1 / 30 + 1;
        let v3 = if (v2 > 12) {
            12
        } else {
            v2
        };
        let v4 = v1 % 30 + 1;
        let v5 = if (v4 > 31) {
            31
        } else {
            v4
        };
        (1970 + v0 / 365, v3, v5)
    }

    public entry fun withdraw(arg0: &mut NFTGameContract, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.banker, 100);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.withdrawable_balance) >= arg1, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.withdrawable_balance, arg1), arg3), arg0.banker);
        let v0 = WithdrawEvent{
            banker      : arg0.banker,
            amount      : arg1,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance) + 0x2::balance::value<0x2::sui::SUI>(&arg0.withdrawable_balance),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

