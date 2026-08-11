module 0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_draw {
    struct DrawState has key {
        id: 0x2::object::UID,
        current_round: u64,
        last_draw_timestamp: u64,
        rollover_count: u8,
        min_qualifying_wallets: u64,
        draw_interval_sec: u64,
    }

    struct DrawResult has store, key {
        id: 0x2::object::UID,
        round: u64,
        draw_timestamp: u64,
        grand_winner: address,
        grand_amount: u64,
        lucky_winners: vector<address>,
        lucky_amounts: vector<u64>,
        total_participants: u64,
        total_savings_entries: u64,
        total_lucky_entries: u64,
    }

    struct DrawResultV2 has store, key {
        id: 0x2::object::UID,
        round: u64,
        draw_timestamp: u64,
        grand_winners: vector<address>,
        grand_amounts: vector<u64>,
        lucky_winners: vector<address>,
        lucky_amounts: vector<u64>,
        total_participants: u64,
        total_savings_entries: u64,
        total_lucky_entries: u64,
    }

    struct DrawRegistry has key {
        id: 0x2::object::UID,
        results: 0x2::table::Table<u64, address>,
        pending_claims: 0x2::table::Table<address, vector<PendingClaim>>,
    }

    struct PendingClaim has copy, drop, store {
        round: u64,
        amount: u64,
        claimed: bool,
    }

    struct DrawExecuted has copy, drop {
        round: u64,
        grand_winner: address,
        grand_amount: u64,
        lucky_winners: vector<address>,
        lucky_amounts: vector<u64>,
        total_participants: u64,
        total_savings_entries: u64,
        total_lucky_entries: u64,
        timestamp: u64,
    }

    struct DrawExecutedV2 has copy, drop {
        round: u64,
        grand_winners: vector<address>,
        grand_amounts: vector<u64>,
        lucky_winners: vector<address>,
        lucky_amounts: vector<u64>,
        total_participants: u64,
        total_savings_entries: u64,
        total_lucky_entries: u64,
        timestamp: u64,
    }

    struct DrawRolledOver has copy, drop {
        round: u64,
        rollover_count: u8,
        participants: u64,
        threshold: u64,
        timestamp: u64,
    }

    struct PrizeClaimed has copy, drop {
        user: address,
        round: u64,
        amount: u64,
        action: u8,
        timestamp: u64,
    }

    struct DrawOutcome has drop {
        drawn: bool,
        round: u64,
        now: u64,
        grand_winners: vector<address>,
        lucky_winners: vector<address>,
        lucky_amounts: vector<u64>,
        total_participants: u64,
        total_savings_entries: u64,
        total_lucky_entries: u64,
    }

    fun add_lucky_pending_claims(arg0: &mut DrawRegistry, arg1: &DrawOutcome) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1.lucky_winners)) {
            add_pending_claim(arg0, *0x1::vector::borrow<address>(&arg1.lucky_winners, v0), arg1.round, *0x1::vector::borrow<u64>(&arg1.lucky_amounts, v0));
            v0 = v0 + 1;
        };
    }

    fun add_pending_claim(arg0: &mut DrawRegistry, arg1: address, arg2: u64, arg3: u64) {
        if (!0x2::table::contains<address, vector<PendingClaim>>(&arg0.pending_claims, arg1)) {
            0x2::table::add<address, vector<PendingClaim>>(&mut arg0.pending_claims, arg1, 0x1::vector::empty<PendingClaim>());
        };
        let v0 = PendingClaim{
            round   : arg2,
            amount  : arg3,
            claimed : false,
        };
        0x1::vector::push_back<PendingClaim>(0x2::table::borrow_mut<address, vector<PendingClaim>>(&mut arg0.pending_claims, arg1), v0);
    }

    public entry fun claim_prize(arg0: &mut DrawRegistry, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, vector<PendingClaim>>(&arg0.pending_claims, v0), 104);
        let v1 = 0x2::table::borrow_mut<address, vector<PendingClaim>>(&mut arg0.pending_claims, v0);
        let v2 = false;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<PendingClaim>(v1)) {
            let v5 = 0x1::vector::borrow_mut<PendingClaim>(v1, v4);
            if (v5.round == arg1 && !v5.claimed) {
                v5.claimed = true;
                v3 = v5.amount;
                v2 = true;
                break
            };
            v4 = v4 + 1;
        };
        assert!(v2, 103);
        let v6 = PrizeClaimed{
            user      : v0,
            round     : arg1,
            amount    : v3,
            action    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<PrizeClaimed>(v6);
    }

    fun copy_vec_addr(arg0: &vector<address>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg0)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun copy_vec_u64(arg0: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun distribute_lucky_amounts(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::random::RandomGenerator) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        if (arg1 == 0) {
            return v0
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = 0x2::random::generate_u64_in_range(arg4, arg2, arg3);
            0x1::vector::push_back<u64>(&mut v0, v3);
            v1 = v1 + (v3 as u128);
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return v0
        };
        let v4 = 0;
        let v5 = 0;
        while (v5 < arg1) {
            let v6 = saturating_u64((*0x1::vector::borrow<u64>(&v0, v5) as u128) * (arg0 as u128) / v1);
            let v7 = if (v6 < arg2) {
                arg2
            } else if (v6 > arg3) {
                arg3
            } else {
                v6
            };
            *0x1::vector::borrow_mut<u64>(&mut v0, v5) = v7;
            v4 = v4 + v7;
            v5 = v5 + 1;
        };
        if (v4 < arg0) {
            let v8 = arg0 - v4;
            let v9 = true;
            while (v8 > 0 && v9) {
                v9 = false;
                let v10 = 0;
                while (v10 < arg1 && v8 > 0) {
                    let v11 = *0x1::vector::borrow<u64>(&v0, v10);
                    if (v11 < arg3) {
                        let v12 = if (arg3 - v11 < v8) {
                            arg3 - v11
                        } else {
                            v8
                        };
                        *0x1::vector::borrow_mut<u64>(&mut v0, v10) = v11 + v12;
                        v8 = v8 - v12;
                        v9 = true;
                    };
                    v10 = v10 + 1;
                };
            };
        } else if (v4 > arg0) {
            let v13 = v4 - arg0;
            let v14 = true;
            while (v13 > 0 && v14) {
                v14 = false;
                let v15 = 0;
                while (v15 < arg1 && v13 > 0) {
                    let v16 = *0x1::vector::borrow<u64>(&v0, v15);
                    if (v16 > arg2) {
                        let v17 = if (v16 - arg2 < v13) {
                            v16 - arg2
                        } else {
                            v13
                        };
                        *0x1::vector::borrow_mut<u64>(&mut v0, v15) = v16 - v17;
                        v13 = v13 - v17;
                        v14 = true;
                    };
                    v15 = v15 + 1;
                };
            };
        };
        v0
    }

    public entry fun execute_draw(arg0: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::AdminCap, arg1: &mut DrawState, arg2: &mut DrawRegistry, arg3: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::UserDeposits, arg4: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral::ReferralConfig, arg5: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral::ReferralRegistry, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg11, arg13);
        let v1 = &mut v0;
        let v2 = run_draw(arg1, arg3, arg4, arg5, 1, arg7, arg8, arg9, arg10, v1, arg12);
        if (!v2.drawn) {
            return
        };
        let v3 = *0x1::vector::borrow<address>(&v2.grand_winners, 0);
        let v4 = DrawResult{
            id                    : 0x2::object::new(arg13),
            round                 : v2.round,
            draw_timestamp        : v2.now,
            grand_winner          : v3,
            grand_amount          : arg6,
            lucky_winners         : copy_vec_addr(&v2.lucky_winners),
            lucky_amounts         : copy_vec_u64(&v2.lucky_amounts),
            total_participants    : v2.total_participants,
            total_savings_entries : v2.total_savings_entries,
            total_lucky_entries   : v2.total_lucky_entries,
        };
        0x2::table::add<u64, address>(&mut arg2.results, v2.round, 0x2::object::id_address<DrawResult>(&v4));
        0x2::transfer::share_object<DrawResult>(v4);
        add_pending_claim(arg2, v3, v2.round, arg6);
        add_lucky_pending_claims(arg2, &v2);
        let v5 = DrawExecuted{
            round                 : v2.round,
            grand_winner          : v3,
            grand_amount          : arg6,
            lucky_winners         : copy_vec_addr(&v2.lucky_winners),
            lucky_amounts         : copy_vec_u64(&v2.lucky_amounts),
            total_participants    : v2.total_participants,
            total_savings_entries : v2.total_savings_entries,
            total_lucky_entries   : v2.total_lucky_entries,
            timestamp             : v2.now,
        };
        0x2::event::emit<DrawExecuted>(v5);
    }

    public entry fun execute_draw_v2(arg0: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::AdminCap, arg1: &mut DrawState, arg2: &mut DrawRegistry, arg3: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::UserDeposits, arg4: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral::ReferralConfig, arg5: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral::ReferralRegistry, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::random::Random, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0 || arg7 == 0, 109);
        let v0 = 0x2::random::new_generator(arg12, arg14);
        let v1 = &mut v0;
        let v2 = run_draw(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, v1, arg13);
        if (!v2.drawn) {
            return
        };
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v2.grand_winners)) {
            0x1::vector::push_back<u64>(&mut v3, arg6);
            v4 = v4 + 1;
        };
        let v5 = DrawResultV2{
            id                    : 0x2::object::new(arg14),
            round                 : v2.round,
            draw_timestamp        : v2.now,
            grand_winners         : copy_vec_addr(&v2.grand_winners),
            grand_amounts         : copy_vec_u64(&v3),
            lucky_winners         : copy_vec_addr(&v2.lucky_winners),
            lucky_amounts         : copy_vec_u64(&v2.lucky_amounts),
            total_participants    : v2.total_participants,
            total_savings_entries : v2.total_savings_entries,
            total_lucky_entries   : v2.total_lucky_entries,
        };
        0x2::table::add<u64, address>(&mut arg2.results, v2.round, 0x2::object::id_address<DrawResultV2>(&v5));
        0x2::transfer::share_object<DrawResultV2>(v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&v2.grand_winners)) {
            add_pending_claim(arg2, *0x1::vector::borrow<address>(&v2.grand_winners, v6), v2.round, arg6);
            v6 = v6 + 1;
        };
        add_lucky_pending_claims(arg2, &v2);
        let v7 = DrawExecutedV2{
            round                 : v2.round,
            grand_winners         : copy_vec_addr(&v2.grand_winners),
            grand_amounts         : v3,
            lucky_winners         : copy_vec_addr(&v2.lucky_winners),
            lucky_amounts         : copy_vec_u64(&v2.lucky_amounts),
            total_participants    : v2.total_participants,
            total_savings_entries : v2.total_savings_entries,
            total_lucky_entries   : v2.total_lucky_entries,
            timestamp             : v2.now,
        };
        0x2::event::emit<DrawExecutedV2>(v7);
    }

    public fun get_current_round(arg0: &DrawState) : u64 {
        arg0.current_round
    }

    public fun get_draw_interval_sec(arg0: &DrawState) : u64 {
        arg0.draw_interval_sec
    }

    public fun get_last_draw_timestamp(arg0: &DrawState) : u64 {
        arg0.last_draw_timestamp
    }

    public fun get_min_qualifying_wallets(arg0: &DrawState) : u64 {
        arg0.min_qualifying_wallets
    }

    public fun get_rollover_count(arg0: &DrawState) : u8 {
        arg0.rollover_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DrawState{
            id                     : 0x2::object::new(arg0),
            current_round          : 0,
            last_draw_timestamp    : 0,
            rollover_count         : 0,
            min_qualifying_wallets : 200,
            draw_interval_sec      : 604800,
        };
        0x2::transfer::share_object<DrawState>(v0);
        let v1 = DrawRegistry{
            id             : 0x2::object::new(arg0),
            results        : 0x2::table::new<u64, address>(arg0),
            pending_claims : 0x2::table::new<address, vector<PendingClaim>>(arg0),
        };
        0x2::transfer::share_object<DrawRegistry>(v1);
    }

    fun rolled_over_outcome(arg0: u64) : DrawOutcome {
        DrawOutcome{
            drawn                 : false,
            round                 : 0,
            now                   : arg0,
            grand_winners         : 0x1::vector::empty<address>(),
            lucky_winners         : 0x1::vector::empty<address>(),
            lucky_amounts         : 0x1::vector::empty<u64>(),
            total_participants    : 0,
            total_savings_entries : 0,
            total_lucky_entries   : 0,
        }
    }

    fun run_draw(arg0: &mut DrawState, arg1: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::UserDeposits, arg2: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral::ReferralConfig, arg3: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral::ReferralRegistry, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::random::RandomGenerator, arg10: &0x2::clock::Clock) : DrawOutcome {
        assert!(arg7 <= arg8, 109);
        assert!(arg5 > 0 || arg6 == 0, 109);
        let v0 = 0x2::clock::timestamp_ms(arg10) / 1000;
        if (arg0.current_round > 0) {
            assert!(v0 >= arg0.last_draw_timestamp + arg0.draw_interval_sec, 101);
        };
        let v1 = 0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::get_depositors(arg1);
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(v1)) {
            let v5 = *0x1::vector::borrow<address>(v1, v4);
            let v6 = 0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::calculate_user_entries(arg1, v5, arg10);
            if (v6 > 0) {
                0x1::vector::push_back<address>(&mut v2, v5);
                0x1::vector::push_back<u64>(&mut v3, v6);
            };
            v4 = v4 + 1;
        };
        let v7 = 0x1::vector::length<address>(&v2);
        if (v7 == 0) {
            arg0.rollover_count = arg0.rollover_count + 1;
            let v8 = DrawRolledOver{
                round          : arg0.current_round + 1,
                rollover_count : arg0.rollover_count,
                participants   : 0,
                threshold      : arg0.min_qualifying_wallets,
                timestamp      : v0,
            };
            0x2::event::emit<DrawRolledOver>(v8);
            return rolled_over_outcome(v0)
        };
        if (v7 < arg0.min_qualifying_wallets && arg0.rollover_count < 4) {
            arg0.rollover_count = arg0.rollover_count + 1;
            let v9 = DrawRolledOver{
                round          : arg0.current_round + 1,
                rollover_count : arg0.rollover_count,
                participants   : v7,
                threshold      : arg0.min_qualifying_wallets,
                timestamp      : v0,
            };
            0x2::event::emit<DrawRolledOver>(v9);
            return rolled_over_outcome(v0)
        };
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0;
        while (v11 < v7) {
            0x1::vector::push_back<u64>(&mut v10, saturating_u64((*0x1::vector::borrow<u64>(&v3, v11) as u128) + (0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral::calculate_referral_bonus(*0x1::vector::borrow<address>(&v2, v11), arg2, arg3, arg1, arg10) as u128)));
            v11 = v11 + 1;
        };
        arg0.current_round = arg0.current_round + 1;
        arg0.last_draw_timestamp = v0;
        arg0.rollover_count = 0;
        let v12 = if (v7 < arg4) {
            v7
        } else {
            arg4
        };
        let v13 = select_weighted_without_replacement(&v3, v12, arg9);
        let v14 = 0x1::vector::empty<address>();
        let v15 = 0;
        while (v15 < 0x1::vector::length<u64>(&v13)) {
            0x1::vector::push_back<address>(&mut v14, *0x1::vector::borrow<address>(&v2, *0x1::vector::borrow<u64>(&v13, v15)));
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::empty<address>();
        let v17 = 0x1::vector::empty<u64>();
        let v18 = 0;
        while (v18 < v7) {
            let v19 = *0x1::vector::borrow<address>(&v2, v18);
            if (!0x1::vector::contains<address>(&v14, &v19)) {
                0x1::vector::push_back<address>(&mut v16, v19);
                0x1::vector::push_back<u64>(&mut v17, *0x1::vector::borrow<u64>(&v10, v18));
            };
            v18 = v18 + 1;
        };
        let v20 = 0x1::vector::length<address>(&v16);
        let v21 = if (v20 < arg6) {
            v20
        } else {
            arg6
        };
        let v22 = select_weighted_without_replacement(&v17, v21, arg9);
        let v23 = 0x1::vector::empty<address>();
        let v24 = 0;
        while (v24 < 0x1::vector::length<u64>(&v22)) {
            0x1::vector::push_back<address>(&mut v23, *0x1::vector::borrow<address>(&v16, *0x1::vector::borrow<u64>(&v22, v24)));
            v24 = v24 + 1;
        };
        let v25 = if (0x1::vector::length<address>(&v23) > 0 && arg5 > 0) {
            distribute_lucky_amounts(arg5, 0x1::vector::length<address>(&v23), arg7, arg8, arg9)
        } else {
            0x1::vector::empty<u64>()
        };
        let v26 = 0;
        let v27 = 0;
        let v28 = 0;
        while (v28 < v7) {
            v26 = v26 + (*0x1::vector::borrow<u64>(&v3, v28) as u128);
            v27 = v27 + (*0x1::vector::borrow<u64>(&v10, v28) as u128);
            v28 = v28 + 1;
        };
        DrawOutcome{
            drawn                 : true,
            round                 : arg0.current_round,
            now                   : v0,
            grand_winners         : v14,
            lucky_winners         : v23,
            lucky_amounts         : v25,
            total_participants    : v7,
            total_savings_entries : saturating_u64(v26),
            total_lucky_entries   : saturating_u64(v27),
        }
    }

    fun saturating_u64(arg0: u128) : u64 {
        if (arg0 > (18446744073709551615 as u128)) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    fun select_weighted_without_replacement(arg0: &vector<u64>, arg1: u64, arg2: &mut 0x2::random::RandomGenerator) : vector<u64> {
        let v0 = copy_vec_u64(arg0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = weighted_random_select(&v0, arg2);
            0x1::vector::push_back<u64>(&mut v1, v3);
            *0x1::vector::borrow_mut<u64>(&mut v0, v3) = 0;
            v2 = v2 + 1;
        };
        v1
    }

    public entry fun update_draw_config(arg0: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::AdminCap, arg1: &mut DrawState, arg2: u64, arg3: u64) {
        assert!(arg3 >= 3600, 109);
        arg1.min_qualifying_wallets = arg2;
        arg1.draw_interval_sec = arg3;
    }

    fun weighted_random_select(arg0: &vector<u64>, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 106);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v2);
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return 0
        };
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = v3 + *0x1::vector::borrow<u64>(arg0, v4);
            v3 = v5;
            if (0x2::random::generate_u64_in_range(arg1, 0, v1 - 1) < v5) {
                return v4
            };
            v4 = v4 + 1;
        };
        v0 - 1
    }

    // decompiled from Move bytecode v7
}

