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

    fun adds_block(arg0: u8) : bool {
        if (arg0 == 8) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 27) {
            true
        } else {
            arg0 == 29
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

    public fun admin_force_close_with_winner(arg0: &mut Battle, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(!arg0.finished, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_battle_finished());
        finish_and_payout(arg0, arg2, arg3);
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
        if (arg0.p1_status.next_turn_penalty > 0) {
            arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(arg0.p1_growth, arg0.p1_status.next_turn_penalty);
            arg0.p1_status.next_turn_penalty = 0;
        };
        if (arg0.p1_status.poison_ticks > 0) {
            arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(arg0.p1_growth, arg0.p1_status.poison_dpt);
            arg0.p1_status.poison_ticks = arg0.p1_status.poison_ticks - 1;
        };
        let v0 = &mut arg0.p1_growth;
        let v1 = &mut arg0.p2_growth;
        let v2 = &mut arg0.p1_status;
        let v3 = &mut arg0.p2_status;
        resolve_move(arg1, v0, v1, v2, v3, arg2, arg3);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player1_move_v2(arg0: &mut PvpBattleV2, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.p1_status.next_turn_penalty > 0) {
            arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(arg0.p1_growth, arg0.p1_status.next_turn_penalty);
            arg0.p1_status.next_turn_penalty = 0;
        };
        if (arg0.p1_status.poison_ticks > 0) {
            arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(arg0.p1_growth, arg0.p1_status.poison_dpt);
            arg0.p1_status.poison_ticks = arg0.p1_status.poison_ticks - 1;
        };
        let v0 = &mut arg0.p1_growth;
        let v1 = &mut arg0.p2_growth;
        let v2 = &mut arg0.p1_status;
        let v3 = &mut arg0.p2_status;
        resolve_move(arg1, v0, v1, v2, v3, arg2, arg3);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player2_move(arg0: &mut Battle, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.p2_status.next_turn_penalty > 0) {
            arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(arg0.p2_growth, arg0.p2_status.next_turn_penalty);
            arg0.p2_status.next_turn_penalty = 0;
        };
        if (arg0.p2_status.poison_ticks > 0) {
            arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(arg0.p2_growth, arg0.p2_status.poison_dpt);
            arg0.p2_status.poison_ticks = arg0.p2_status.poison_ticks - 1;
        };
        let v0 = &mut arg0.p2_growth;
        let v1 = &mut arg0.p1_growth;
        let v2 = &mut arg0.p2_status;
        let v3 = &mut arg0.p1_status;
        resolve_move(arg1, v0, v1, v2, v3, arg2, arg3);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun apply_player2_move_v2(arg0: &mut PvpBattleV2, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.p2_status.next_turn_penalty > 0) {
            arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(arg0.p2_growth, arg0.p2_status.next_turn_penalty);
            arg0.p2_status.next_turn_penalty = 0;
        };
        if (arg0.p2_status.poison_ticks > 0) {
            arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::sub_growth(arg0.p2_growth, arg0.p2_status.poison_dpt);
            arg0.p2_status.poison_ticks = arg0.p2_status.poison_ticks - 1;
        };
        let v0 = &mut arg0.p2_growth;
        let v1 = &mut arg0.p1_growth;
        let v2 = &mut arg0.p2_status;
        let v3 = &mut arg0.p1_status;
        resolve_move(arg1, v0, v1, v2, v3, arg2, arg3);
        arg0.p2_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p2_growth, 0, 100);
        arg0.p1_growth = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::clamp(arg0.p1_growth, 0, 100);
        arg0.last_move_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    fun assert_valid_pvp_v2_target(arg0: u64) {
        assert!(is_valid_pvp_v2_target(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_target_growth());
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
        if (arg0 == 13 && arg2 > 0) {
            v1 = v1 + 20;
        };
        if (adds_block(arg0)) {
            let v9 = if (arg3.block_turns == 0) {
                12
            } else {
                2
            };
            v1 = v1 + v9;
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

    fun emit_bot_move_resolved(arg0: &Battle, arg1: u8) {
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

    fun expected_damage(arg0: u8) : u64 {
        if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            8
        } else if (arg0 == 3) {
            12
        } else if (arg0 == 4) {
            7
        } else if (arg0 == 5) {
            9
        } else if (arg0 == 6) {
            6
        } else if (arg0 == 7) {
            11
        } else if (arg0 == 8) {
            5
        } else if (arg0 == 9) {
            8
        } else if (arg0 == 11) {
            12
        } else if (arg0 == 12) {
            5
        } else if (arg0 == 13) {
            7
        } else {
            0
        }
    }

    fun expected_self_growth(arg0: u8) : u64 {
        if (arg0 == 9) {
            4
        } else if (arg0 == 20) {
            10
        } else if (arg0 == 21) {
            10
        } else if (arg0 == 22) {
            15
        } else if (arg0 == 23) {
            10
        } else if (arg0 == 24) {
            15
        } else if (arg0 == 25) {
            18
        } else if (arg0 == 26) {
            17
        } else if (arg0 == 27) {
            10
        } else if (arg0 == 28) {
            12
        } else if (arg0 == 29) {
            8
        } else if (arg0 == 30) {
            12
        } else {
            0
        }
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

    fun gen_moves(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
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
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 20);
        0x1::vector::push_back<u8>(&mut v1, 21);
        0x1::vector::push_back<u8>(&mut v1, 22);
        0x1::vector::push_back<u8>(&mut v1, 23);
        0x1::vector::push_back<u8>(&mut v1, 24);
        0x1::vector::push_back<u8>(&mut v1, 25);
        0x1::vector::push_back<u8>(&mut v1, 26);
        0x1::vector::push_back<u8>(&mut v1, 28);
        0x1::vector::push_back<u8>(&mut v1, 30);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, 9);
        0x1::vector::push_back<u8>(&mut v2, 27);
        0x1::vector::push_back<u8>(&mut v2, 29);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x2::random::new_generator(arg0, arg1);
        let v5 = 0x1::vector::length<u8>(&v0);
        let v6 = 0x2::random::generate_u64(&mut v4) % v5;
        let v7 = 0x2::random::generate_u64(&mut v4) % v5;
        let v8 = v7;
        if (v6 == v7) {
            v8 = (v6 + 1) % v5;
        };
        0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v0, v6));
        0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v0, v8));
        0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v1, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v1)));
        0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v2)));
        v3
    }

    public fun is_valid_pvp_v2_target(arg0: u64) : bool {
        arg0 == 50 || arg0 == 75
    }

    fun map_ability_name(arg0: vector<u8>) : u8 {
        if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ThornSpikeBomb")) {
            1
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RazorLeafSword")) {
            2
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"TumbleweedMace")) {
            3
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ShovelSpear")) {
            4
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ThornedWhip")) {
            5
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"AcornSlingshot")) {
            6
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"StoneNunchuck")) {
            7
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"CactusShield")) {
            8
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"LifeAbsorb")) {
            9
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"Poison")) {
            10
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"WitherTouch")) {
            11
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PollenCloud")) {
            12
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"FungalRot")) {
            13
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RootsUp")) {
            20
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"SunBeam")) {
            21
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"RainStorm")) {
            22
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"WhiteMold")) {
            23
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"GreenhouseGas")) {
            24
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PotassiumPowerUp")) {
            25
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"PhotosyntheticSurge")) {
            26
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"BarkskinArmor")) {
            27
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"SapOverflow")) {
            28
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"CloudCover")) {
            29
        } else if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::eq_str(arg0, b"ShadowCanopy")) {
            30
        } else {
            0
        }
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
        } else if (arg0 == 20) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 10);
        } else if (arg0 == 21) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::rand_inclusive(arg5, arg6, 8, 12));
        } else if (arg0 == 22) {
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 15);
        } else if (arg0 == 23) {
            let v1 = if (0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::miss(arg5, arg6, 20)) {
                5
            } else {
                0
            };
            *arg1 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::utils::add_growth(*arg1, 10 + v1);
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

