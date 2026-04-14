module 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat {
    struct PlayerCombatResult has copy, drop {
        damage_dealt: u64,
        hp_after: u64,
        attack_result: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::AttackResult,
        defend_result: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::DefendResult,
        block_pct: u64,
        call_success: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess,
        bluff_caught: bool,
        reward_applied: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::BluffReward,
        genuine_miss: bool,
        genuine_crit: bool,
        newly_charging: bool,
    }

    struct CombatResolution has copy, drop {
        player_0: PlayerCombatResult,
        player_1: PlayerCombatResult,
        first_actor: u8,
    }

    public fun attack_result(arg0: &PlayerCombatResult) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::AttackResult {
        arg0.attack_result
    }

    public fun block_pct(arg0: &PlayerCombatResult) : u64 {
        arg0.block_pct
    }

    public fun bluff_caught(arg0: &PlayerCombatResult) : bool {
        arg0.bluff_caught
    }

    public fun call_success(arg0: &PlayerCombatResult) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess {
        arg0.call_success
    }

    fun compute_reward_applied(arg0: bool, arg1: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EffectiveAction) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::BluffReward {
        if (!arg0) {
            return 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::bluff_reward_none()
        };
        let v0 = if (arg1 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_fast_attack()) {
            true
        } else if (arg1 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_resolving_special()) {
            true
        } else {
            arg1 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_defend()
        };
        if (v0) {
            0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::bluff_reward_applied()
        } else {
            0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::bluff_reward_not_applied()
        }
    }

    public fun damage_dealt(arg0: &PlayerCombatResult) : u64 {
        arg0.damage_dealt
    }

    public fun defend_result(arg0: &PlayerCombatResult) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::DefendResult {
        arg0.defend_result
    }

    public(friend) fun determine_speed_order(arg0: u64, arg1: u64, arg2: u32, arg3: u32, arg4: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EffectiveAction, arg5: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EffectiveAction) : u8 {
        let v0 = has_priority(arg4);
        let v1 = has_priority(arg5);
        if (v0 && !v1) {
            return 0
        };
        if (v1 && !v0) {
            return 1
        };
        if (arg0 > arg1) {
            0
        } else if (arg1 > arg0) {
            1
        } else if (arg2 <= arg3) {
            0
        } else {
            1
        }
    }

    public fun estimate_can_win_in(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : u32 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::apply_stat_scaling(150000, arg1, arg2, 30000, 1000000);
        let v1 = 0;
        while (arg0 > 0) {
            let v2 = if (arg3 > 0) {
                arg3 = arg3 - 1;
                0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::mul(v0, 20000)
            } else {
                v0
            };
            arg0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::saturating_sub(arg0, v2);
            v1 = v1 + 1;
        };
        v1
    }

    public fun first_actor(arg0: &CombatResolution) : u8 {
        arg0.first_actor
    }

    public fun genuine_crit(arg0: &PlayerCombatResult) : bool {
        arg0.genuine_crit
    }

    public fun genuine_miss(arg0: &PlayerCombatResult) : bool {
        arg0.genuine_miss
    }

    fun has_priority(arg0: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EffectiveAction) : bool {
        arg0 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_defend() || arg0 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_charging()
    }

    public fun hp_after(arg0: &PlayerCombatResult) : u64 {
        arg0.hp_after
    }

    public fun max_crit_hits() : u8 {
        3
    }

    public fun max_fp() : u8 {
        8
    }

    public fun newly_charging(arg0: &PlayerCombatResult) : bool {
        arg0.newly_charging
    }

    fun next_random(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        (v0 % 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale(), arg1 + 8)
    }

    public fun player_0(arg0: &CombatResolution) : &PlayerCombatResult {
        &arg0.player_0
    }

    public fun player_1(arg0: &CombatResolution) : &PlayerCombatResult {
        &arg0.player_1
    }

    fun process_bluff_calls(arg0: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg1: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg2: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess, arg3: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg4: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg5: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess) : (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess, bool, bool) {
        let (v0, v1) = process_single_bluff_call(arg0, arg1, arg2);
        let (v2, v3) = process_single_bluff_call(arg3, arg4, arg5);
        (v0, v2, v1, v3)
    }

    public(friend) fun process_single_bluff_call(arg0: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg1: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg2: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess) : (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess, bool) {
        if (arg2 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_none()) {
            return (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_no_call(), false)
        };
        if (arg0 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none()) {
            return (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_no_call(), false)
        };
        if (arg1 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_none()) {
            return (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_no_call(), false)
        };
        let v0 = arg2 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_defend() && arg1 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_defend() || arg2 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_special() && arg1 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_special_attack();
        let v1 = if (v0) {
            0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_correct()
        } else {
            0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_incorrect()
        };
        let v2 = arg0 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_defend() && arg1 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_defend() || arg0 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_special() && arg1 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_special_attack();
        let v3 = v0 && !v2;
        (v1, v3)
    }

    fun resolve_defend(arg0: u64, arg1: u64, arg2: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState, arg3: bool, arg4: &vector<u8>, arg5: u64) : (u64, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::DefendResult, u64) {
        let (v0, v1) = next_random(arg4, arg5);
        if (v0 < 500) {
            return (0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_fail(), v1)
        };
        let (v2, v3) = next_random(arg4, v1);
        if (v2 < 1500) {
            return (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale(), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_crit_block(), v3)
        };
        let (v4, v5) = next_random(arg4, v3);
        let v6 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::apply_stat_scaling(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sample_distribution(6000, 8000, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::distribution(arg2), v4), arg0, arg1, 1000, 1000000);
        let v7 = v6;
        if (arg3) {
            v7 = v6 + 1500;
        };
        (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::clamp(v7, 0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale()), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_normal(), v5)
    }

    fun resolve_fast_attack(arg0: u64, arg1: u64, arg2: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState, arg3: u8, arg4: u8, arg5: &vector<u8>, arg6: u64) : (u64, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::AttackResult, u64) {
        let v0 = arg6;
        if (arg3 < 3) {
            let (v1, v2) = next_random(arg5, arg6);
            v0 = v2;
            if (v1 < 500) {
                return (0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_miss(), v2)
            };
        };
        let (v3, v4) = next_random(arg5, v0);
        let (v5, v6) = next_random(arg5, v4);
        let (v7, v8) = if (arg4 < 3 && v5 < 1500) {
            (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::mul(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::apply_stat_scaling(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sample_int_distribution(50000, 150000, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::distribution(arg2), v3), arg0, arg1, 30000, 1000000), 20000), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_crit())
        } else {
            (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::apply_stat_scaling(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sample_int_distribution(50000, 150000, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::distribution(arg2), v3), arg0, arg1, 30000, 1000000), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_hit())
        };
        (v7, v8, v6)
    }

    public fun resolve_round(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u32, arg5: bool, arg6: u8, arg7: u8, arg8: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg9: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u32, arg15: bool, arg16: u8, arg17: u8, arg18: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg19: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg20: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg21: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState, arg22: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg23: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess, arg24: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg25: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState, arg26: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg27: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess, arg28: &vector<u8>) : CombatResolution {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::effective_action(arg5, arg20);
        let v3 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::effective_action(arg15, arg24);
        let (v4, v5, v6, v7) = process_bluff_calls(arg18, arg19, arg23, arg8, arg9, arg27);
        let v8 = !arg5 && arg20 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_special_attack();
        let v9 = !arg15 && arg24 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_special_attack();
        if (v2 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_defend() && v3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_defend()) {
            let v10 = PlayerCombatResult{
                damage_dealt   : 0,
                hp_after       : arg0,
                attack_result  : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_none(),
                defend_result  : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_normal(),
                block_pct      : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale(),
                call_success   : v4,
                bluff_caught   : v6,
                reward_applied : compute_reward_applied(v6, v2),
                genuine_miss   : false,
                genuine_crit   : false,
                newly_charging : v8,
            };
            let v11 = PlayerCombatResult{
                damage_dealt   : 0,
                hp_after       : arg10,
                attack_result  : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_none(),
                defend_result  : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_normal(),
                block_pct      : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale(),
                call_success   : v5,
                bluff_caught   : v7,
                reward_applied : compute_reward_applied(v7, v3),
                genuine_miss   : false,
                genuine_crit   : false,
                newly_charging : v9,
            };
            return CombatResolution{
                player_0    : v10,
                player_1    : v11,
                first_actor : 255,
            }
        };
        let v12 = 0;
        let v13 = 0;
        let v14 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_none();
        let v15 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_none();
        if (v2 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_fast_attack()) {
            let (v16, v17, v18) = resolve_fast_attack(arg1, arg12, arg21, arg6, arg7, arg28, v0);
            let v19 = if (v6) {
                0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::mul(v16, 12500)
            } else {
                v16
            };
            v12 = v19;
            v14 = v17;
            v1 = v18;
        } else if (v2 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_resolving_special()) {
            let (v20, v21) = resolve_special_attack(arg1, arg12, arg21, arg28, v0);
            let v22 = if (v6) {
                0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::mul(v20, 12500)
            } else {
                v20
            };
            v12 = v22;
            v14 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_hit();
            v1 = v21;
        };
        if (v3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_fast_attack()) {
            let (v23, v24, v25) = resolve_fast_attack(arg11, arg2, arg25, arg16, arg17, arg28, v1);
            let v26 = if (v7) {
                0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::mul(v23, 12500)
            } else {
                v23
            };
            v13 = v26;
            v15 = v24;
            v1 = v25;
        } else if (v3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_resolving_special()) {
            let (v27, v28) = resolve_special_attack(arg11, arg2, arg25, arg28, v1);
            let v29 = if (v7) {
                0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::mul(v27, 12500)
            } else {
                v27
            };
            v13 = v29;
            v15 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_hit();
            v1 = v28;
        };
        let v30 = v14 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_miss();
        let v31 = v15 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_miss();
        let v32 = v14 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_crit();
        let v33 = v15 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_crit();
        let v34 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_none();
        let v35 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_none();
        let v36 = 0;
        let v37 = 0;
        if (v2 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_defend()) {
            let (v38, v39, v40) = resolve_defend(arg2, arg11, arg21, v6, arg28, v1);
            v36 = v38;
            v34 = v39;
            v1 = v40;
        };
        if (v3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::eff_defend()) {
            let (v41, v42, _) = resolve_defend(arg12, arg1, arg25, v7, arg28, v1);
            v37 = v41;
            v35 = v42;
        };
        let v44 = determine_speed_order(arg3, arg13, arg4, arg14, v2, v3);
        let v45 = arg0;
        let v46 = arg10;
        let v47 = 0;
        let v48 = 0;
        let v49 = false;
        let v50 = 0;
        while (v50 < 2) {
            let v51 = if (v50 == 0) {
                v44
            } else {
                1 - v44
            };
            let (v52, v53) = if (v51 == 0) {
                (v12, v2)
            } else {
                (v13, v3)
            };
            if (!0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::is_attack(v53)) {
                v50 = v50 + 1;
                continue
            };
            let v54 = if (v51 == 0) {
                v46
            } else {
                v45
            };
            if (v54 == 0 || v49) {
                if (v51 == 0) {
                    v14 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_none();
                } else {
                    v15 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_none();
                };
                v50 = v50 + 1;
                continue
            };
            let v55 = v52;
            if (v51 == 0 && v9 || v8) {
                v55 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::mul(v52, 15000);
            };
            let (v56, v57) = if (v51 == 0) {
                (v37, v35)
            } else {
                (v36, v34)
            };
            if (v56 > 0) {
                v55 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::mul(v55, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::saturating_sub(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale(), v56));
                if (v57 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_crit_block()) {
                    if (v51 == 0) {
                        v14 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_crit_blocked();
                    } else {
                        v15 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_crit_blocked();
                    };
                };
            };
            if (v51 == 0) {
                v47 = v55;
                let v58 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::saturating_sub(v46, v55);
                v46 = v58;
                if (v58 == 0) {
                    v49 = true;
                };
            } else {
                v48 = v55;
                let v59 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::saturating_sub(v45, v55);
                v45 = v59;
                if (v59 == 0) {
                    v49 = true;
                };
            };
            v50 = v50 + 1;
        };
        let v60 = PlayerCombatResult{
            damage_dealt   : v47,
            hp_after       : v45,
            attack_result  : v14,
            defend_result  : v34,
            block_pct      : v36,
            call_success   : v4,
            bluff_caught   : v6,
            reward_applied : compute_reward_applied(v6, v2),
            genuine_miss   : v30,
            genuine_crit   : v32,
            newly_charging : v8,
        };
        let v61 = PlayerCombatResult{
            damage_dealt   : v48,
            hp_after       : v46,
            attack_result  : v15,
            defend_result  : v35,
            block_pct      : v37,
            call_success   : v5,
            bluff_caught   : v7,
            reward_applied : compute_reward_applied(v7, v3),
            genuine_miss   : v31,
            genuine_crit   : v33,
            newly_charging : v9,
        };
        CombatResolution{
            player_0    : v60,
            player_1    : v61,
            first_actor : v44,
        }
    }

    fun resolve_special_attack(arg0: u64, arg1: u64, arg2: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState, arg3: &vector<u8>, arg4: u64) : (u64, u64) {
        let (v0, v1) = next_random(arg3, arg4);
        (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::apply_stat_scaling(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sample_int_distribution(300000, 500000, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::distribution(arg2), v0), arg0, arg1, 100000, 1000000), v1)
    }

    public fun reward_applied(arg0: &PlayerCombatResult) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::BluffReward {
        arg0.reward_applied
    }

    // decompiled from Move bytecode v7
}

