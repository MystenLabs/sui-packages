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
        assert!(arg9 <= arg10, 109);
        assert!(arg7 > 0 || arg8 == 0, 109);
        let v0 = 0x2::clock::timestamp_ms(arg12) / 1000;
        if (arg1.current_round > 0) {
            assert!(v0 >= arg1.last_draw_timestamp + arg1.draw_interval_sec, 101);
        };
        let v1 = 0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::get_depositors(arg3);
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(v1)) {
            let v5 = *0x1::vector::borrow<address>(v1, v4);
            let v6 = 0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::calculate_user_entries(arg3, v5, arg12);
            if (v6 > 0) {
                0x1::vector::push_back<address>(&mut v2, v5);
                0x1::vector::push_back<u64>(&mut v3, v6);
            };
            v4 = v4 + 1;
        };
        let v7 = 0x1::vector::length<address>(&v2);
        if (v7 == 0) {
            arg1.rollover_count = arg1.rollover_count + 1;
            let v8 = DrawRolledOver{
                round          : arg1.current_round + 1,
                rollover_count : arg1.rollover_count,
                participants   : 0,
                threshold      : arg1.min_qualifying_wallets,
                timestamp      : v0,
            };
            0x2::event::emit<DrawRolledOver>(v8);
            return
        };
        if (v7 < arg1.min_qualifying_wallets && arg1.rollover_count < 4) {
            arg1.rollover_count = arg1.rollover_count + 1;
            let v9 = DrawRolledOver{
                round          : arg1.current_round + 1,
                rollover_count : arg1.rollover_count,
                participants   : v7,
                threshold      : arg1.min_qualifying_wallets,
                timestamp      : v0,
            };
            0x2::event::emit<DrawRolledOver>(v9);
            return
        };
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0;
        while (v11 < v7) {
            0x1::vector::push_back<u64>(&mut v10, saturating_u64((*0x1::vector::borrow<u64>(&v3, v11) as u128) + (0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_referral::calculate_referral_bonus(*0x1::vector::borrow<address>(&v2, v11), arg4, arg5, arg3, arg12) as u128)));
            v11 = v11 + 1;
        };
        arg1.current_round = arg1.current_round + 1;
        arg1.last_draw_timestamp = v0;
        arg1.rollover_count = 0;
        let v12 = arg1.current_round;
        let v13 = 0x2::random::new_generator(arg11, arg13);
        let v14 = &mut v13;
        let v15 = *0x1::vector::borrow<address>(&v2, weighted_random_select(&v3, v14));
        let v16 = 0x1::vector::empty<address>();
        let v17 = 0x1::vector::empty<u64>();
        let v18 = 0;
        while (v18 < v7) {
            let v19 = *0x1::vector::borrow<address>(&v2, v18);
            if (v19 != v15) {
                0x1::vector::push_back<address>(&mut v16, v19);
                0x1::vector::push_back<u64>(&mut v17, *0x1::vector::borrow<u64>(&v10, v18));
            };
            v18 = v18 + 1;
        };
        let v20 = 0x1::vector::length<address>(&v16);
        let v21 = if (v20 < arg8) {
            v20
        } else {
            arg8
        };
        let v22 = 0x1::vector::empty<address>();
        let v23 = 0;
        while (v23 < v21) {
            let v24 = &mut v13;
            let v25 = weighted_random_select(&v17, v24);
            0x1::vector::push_back<address>(&mut v22, *0x1::vector::borrow<address>(&v16, v25));
            *0x1::vector::borrow_mut<u64>(&mut v17, v25) = 0;
            v23 = v23 + 1;
        };
        let v26 = if (0x1::vector::length<address>(&v22) > 0 && arg7 > 0) {
            let v27 = &mut v13;
            distribute_lucky_amounts(arg7, 0x1::vector::length<address>(&v22), arg9, arg10, v27)
        } else {
            0x1::vector::empty<u64>()
        };
        let v28 = v26;
        let v29 = 0;
        let v30 = 0;
        let v31 = 0;
        while (v31 < v7) {
            v29 = v29 + (*0x1::vector::borrow<u64>(&v3, v31) as u128);
            v30 = v30 + (*0x1::vector::borrow<u64>(&v10, v31) as u128);
            v31 = v31 + 1;
        };
        let v32 = saturating_u64(v29);
        let v33 = saturating_u64(v30);
        let v34 = DrawResult{
            id                    : 0x2::object::new(arg13),
            round                 : v12,
            draw_timestamp        : v0,
            grand_winner          : v15,
            grand_amount          : arg6,
            lucky_winners         : copy_vec_addr(&v22),
            lucky_amounts         : copy_vec_u64(&v28),
            total_participants    : v7,
            total_savings_entries : v32,
            total_lucky_entries   : v33,
        };
        0x2::table::add<u64, address>(&mut arg2.results, v12, 0x2::object::id_address<DrawResult>(&v34));
        0x2::transfer::share_object<DrawResult>(v34);
        add_pending_claim(arg2, v15, v12, arg6);
        let v35 = 0;
        while (v35 < 0x1::vector::length<address>(&v22)) {
            add_pending_claim(arg2, *0x1::vector::borrow<address>(&v22, v35), v12, *0x1::vector::borrow<u64>(&v28, v35));
            v35 = v35 + 1;
        };
        let v36 = DrawExecuted{
            round                 : v12,
            grand_winner          : v15,
            grand_amount          : arg6,
            lucky_winners         : v22,
            lucky_amounts         : v28,
            total_participants    : v7,
            total_savings_entries : v32,
            total_lucky_entries   : v33,
            timestamp             : v0,
        };
        0x2::event::emit<DrawExecuted>(v36);
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

    fun saturating_u64(arg0: u128) : u64 {
        if (arg0 > (18446744073709551615 as u128)) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
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

