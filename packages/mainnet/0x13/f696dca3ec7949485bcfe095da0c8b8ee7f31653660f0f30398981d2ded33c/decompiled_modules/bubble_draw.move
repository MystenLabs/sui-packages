module 0x13f696dca3ec7949485bcfe095da0c8b8ee7f31653660f0f30398981d2ded33c::bubble_draw {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PassInfo has copy, drop, store {
        tier: u8,
        amount_paid: u64,
        cycle_start: u64,
    }

    struct BubbleDraw<phantom T0> has key {
        id: 0x2::object::UID,
        round: u64,
        round_start: u64,
        bubble_count: u64,
        participants: vector<address>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        referral_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        pop_pool: 0x2::balance::Balance<T0>,
        participation_pool: 0x2::balance::Balance<T0>,
        growth_per_round: u64,
        reward_per_bubble: u64,
        rounds_since_pop: u64,
        last_pop_round: u64,
        total_rounds: u64,
        total_paid_out: u64,
        total_bubbles_sold: u64,
        total_bublz_popped: u64,
        total_bublz_earned: u64,
        total_bublz_burned: u64,
        paused: bool,
        pop_claims: 0x2::table::Table<u64, PopResult>,
        participation_rewards: 0x2::table::Table<address, u64>,
        referrals: 0x2::table::Table<address, address>,
        referral_earnings: 0x2::table::Table<address, u64>,
        passes: 0x2::table::Table<address, PassInfo>,
        cycle_start: u64,
        cycle_duration: u64,
    }

    struct PopResult has store {
        total_bublz: u64,
        total_bubbles: u64,
        participants: vector<address>,
        bubble_counts: vector<u64>,
        claimed: vector<address>,
        timestamp: u64,
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
        pop_amount: u64,
    }

    struct BubblePopped has copy, drop {
        round: u64,
        total_bublz: u64,
        rounds_accumulated: u64,
        total_bubbles: u64,
        num_participants: u64,
    }

    struct RewardsClaimed has copy, drop {
        claimer: address,
        participation_amount: u64,
        pop_amount: u64,
        pop_rounds_claimed: vector<u64>,
    }

    struct ReferralClaimed has copy, drop {
        claimer: address,
        amount: u64,
    }

    struct PassPurchased has copy, drop {
        buyer: address,
        tier: u8,
        amount_burned: u64,
        upgraded_from: u8,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    entry fun buy_bubbles<T0>(arg0: &mut BubbleDraw<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(arg2 > 0, 1);
        assert!(arg2 <= 100, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.round_start + 60000, 12);
        assert!(v0 < arg0.round_start + 540000, 0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = (((250000000 as u128) * (arg2 as u128)) as u64);
        assert!(v1 >= v2, 2);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v1 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v1 - v2), arg4), 0x2::tx_context::sender(arg4));
        };
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = (((v4 as u128) * (100 as u128) / (10000 as u128)) as u64);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::split<0x2::sui::SUI>(&mut v3, (((v4 as u128) * (7000 as u128) / (10000 as u128)) as u64)));
        let v6 = 0x2::tx_context::sender(arg4);
        let v7 = @0x0;
        let v8 = 0;
        if (0x2::table::contains<address, address>(&arg0.referrals, v6) && v5 > 0) {
            let v9 = *0x2::table::borrow<address, address>(&arg0.referrals, v6);
            v7 = v9;
            v8 = v5;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.referral_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v5));
            if (0x2::table::contains<address, u64>(&arg0.referral_earnings, v9)) {
                let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_earnings, v9);
                *v10 = *v10 + v5;
            } else {
                0x2::table::add<address, u64>(&mut arg0.referral_earnings, v9, v5);
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v3);
        let v11 = 0;
        if (get_active_tier<T0>(arg0, v6) == 3) {
            v11 = arg2 / 5;
        };
        let v12 = arg2 + v11;
        let v13 = 0;
        while (v13 < v12) {
            0x1::vector::push_back<address>(&mut arg0.participants, v6);
            v13 = v13 + 1;
        };
        arg0.bubble_count = arg0.bubble_count + v12;
        arg0.total_bubbles_sold = arg0.total_bubbles_sold + arg2;
        let v14 = 0;
        if (arg0.reward_per_bubble > 0) {
            let v15 = ((((v12 * arg0.reward_per_bubble) as u128) * (get_active_multiplier<T0>(arg0, v6) as u128) / (100 as u128)) as u64);
            if (0x2::balance::value<T0>(&arg0.participation_pool) >= v15) {
                v14 = v15;
                arg0.total_bublz_earned = arg0.total_bublz_earned + v15;
                if (0x2::table::contains<address, u64>(&arg0.participation_rewards, v6)) {
                    let v16 = 0x2::table::borrow_mut<address, u64>(&mut arg0.participation_rewards, v6);
                    *v16 = *v16 + v15;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.participation_rewards, v6, v15);
                };
            };
        };
        let v17 = BubblesPurchased{
            buyer           : v6,
            round           : arg0.round,
            bubble_count    : arg2,
            total_entries   : v12,
            amount          : v4,
            bublz_earned    : v14,
            referrer        : v7,
            referral_amount : v8,
        };
        0x2::event::emit<BubblesPurchased>(v17);
    }

    entry fun buy_pass<T0>(arg0: &mut BubbleDraw<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 3, 15);
        let v0 = get_pass_price(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0;
        let v3 = 0;
        if (0x2::table::contains<address, PassInfo>(&arg0.passes, v1)) {
            let v4 = 0x2::table::borrow<address, PassInfo>(&arg0.passes, v1);
            if (v4.cycle_start == arg0.cycle_start) {
                assert!(arg1 > v4.tier, 16);
                v2 = v4.amount_paid;
                v3 = v4.tier;
            };
        };
        let v5 = v0 - v2;
        let v6 = 0x2::coin::value<T0>(&arg2);
        assert!(v6 >= v5, 17);
        let v7 = 0x2::coin::into_balance<T0>(arg2);
        if (v6 > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v6 - v5), arg3), v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg3), @0x0);
        arg0.total_bublz_burned = arg0.total_bublz_burned + v5;
        if (0x2::table::contains<address, PassInfo>(&arg0.passes, v1)) {
            let v8 = 0x2::table::borrow_mut<address, PassInfo>(&mut arg0.passes, v1);
            v8.tier = arg1;
            v8.amount_paid = v0;
            v8.cycle_start = arg0.cycle_start;
        } else {
            let v9 = PassInfo{
                tier        : arg1,
                amount_paid : v0,
                cycle_start : arg0.cycle_start,
            };
            0x2::table::add<address, PassInfo>(&mut arg0.passes, v1, v9);
        };
        let v10 = PassPurchased{
            buyer         : v1,
            tier          : arg1,
            amount_burned : v5,
            upgraded_from : v3,
        };
        0x2::event::emit<PassPurchased>(v10);
    }

    entry fun claim_all_rewards<T0>(arg0: &mut BubbleDraw<T0>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        if (0x2::table::contains<address, u64>(&arg0.participation_rewards, v0)) {
            v1 = 0x2::table::remove<address, u64>(&mut arg0.participation_rewards, v0);
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg1)) {
            let v5 = *0x1::vector::borrow<u64>(&arg1, v4);
            if (0x2::table::contains<u64, PopResult>(&arg0.pop_claims, v5)) {
                let v6 = 0x2::table::borrow_mut<u64, PopResult>(&mut arg0.pop_claims, v5);
                if (0x2::clock::timestamp_ms(arg2) <= v6.timestamp + 604800000) {
                    let v7 = false;
                    let v8 = 0;
                    while (v8 < 0x1::vector::length<address>(&v6.claimed)) {
                        if (*0x1::vector::borrow<address>(&v6.claimed, v8) == v0) {
                            v7 = true;
                            v8 = 0x1::vector::length<address>(&v6.claimed);
                        };
                        v8 = v8 + 1;
                    };
                    if (!v7) {
                        let v9 = 0;
                        let v10 = 0;
                        while (v10 < 0x1::vector::length<address>(&v6.participants)) {
                            if (*0x1::vector::borrow<address>(&v6.participants, v10) == v0) {
                                v9 = *0x1::vector::borrow<u64>(&v6.bubble_counts, v10);
                                v10 = 0x1::vector::length<address>(&v6.participants);
                            };
                            v10 = v10 + 1;
                        };
                        if (v9 > 0) {
                            v2 = v2 + ((((((v6.total_bublz as u128) * (v9 as u128) / (v6.total_bubbles as u128)) as u64) as u128) * (get_active_multiplier<T0>(arg0, v0) as u128) / (100 as u128)) as u64);
                            0x1::vector::push_back<address>(&mut v6.claimed, v0);
                            0x1::vector::push_back<u64>(&mut v3, v5);
                        };
                    };
                };
            };
            v4 = v4 + 1;
        };
        assert!(v1 + v2 > 0, 10);
        let v11 = 1500;
        let v12 = 500;
        if (v1 > 0 && 0x2::balance::value<T0>(&arg0.participation_pool) >= v1) {
            let v13 = (((v1 as u128) * (v11 as u128) / (10000 as u128)) as u64);
            let v14 = (((v1 as u128) * (v12 as u128) / (10000 as u128)) as u64);
            let v15 = v1 - v13 - v14;
            let v16 = 0x2::balance::split<T0>(&mut arg0.participation_pool, v1);
            0x2::balance::join<T0>(&mut arg0.participation_pool, 0x2::balance::split<T0>(&mut v16, v13));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v16, v14), arg3), @0x0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg3), v0);
            arg0.total_bublz_burned = arg0.total_bublz_burned + v14;
            v1 = v15;
        };
        if (v2 > 0 && 0x2::balance::value<T0>(&arg0.pop_pool) >= v2) {
            let v17 = (((v2 as u128) * (v11 as u128) / (10000 as u128)) as u64);
            let v18 = (((v2 as u128) * (v12 as u128) / (10000 as u128)) as u64);
            let v19 = v2 - v17 - v18;
            let v20 = 0x2::balance::split<T0>(&mut arg0.pop_pool, v2);
            0x2::balance::join<T0>(&mut arg0.pop_pool, 0x2::balance::split<T0>(&mut v20, v17));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v20, v18), arg3), @0x0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v20, arg3), v0);
            arg0.total_bublz_burned = arg0.total_bublz_burned + v18;
            v2 = v19;
        };
        let v21 = RewardsClaimed{
            claimer              : v0,
            participation_amount : v1,
            pop_amount           : v2,
            pop_rounds_claimed   : v3,
        };
        0x2::event::emit<RewardsClaimed>(v21);
    }

    entry fun claim_referral_rewards<T0>(arg0: &mut BubbleDraw<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.referral_earnings, v0), 18);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.referral_earnings, v0);
        assert!(v1 > 0, 18);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.referral_pool) >= v1, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.referral_pool, v1), arg1), v0);
        let v2 = ReferralClaimed{
            claimer : v0,
            amount  : v1,
        };
        0x2::event::emit<ReferralClaimed>(v2);
    }

    entry fun create_draw<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = BubbleDraw<T0>{
            id                    : 0x2::object::new(arg5),
            round                 : 1,
            round_start           : v0,
            bubble_count          : 0,
            participants          : 0x1::vector::empty<address>(),
            pot                   : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury              : 0x2::balance::zero<0x2::sui::SUI>(),
            referral_pool         : 0x2::balance::zero<0x2::sui::SUI>(),
            pop_pool              : 0x2::balance::zero<T0>(),
            participation_pool    : 0x2::balance::zero<T0>(),
            growth_per_round      : arg1,
            reward_per_bubble     : arg2,
            rounds_since_pop      : 0,
            last_pop_round        : 0,
            total_rounds          : 0,
            total_paid_out        : 0,
            total_bubbles_sold    : 0,
            total_bublz_popped    : 0,
            total_bublz_earned    : 0,
            total_bublz_burned    : 0,
            paused                : false,
            pop_claims            : 0x2::table::new<u64, PopResult>(arg5),
            participation_rewards : 0x2::table::new<address, u64>(arg5),
            referrals             : 0x2::table::new<address, address>(arg5),
            referral_earnings     : 0x2::table::new<address, u64>(arg5),
            passes                : 0x2::table::new<address, PassInfo>(arg5),
            cycle_start           : v0,
            cycle_duration        : arg3,
        };
        0x2::transfer::share_object<BubbleDraw<T0>>(v1);
    }

    entry fun draw_winner<T0>(arg0: &mut BubbleDraw<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.round_start + 540000, 0);
        let v1 = 0x2::random::new_generator(arg1, arg3);
        let v2 = arg0.round;
        let v3 = arg0.bubble_count;
        let v4 = @0x0;
        let v5 = 0;
        let v6 = false;
        let v7 = 0;
        if (v3 > 0) {
            let v8 = *0x1::vector::borrow<address>(&arg0.participants, 0x2::random::generate_u64_in_range(&mut v1, 0, v3 - 1));
            v4 = v8;
            let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
            v5 = v9;
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v9), arg3), v8);
            };
        };
        arg0.rounds_since_pop = arg0.rounds_since_pop + 1;
        if (v3 > 0) {
            let v10 = arg0.rounds_since_pop * arg0.growth_per_round;
            let v11 = 0x2::balance::value<T0>(&arg0.pop_pool);
            let v12 = if (v10 > v11) {
                v11
            } else {
                v10
            };
            if (0x2::random::generate_u64_in_range(&mut v1, 0, 10000 - 1) < 200 && v12 > 0) {
                v6 = true;
                v7 = v12;
                let v13 = 0x1::vector::empty<address>();
                let v14 = 0x1::vector::empty<u64>();
                let v15 = 0;
                while (v15 < 0x1::vector::length<address>(&arg0.participants)) {
                    let v16 = *0x1::vector::borrow<address>(&arg0.participants, v15);
                    let v17 = false;
                    let v18 = 0;
                    while (v18 < 0x1::vector::length<address>(&v13)) {
                        if (*0x1::vector::borrow<address>(&v13, v18) == v16) {
                            let v19 = 0x1::vector::borrow_mut<u64>(&mut v14, v18);
                            *v19 = *v19 + 1;
                            v17 = true;
                            v18 = 0x1::vector::length<address>(&v13);
                        };
                        v18 = v18 + 1;
                    };
                    if (!v17) {
                        0x1::vector::push_back<address>(&mut v13, v16);
                        0x1::vector::push_back<u64>(&mut v14, 1);
                    };
                    v15 = v15 + 1;
                };
                let v20 = PopResult{
                    total_bublz   : v12,
                    total_bubbles : v3,
                    participants  : v13,
                    bubble_counts : v14,
                    claimed       : 0x1::vector::empty<address>(),
                    timestamp     : v0,
                };
                0x2::table::add<u64, PopResult>(&mut arg0.pop_claims, v2, v20);
                arg0.total_bublz_popped = arg0.total_bublz_popped + v12;
                arg0.last_pop_round = v2;
                arg0.rounds_since_pop = 0;
                let v21 = BubblePopped{
                    round              : v2,
                    total_bublz        : v12,
                    rounds_accumulated : arg0.rounds_since_pop,
                    total_bubbles      : v3,
                    num_participants   : 0x1::vector::length<address>(&v13),
                };
                0x2::event::emit<BubblePopped>(v21);
            };
        };
        let v22 = DrawComplete{
            round           : v2,
            winner          : v4,
            prize           : v5,
            treasury_amount : 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury),
            total_bubbles   : v3,
            bubble_popped   : v6,
            pop_amount      : v7,
        };
        0x2::event::emit<DrawComplete>(v22);
        arg0.total_rounds = arg0.total_rounds + 1;
        arg0.total_paid_out = arg0.total_paid_out + v5;
        arg0.round = arg0.round + 1;
        arg0.round_start = v0;
        arg0.bubble_count = 0;
        arg0.participants = 0x1::vector::empty<address>();
        if (v0 >= arg0.cycle_start + arg0.cycle_duration) {
            arg0.cycle_start = v0;
        };
    }

    entry fun emergency_withdraw<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.referral_pool);
        let v4 = 0x2::balance::value<T0>(&arg0.pop_pool);
        let v5 = 0x2::balance::value<T0>(&arg0.participation_pool);
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
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pop_pool, v4), arg2), v0);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.participation_pool, v5), arg2), v0);
        };
    }

    entry fun fund_participation_pool<T0>(arg0: &mut BubbleDraw<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.participation_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun fund_pop_pool<T0>(arg0: &mut BubbleDraw<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pop_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    fun get_active_multiplier<T0>(arg0: &BubbleDraw<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, PassInfo>(&arg0.passes, arg1)) {
            return 100
        };
        let v0 = 0x2::table::borrow<address, PassInfo>(&arg0.passes, arg1);
        if (v0.cycle_start != arg0.cycle_start) {
            return 100
        };
        get_pass_multiplier(v0.tier)
    }

    fun get_active_tier<T0>(arg0: &BubbleDraw<T0>, arg1: address) : u8 {
        if (!0x2::table::contains<address, PassInfo>(&arg0.passes, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, PassInfo>(&arg0.passes, arg1);
        if (v0.cycle_start != arg0.cycle_start) {
            return 0
        };
        v0.tier
    }

    public fun get_bubble_count<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.bubble_count
    }

    public fun get_cycle_duration<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.cycle_duration
    }

    public fun get_cycle_start<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.cycle_start
    }

    public fun get_growth_per_round<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.growth_per_round
    }

    public fun get_last_pop_round<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.last_pop_round
    }

    public fun get_participation_pool_value<T0>(arg0: &BubbleDraw<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.participation_pool)
    }

    fun get_pass_multiplier(arg0: u8) : u64 {
        if (arg0 == 1) {
            125
        } else if (arg0 == 2) {
            150
        } else if (arg0 == 3) {
            200
        } else {
            100
        }
    }

    fun get_pass_price(arg0: u8) : u64 {
        if (arg0 == 1) {
            750000000000000
        } else if (arg0 == 2) {
            1500000000000000
        } else {
            assert!(arg0 == 3, 15);
            2500000000000000
        }
    }

    public fun get_pop_pool_value<T0>(arg0: &BubbleDraw<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pop_pool)
    }

    public fun get_pot_value<T0>(arg0: &BubbleDraw<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun get_referral_pool_value<T0>(arg0: &BubbleDraw<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.referral_pool)
    }

    public fun get_reward_per_bubble<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.reward_per_bubble
    }

    public fun get_round<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.round
    }

    public fun get_round_start<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.round_start
    }

    public fun get_rounds_since_pop<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.rounds_since_pop
    }

    public fun get_total_bubbles_sold<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.total_bubbles_sold
    }

    public fun get_total_bublz_burned<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.total_bublz_burned
    }

    public fun get_total_bublz_earned<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.total_bublz_earned
    }

    public fun get_total_bublz_popped<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.total_bublz_popped
    }

    public fun get_total_paid_out<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.total_paid_out
    }

    public fun get_total_rounds<T0>(arg0: &BubbleDraw<T0>) : u64 {
        arg0.total_rounds
    }

    public fun get_treasury_value<T0>(arg0: &BubbleDraw<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
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

    entry fun set_paused<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    entry fun set_referral<T0>(arg0: &mut BubbleDraw<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 14);
        assert!(!0x2::table::contains<address, address>(&arg0.referrals, v0), 13);
        0x2::table::add<address, address>(&mut arg0.referrals, v0, arg1);
    }

    entry fun set_reward_per_bubble<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.reward_per_bubble = arg2;
    }

    entry fun skip_round<T0>(arg0: &mut BubbleDraw<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.round_start + 540000, 0);
        assert!(arg0.bubble_count == 0, 5);
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

