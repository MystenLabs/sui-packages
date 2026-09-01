module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle {
    struct Status has copy, drop, store {
        block_turns: u8,
        next_turn_penalty: u64,
        poison_ticks: u8,
        poison_dpt: u64,
    }

    struct Battle has key {
        id: 0x2::object::UID,
        player1: address,
        player2: address,
        p1_growth: u64,
        p2_growth: u64,
        turn: u8,
        finished: bool,
        winner: 0x1::option::Option<address>,
        p1_moves: vector<u8>,
        p2_moves: vector<u8>,
        p1_status: Status,
        p2_status: Status,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        battle_entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
        treasury_addr: address,
        last_move_ms: u64,
        is_bot_battle: bool,
    }

    struct BattleUpdate has copy, drop {
        battle_id: 0x2::object::ID,
        player1: address,
        player2: address,
        player1_moves: vector<u8>,
        player2_moves: vector<u8>,
        player1_growth: u64,
        player2_growth: u64,
        winner: 0x1::option::Option<address>,
        last_move_ms: u64,
        is_bot_battle: bool,
    }

    struct PvpV3RulesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PvpV3RulesState has store {
        p1_last_move: 0x1::option::Option<u8>,
        p2_last_move: 0x1::option::Option<u8>,
    }

    struct CardRulesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FighterCardState has store {
        last_move: 0x1::option::Option<u8>,
        reflect_damage: u64,
        armor_half: bool,
        attack_cap: 0x1::option::Option<u64>,
    }

    struct CardRulesState has store {
        p1: FighterCardState,
        p2: FighterCardState,
        total_turns: u64,
    }

    struct PvpBattleV2 has key {
        id: 0x2::object::UID,
        player1: address,
        player2: address,
        p1_growth: u64,
        p2_growth: u64,
        turn: u8,
        finished: bool,
        winner: 0x1::option::Option<address>,
        p1_moves: vector<u8>,
        p2_moves: vector<u8>,
        p1_status: Status,
        p2_status: Status,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        battle_entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
        treasury_addr: address,
        last_move_ms: u64,
        target_growth: u64,
    }

    struct BotMoveResolved has copy, drop {
        battle_id: 0x2::object::ID,
        bot_player: address,
        move_id: u8,
    }

    struct PvpBattleV2Update has copy, drop {
        battle_id: 0x2::object::ID,
        player1: address,
        player2: address,
        player1_moves: vector<u8>,
        player2_moves: vector<u8>,
        player1_growth: u64,
        player2_growth: u64,
        winner: 0x1::option::Option<address>,
        last_move_ms: u64,
        target_growth: u64,
    }

    struct PvpBattleV3 has key {
        id: 0x2::object::UID,
        player1: address,
        player2: address,
        p1_growth: u64,
        p2_growth: u64,
        turn: u8,
        finished: bool,
        winner: 0x1::option::Option<address>,
        p1_moves: vector<u8>,
        p2_moves: vector<u8>,
        p1_status: Status,
        p2_status: Status,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        battle_entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
        treasury_addr: address,
        last_move_ms: u64,
        target_growth: u64,
        p1_fifth_move_entitled: bool,
        p2_fifth_move_entitled: bool,
        p1_eligibility_digest: vector<u8>,
        p2_eligibility_digest: vector<u8>,
        p1_reroll_used: bool,
        p2_reroll_used: bool,
    }

    struct RankedBotBattleV2 has key {
        id: 0x2::object::UID,
        player1: address,
        player2: address,
        p1_growth: u64,
        p2_growth: u64,
        turn: u8,
        finished: bool,
        winner: 0x1::option::Option<address>,
        p1_moves: vector<u8>,
        p2_moves: vector<u8>,
        p1_status: Status,
        p2_status: Status,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        battle_entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
        treasury_addr: address,
        last_move_ms: u64,
        target_growth: u64,
        p1_fifth_move_entitled: bool,
        p1_eligibility_digest: vector<u8>,
        p1_reroll_used: bool,
    }

    struct PvpBattleV3Update has copy, drop {
        battle_id: 0x2::object::ID,
        player1: address,
        player2: address,
        player1_moves: vector<u8>,
        player2_moves: vector<u8>,
        player1_growth: u64,
        player2_growth: u64,
        winner: 0x1::option::Option<address>,
        last_move_ms: u64,
        target_growth: u64,
        p1_fifth_move_entitled: bool,
        p2_fifth_move_entitled: bool,
        p1_reroll_used: bool,
        p2_reroll_used: bool,
    }

    struct RankedBotBattleV2Update has copy, drop {
        battle_id: 0x2::object::ID,
        player1: address,
        player2: address,
        player1_moves: vector<u8>,
        player2_moves: vector<u8>,
        player1_growth: u64,
        player2_growth: u64,
        winner: 0x1::option::Option<address>,
        last_move_ms: u64,
        target_growth: u64,
        p1_fifth_move_entitled: bool,
        p1_reroll_used: bool,
    }

    fun add_card_rules_state(arg0: &mut 0x2::object::UID) {
        let v0 = CardRulesKey{dummy_field: false};
        let v1 = CardRulesState{
            p1          : new_fighter_card_state(),
            p2          : new_fighter_card_state(),
            total_turns : 0,
        };
        0x2::dynamic_field::add<CardRulesKey, CardRulesState>(arg0, v0, v1);
    }

    fun adds_block(arg0: u8) : bool {
        if (arg0 == 8) {
            true
        } else if (arg0 == 17) {
            true
        } else if (arg0 == 29) {
            true
        } else {
            arg0 == 37
        }
    }

    public fun admin_close(arg0: &mut Battle, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        admin_force_close(arg0, arg1, arg2);
    }

    public fun admin_force_close(arg0: &mut Battle, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        arg0.finished = true;
        arg0.winner = 0x1::option::none<address>();
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault) / 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg0.player1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg0.player2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v1), arg2), arg0.player1);
        };
        emit_update(arg0);
    }

    public fun admin_force_close_pvp_v2(arg0: &mut PvpBattleV2, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        arg0.finished = true;
        arg0.winner = 0x1::option::none<address>();
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault) / 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg0.player1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg0.player2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v1), arg2), arg0.player1);
        };
        emit_update_v2(arg0);
    }

    public fun admin_force_close_pvp_v2_with_winner(arg0: &mut PvpBattleV2, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        finish_and_payout_v2(arg0, arg2, arg3);
    }

    public fun admin_force_close_pvp_v3(arg0: &mut PvpBattleV3, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        arg0.finished = true;
        arg0.winner = 0x1::option::none<address>();
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault) / 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg0.player1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg0.player2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v1), arg2), arg0.player1);
        };
        emit_update_v3(arg0);
    }

    public fun admin_force_close_pvp_v3_with_winner(arg0: &mut PvpBattleV3, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        finish_and_payout_v3(arg0, arg2, arg3);
    }

    public fun admin_force_close_ranked_bot_v2(arg0: &mut RankedBotBattleV2, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        arg0.finished = true;
        arg0.winner = 0x1::option::none<address>();
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg0.player1);
        };
        emit_update_ranked_bot_v2(arg0);
    }

    public fun admin_force_close_with_winner(arg0: &mut Battle, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        finish_and_payout(arg0, arg2, arg3);
    }

    fun all_hand_candidate_moves() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 4);
        0x1::vector::push_back<u8>(&mut v0, 5);
        0x1::vector::push_back<u8>(&mut v0, 6);
        0x1::vector::push_back<u8>(&mut v0, 7);
        0x1::vector::push_back<u8>(&mut v0, 10);
        0x1::vector::push_back<u8>(&mut v0, 11);
        0x1::vector::push_back<u8>(&mut v0, 12);
        0x1::vector::push_back<u8>(&mut v0, 13);
        0x1::vector::push_back<u8>(&mut v0, 14);
        0x1::vector::push_back<u8>(&mut v0, 15);
        0x1::vector::push_back<u8>(&mut v0, 16);
        0x1::vector::push_back<u8>(&mut v0, 17);
        0x1::vector::push_back<u8>(&mut v0, 18);
        0x1::vector::push_back<u8>(&mut v0, 19);
        0x1::vector::push_back<u8>(&mut v0, 20);
        0x1::vector::push_back<u8>(&mut v0, 21);
        0x1::vector::push_back<u8>(&mut v0, 22);
        0x1::vector::push_back<u8>(&mut v0, 23);
        0x1::vector::push_back<u8>(&mut v0, 24);
        0x1::vector::push_back<u8>(&mut v0, 25);
        0x1::vector::push_back<u8>(&mut v0, 26);
        0x1::vector::push_back<u8>(&mut v0, 28);
        0x1::vector::push_back<u8>(&mut v0, 30);
        0x1::vector::push_back<u8>(&mut v0, 9);
        0x1::vector::push_back<u8>(&mut v0, 27);
        0x1::vector::push_back<u8>(&mut v0, 29);
        0x1::vector::push_back<u8>(&mut v0, 8);
        v0
    }

    fun apply_catalog_damage(arg0: u64, arg1: bool, arg2: &mut u64, arg3: &mut u64, arg4: &mut Status, arg5: &mut FighterCardState) {
        if (!arg1 && arg4.block_turns > 0) {
            arg4.block_turns = arg4.block_turns - 1;
            if (arg5.reflect_damage > 0) {
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, arg5.reflect_damage);
                arg5.reflect_damage = 0;
            };
            return
        };
        let v0 = arg0;
        if (0x1::option::is_some<u64>(&arg5.attack_cap)) {
            let v1 = *0x1::option::borrow<u64>(&arg5.attack_cap);
            if (arg0 > v1) {
                v0 = v1;
            };
            arg5.attack_cap = 0x1::option::none<u64>();
        };
        if (arg5.armor_half) {
            let v2 = v0 + 1;
            v0 = v2 / 2;
            arg5.armor_half = false;
        };
        *arg3 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg3, v0);
    }

    fun apply_catalog_start_of_turn(arg0: u8, arg1: u64, arg2: &mut u64, arg3: &mut Status) : bool {
        let v0 = if (arg1 >= 25) {
            3
        } else if (arg1 >= 15) {
            2
        } else {
            1
        };
        *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v0);
        let v1 = arg3.next_turn_penalty > 0 || arg3.poison_ticks > 0;
        if (arg0 == 14 || arg0 == 36) {
            arg3.next_turn_penalty = 0;
            arg3.poison_ticks = 0;
            arg3.poison_dpt = 0;
            return v1
        };
        if (arg0 == 20) {
            arg3.next_turn_penalty = 0;
        };
        if (arg3.next_turn_penalty > 0) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, arg3.next_turn_penalty);
            arg3.next_turn_penalty = 0;
        };
        if (arg3.poison_ticks > 0) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, arg3.poison_dpt);
            arg3.poison_ticks = arg3.poison_ticks - 1;
            if (arg3.poison_ticks == 0) {
                arg3.poison_dpt = 0;
            };
        };
        v1
    }

    fun apply_damage(arg0: u64, arg1: &mut Status) : u64 {
        if (arg1.block_turns > 0) {
            arg1.block_turns = arg1.block_turns - 1;
            0
        } else {
            arg0
        }
    }

    fun apply_player1_move(arg0: &mut Battle, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.p1_growth;
        let v1 = &mut arg0.p1_status;
        apply_start_of_turn_status(arg1, v0, v1);
        let v2 = &mut arg0.p1_growth;
        let v3 = &mut arg0.p2_growth;
        let v4 = &mut arg0.p1_status;
        let v5 = &mut arg0.p2_status;
        resolve_move(arg1, v2, v3, v4, v5, arg2, arg3);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player1_move_ranked_bot_v2(arg0: &mut RankedBotBattleV2, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CardRulesKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CardRulesKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<CardRulesKey, CardRulesState>(&mut arg0.id, v0);
            let v2 = v1.total_turns;
            let v3 = &mut arg0.p1_growth;
            let v4 = &mut arg0.p1_status;
            let v5 = &mut arg0.p1_growth;
            let v6 = &mut arg0.p2_growth;
            let v7 = &mut arg0.p1_status;
            let v8 = &mut arg0.p2_status;
            let v9 = &mut v1.p1;
            let v10 = &mut v1.p2;
            resolve_catalog_move(arg1, apply_catalog_start_of_turn(arg1, v2, v3, v4), v5, v6, v7, v8, v9, v10, arg2, arg3);
            v1.total_turns = v1.total_turns + 1;
        } else {
            let v11 = &mut arg0.p1_growth;
            let v12 = &mut arg0.p1_status;
            apply_start_of_turn_status(arg1, v11, v12);
            let v13 = &mut arg0.p1_growth;
            let v14 = &mut arg0.p2_growth;
            let v15 = &mut arg0.p1_status;
            let v16 = &mut arg0.p2_status;
            resolve_move(arg1, v13, v14, v15, v16, arg2, arg3);
        };
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player1_move_v2(arg0: &mut PvpBattleV2, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.p1_growth;
        let v1 = &mut arg0.p1_status;
        apply_start_of_turn_status(arg1, v0, v1);
        let v2 = &mut arg0.p1_growth;
        let v3 = &mut arg0.p2_growth;
        let v4 = &mut arg0.p1_status;
        let v5 = &mut arg0.p2_status;
        resolve_move(arg1, v2, v3, v4, v5, arg2, arg3);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player1_move_v3(arg0: &mut PvpBattleV3, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CardRulesKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CardRulesKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<CardRulesKey, CardRulesState>(&mut arg0.id, v0);
            let v2 = v1.total_turns;
            let v3 = &mut arg0.p1_growth;
            let v4 = &mut arg0.p1_status;
            let v5 = &mut arg0.p1_growth;
            let v6 = &mut arg0.p2_growth;
            let v7 = &mut arg0.p1_status;
            let v8 = &mut arg0.p2_status;
            let v9 = &mut v1.p1;
            let v10 = &mut v1.p2;
            resolve_catalog_move(arg1, apply_catalog_start_of_turn(arg1, v2, v3, v4), v5, v6, v7, v8, v9, v10, arg2, arg3);
            v1.total_turns = v1.total_turns + 1;
        } else {
            let v11 = &mut arg0.p1_growth;
            let v12 = &mut arg0.p1_status;
            apply_start_of_turn_status(arg1, v11, v12);
            let v13 = &mut arg0.p1_growth;
            let v14 = &mut arg0.p2_growth;
            let v15 = &mut arg0.p1_status;
            let v16 = &mut arg0.p2_status;
            resolve_move(arg1, v13, v14, v15, v16, arg2, arg3);
        };
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player2_move(arg0: &mut Battle, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.p2_growth;
        let v1 = &mut arg0.p2_status;
        apply_start_of_turn_status(arg1, v0, v1);
        let v2 = &mut arg0.p2_growth;
        let v3 = &mut arg0.p1_growth;
        let v4 = &mut arg0.p2_status;
        let v5 = &mut arg0.p1_status;
        resolve_move(arg1, v2, v3, v4, v5, arg2, arg3);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player2_move_ranked_bot_v2(arg0: &mut RankedBotBattleV2, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CardRulesKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CardRulesKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<CardRulesKey, CardRulesState>(&mut arg0.id, v0);
            let v2 = v1.total_turns;
            let v3 = &mut arg0.p2_growth;
            let v4 = &mut arg0.p2_status;
            let v5 = &mut arg0.p2_growth;
            let v6 = &mut arg0.p1_growth;
            let v7 = &mut arg0.p2_status;
            let v8 = &mut arg0.p1_status;
            let v9 = &mut v1.p2;
            let v10 = &mut v1.p1;
            resolve_catalog_move(arg1, apply_catalog_start_of_turn(arg1, v2, v3, v4), v5, v6, v7, v8, v9, v10, arg2, arg3);
            v1.total_turns = v1.total_turns + 1;
        } else {
            let v11 = &mut arg0.p2_growth;
            let v12 = &mut arg0.p2_status;
            apply_start_of_turn_status(arg1, v11, v12);
            let v13 = &mut arg0.p2_growth;
            let v14 = &mut arg0.p1_growth;
            let v15 = &mut arg0.p2_status;
            let v16 = &mut arg0.p1_status;
            resolve_move(arg1, v13, v14, v15, v16, arg2, arg3);
        };
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player2_move_v2(arg0: &mut PvpBattleV2, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.p2_growth;
        let v1 = &mut arg0.p2_status;
        apply_start_of_turn_status(arg1, v0, v1);
        let v2 = &mut arg0.p2_growth;
        let v3 = &mut arg0.p1_growth;
        let v4 = &mut arg0.p2_status;
        let v5 = &mut arg0.p1_status;
        resolve_move(arg1, v2, v3, v4, v5, arg2, arg3);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player2_move_v3(arg0: &mut PvpBattleV3, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CardRulesKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CardRulesKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<CardRulesKey, CardRulesState>(&mut arg0.id, v0);
            let v2 = v1.total_turns;
            let v3 = &mut arg0.p2_growth;
            let v4 = &mut arg0.p2_status;
            let v5 = &mut arg0.p2_growth;
            let v6 = &mut arg0.p1_growth;
            let v7 = &mut arg0.p2_status;
            let v8 = &mut arg0.p1_status;
            let v9 = &mut v1.p2;
            let v10 = &mut v1.p1;
            resolve_catalog_move(arg1, apply_catalog_start_of_turn(arg1, v2, v3, v4), v5, v6, v7, v8, v9, v10, arg2, arg3);
            v1.total_turns = v1.total_turns + 1;
        } else {
            let v11 = &mut arg0.p2_growth;
            let v12 = &mut arg0.p2_status;
            apply_start_of_turn_status(arg1, v11, v12);
            let v13 = &mut arg0.p2_growth;
            let v14 = &mut arg0.p1_growth;
            let v15 = &mut arg0.p2_status;
            let v16 = &mut arg0.p1_status;
            resolve_move(arg1, v13, v14, v15, v16, arg2, arg3);
        };
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_start_of_turn_status(arg0: u8, arg1: &mut u64, arg2: &mut Status) {
        if (arg0 == 14) {
            arg2.next_turn_penalty = 0;
            arg2.poison_ticks = 0;
            arg2.poison_dpt = 0;
            return
        };
        if (arg2.next_turn_penalty > 0) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg1, arg2.next_turn_penalty);
            arg2.next_turn_penalty = 0;
        };
        if (arg2.poison_ticks > 0) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg1, arg2.poison_dpt);
            arg2.poison_ticks = arg2.poison_ticks - 1;
            if (arg2.poison_ticks == 0) {
                arg2.poison_dpt = 0;
            };
        };
    }

    fun assert_not_repeated_and_record(arg0: &mut PvpBattleV3, arg1: bool, arg2: u8) {
        let v0 = PvpV3RulesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<PvpV3RulesKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<PvpV3RulesKey, PvpV3RulesState>(&mut arg0.id, v0);
        if (arg1) {
            if (0x1::option::is_some<u8>(&v1.p1_last_move)) {
                assert!(*0x1::option::borrow<u8>(&v1.p1_last_move) != arg2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_move_repeated());
            };
            v1.p1_last_move = 0x1::option::some<u8>(arg2);
        } else {
            if (0x1::option::is_some<u8>(&v1.p2_last_move)) {
                assert!(*0x1::option::borrow<u8>(&v1.p2_last_move) != arg2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_move_repeated());
            };
            v1.p2_last_move = 0x1::option::some<u8>(arg2);
        };
    }

    fun assert_ranked_bot_move_not_repeated(arg0: &RankedBotBattleV2, arg1: u8) {
        let v0 = CardRulesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<CardRulesKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow<CardRulesKey, CardRulesState>(&arg0.id, v0);
        if (0x1::option::is_some<u8>(&v1.p1.last_move)) {
            assert!(*0x1::option::borrow<u8>(&v1.p1.last_move) != arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_move_repeated());
        };
    }

    fun assert_valid_pvp_v2_target(arg0: u64) {
        assert!(is_valid_pvp_v2_target(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_target_growth());
    }

    fun attack_hand_candidate_moves() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 4);
        0x1::vector::push_back<u8>(&mut v0, 5);
        0x1::vector::push_back<u8>(&mut v0, 6);
        0x1::vector::push_back<u8>(&mut v0, 7);
        0x1::vector::push_back<u8>(&mut v0, 10);
        0x1::vector::push_back<u8>(&mut v0, 11);
        0x1::vector::push_back<u8>(&mut v0, 12);
        0x1::vector::push_back<u8>(&mut v0, 13);
        0x1::vector::push_back<u8>(&mut v0, 16);
        v0
    }

    fun bot_move_score(arg0: u8, arg1: u64, arg2: u64, arg3: &Status, arg4: &Status) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = expected_self_growth(arg0);
        if (v2 > 0 && arg1 < 100) {
            let v3 = 100 - arg1;
            let v4 = if (v2 > v3) {
                v3
            } else {
                v2
            };
            v1 = v0 + 100 + v4;
        };
        let v5 = expected_damage(arg0);
        if (v5 > 0 && arg2 > 0) {
            if (arg4.block_turns > 0) {
                v1 = v1 + 10;
            } else {
                let v6 = if (v5 > arg2) {
                    arg2
                } else {
                    v5
                };
                let v7 = v1 + 40;
                v1 = v7 + v6;
            };
        };
        let v8 = if (arg0 == 10) {
            if (arg2 > 0) {
                arg4.poison_ticks == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            v1 = v1 + 35;
        };
        let v9 = if (arg0 == 32) {
            if (arg2 > 0) {
                arg4.poison_ticks == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v9) {
            v1 = v1 + 30;
        };
        if (arg0 == 13 && arg2 > 0) {
            v1 = v1 + 20;
        };
        if (adds_block(arg0)) {
            let v10 = if (arg3.block_turns == 0) {
                12
            } else {
                2
            };
            v1 = v1 + v10;
        };
        if (v1 == 0) {
            1
        } else {
            v1
        }
    }

    fun bot_score_is_viable(arg0: u64, arg1: u64) : bool {
        arg0 == arg1 || arg1 - arg0 <= 20
    }

    fun candidates_excluding(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(arg1, v2)) {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun charge_reroll<T0>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::TreeConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_utility_coin<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_incorrect_coin_type());
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::reroll_cost(arg0) * arg2;
        assert!(v0 > 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_tree_insufficient());
        assert!(0x2::coin::value<T0>(&arg1) >= v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0, arg3), @0x0);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    fun choose_bot_move(arg0: &Battle, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x1::vector::length<u8>(&arg0.p2_moves);
        assert!(v0 > 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_move());
        let v1 = *0x1::vector::borrow<u8>(&arg0.p2_moves, v0 - 1);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = bot_move_score(*0x1::vector::borrow<u8>(&arg0.p2_moves, v4), arg0.p2_growth, arg0.p1_growth, &arg0.p2_status, &arg0.p1_status);
            if (v5 > v2) {
                v3 = v5;
            };
            v4 = v4 + 1;
        };
        let v6 = 0;
        let v7 = 0;
        v4 = 0;
        while (v4 < v0) {
            let v8 = *0x1::vector::borrow<u8>(&arg0.p2_moves, v4);
            if (bot_score_is_viable(bot_move_score(v8, arg0.p2_growth, arg0.p1_growth, &arg0.p2_status, &arg0.p1_status), v3)) {
                v6 = v6 + 1;
                if (v8 != v1) {
                    v7 = v7 + 1;
                };
            };
            v4 = v4 + 1;
        };
        let v9 = v7 > 0;
        let v10 = if (v9) {
            v7
        } else {
            v6
        };
        let v11 = 0x2::random::new_generator(arg1, arg2);
        let v12 = 0;
        v4 = 0;
        while (v4 < v0) {
            let v13 = *0x1::vector::borrow<u8>(&arg0.p2_moves, v4);
            if (bot_score_is_viable(bot_move_score(v13, arg0.p2_growth, arg0.p1_growth, &arg0.p2_status, &arg0.p1_status), v3) && (!v9 || v13 != v1)) {
                if (v12 == 0x2::random::generate_u64(&mut v11) % v10) {
                    return v13
                };
                v12 = v12 + 1;
            };
            v4 = v4 + 1;
        };
        *0x1::vector::borrow<u8>(&arg0.p2_moves, 0)
    }

    fun choose_ranked_bot_v2_move(arg0: &RankedBotBattleV2, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x1::vector::length<u8>(&arg0.p2_moves);
        assert!(v0 > 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_move());
        let v1 = *0x1::vector::borrow<u8>(&arg0.p2_moves, v0 - 1);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = bot_move_score(*0x1::vector::borrow<u8>(&arg0.p2_moves, v4), arg0.p2_growth, arg0.p1_growth, &arg0.p2_status, &arg0.p1_status);
            if (v5 > v2) {
                v3 = v5;
            };
            v4 = v4 + 1;
        };
        let v6 = 0;
        let v7 = 0;
        v4 = 0;
        while (v4 < v0) {
            let v8 = *0x1::vector::borrow<u8>(&arg0.p2_moves, v4);
            if (bot_score_is_viable(bot_move_score(v8, arg0.p2_growth, arg0.p1_growth, &arg0.p2_status, &arg0.p1_status), v3)) {
                v6 = v6 + 1;
                if (v8 != v1) {
                    v7 = v7 + 1;
                };
            };
            v4 = v4 + 1;
        };
        let v9 = v7 > 0;
        let v10 = if (v9) {
            v7
        } else {
            v6
        };
        let v11 = 0x2::random::new_generator(arg1, arg2);
        let v12 = 0;
        v4 = 0;
        while (v4 < v0) {
            let v13 = *0x1::vector::borrow<u8>(&arg0.p2_moves, v4);
            if (bot_score_is_viable(bot_move_score(v13, arg0.p2_growth, arg0.p1_growth, &arg0.p2_status, &arg0.p1_status), v3) && (!v9 || v13 != v1)) {
                if (v12 == 0x2::random::generate_u64(&mut v11) % v10) {
                    return v13
                };
                v12 = v12 + 1;
            };
            v4 = v4 + 1;
        };
        *0x1::vector::borrow<u8>(&arg0.p2_moves, 0)
    }

    public fun claim_timeout_win(arg0: &mut Battle, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(arg0.turn == 0 && v0 == arg0.player2 || v0 == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        let v1 = if (arg0.is_bot_battle) {
            600000
        } else {
            86400000
        };
        assert!(0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.last_move_ms + v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        finish_and_payout(arg0, v0, arg1);
    }

    public fun claim_timeout_win_pvp_v2(arg0: &mut PvpBattleV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(arg0.turn == 0 && v0 == arg0.player2 || v0 == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.last_move_ms + 86400000, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        finish_and_payout_v2(arg0, v0, arg1);
    }

    public fun claim_timeout_win_pvp_v3(arg0: &mut PvpBattleV3, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(arg0.turn == 0 && v0 == arg0.player2 || v0 == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.last_move_ms + 86400000, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        finish_and_payout_v3(arg0, v0, arg1);
    }

    public fun claim_timeout_win_ranked_bot_v2(arg0: &mut RankedBotBattleV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        assert!(0x2::tx_context::sender(arg1) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.last_move_ms + 600000, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        let v0 = arg0.player1;
        finish_and_payout_ranked_bot_v2(arg0, v0, arg1);
    }

    fun clear_one_block(arg0: &mut Status, arg1: &mut FighterCardState) {
        if (arg0.block_turns > 0) {
            arg0.block_turns = arg0.block_turns - 1;
            arg1.reflect_damage = 0;
        };
    }

    public fun create_battle(arg0: address, arg1: address, arg2: u64, arg3: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        let v0 = 0x2::object::new(arg6);
        let v1 = gen_moves(arg5, arg6);
        let v2 = gen_moves(arg5, arg6);
        let v3 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v4 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v5 = Battle{
            id               : v0,
            player1          : arg0,
            player2          : arg1,
            p1_growth        : 0,
            p2_growth        : 0,
            turn             : 0,
            finished         : false,
            winner           : 0x1::option::none<address>(),
            p1_moves         : v1,
            p2_moves         : v2,
            p1_status        : v3,
            p2_status        : v4,
            vault            : arg4,
            battle_entry_fee : arg2,
            winner_payout    : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::winner_payout(arg3),
            treasury_share   : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury_share(arg3),
            treasury_addr    : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg3),
            last_move_ms     : 0x2::tx_context::epoch_timestamp_ms(arg6),
            is_bot_battle    : false,
        };
        emit_update(&v5);
        0x2::transfer::share_object<Battle>(v5);
    }

    entry fun create_bot_battle<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &T0, arg2: address, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 != @0x0 && arg2 != v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        let v1 = 0x2::object::new(arg4);
        let v2 = gen_moves(arg3, arg4);
        let v3 = gen_moves(arg3, arg4);
        let v4 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v5 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v6 = Battle{
            id               : v1,
            player1          : v0,
            player2          : arg2,
            p1_growth        : 0,
            p2_growth        : 0,
            turn             : 0,
            finished         : false,
            winner           : 0x1::option::none<address>(),
            p1_moves         : v2,
            p2_moves         : v3,
            p1_status        : v4,
            p2_status        : v5,
            vault            : 0x2::balance::zero<0x2::sui::SUI>(),
            battle_entry_fee : 0,
            winner_payout    : 0,
            treasury_share   : 0,
            treasury_addr    : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg0),
            last_move_ms     : 0x2::tx_context::epoch_timestamp_ms(arg4),
            is_bot_battle    : true,
        };
        emit_update(&v6);
        0x2::transfer::share_object<Battle>(v6);
    }

    entry fun create_bot_battle_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<T0>(arg1, arg2, arg3);
        let v2 = v0;
        create_bot_battle<T0>(arg0, &v2, arg4, arg5, arg6);
        0x2::kiosk::return_val<T0>(arg1, v2, v1);
    }

    entry fun create_paid_bot_battle<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &T0, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::entry_fee(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg2 != @0x0 && arg2 != v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        let v2 = 0x2::object::new(arg5);
        let v3 = gen_moves(arg4, arg5);
        let v4 = gen_moves(arg4, arg5);
        let v5 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v6 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v7 = Battle{
            id               : v2,
            player1          : v1,
            player2          : arg2,
            p1_growth        : 0,
            p2_growth        : 0,
            turn             : 0,
            finished         : false,
            winner           : 0x1::option::none<address>(),
            p1_moves         : v3,
            p2_moves         : v4,
            p1_status        : v5,
            p2_status        : v6,
            vault            : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            battle_entry_fee : v0,
            winner_payout    : v0,
            treasury_share   : 0,
            treasury_addr    : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg0),
            last_move_ms     : 0x2::tx_context::epoch_timestamp_ms(arg5),
            is_bot_battle    : true,
        };
        emit_update(&v7);
        0x2::transfer::share_object<Battle>(v7);
    }

    entry fun create_paid_bot_battle_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<T0>(arg1, arg2, arg3);
        let v2 = v0;
        create_paid_bot_battle<T0>(arg0, &v2, arg4, arg5, arg6, arg7);
        0x2::kiosk::return_val<T0>(arg1, v2, v1);
    }

    public fun create_pvp_battle_v2(arg0: address, arg1: address, arg2: u64, arg3: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: u64, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_pvp_v2_target(arg5);
        assert!(arg0 != arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        let v0 = 0x2::object::new(arg7);
        let v1 = gen_moves(arg6, arg7);
        let v2 = gen_moves(arg6, arg7);
        let v3 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v4 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v5 = PvpBattleV2{
            id               : v0,
            player1          : arg0,
            player2          : arg1,
            p1_growth        : 0,
            p2_growth        : 0,
            turn             : 0,
            finished         : false,
            winner           : 0x1::option::none<address>(),
            p1_moves         : v1,
            p2_moves         : v2,
            p1_status        : v3,
            p2_status        : v4,
            vault            : arg4,
            battle_entry_fee : arg2,
            winner_payout    : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::winner_payout(arg3),
            treasury_share   : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury_share(arg3),
            treasury_addr    : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg3),
            last_move_ms     : 0x2::tx_context::epoch_timestamp_ms(arg7),
            target_growth    : arg5,
        };
        emit_update_v2(&v5);
        0x2::transfer::share_object<PvpBattleV2>(v5);
    }

    public fun create_pvp_battle_v3(arg0: address, arg1: address, arg2: u64, arg3: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: u64, arg6: 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveEligibility, arg7: 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveEligibility, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        assert_valid_pvp_v2_target(arg5);
        assert!(arg0 != arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::entitled(&arg6);
        let v1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::entitled(&arg7);
        let v2 = 0x2::random::new_generator(arg8, arg9);
        let v3 = 0x2::object::new(arg9);
        let v4 = gen_moves_for_entitlement(v0, arg8, arg9);
        let v5 = gen_moves_for_entitlement(v1, arg8, arg9);
        let v6 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v7 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v8 = PvpBattleV3{
            id                     : v3,
            player1                : arg0,
            player2                : arg1,
            p1_growth              : 0,
            p2_growth              : 0,
            turn                   : ((0x2::random::generate_u64(&mut v2) % 2) as u8),
            finished               : false,
            winner                 : 0x1::option::none<address>(),
            p1_moves               : v4,
            p2_moves               : v5,
            p1_status              : v6,
            p2_status              : v7,
            vault                  : arg4,
            battle_entry_fee       : arg2,
            winner_payout          : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::winner_payout(arg3),
            treasury_share         : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury_share(arg3),
            treasury_addr          : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg3),
            last_move_ms           : 0x2::tx_context::epoch_timestamp_ms(arg9),
            target_growth          : arg5,
            p1_fifth_move_entitled : v0,
            p2_fifth_move_entitled : v1,
            p1_eligibility_digest  : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::attestation_digest(&arg6),
            p2_eligibility_digest  : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::attestation_digest(&arg7),
            p1_reroll_used         : false,
            p2_reroll_used         : false,
        };
        let v9 = PvpV3RulesKey{dummy_field: false};
        let v10 = PvpV3RulesState{
            p1_last_move : 0x1::option::none<u8>(),
            p2_last_move : 0x1::option::none<u8>(),
        };
        0x2::dynamic_field::add<PvpV3RulesKey, PvpV3RulesState>(&mut v8.id, v9, v10);
        let v11 = &mut v8.id;
        add_card_rules_state(v11);
        emit_update_v3(&v8);
        0x2::transfer::share_object<PvpBattleV3>(v8);
    }

    public entry fun create_ranked_bot_battle_v2<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &T0, arg2: address, arg3: 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveEligibility, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg2 != @0x0 && arg2 != v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        let v1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::entitled(&arg3);
        let v2 = 0x2::object::new(arg5);
        let v3 = gen_moves_for_entitlement(v1, arg4, arg5);
        let v4 = gen_moves(arg4, arg5);
        let v5 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v6 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v7 = RankedBotBattleV2{
            id                     : v2,
            player1                : v0,
            player2                : arg2,
            p1_growth              : 0,
            p2_growth              : 0,
            turn                   : 0,
            finished               : false,
            winner                 : 0x1::option::none<address>(),
            p1_moves               : v3,
            p2_moves               : v4,
            p1_status              : v5,
            p2_status              : v6,
            vault                  : 0x2::balance::zero<0x2::sui::SUI>(),
            battle_entry_fee       : 0,
            winner_payout          : 0,
            treasury_share         : 0,
            treasury_addr          : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg0),
            last_move_ms           : 0x2::tx_context::epoch_timestamp_ms(arg5),
            target_growth          : 50,
            p1_fifth_move_entitled : v1,
            p1_eligibility_digest  : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::attestation_digest(&arg3),
            p1_reroll_used         : false,
        };
        let v8 = &mut v7.id;
        add_card_rules_state(v8);
        emit_update_ranked_bot_v2(&v7);
        0x2::transfer::share_object<RankedBotBattleV2>(v7);
    }

    public entry fun create_ranked_bot_battle_v2_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveEligibility, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<T0>(arg1, arg2, arg3);
        let v2 = v0;
        create_ranked_bot_battle_v2<T0>(arg0, &v2, arg4, arg5, arg6, arg7);
        0x2::kiosk::return_val<T0>(arg1, v2, v1);
    }

    public entry fun create_ranked_bot_battle_v2_standard<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &T0, arg2: address, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        create_ranked_bot_battle_v2<T0>(arg0, arg1, arg2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::standard_eligibility(), arg3, arg4);
    }

    public entry fun create_ranked_bot_battle_v2_standard_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<T0>(arg1, arg2, arg3);
        let v2 = v0;
        create_ranked_bot_battle_v2_standard<T0>(arg0, &v2, arg4, arg5, arg6);
        0x2::kiosk::return_val<T0>(arg1, v2, v1);
    }

    public entry fun create_ranked_bot_battle_v2_with_fifth_move<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveConfig, arg2: &T0, arg3: address, arg4: vector<u8>, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x2::random::Random, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::verify_attestation(arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::payload(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::config_id(arg1), 0x2::tx_context::sender(arg14), arg5, arg6, arg7, arg8, arg9, arg10, arg11), arg4, arg12, arg14);
        create_ranked_bot_battle_v2<T0>(arg0, arg2, arg3, v0, arg13, arg14);
    }

    public entry fun create_ranked_bot_battle_v2_with_fifth_move_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveConfig, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: address, arg6: vector<u8>, arg7: bool, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &0x2::random::Random, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<T0>(arg2, arg3, arg4);
        let v2 = v0;
        create_ranked_bot_battle_v2_with_fifth_move<T0>(arg0, arg1, &v2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0x2::kiosk::return_val<T0>(arg2, v2, v1);
    }

    fun emit_bot_move_resolved(arg0: &Battle, arg1: u8) {
        let v0 = BotMoveResolved{
            battle_id  : 0x2::object::uid_to_inner(&arg0.id),
            bot_player : arg0.player2,
            move_id    : arg1,
        };
        0x2::event::emit<BotMoveResolved>(v0);
    }

    fun emit_ranked_bot_v2_move_resolved(arg0: &RankedBotBattleV2, arg1: u8) {
        let v0 = BotMoveResolved{
            battle_id  : 0x2::object::uid_to_inner(&arg0.id),
            bot_player : arg0.player2,
            move_id    : arg1,
        };
        0x2::event::emit<BotMoveResolved>(v0);
    }

    fun emit_update(arg0: &Battle) {
        let v0 = BattleUpdate{
            battle_id      : 0x2::object::uid_to_inner(&arg0.id),
            player1        : arg0.player1,
            player2        : arg0.player2,
            player1_moves  : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clone_vec_u8(&arg0.p1_moves),
            player2_moves  : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clone_vec_u8(&arg0.p2_moves),
            player1_growth : arg0.p1_growth,
            player2_growth : arg0.p2_growth,
            winner         : arg0.winner,
            last_move_ms   : arg0.last_move_ms,
            is_bot_battle  : arg0.is_bot_battle,
        };
        0x2::event::emit<BattleUpdate>(v0);
    }

    fun emit_update_ranked_bot_v2(arg0: &RankedBotBattleV2) {
        let v0 = RankedBotBattleV2Update{
            battle_id              : 0x2::object::uid_to_inner(&arg0.id),
            player1                : arg0.player1,
            player2                : arg0.player2,
            player1_moves          : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clone_vec_u8(&arg0.p1_moves),
            player2_moves          : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clone_vec_u8(&arg0.p2_moves),
            player1_growth         : arg0.p1_growth,
            player2_growth         : arg0.p2_growth,
            winner                 : arg0.winner,
            last_move_ms           : arg0.last_move_ms,
            target_growth          : arg0.target_growth,
            p1_fifth_move_entitled : arg0.p1_fifth_move_entitled,
            p1_reroll_used         : arg0.p1_reroll_used,
        };
        0x2::event::emit<RankedBotBattleV2Update>(v0);
    }

    fun emit_update_v2(arg0: &PvpBattleV2) {
        let v0 = PvpBattleV2Update{
            battle_id      : 0x2::object::uid_to_inner(&arg0.id),
            player1        : arg0.player1,
            player2        : arg0.player2,
            player1_moves  : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clone_vec_u8(&arg0.p1_moves),
            player2_moves  : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clone_vec_u8(&arg0.p2_moves),
            player1_growth : arg0.p1_growth,
            player2_growth : arg0.p2_growth,
            winner         : arg0.winner,
            last_move_ms   : arg0.last_move_ms,
            target_growth  : arg0.target_growth,
        };
        0x2::event::emit<PvpBattleV2Update>(v0);
    }

    fun emit_update_v3(arg0: &PvpBattleV3) {
        let v0 = PvpBattleV3Update{
            battle_id              : 0x2::object::uid_to_inner(&arg0.id),
            player1                : arg0.player1,
            player2                : arg0.player2,
            player1_moves          : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clone_vec_u8(&arg0.p1_moves),
            player2_moves          : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clone_vec_u8(&arg0.p2_moves),
            player1_growth         : arg0.p1_growth,
            player2_growth         : arg0.p2_growth,
            winner                 : arg0.winner,
            last_move_ms           : arg0.last_move_ms,
            target_growth          : arg0.target_growth,
            p1_fifth_move_entitled : arg0.p1_fifth_move_entitled,
            p2_fifth_move_entitled : arg0.p2_fifth_move_entitled,
            p1_reroll_used         : arg0.p1_reroll_used,
            p2_reroll_used         : arg0.p2_reroll_used,
        };
        0x2::event::emit<PvpBattleV3Update>(v0);
    }

    fun expected_damage(arg0: u8) : u64 {
        if (arg0 == 1) {
            11
        } else if (arg0 == 2) {
            8
        } else if (arg0 == 3) {
            12
        } else if (arg0 == 4) {
            11
        } else if (arg0 == 5) {
            8
        } else if (arg0 == 6) {
            12
        } else if (arg0 == 7) {
            10
        } else if (arg0 == 9) {
            6
        } else if (arg0 == 11) {
            13
        } else if (arg0 == 12) {
            10
        } else if (arg0 == 13) {
            7
        } else if (arg0 == 16) {
            16
        } else if (arg0 == 18) {
            5
        } else if (arg0 == 31) {
            8
        } else if (arg0 == 32) {
            6
        } else if (arg0 == 33) {
            8
        } else if (arg0 == 38) {
            6
        } else {
            0
        }
    }

    fun expected_self_growth(arg0: u8) : u64 {
        if (arg0 == 8) {
            6
        } else if (arg0 == 9) {
            4
        } else if (arg0 == 14) {
            10
        } else if (arg0 == 15) {
            10
        } else if (arg0 == 17) {
            7
        } else if (arg0 == 18) {
            5
        } else if (arg0 == 19) {
            10
        } else if (arg0 == 20) {
            10
        } else if (arg0 == 21) {
            11
        } else if (arg0 == 22) {
            10
        } else if (arg0 == 23) {
            10
        } else if (arg0 == 24) {
            14
        } else if (arg0 == 25) {
            12
        } else if (arg0 == 26) {
            11
        } else if (arg0 == 27) {
            7
        } else if (arg0 == 28) {
            10
        } else if (arg0 == 29) {
            8
        } else if (arg0 == 30) {
            8
        } else if (arg0 == 31) {
            3
        } else if (arg0 == 32) {
            4
        } else if (arg0 == 33) {
            3
        } else if (arg0 == 34) {
            10
        } else if (arg0 == 35) {
            10
        } else if (arg0 == 36) {
            9
        } else if (arg0 == 37) {
            7
        } else if (arg0 == 38) {
            6
        } else if (arg0 == 39) {
            8
        } else {
            0
        }
    }

    fun fifth_attack_candidate_moves() : vector<u8> {
        x"1f2021"
    }

    fun fifth_growth_candidate_moves() : vector<u8> {
        b"\"#$"
    }

    fun fifth_hybrid_candidate_moves() : vector<u8> {
        b"%&'"
    }

    fun fifth_move_draft_pending(arg0: &vector<u8>, arg1: bool) : bool {
        arg1 && 0x1::vector::length<u8>(arg0) == 7
    }

    fun finish_and_payout(arg0: &mut Battle, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        arg0.finished = true;
        arg0.winner = 0x1::option::some<address>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= arg0.winner_payout + arg0.treasury_share, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_vault());
        if (arg0.winner_payout > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.winner_payout), arg2), arg1);
        };
        if (arg0.treasury_share > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.treasury_share), arg2), arg0.treasury_addr);
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg1);
        };
        emit_update(arg0);
    }

    fun finish_and_payout_ranked_bot_v2(arg0: &mut RankedBotBattleV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        arg0.finished = true;
        arg0.winner = 0x1::option::some<address>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= arg0.winner_payout + arg0.treasury_share, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_vault());
        if (arg0.winner_payout > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.winner_payout), arg2), arg1);
        };
        if (arg0.treasury_share > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.treasury_share), arg2), arg0.treasury_addr);
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg1);
        };
        emit_update_ranked_bot_v2(arg0);
    }

    fun finish_and_payout_v2(arg0: &mut PvpBattleV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        arg0.finished = true;
        arg0.winner = 0x1::option::some<address>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= arg0.winner_payout + arg0.treasury_share, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_vault());
        if (arg0.winner_payout > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.winner_payout), arg2), arg1);
        };
        if (arg0.treasury_share > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.treasury_share), arg2), arg0.treasury_addr);
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg1);
        };
        emit_update_v2(arg0);
    }

    fun finish_and_payout_v3(arg0: &mut PvpBattleV3, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        arg0.finished = true;
        arg0.winner = 0x1::option::some<address>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= arg0.winner_payout + arg0.treasury_share, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_vault());
        if (arg0.winner_payout > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.winner_payout), arg2), arg1);
        };
        if (arg0.treasury_share > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.treasury_share), arg2), arg0.treasury_addr);
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2), arg1);
        };
        emit_update_v3(arg0);
    }

    fun gen_free_ranked_bot_reroll_moves(arg0: &vector<u8>, arg1: bool, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = gen_reroll_moves(arg0, false, arg2, arg3);
        if (!arg1) {
            return v0
        };
        let v1 = 0x1::vector::length<u8>(arg0);
        if (v1 == 7) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, 4));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, 5));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, 6));
        } else if (v1 >= 5) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, 4));
        };
        v0
    }

    fun gen_moves(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = attack_hand_candidate_moves();
        let v1 = growth_hand_candidate_moves();
        let v2 = hybrid_hand_candidate_moves();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x2::random::new_generator(arg0, arg1);
        0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v0, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v0)));
        0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v1, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v1)));
        0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v2)));
        let v5 = all_hand_candidate_moves();
        let v6 = candidates_excluding(&v5, &v3);
        0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v6, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v6)));
        v3
    }

    fun gen_moves_for_entitlement(arg0: bool, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = gen_moves(arg1, arg2);
        if (!arg0) {
            return v0
        };
        let v1 = fifth_attack_candidate_moves();
        let v2 = fifth_growth_candidate_moves();
        let v3 = fifth_hybrid_candidate_moves();
        let v4 = 0x2::random::new_generator(arg1, arg2);
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v1)));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v2, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v2)));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v3, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v3)));
        v0
    }

    fun gen_reroll_moves(arg0: &vector<u8>, arg1: bool, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = attack_hand_candidate_moves();
        let v1 = candidates_excluding(&v0, arg0);
        let v2 = growth_hand_candidate_moves();
        let v3 = candidates_excluding(&v2, arg0);
        let v4 = hybrid_hand_candidate_moves();
        let v5 = candidates_excluding(&v4, arg0);
        let v6 = 0x2::random::new_generator(arg2, arg3);
        let v7 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v1, 0x2::random::generate_u64(&mut v6) % 0x1::vector::length<u8>(&v1)));
        0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v3, 0x2::random::generate_u64(&mut v6) % 0x1::vector::length<u8>(&v3)));
        0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v5, 0x2::random::generate_u64(&mut v6) % 0x1::vector::length<u8>(&v5)));
        let v8 = all_hand_candidate_moves();
        let v9 = candidates_excluding(&v8, arg0);
        let v10 = candidates_excluding(&v9, &v7);
        0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v10, 0x2::random::generate_u64(&mut v6) % 0x1::vector::length<u8>(&v10)));
        if (!arg1) {
            return v7
        };
        let v11 = fifth_attack_candidate_moves();
        let v12 = candidates_excluding(&v11, arg0);
        let v13 = fifth_growth_candidate_moves();
        let v14 = candidates_excluding(&v13, arg0);
        let v15 = fifth_hybrid_candidate_moves();
        let v16 = candidates_excluding(&v15, arg0);
        let v17 = candidates_excluding(&v12, &v7);
        let v18 = candidates_excluding(&v14, &v7);
        let v19 = candidates_excluding(&v16, &v7);
        0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v17, 0x2::random::generate_u64(&mut v6) % 0x1::vector::length<u8>(&v17)));
        0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v18, 0x2::random::generate_u64(&mut v6) % 0x1::vector::length<u8>(&v18)));
        0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v19, 0x2::random::generate_u64(&mut v6) % 0x1::vector::length<u8>(&v19)));
        v7
    }

    fun growth_hand_candidate_moves() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 15);
        0x1::vector::push_back<u8>(&mut v0, 19);
        0x1::vector::push_back<u8>(&mut v0, 20);
        0x1::vector::push_back<u8>(&mut v0, 21);
        0x1::vector::push_back<u8>(&mut v0, 22);
        0x1::vector::push_back<u8>(&mut v0, 23);
        0x1::vector::push_back<u8>(&mut v0, 24);
        0x1::vector::push_back<u8>(&mut v0, 25);
        0x1::vector::push_back<u8>(&mut v0, 26);
        0x1::vector::push_back<u8>(&mut v0, 28);
        0x1::vector::push_back<u8>(&mut v0, 30);
        v0
    }

    fun hybrid_hand_candidate_moves() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 8);
        0x1::vector::push_back<u8>(&mut v0, 9);
        0x1::vector::push_back<u8>(&mut v0, 14);
        0x1::vector::push_back<u8>(&mut v0, 17);
        0x1::vector::push_back<u8>(&mut v0, 18);
        0x1::vector::push_back<u8>(&mut v0, 27);
        0x1::vector::push_back<u8>(&mut v0, 29);
        v0
    }

    fun is_attack_move(arg0: u8) : bool {
        if (is_standard_attack(arg0)) {
            true
        } else if (arg0 == 31) {
            true
        } else if (arg0 == 32) {
            true
        } else {
            arg0 == 33
        }
    }

    fun is_growth_move(arg0: u8) : bool {
        if (arg0 == 15) {
            true
        } else if (arg0 == 19) {
            true
        } else if (arg0 == 20) {
            true
        } else if (arg0 == 21) {
            true
        } else if (arg0 == 22) {
            true
        } else if (arg0 == 23) {
            true
        } else if (arg0 == 24) {
            true
        } else if (arg0 == 25) {
            true
        } else if (arg0 == 26) {
            true
        } else if (arg0 == 28) {
            true
        } else if (arg0 == 30) {
            true
        } else if (arg0 == 34) {
            true
        } else if (arg0 == 35) {
            true
        } else {
            arg0 == 36
        }
    }

    fun is_standard_attack(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 10) {
            true
        } else if (arg0 == 11) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 13) {
            true
        } else {
            arg0 == 16
        }
    }

    public fun is_valid_pvp_v2_target(arg0: u64) : bool {
        arg0 == 50 || arg0 == 75
    }

    fun lock_fifth_move_draft(arg0: &mut vector<u8>, arg1: u8) {
        assert!(0x1::vector::length<u8>(arg0) == 7, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_draft_required());
        let v0 = if (*0x1::vector::borrow<u8>(arg0, 4) == arg1) {
            true
        } else if (*0x1::vector::borrow<u8>(arg0, 5) == arg1) {
            true
        } else {
            *0x1::vector::borrow<u8>(arg0, 6) == arg1
        };
        assert!(v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_invalid_draft_choice());
        0x1::vector::pop_back<u8>(arg0);
        0x1::vector::pop_back<u8>(arg0);
        0x1::vector::pop_back<u8>(arg0);
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    fun map_ability_name(arg0: vector<u8>) : u8 {
        if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"Wedgebreaker") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ThornSpikeBomb")) {
            1
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"SkyreachSaw") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RazorLeafSword")) {
            2
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ChainsawCyclone") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"TumbleweedMace")) {
            3
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"Rootpiercer") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ShovelSpear")) {
            4
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"LimbfallSlam") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ThornedWhip")) {
            5
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"AcornBarrage") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"AcornSlingshot")) {
            6
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"LogSwingRampage") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"StoneNunchuck")) {
            7
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"BarklashShield") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"CactusShield")) {
            8
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RootSiphon") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"LifeAbsorb")) {
            9
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"BeetleBlight") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"Poison")) {
            10
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"LightningCrown") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"WitherTouch")) {
            11
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"AirSpadeBlast") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PollenCloud")) {
            12
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"FungalDoom") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"FungalRot")) {
            13
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"CompostCleanse") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"CompostTea")) {
            14
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RootlinkSurge") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"MycorrhizalNetwork")) {
            15
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PruningFury") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PruningShears")) {
            16
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"MulchFortress") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"MulchBarrier")) {
            17
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"GraftFusion") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RootGraft")) {
            18
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"WildwoodGamble") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"OvergrowthGamble")) {
            19
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RootRevival") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RootsUp")) {
            20
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"SolarBloom") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"SunBeam")) {
            21
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"Rainmaker") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RainStorm")) {
            22
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"MycoMight") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"WhiteMold")) {
            23
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"CanopyDownpour") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"GreenhouseGas")) {
            24
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PotassiumPower") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PotassiumPowerUp")) {
            25
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PhotosynthesisOverdrive") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PhotosyntheticSurge")) {
            26
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"IronbarkArmor") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"BarkskinArmor")) {
            27
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"SapSurge") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"SapOverflow")) {
            28
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"GaleGuard") || 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"CloudCover")) {
            29
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ShadowCanopy")) {
            30
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ChainsawCataclysm")) {
            31
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"BeetleSwarmBlitz")) {
            32
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"LightningSplit")) {
            33
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"AncientRootAwakening")) {
            34
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"CanopyExplosion")) {
            35
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"SolarCrownSurge")) {
            36
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"IronwoodFortress")) {
            37
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RootstormSiphon")) {
            38
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ArboristAscension")) {
            39
        } else {
            0
        }
    }

    fun new_fighter_card_state() : FighterCardState {
        FighterCardState{
            last_move      : 0x1::option::none<u8>(),
            reflect_damage : 0,
            armor_half     : false,
            attack_cap     : 0x1::option::none<u64>(),
        }
    }

    fun optional_move_is_attack(arg0: &0x1::option::Option<u8>) : bool {
        0x1::option::is_some<u8>(arg0) && is_attack_move(*0x1::option::borrow<u8>(arg0))
    }

    fun optional_move_is_growth(arg0: &0x1::option::Option<u8>) : bool {
        0x1::option::is_some<u8>(arg0) && is_growth_move(*0x1::option::borrow<u8>(arg0))
    }

    public entry fun reroll_moves<T0>(arg0: &mut Battle, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::TreeConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_utility_coin<T0>(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_incorrect_coin_type());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::reroll_cost(arg1) > 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_tree_insufficient());
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        let v1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::reroll_cost(arg1);
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v1, arg4), @0x0);
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        if (v0 == arg0.player1) {
            arg0.p1_moves = gen_moves(arg3, arg4);
        } else {
            arg0.p2_moves = gen_moves(arg3, arg4);
        };
        emit_update(arg0);
    }

    public entry fun reroll_pvp_v3_moves<T0>(arg0: &mut PvpBattleV3, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::TreeConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = 0x2::tx_context::sender(arg4);
        if (v0 == arg0.player1) {
            assert!(arg0.turn == 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_reroll_not_players_turn());
            assert!(!arg0.p1_reroll_used, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_reroll_already_used());
            charge_reroll<T0>(arg1, arg2, 2, arg4);
            arg0.p1_moves = gen_reroll_moves(&arg0.p1_moves, arg0.p1_fifth_move_entitled, arg3, arg4);
            arg0.p1_reroll_used = true;
        } else {
            assert!(v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(arg0.turn == 1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_reroll_not_players_turn());
            assert!(!arg0.p2_reroll_used, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_reroll_already_used());
            charge_reroll<T0>(arg1, arg2, 2, arg4);
            arg0.p2_moves = gen_reroll_moves(&arg0.p2_moves, arg0.p2_fifth_move_entitled, arg3, arg4);
            arg0.p2_reroll_used = true;
        };
        emit_update_v3(arg0);
    }

    public entry fun reroll_ranked_bot_v2_moves<T0>(arg0: &mut RankedBotBattleV2, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::TreeConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_reroll_disabled_for_mode()
    }

    public entry fun reroll_ranked_bot_v2_moves_free(arg0: &mut RankedBotBattleV2, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        assert!(0x2::tx_context::sender(arg2) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(arg0.turn == 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_reroll_not_players_turn());
        assert!(!arg0.p1_reroll_used, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_reroll_already_used());
        arg0.p1_moves = gen_free_ranked_bot_reroll_moves(&arg0.p1_moves, arg0.p1_fifth_move_entitled, arg1, arg2);
        arg0.p1_reroll_used = true;
        emit_update_ranked_bot_v2(arg0);
    }

    fun resolve_catalog_move(arg0: u8, arg1: bool, arg2: &mut u64, arg3: &mut u64, arg4: &mut Status, arg5: &mut Status, arg6: &mut FighterCardState, arg7: &mut FighterCardState, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        if (is_standard_attack(arg0) && *arg3 == 0) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 4);
        };
        if (arg0 == 1) {
            if (arg5.block_turns > 0) {
                clear_one_block(arg5, arg7);
                apply_catalog_damage(7, true, arg2, arg3, arg5, arg7);
            } else {
                apply_catalog_damage(11, false, arg2, arg3, arg5, arg7);
            };
        } else if (arg0 == 2) {
            let v0 = if (*arg3 >= 40) {
                12
            } else {
                8
            };
            apply_catalog_damage(v0, false, arg2, arg3, arg5, arg7);
        } else if (arg0 == 3) {
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg8, arg9, 25)) {
                apply_catalog_damage(16, false, arg2, arg3, arg5, arg7);
            };
        } else if (arg0 == 4) {
            apply_catalog_damage(11, true, arg2, arg3, arg5, arg7);
        } else if (arg0 == 5) {
            let v1 = if (optional_move_is_growth(&arg7.last_move)) {
                12
            } else {
                8
            };
            apply_catalog_damage(v1, false, arg2, arg3, arg5, arg7);
        } else if (arg0 == 6) {
            apply_catalog_damage(6, false, arg2, arg3, arg5, arg7);
            apply_catalog_damage(6, false, arg2, arg3, arg5, arg7);
        } else if (arg0 == 7) {
            let v2 = if (*arg2 < *arg3) {
                13
            } else {
                10
            };
            apply_catalog_damage(v2, false, arg2, arg3, arg5, arg7);
        } else if (arg0 == 8) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 6);
            if (arg4.block_turns == 0) {
                arg4.block_turns = 1;
                arg6.reflect_damage = 4;
            };
        } else if (arg0 == 9) {
            apply_catalog_damage(6, false, arg2, arg3, arg5, arg7);
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 4);
        } else if (arg0 == 10) {
            if (arg5.poison_ticks == 0) {
                arg5.poison_ticks = 2;
                arg5.poison_dpt = 4;
            };
        } else if (arg0 == 11) {
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg8, arg9, 25)) {
                apply_catalog_damage(17, false, arg2, arg3, arg5, arg7);
            };
        } else if (arg0 == 12) {
            clear_one_block(arg5, arg7);
            apply_catalog_damage(10, true, arg2, arg3, arg5, arg7);
        } else if (arg0 == 13) {
            apply_catalog_damage(7, false, arg2, arg3, arg5, arg7);
            arg5.next_turn_penalty = arg5.next_turn_penalty + 4;
        } else if (arg0 == 14) {
            let v3 = if (arg1) {
                14
            } else {
                10
            };
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v3);
        } else if (arg0 == 15) {
            let v4 = if (*arg2 < *arg3) {
                12
            } else {
                8
            };
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v4);
        } else if (arg0 == 16) {
            if (*arg2 >= 4) {
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, 4);
                apply_catalog_damage(16, false, arg2, arg3, arg5, arg7);
            };
        } else if (arg0 == 17) {
            if (arg4.block_turns > 0) {
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 10);
            } else {
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 7);
                arg4.block_turns = 1;
            };
        } else if (arg0 == 18) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 5);
            apply_catalog_damage(5, false, arg2, arg3, arg5, arg7);
        } else if (arg0 == 19) {
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg8, arg9, 40)) {
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 20);
            } else {
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, 4);
            };
        } else if (arg0 == 20) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 10);
        } else if (arg0 == 21) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::rand_inclusive(arg8, arg9, 8, 14));
        } else if (arg0 == 22) {
            let v5 = if (optional_move_is_attack(&arg7.last_move)) {
                14
            } else {
                10
            };
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v5);
        } else if (arg0 == 23) {
            let v6 = if (arg5.block_turns > 0) {
                15
            } else {
                10
            };
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v6);
        } else if (arg0 == 24) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 14);
            *arg3 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg3, 3);
        } else if (arg0 == 25) {
            let v7 = if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg8, arg9, 25)) {
                15
            } else {
                3
            };
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v7);
        } else if (arg0 == 26) {
            let v8 = if (optional_move_is_attack(&arg6.last_move)) {
                13
            } else {
                11
            };
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v8);
        } else if (arg0 == 27) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 7);
            arg6.armor_half = true;
        } else if (arg0 == 28) {
            let v9 = if (*arg2 <= 10) {
                13
            } else {
                10
            };
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v9);
        } else if (arg0 == 29) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 8);
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg8, arg9, 50) && arg4.block_turns == 0) {
                arg4.block_turns = 1;
            };
        } else if (arg0 == 30) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 8);
            arg6.attack_cap = 0x1::option::some<u64>(8);
        } else if (arg0 == 31) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 3);
            apply_catalog_damage(8, false, arg2, arg3, arg5, arg7);
        } else if (arg0 == 32) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 4);
            if (arg5.poison_ticks == 0) {
                arg5.poison_ticks = 2;
                arg5.poison_dpt = 3;
            };
        } else if (arg0 == 33) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 3);
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg8, arg9, 25)) {
                apply_catalog_damage(10, false, arg2, arg3, arg5, arg7);
            };
        } else if (arg0 == 34) {
            let v10 = if (*arg2 < *arg3) {
                11
            } else {
                10
            };
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, v10);
        } else if (arg0 == 35) {
            clear_one_block(arg5, arg7);
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 10);
        } else if (arg0 == 36) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 9);
        } else if (arg0 == 37) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 7);
            if (arg4.block_turns == 0) {
                arg4.block_turns = 1;
            };
        } else if (arg0 == 38) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 6);
            apply_catalog_damage(6, false, arg2, arg3, arg5, arg7);
        } else if (arg0 == 39) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg2, 8);
            arg6.attack_cap = 0x1::option::some<u64>(8);
        };
        arg6.last_move = 0x1::option::some<u8>(arg0);
    }

    fun resolve_move(arg0: u8, arg1: &mut u64, arg2: &mut u64, arg3: &mut Status, arg4: &mut Status, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0 == 1) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(10, arg4));
        } else if (arg0 == 2) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(8, arg4));
        } else if (arg0 == 3) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(12, arg4));
        } else if (arg0 == 4) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(7, arg4));
        } else if (arg0 == 5) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(9, arg4));
        } else if (arg0 == 6) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(6, arg4));
        } else if (arg0 == 7) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(11, arg4));
        } else if (arg0 == 8) {
            arg3.block_turns = 1;
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, 5);
        } else if (arg0 == 9) {
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(8, arg4));
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 4);
        } else if (arg0 == 10) {
            arg4.poison_ticks = 2;
            arg4.poison_dpt = 5;
        } else if (arg0 == 11) {
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg5, arg6, 20)) {
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(15, arg4));
            };
        } else if (arg0 == 12) {
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg5, arg6, 50)) {
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(10, arg4));
            } else {
                arg4.block_turns = arg4.block_turns + 1;
            };
        } else if (arg0 == 13) {
            let v0 = apply_damage(7, arg4);
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, v0);
            arg4.next_turn_penalty = arg4.next_turn_penalty + 3;
        } else if (arg0 == 14) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 8);
            arg3.poison_ticks = 0;
            arg3.poison_dpt = 0;
            arg3.next_turn_penalty = 0;
        } else if (arg0 == 15) {
            let v1 = if (*arg1 < *arg2) {
                14
            } else {
                7
            };
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, v1);
        } else if (arg0 == 16) {
            if (*arg1 >= 5) {
                *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg1, 5);
                *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(15, arg4));
            };
        } else if (arg0 == 17) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 6);
            arg3.block_turns = arg3.block_turns + 1;
        } else if (arg0 == 18) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 6);
            *arg2 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg2, apply_damage(6, arg4));
        } else if (arg0 == 19) {
            if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg5, arg6, 40)) {
                *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(*arg1, 5);
            } else {
                *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 22);
            };
        } else if (arg0 == 20) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 10);
        } else if (arg0 == 21) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::rand_inclusive(arg5, arg6, 8, 12));
        } else if (arg0 == 22) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 15);
        } else if (arg0 == 23) {
            let v2 = if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg5, arg6, 20)) {
                5
            } else {
                0
            };
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 10 + v2);
        } else if (arg0 == 24) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::rand_inclusive(arg5, arg6, 12, 18));
        } else if (arg0 == 25) {
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg5, arg6, 10)) {
                *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 20);
            };
        } else if (arg0 == 26) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::rand_inclusive(arg5, arg6, 15, 20));
        } else if (arg0 == 27) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 10);
            arg3.block_turns = 1;
        } else if (arg0 == 28) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 12);
        } else if (arg0 == 29) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 8);
            if (!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg5, arg6, 50)) {
                arg3.block_turns = arg3.block_turns + 1;
            };
        } else if (arg0 == 30) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::rand_inclusive(arg5, arg6, 10, 15));
        };
    }

    fun rotate_bot_move_to_end(arg0: &mut Battle, arg1: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.p2_moves)) {
            if (*0x1::vector::borrow<u8>(&arg0.p2_moves, v0) == arg1) {
                0x1::vector::push_back<u8>(&mut arg0.p2_moves, 0x1::vector::remove<u8>(&mut arg0.p2_moves, v0));
                return
            };
            v0 = v0 + 1;
        };
    }

    fun rotate_ranked_bot_v2_move_to_end(arg0: &mut RankedBotBattleV2, arg1: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.p2_moves)) {
            if (*0x1::vector::borrow<u8>(&arg0.p2_moves, v0) == arg1) {
                0x1::vector::push_back<u8>(&mut arg0.p2_moves, 0x1::vector::remove<u8>(&mut arg0.p2_moves, v0));
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun surrender(arg0: &mut Battle, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (v0 == arg0.player1) {
            arg0.player2
        } else {
            assert!(v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            arg0.player1
        };
        finish_and_payout(arg0, v1, arg1);
    }

    public fun surrender_pvp_v2(arg0: &mut PvpBattleV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (v0 == arg0.player1) {
            arg0.player2
        } else {
            assert!(v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            arg0.player1
        };
        finish_and_payout_v2(arg0, v1, arg1);
    }

    public fun surrender_pvp_v3(arg0: &mut PvpBattleV3, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (v0 == arg0.player1) {
            arg0.player2
        } else {
            assert!(v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            arg0.player1
        };
        finish_and_payout_v3(arg0, v1, arg1);
    }

    public fun surrender_ranked_bot_v2(arg0: &mut RankedBotBattleV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        assert!(0x2::tx_context::sender(arg1) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        let v0 = arg0.player2;
        finish_and_payout_ranked_bot_v2(arg0, v0, arg1);
    }

    public entry fun tree_boost<T0>(arg0: &mut Battle, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::TreeConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_utility_coin<T0>(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_incorrect_coin_type());
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        let v1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::boost_cost(arg1);
        assert!(v1 > 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_tree_insufficient());
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v1, arg4), @0x0);
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        if (v0 == arg0.player1) {
            arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(arg0.p1_growth, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::boost_growth(arg1));
        } else {
            arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(arg0.p2_growth, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::boost_growth(arg1));
        };
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        emit_update(arg0);
    }

    public fun use_ability(arg0: &mut Battle, arg1: vector<u8>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = map_ability_name(arg1);
        assert!(v0 != 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_ability_name());
        use_ability_id(arg0, v0, arg2, arg3);
    }

    public fun use_ability_id(arg0: &mut Battle, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = if (arg0.turn == 0) {
            assert!(0x2::tx_context::sender(arg3) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p1_moves, arg1)
        } else {
            assert!(0x2::tx_context::sender(arg3) == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p2_moves, arg1)
        };
        assert!(v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_move());
        if (arg0.turn == 0) {
            apply_player1_move(arg0, arg1, arg2, arg3);
            let v1 = if (arg0.is_bot_battle) {
                50
            } else {
                100
            };
            if (arg0.p1_growth >= v1) {
                let v2 = arg0.player1;
                finish_and_payout(arg0, v2, arg3);
            } else if (arg0.is_bot_battle) {
                let v3 = choose_bot_move(arg0, arg2, arg3);
                emit_bot_move_resolved(arg0, v3);
                rotate_bot_move_to_end(arg0, v3);
                apply_player2_move(arg0, v3, arg2, arg3);
                if (arg0.p2_growth >= v1) {
                    let v4 = arg0.player2;
                    finish_and_payout(arg0, v4, arg3);
                } else {
                    arg0.turn = 0;
                    emit_update(arg0);
                };
            } else {
                arg0.turn = 1;
                emit_update(arg0);
            };
        } else {
            apply_player2_move(arg0, arg1, arg2, arg3);
            let v5 = if (arg0.is_bot_battle) {
                50
            } else {
                100
            };
            if (arg0.p2_growth >= v5) {
                let v6 = arg0.player2;
                finish_and_payout(arg0, v6, arg3);
            } else {
                arg0.turn = 0;
                emit_update(arg0);
            };
        };
    }

    public fun use_ability_id_pvp_v2(arg0: &mut PvpBattleV2, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = if (arg0.turn == 0) {
            assert!(0x2::tx_context::sender(arg3) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p1_moves, arg1)
        } else {
            assert!(0x2::tx_context::sender(arg3) == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p2_moves, arg1)
        };
        assert!(v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_move());
        if (arg0.turn == 0) {
            apply_player1_move_v2(arg0, arg1, arg2, arg3);
            if (arg0.p1_growth >= arg0.target_growth) {
                let v1 = arg0.player1;
                finish_and_payout_v2(arg0, v1, arg3);
            } else {
                arg0.turn = 1;
                emit_update_v2(arg0);
            };
        } else {
            apply_player2_move_v2(arg0, arg1, arg2, arg3);
            if (arg0.p2_growth >= arg0.target_growth) {
                let v2 = arg0.player2;
                finish_and_payout_v2(arg0, v2, arg3);
            } else {
                arg0.turn = 0;
                emit_update_v2(arg0);
            };
        };
    }

    public fun use_ability_id_pvp_v3(arg0: &mut PvpBattleV3, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = if (arg0.turn == 0) {
            assert!(0x2::tx_context::sender(arg3) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(!fifth_move_draft_pending(&arg0.p1_moves, arg0.p1_fifth_move_entitled), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_draft_required());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p1_moves, arg1)
        } else {
            assert!(0x2::tx_context::sender(arg3) == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(!fifth_move_draft_pending(&arg0.p2_moves, arg0.p2_fifth_move_entitled), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_draft_required());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p2_moves, arg1)
        };
        assert!(v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_move());
        let v1 = arg0.turn == 0;
        assert_not_repeated_and_record(arg0, v1, arg1);
        if (arg0.turn == 0) {
            apply_player1_move_v3(arg0, arg1, arg2, arg3);
            if (arg0.p1_growth >= arg0.target_growth) {
                let v2 = arg0.player1;
                finish_and_payout_v3(arg0, v2, arg3);
            } else {
                arg0.turn = 1;
                emit_update_v3(arg0);
            };
        } else {
            apply_player2_move_v3(arg0, arg1, arg2, arg3);
            if (arg0.p2_growth >= arg0.target_growth) {
                let v3 = arg0.player2;
                finish_and_payout_v3(arg0, v3, arg3);
            } else {
                arg0.turn = 0;
                emit_update_v3(arg0);
            };
        };
    }

    public fun use_ability_id_pvp_v3_with_fifth_move(arg0: &mut PvpBattleV3, arg1: u8, arg2: u8, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (v0 == arg0.player1) {
            assert!(fifth_move_draft_pending(&arg0.p1_moves, arg0.p1_fifth_move_entitled), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_draft_required());
            let v1 = &mut arg0.p1_moves;
            lock_fifth_move_draft(v1, arg1);
        } else {
            assert!(v0 == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(fifth_move_draft_pending(&arg0.p2_moves, arg0.p2_fifth_move_entitled), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_draft_required());
            let v2 = &mut arg0.p2_moves;
            lock_fifth_move_draft(v2, arg1);
        };
        use_ability_id_pvp_v3(arg0, arg2, arg3, arg4);
    }

    public fun use_ability_id_ranked_bot_v2(arg0: &mut RankedBotBattleV2, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        assert!(0x2::tx_context::sender(arg3) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(!fifth_move_draft_pending(&arg0.p1_moves, arg0.p1_fifth_move_entitled), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_draft_required());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p1_moves, arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_move());
        assert_ranked_bot_move_not_repeated(arg0, arg1);
        apply_player1_move_ranked_bot_v2(arg0, arg1, arg2, arg3);
        if (arg0.p1_growth >= arg0.target_growth) {
            let v0 = arg0.player1;
            finish_and_payout_ranked_bot_v2(arg0, v0, arg3);
        } else {
            let v1 = choose_ranked_bot_v2_move(arg0, arg2, arg3);
            emit_ranked_bot_v2_move_resolved(arg0, v1);
            rotate_ranked_bot_v2_move_to_end(arg0, v1);
            apply_player2_move_ranked_bot_v2(arg0, v1, arg2, arg3);
            if (arg0.p2_growth >= arg0.target_growth) {
                let v2 = arg0.player2;
                finish_and_payout_ranked_bot_v2(arg0, v2, arg3);
            } else {
                arg0.turn = 0;
                emit_update_ranked_bot_v2(arg0);
            };
        };
    }

    public fun use_ability_id_ranked_bot_v2_with_fifth_move(arg0: &mut RankedBotBattleV2, arg1: u8, arg2: u8, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        assert!(fifth_move_draft_pending(&arg0.p1_moves, arg0.p1_fifth_move_entitled), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_draft_required());
        let v0 = &mut arg0.p1_moves;
        lock_fifth_move_draft(v0, arg1);
        use_ability_id_ranked_bot_v2(arg0, arg2, arg3, arg4);
    }

    public fun use_ability_id_v2(arg0: &mut Battle, arg1: u8, arg2: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg3: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::TreeConfig, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        let v0 = if (arg0.turn == 0) {
            assert!(0x2::tx_context::sender(arg5) == arg0.player1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p1_moves, arg1)
        } else {
            assert!(0x2::tx_context::sender(arg5) == arg0.player2, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::contains_u8(&arg0.p2_moves, arg1)
        };
        assert!(v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_move());
        let v1 = if (arg0.is_bot_battle) {
            50
        } else {
            100
        };
        if (arg0.turn == 0) {
            apply_player1_move(arg0, arg1, arg4, arg5);
            if (arg0.p1_growth >= v1) {
                let v2 = arg0.player1;
                finish_and_payout(arg0, v2, arg5);
            } else if (arg0.is_bot_battle) {
                let v3 = choose_bot_move(arg0, arg4, arg5);
                emit_bot_move_resolved(arg0, v3);
                rotate_bot_move_to_end(arg0, v3);
                apply_player2_move(arg0, v3, arg4, arg5);
                if (arg0.p2_growth >= v1) {
                    let v4 = arg0.player2;
                    finish_and_payout(arg0, v4, arg5);
                } else {
                    arg0.turn = 0;
                    emit_update(arg0);
                };
            } else {
                arg0.turn = 1;
                emit_update(arg0);
            };
        } else {
            apply_player2_move(arg0, arg1, arg4, arg5);
            if (arg0.p2_growth >= v1) {
                let v5 = arg0.player2;
                finish_and_payout(arg0, v5, arg5);
            } else {
                arg0.turn = 0;
                emit_update(arg0);
            };
        };
    }

    // decompiled from Move bytecode v7
}

