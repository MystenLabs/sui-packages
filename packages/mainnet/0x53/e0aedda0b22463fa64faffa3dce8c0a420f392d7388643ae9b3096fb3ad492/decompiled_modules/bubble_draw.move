module 0x817f244fc50df064cef85684b7fb1024f6b904aa91d2118dfa704d820d05e920::bubble_draw {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LoyaltyState has copy, drop, store {
        multiplier_bps: u64,
        qualifying_rounds: u64,
        last_qualified_round: u64,
    }

    struct PassInfo has copy, drop, store {
        cycle_start: u64,
    }

    struct Stats has store {
        total_rounds: u64,
        total_paid_out: u64,
        total_bubbles_sold: u64,
        total_bublz_popped: u64,
        total_bublz_earned: u64,
        total_bublz_burned: u64,
        total_pop_sui_paid: u64,
    }

    struct PopResult has store {
        total_bublz: u64,
        total_sui: u64,
        total_bubbles: u64,
        participants: vector<address>,
        bubble_counts: vector<u64>,
        claimed_sui: vector<address>,
        claimed_bublz: vector<address>,
        timestamp: u64,
    }

    struct BubbleDraw<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        round: u64,
        round_start: u64,
        bubble_count: u64,
        participants: vector<address>,
        round_counts: 0x2::table::Table<address, u64>,
        unique_participants: vector<address>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        pop_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        referral_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        pop_bublz: 0x2::balance::Balance<T0>,
        participation_pool: 0x2::balance::Balance<T0>,
        growth_per_round: u64,
        rounds_since_pop: u64,
        last_pop_round: u64,
        pop_claims: 0x2::table::Table<u64, PopResult>,
        reward_per_bubble: u64,
        participation_rewards: 0x2::table::Table<address, u64>,
        loyalty: 0x2::table::Table<address, LoyaltyState>,
        passes: 0x2::table::Table<address, PassInfo>,
        pass_price: u64,
        cycle_start: u64,
        cycle_duration: u64,
        referrals: 0x2::table::Table<address, address>,
        referral_earnings: 0x2::table::Table<address, u64>,
        stats: Stats,
        paused: bool,
    }

    struct BubblesPurchased has copy, drop {
        buyer: address,
        round: u64,
        bubble_count: u64,
        total_entries: u64,
        amount: u64,
        bublz_earned: u64,
        referrer: address,
        referral_amount: u64,
    }

    struct DrawComplete has copy, drop {
        round: u64,
        winner: address,
        prize: u64,
        treasury_amount: u64,
        total_bubbles: u64,
        bubble_popped: bool,
        pop_bublz: u64,
        pop_sui: u64,
    }

    struct BubblePopped has copy, drop {
        round: u64,
        total_bublz: u64,
        total_sui: u64,
        rounds_accumulated: u64,
        total_bubbles: u64,
        num_participants: u64,
    }

    struct RewardsClaimed has copy, drop {
        claimer: address,
        participation_amount: u64,
        pop_amount_bublz: u64,
        pop_rounds_claimed: vector<u64>,
        multiplier_bps: u64,
    }

    struct PopSuiClaimed has copy, drop {
        claimer: address,
        amount: u64,
        pop_rounds_claimed: vector<u64>,
    }

    struct ReferralClaimed has copy, drop {
        claimer: address,
        amount: u64,
    }

    struct PassPurchased has copy, drop {
        buyer: address,
        amount_burned: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    entry fun buy_bubbles<T0>(arg0: &mut BubbleDraw<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(arg2 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.round_start + 60000, 6);
        assert!(v0 < arg0.round_start + 270000, 5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = (((250000000 as u128) * (arg2 as u128)) as u64);
        assert!(v1 >= v2, 3);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v4 = 0x2::tx_context::sender(arg4);
        if (v1 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v1 - v2), arg4), v4);
        };
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v6 = (((v5 as u128) * (100 as u128) / (10000 as u128)) as u64);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::split<0x2::sui::SUI>(&mut v3, (((v5 as u128) * (7000 as u128) / (10000 as u128)) as u64)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pop_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v3, (((v5 as u128) * (1000 as u128) / (10000 as u128)) as u64)));
        let v7 = @0x0;
        let v8 = 0;
        if (0x2::table::contains<address, address>(&arg0.referrals, v4) && v6 > 0) {
            let v9 = *0x2::table::borrow<address, address>(&arg0.referrals, v4);
            v7 = v9;
            v8 = v6;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.referral_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v6));
            if (0x2::table::contains<address, u64>(&arg0.referral_earnings, v9)) {
                let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_earnings, v9);
                *v10 = *v10 + v6;
            } else {
                0x2::table::add<address, u64>(&mut arg0.referral_earnings, v9, v6);
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v3);
        let v11 = if (has_active_pass<T0>(arg0, v4)) {
            arg2 / 5
        } else {
            0
        };
        let v12 = arg2 + v11;
        let v13 = 0;
        while (v13 < v12) {
            0x1::vector::push_back<address>(&mut arg0.participants, v4);
            v13 = v13 + 1;
        };
        if (0x2::table::contains<address, u64>(&arg0.round_counts, v4)) {
            let v14 = 0x2::table::borrow_mut<address, u64>(&mut arg0.round_counts, v4);
            *v14 = *v14 + v12;
        } else {
            0x2::table::add<address, u64>(&mut arg0.round_counts, v4, v12);
            0x1::vector::push_back<address>(&mut arg0.unique_participants, v4);
        };
        arg0.bubble_count = arg0.bubble_count + v12;
        arg0.stats.total_bubbles_sold = arg0.stats.total_bubbles_sold + arg2;
        let v15 = 0;
        if (arg0.reward_per_bubble > 0) {
            let v16 = arg2 * arg0.reward_per_bubble;
            v15 = v16;
            arg0.stats.total_bublz_earned = arg0.stats.total_bublz_earned + v16;
            if (0x2::table::contains<address, u64>(&arg0.participation_rewards, v4)) {
                let v17 = 0x2::table::borrow_mut<address, u64>(&mut arg0.participation_rewards, v4);
                *v17 = *v17 + v16;
            } else {
                0x2::table::add<address, u64>(&mut arg0.participation_rewards, v4, v16);
            };
        };
        if (*0x2::table::borrow<address, u64>(&arg0.round_counts, v4) >= 4) {
            if (!0x2::table::contains<address, LoyaltyState>(&arg0.loyalty, v4)) {
                let v18 = LoyaltyState{
                    multiplier_bps       : 10000 + 100,
                    qualifying_rounds    : 1,
                    last_qualified_round : arg0.round,
                };
                0x2::table::add<address, LoyaltyState>(&mut arg0.loyalty, v4, v18);
            } else {
                let v19 = 0x2::table::borrow_mut<address, LoyaltyState>(&mut arg0.loyalty, v4);
                if (v19.last_qualified_round != arg0.round) {
                    if (v19.multiplier_bps < 20000) {
                        v19.multiplier_bps = v19.multiplier_bps + 100;
                        if (v19.multiplier_bps > 20000) {
                            v19.multiplier_bps = 20000;
                        };
                    };
                    v19.qualifying_rounds = v19.qualifying_rounds + 1;
                    v19.last_qualified_round = arg0.round;
                };
            };
        };
        let v20 = BubblesPurchased{
            buyer           : v4,
            round           : arg0.round,
            bubble_count    : arg2,
            total_entries   : v12,
            amount          : v5,
            bublz_earned    : v15,
            referrer        : v7,
            referral_amount : v8,
        };
        0x2::event::emit<BubblesPurchased>(v20);
    }

    entry fun buy_pass<T0>(arg0: &mut BubbleDraw<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg0.pass_price, 15);
        if (0x2::table::contains<address, PassInfo>(&arg0.passes, v0)) {
            assert!(0x2::table::borrow<address, PassInfo>(&arg0.passes, v0).cycle_start != arg0.cycle_start, 14);
        };
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        if (v1 > arg0.pass_price) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v1 - arg0.pass_price), arg2), v0);
        };
        let v3 = 0x2::balance::value<T0>(&v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), @0x0);
        arg0.stats.total_bublz_burned = arg0.stats.total_bublz_burned + v3;
        if (0x2::table::contains<address, PassInfo>(&arg0.passes, v0)) {
            0x2::table::borrow_mut<address, PassInfo>(&mut arg0.passes, v0).cycle_start = arg0.cycle_start;
        } else {
            let v4 = PassInfo{cycle_start: arg0.cycle_start};
            0x2::table::add<address, PassInfo>(&mut arg0.passes, v0, v4);
        };
        let v5 = PassPurchased{
            buyer         : v0,
            amount_burned : v3,
        };
        0x2::event::emit<PassPurchased>(v5);
    }

    entry fun claim_bublz_rewards<T0>(arg0: &mut BubbleDraw<T0>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_loyalty_multiplier<T0>(arg0, v0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<u64>();
        if (0x2::table::contains<address, u64>(&arg0.participation_rewards, v0)) {
            v2 = *0x2::table::borrow<address, u64>(&arg0.participation_rewards, v0);
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg1)) {
            let v6 = *0x1::vector::borrow<u64>(&arg1, v5);
            if (0x2::table::contains<u64, PopResult>(&arg0.pop_claims, v6)) {
                let v7 = 0x2::table::borrow_mut<u64, PopResult>(&mut arg0.pop_claims, v6);
                if (0x2::clock::timestamp_ms(arg2) <= v7.timestamp + 604800000) {
                    let v8 = false;
                    let v9 = 0;
                    while (v9 < 0x1::vector::length<address>(&v7.claimed_bublz)) {
                        if (*0x1::vector::borrow<address>(&v7.claimed_bublz, v9) == v0) {
                            v8 = true;
                            v9 = 0x1::vector::length<address>(&v7.claimed_bublz);
                        };
                        v9 = v9 + 1;
                    };
                    if (!v8) {
                        let v10 = 0;
                        let v11 = 0;
                        while (v11 < 0x1::vector::length<address>(&v7.participants)) {
                            if (*0x1::vector::borrow<address>(&v7.participants, v11) == v0) {
                                v10 = *0x1::vector::borrow<u64>(&v7.bubble_counts, v11);
                                v11 = 0x1::vector::length<address>(&v7.participants);
                            };
                            v11 = v11 + 1;
                        };
                        if (v10 > 0) {
                            v3 = v3 + (((v7.total_bublz as u128) * (v10 as u128) / (v7.total_bubbles as u128)) as u64);
                            0x1::vector::push_back<address>(&mut v7.claimed_bublz, v0);
                            0x1::vector::push_back<u64>(&mut v4, v6);
                        };
                    };
                };
            };
            v5 = v5 + 1;
        };
        let v12 = ((((v2 + v3) as u128) * (v1 as u128) / (10000 as u128)) as u64);
        assert!(v12 > 0, 9);
        let v13 = 0x2::balance::value<T0>(&arg0.pop_bublz) + 0x2::balance::value<T0>(&arg0.participation_pool);
        let v14 = if (v12 > v13) {
            v13
        } else {
            v12
        };
        if (v14 > 0) {
            let v15 = v14;
            let v16 = 0x2::balance::value<T0>(&arg0.participation_pool);
            if (v16 > 0 && v14 > 0) {
                let v17 = if (v14 > v16) {
                    v16
                } else {
                    v14
                };
                let v18 = 0x2::balance::split<T0>(&mut arg0.participation_pool, v17);
                let v19 = (((v17 as u128) * (500 as u128) / (10000 as u128)) as u64);
                0x2::balance::join<T0>(&mut arg0.participation_pool, 0x2::balance::split<T0>(&mut v18, (((v17 as u128) * (1500 as u128) / (10000 as u128)) as u64)));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v18, v19), arg3), @0x0);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg3), v0);
                arg0.stats.total_bublz_burned = arg0.stats.total_bublz_burned + v19;
                v15 = v14 - v17;
            };
            if (v15 > 0) {
                let v20 = 0x2::balance::value<T0>(&arg0.pop_bublz);
                if (v20 > 0) {
                    let v21 = if (v15 > v20) {
                        v20
                    } else {
                        v15
                    };
                    let v22 = 0x2::balance::split<T0>(&mut arg0.pop_bublz, v21);
                    let v23 = (((v21 as u128) * (500 as u128) / (10000 as u128)) as u64);
                    0x2::balance::join<T0>(&mut arg0.pop_bublz, 0x2::balance::split<T0>(&mut v22, (((v21 as u128) * (1500 as u128) / (10000 as u128)) as u64)));
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v22, v23), arg3), @0x0);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v22, arg3), v0);
                    arg0.stats.total_bublz_burned = arg0.stats.total_bublz_burned + v23;
                };
            };
        };
        if (v2 > 0 && 0x2::table::contains<address, u64>(&arg0.participation_rewards, v0)) {
            if (v14 >= v12) {
                0x2::table::remove<address, u64>(&mut arg0.participation_rewards, v0);
            } else {
                let v24 = (((v14 as u128) * (10000 as u128) / (v1 as u128)) as u64);
                let v25 = if (v24 >= v2) {
                    0
                } else {
                    v2 - v24
                };
                if (v25 > 0) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.participation_rewards, v0) = v25;
                } else {
                    0x2::table::remove<address, u64>(&mut arg0.participation_rewards, v0);
                };
            };
        };
        if (0x2::table::contains<address, LoyaltyState>(&arg0.loyalty, v0)) {
            let v26 = 0x2::table::borrow_mut<address, LoyaltyState>(&mut arg0.loyalty, v0);
            v26.multiplier_bps = 10000;
            v26.qualifying_rounds = 0;
        };
        let v27 = RewardsClaimed{
            claimer              : v0,
            participation_amount : v2,
            pop_amount_bublz     : v3,
            pop_rounds_claimed   : v4,
            multiplier_bps       : v1,
        };
        0x2::event::emit<RewardsClaimed>(v27);
    }

    entry fun claim_pop_sui<T0>(arg0: &mut BubbleDraw<T0>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg1)) {
            let v4 = *0x1::vector::borrow<u64>(&arg1, v3);
            if (0x2::table::contains<u64, PopResult>(&arg0.pop_claims, v4)) {
                let v5 = 0x2::table::borrow_mut<u64, PopResult>(&mut arg0.pop_claims, v4);
                if (0x2::clock::timestamp_ms(arg2) <= v5.timestamp + 604800000) {
                    let v6 = false;
                    let v7 = 0;
                    while (v7 < 0x1::vector::length<address>(&v5.claimed_sui)) {
                        if (*0x1::vector::borrow<address>(&v5.claimed_sui, v7) == v0) {
                            v6 = true;
                            v7 = 0x1::vector::length<address>(&v5.claimed_sui);
                        };
                        v7 = v7 + 1;
                    };
                    if (!v6) {
                        let v8 = 0;
                        let v9 = 0;
                        while (v9 < 0x1::vector::length<address>(&v5.participants)) {
                            if (*0x1::vector::borrow<address>(&v5.participants, v9) == v0) {
                                v8 = *0x1::vector::borrow<u64>(&v5.bubble_counts, v9);
                                v9 = 0x1::vector::length<address>(&v5.participants);
                            };
                            v9 = v9 + 1;
                        };
                        if (v8 > 0) {
                            v1 = v1 + (((v5.total_sui as u128) * (v8 as u128) / (v5.total_bubbles as u128)) as u64);
                            0x1::vector::push_back<address>(&mut v5.claimed_sui, v0);
                            0x1::vector::push_back<u64>(&mut v2, v4);
                        };
                    };
                };
            };
            v3 = v3 + 1;
        };
        assert!(v1 > 0, 9);
        let v10 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pop_sui);
        let v11 = if (v1 > v10) {
            v10
        } else {
            v1
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pop_sui, v11), arg3), v0);
        };
        let v12 = PopSuiClaimed{
            claimer            : v0,
            amount             : v11,
            pop_rounds_claimed : v2,
        };
        0x2::event::emit<PopSuiClaimed>(v12);
    }

    entry fun claim_referral_rewards<T0>(arg0: &mut BubbleDraw<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.referral_earnings, v0), 13);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.referral_earnings, v0);
        assert!(v1 > 0, 13);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.referral_pool) >= v1, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.referral_pool, v1), arg1), v0);
        let v2 = ReferralClaimed{
            claimer : v0,
            amount  : v1,
        };
        0x2::event::emit<ReferralClaimed>(v2);
    }

    entry fun create_draw<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = Stats{
            total_rounds       : 0,
            total_paid_out     : 0,
            total_bubbles_sold : 0,
            total_bublz_popped : 0,
            total_bublz_earned : 0,
            total_bublz_burned : 0,
            total_pop_sui_paid : 0,
        };
        let v2 = BubbleDraw<T0>{
            id                    : 0x2::object::new(arg6),
            admin                 : 0x2::tx_context::sender(arg6),
            round                 : 1,
            round_start           : v0,
            bubble_count          : 0,
            participants          : 0x1::vector::empty<address>(),
            round_counts          : 0x2::table::new<address, u64>(arg6),
            unique_participants   : 0x1::vector::empty<address>(),
            pot                   : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury              : 0x2::balance::zero<0x2::sui::SUI>(),
            pop_sui               : 0x2::balance::zero<0x2::sui::SUI>(),
            referral_pool         : 0x2::balance::zero<0x2::sui::SUI>(),
            pop_bublz             : 0x2::balance::zero<T0>(),
            participation_pool    : 0x2::balance::zero<T0>(),
            growth_per_round      : arg1,
            rounds_since_pop      : 0,
            last_pop_round        : 0,
            pop_claims            : 0x2::table::new<u64, PopResult>(arg6),
            reward_per_bubble     : arg2,
            participation_rewards : 0x2::table::new<address, u64>(arg6),
            loyalty               : 0x2::table::new<address, LoyaltyState>(arg6),
            passes                : 0x2::table::new<address, PassInfo>(arg6),
            pass_price            : arg3,
            cycle_start           : v0,
            cycle_duration        : arg4,
            referrals             : 0x2::table::new<address, address>(arg6),
            referral_earnings     : 0x2::table::new<address, u64>(arg6),
            stats                 : v1,
            paused                : false,
        };
        0x2::transfer::share_object<BubbleDraw<T0>>(v2);
    }

    entry fun distribute_pop_sui<T0>(arg0: &mut BubbleDraw<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, PopResult>(&arg0.pop_claims, arg1), 9);
        let v0 = 0x2::table::borrow_mut<u64, PopResult>(&mut arg0.pop_claims, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0.participants)) {
            let v2 = *0x1::vector::borrow<address>(&v0.participants, v1);
            let v3 = false;
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(&v0.claimed_sui)) {
                if (*0x1::vector::borrow<address>(&v0.claimed_sui, v4) == v2) {
                    v3 = true;
                    v4 = 0x1::vector::length<address>(&v0.claimed_sui);
                };
                v4 = v4 + 1;
            };
            if (!v3) {
                let v5 = (((v0.total_sui as u128) * (*0x1::vector::borrow<u64>(&v0.bubble_counts, v1) as u128) / (v0.total_bubbles as u128)) as u64);
                let v6 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pop_sui);
                let v7 = if (v5 > v6) {
                    v6
                } else {
                    v5
                };
                if (v7 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pop_sui, v7), arg2), v2);
                    0x1::vector::push_back<address>(&mut v0.claimed_sui, v2);
                };
            };
            v1 = v1 + 1;
        };
    }

    entry fun draw_winner<T0>(arg0: &mut BubbleDraw<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.round_start + 300000, 1);
        let v1 = 0x2::random::new_generator(arg1, arg3);
        let v2 = arg0.round;
        let v3 = arg0.bubble_count;
        let v4 = @0x0;
        let v5 = 0;
        let v6 = false;
        let v7 = 0;
        let v8 = 0;
        if (v3 > 0) {
            let v9 = *0x1::vector::borrow<address>(&arg0.participants, 0x2::random::generate_u64_in_range(&mut v1, 0, v3 - 1));
            v4 = v9;
            let v10 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
            v5 = v10;
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v10), arg3), v9);
            };
        };
        arg0.rounds_since_pop = arg0.rounds_since_pop + 1;
        if (v3 > 0) {
            let v11 = arg0.rounds_since_pop * arg0.growth_per_round;
            let v12 = 0x2::balance::value<T0>(&arg0.pop_bublz);
            let v13 = if (v11 > v12) {
                v12
            } else {
                v11
            };
            let v14 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pop_sui);
            if (0x2::random::generate_u64_in_range(&mut v1, 0, 10000 - 1) < 100 && (v13 > 0 || v14 > 0)) {
                v6 = true;
                v7 = v13;
                v8 = v14;
                let v15 = 0x1::vector::empty<address>();
                let v16 = 0x1::vector::empty<u64>();
                let v17 = 0;
                while (v17 < 0x1::vector::length<address>(&arg0.unique_participants)) {
                    let v18 = *0x1::vector::borrow<address>(&arg0.unique_participants, v17);
                    0x1::vector::push_back<address>(&mut v15, v18);
                    0x1::vector::push_back<u64>(&mut v16, *0x2::table::borrow<address, u64>(&arg0.round_counts, v18));
                    v17 = v17 + 1;
                };
                let v19 = PopResult{
                    total_bublz   : v13,
                    total_sui     : v14,
                    total_bubbles : v3,
                    participants  : v15,
                    bubble_counts : v16,
                    claimed_sui   : 0x1::vector::empty<address>(),
                    claimed_bublz : 0x1::vector::empty<address>(),
                    timestamp     : v0,
                };
                0x2::table::add<u64, PopResult>(&mut arg0.pop_claims, v2, v19);
                arg0.stats.total_bublz_popped = arg0.stats.total_bublz_popped + v13;
                arg0.stats.total_pop_sui_paid = arg0.stats.total_pop_sui_paid + v14;
                arg0.last_pop_round = v2;
                arg0.rounds_since_pop = 0;
                let v20 = BubblePopped{
                    round              : v2,
                    total_bublz        : v13,
                    total_sui          : v14,
                    rounds_accumulated : arg0.rounds_since_pop,
                    total_bubbles      : v3,
                    num_participants   : 0x1::vector::length<address>(&v15),
                };
                0x2::event::emit<BubblePopped>(v20);
            };
        };
        let v21 = DrawComplete{
            round           : v2,
            winner          : v4,
            prize           : v5,
            treasury_amount : 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury),
            total_bubbles   : v3,
            bubble_popped   : v6,
            pop_bublz       : v7,
            pop_sui         : v8,
        };
        0x2::event::emit<DrawComplete>(v21);
        arg0.stats.total_rounds = arg0.stats.total_rounds + 1;
        arg0.stats.total_paid_out = arg0.stats.total_paid_out + v5;
        arg0.round = arg0.round + 1;
        arg0.round_start = v0;
        arg0.bubble_count = 0;
        arg0.participants = 0x1::vector::empty<address>();
        let v22 = 0;
        while (v22 < 0x1::vector::length<address>(&arg0.unique_participants)) {
            0x2::table::remove<address, u64>(&mut arg0.round_counts, *0x1::vector::borrow<address>(&arg0.unique_participants, v22));
            v22 = v22 + 1;
        };
        arg0.unique_participants = 0x1::vector::empty<address>();
        if (v0 >= arg0.cycle_start + arg0.cycle_duration) {
            arg0.cycle_start = v0;
        };
    }

    entry fun emergency_withdraw<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 17);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.referral_pool);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pop_sui);
        let v5 = 0x2::balance::value<T0>(&arg0.pop_bublz);
        let v6 = 0x2::balance::value<T0>(&arg0.participation_pool);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v1), arg2), v0);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v2), arg2), v0);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.referral_pool, v3), arg2), v0);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pop_sui, v4), arg2), v0);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pop_bublz, v5), arg2), v0);
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.participation_pool, v6), arg2), v0);
        };
    }

    entry fun fund_participation_pool<T0>(arg0: &mut BubbleDraw<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.participation_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun fund_pop_pool<T0>(arg0: &mut BubbleDraw<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pop_bublz, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_bubble_count<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.bubble_count
    }

    fun get_loyalty_multiplier<T0>(arg0: &BubbleDraw<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, LoyaltyState>(&arg0.loyalty, arg1)) {
            return 10000
        };
        0x2::table::borrow<address, LoyaltyState>(&arg0.loyalty, arg1).multiplier_bps
    }

    public fun get_pop_bublz_value<T0>(arg0: &BubbleDraw<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pop_bublz)
    }

    public fun get_pop_sui_value<T0>(arg0: &BubbleDraw<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pop_sui)
    }

    public fun get_pot_value<T0>(arg0: &BubbleDraw<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun get_round<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.round
    }

    fun has_active_pass<T0>(arg0: &BubbleDraw<T0>, arg1: address) : bool {
        if (!0x2::table::contains<address, PassInfo>(&arg0.passes, arg1)) {
            return false
        };
        0x2::table::borrow<address, PassInfo>(&arg0.passes, arg1).cycle_start == arg0.cycle_start
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun set_cycle_duration<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.cycle_duration = arg2;
    }

    entry fun set_growth_per_round<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.growth_per_round = arg2;
    }

    entry fun set_pass_price<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.pass_price = arg2;
    }

    entry fun set_paused<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    entry fun set_referral<T0>(arg0: &mut BubbleDraw<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 8);
        assert!(!0x2::table::contains<address, address>(&arg0.referrals, v0), 7);
        0x2::table::add<address, address>(&mut arg0.referrals, v0, arg1);
    }

    entry fun set_reward_per_bubble<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.reward_per_bubble = arg2;
    }

    entry fun skip_round<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.round_start + 300000, 1);
        assert!(arg0.bubble_count == 0, 16);
        arg0.round = arg0.round + 1;
        arg0.round_start = v0;
    }

    entry fun withdraw_treasury<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        if (v0 > 0) {
            let v1 = 0x2::tx_context::sender(arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v0), arg2), v1);
            let v2 = TreasuryWithdrawn{
                amount    : v0,
                recipient : v1,
            };
            0x2::event::emit<TreasuryWithdrawn>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

