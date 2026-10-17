module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond {
    struct Bond has key {
        id: 0x2::object::UID,
        number: u64,
        funds: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        unbonding_since_ms: u64,
        last_concession_ms: 0x1::option::Option<u64>,
        strikes: vector<Strike>,
        suspended_until_ms: u64,
        last_suspension_ms: 0x1::option::Option<u64>,
        open_jobs: u64,
        in_flight: u64,
        rating_sum: u64,
        rating_count: u64,
        score_root_sum: u128,
        score_penalty: u128,
        distinct_buyers: u64,
        scored_jobs: u64,
    }

    struct Strike has copy, drop, store {
        at_ms: u64,
        by: address,
    }

    struct BuyerKey has copy, drop, store {
        buyer: address,
    }

    struct AbsorbedV1 has copy, drop {
        bond: 0x2::object::ID,
        amount: u64,
        total: u64,
    }

    struct ExcessReleasedV1 has copy, drop {
        bond: 0x2::object::ID,
        amount: u64,
        sent: u64,
        to: address,
    }

    struct ToppedUpV1 has copy, drop {
        bond: 0x2::object::ID,
        amount: u64,
        total: u64,
    }

    struct FundedV1 has copy, drop {
        bond: 0x2::object::ID,
        total: u64,
    }

    struct WithdrawnV1 has copy, drop {
        bond: 0x2::object::ID,
        amount: u64,
        sent: u64,
        to: address,
    }

    struct UnbondingV1 has copy, drop {
        bond: 0x2::object::ID,
        since_ms: u64,
    }

    struct StrikeV1 has copy, drop {
        bond: 0x2::object::ID,
        at_ms: u64,
        by: address,
        suspended_until_ms: u64,
    }

    struct SuspendedV1 has copy, drop {
        number: u64,
        until_ms: u64,
        repeat: bool,
    }

    struct ScoreUpdatedV1 has copy, drop {
        bond: 0x2::object::ID,
        job: 0x2::object::ID,
        buyer: address,
        kind: u8,
        applied: bool,
        buyer_index: u128,
        root_sum: u128,
        penalty: u128,
        distinct_buyers: u64,
        scored_jobs: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Bond{
            id                 : 0x2::object::new(arg1),
            number             : arg0,
            funds              : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            unbonding_since_ms : 0,
            last_concession_ms : 0x1::option::none<u64>(),
            strikes            : 0x1::vector::empty<Strike>(),
            suspended_until_ms : 0,
            last_suspension_ms : 0x1::option::none<u64>(),
            open_jobs          : 0,
            in_flight          : 0,
            rating_sum         : 0,
            rating_count       : 0,
            score_root_sum     : 0,
            score_penalty      : 0,
            distinct_buyers    : 0,
            scored_jobs        : 0,
        };
        0x2::transfer::share_object<Bond>(v0);
        0x2::object::id<Bond>(&v0)
    }

    entry fun absorb(arg0: &mut Bond, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) {
        let v0 = 0x2::balance::settled_funds_value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::object::uid_to_address(&arg0.id));
        absorb_settled(arg0, v0, arg2);
    }

    fun absorb_settled(arg0: &mut Bond, arg1: u64, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        if (arg0.unbonding_since_ms != 0 || is_funded(arg0, arg2)) {
            return
        };
        let v0 = 0x1::u64::min(arg1, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::deposit_minimum(arg2) - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.funds));
        if (v0 == 0) {
            return
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds, 0x2::balance::redeem_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_funds_from_object<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.id, v0)));
        let v1 = AbsorbedV1{
            bond   : 0x2::object::id<Bond>(arg0),
            amount : v0,
            total  : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.funds),
        };
        0x2::event::emit<AbsorbedV1>(v1);
        if (is_funded(arg0, arg2)) {
            let v2 = FundedV1{
                bond  : 0x2::object::id<Bond>(arg0),
                total : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.funds),
            };
            0x2::event::emit<FundedV1>(v2);
        };
    }

    public(friend) fun add_rating(arg0: &mut Bond, arg1: u8) {
        arg0.rating_sum = arg0.rating_sum + (arg1 as u64);
        arg0.rating_count = arg0.rating_count + 1;
    }

    public(friend) fun correct_rating(arg0: &mut Bond, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = try_correct(arg0, arg2, arg3, arg4, arg5, arg6);
        emit_update(arg0, arg1, arg2, 1, v0);
    }

    public(friend) fun credit_job(arg0: &mut Bond, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) : bool {
        let v0 = try_credit(arg0, arg2, arg3, arg4);
        emit_update(arg0, arg1, arg2, 0, v0);
        v0
    }

    public fun deposit_address(arg0: &Bond) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun distinct_buyers(arg0: &Bond) : u64 {
        arg0.distinct_buyers
    }

    fun emit_update(arg0: &Bond, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: bool) {
        let v0 = BuyerKey{buyer: arg2};
        let v1 = if (0x2::dynamic_field::exists<BuyerKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<BuyerKey, u128>(&arg0.id, v0)
        } else {
            0
        };
        let v2 = ScoreUpdatedV1{
            bond            : 0x2::object::id<Bond>(arg0),
            job             : arg1,
            buyer           : arg2,
            kind            : arg3,
            applied         : arg4,
            buyer_index     : v1,
            root_sum        : arg0.score_root_sum,
            penalty         : arg0.score_penalty,
            distinct_buyers : arg0.distinct_buyers,
            scored_jobs     : arg0.scored_jobs,
        };
        0x2::event::emit<ScoreUpdatedV1>(v2);
    }

    public fun in_flight(arg0: &Bond) : u64 {
        arg0.in_flight
    }

    public fun is_active(arg0: &Bond, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) : bool {
        arg0.unbonding_since_ms == 0 && is_funded(arg0, arg1)
    }

    fun is_denied(arg0: &0x2::deny_list::DenyList, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_contains_current_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2) || 0x2::coin::deny_list_v2_contains_next_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1)
    }

    public fun is_funded(arg0: &Bond, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) : bool {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.funds) >= 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::deposit_minimum(arg1)
    }

    public fun is_suspended(arg0: &Bond, arg1: u64) : bool {
        arg1 < arg0.suspended_until_ms
    }

    public fun number(arg0: &Bond) : u64 {
        arg0.number
    }

    public fun open_jobs(arg0: &Bond) : u64 {
        arg0.open_jobs
    }

    public(friend) fun penalise(arg0: &mut Bond, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = try_penalise(arg0, arg3);
        emit_update(arg0, arg1, arg2, 2, v0);
    }

    public fun rating_count(arg0: &Bond) : u64 {
        arg0.rating_count
    }

    public fun rating_sum(arg0: &Bond) : u64 {
        arg0.rating_sum
    }

    public(friend) fun record_concession(arg0: &mut Bond, arg1: u64) : bool {
        let v0 = &arg0.last_concession_ms;
        let v1 = 0x1::option::is_some<u64>(v0) && arg1 < *0x1::option::borrow<u64>(v0) + 2592000000;
        arg0.last_concession_ms = 0x1::option::some<u64>(arg1);
        v1
    }

    public(friend) fun record_strike(arg0: &mut Bond, arg1: address, arg2: u64) {
        let v0 = Strike{
            at_ms : arg2,
            by    : arg1,
        };
        let v1 = &arg0.strikes;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<Strike>(v1)) {
            if (0x1::vector::borrow<Strike>(v1, v2).by == arg1) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v3)) {
                    *0x1::vector::borrow_mut<Strike>(&mut arg0.strikes, 0x1::option::destroy_some<u64>(v3)) = v0;
                } else if (0x1::vector::length<Strike>(&arg0.strikes) < 16) {
                    0x1::vector::push_back<Strike>(&mut arg0.strikes, v0);
                } else {
                    let v4 = 0;
                    let v5 = 1;
                    while (v5 < 16) {
                        v5 = v5 + 1;
                    };
                    *0x1::vector::borrow_mut<Strike>(&mut arg0.strikes, v4) = v0;
                };
                let v6 = arg0.last_suspension_ms;
                let v7 = 0;
                let v8 = &arg0.strikes;
                let v9 = 0;
                while (v9 < 0x1::vector::length<Strike>(v8)) {
                    let v10 = 0x1::vector::borrow<Strike>(v8, v9);
                    let v11 = if (v10.at_ms + 2592000000 > arg2) {
                        let v12 = &v6;
                        0x1::option::is_none<u64>(v12) || v10.at_ms > *0x1::option::borrow<u64>(v12)
                    } else {
                        false
                    };
                    if (v11) {
                        v7 = v7 + 1;
                    };
                    v9 = v9 + 1;
                };
                if (v7 >= 3 && arg2 >= arg0.suspended_until_ms) {
                    let v13 = &v6;
                    let v14 = 0x1::option::is_some<u64>(v13) && arg2 < *0x1::option::borrow<u64>(v13) + 7776000000;
                    let v15 = if (v14) {
                        5184000000
                    } else {
                        1209600000
                    };
                    arg0.suspended_until_ms = arg2 + v15;
                    arg0.last_suspension_ms = 0x1::option::some<u64>(arg2);
                    let v16 = SuspendedV1{
                        number   : arg0.number,
                        until_ms : arg0.suspended_until_ms,
                        repeat   : v14,
                    };
                    0x2::event::emit<SuspendedV1>(v16);
                };
                let v17 = StrikeV1{
                    bond               : 0x2::object::id<Bond>(arg0),
                    at_ms              : arg2,
                    by                 : arg1,
                    suspended_until_ms : arg0.suspended_until_ms,
                };
                0x2::event::emit<StrikeV1>(v17);
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun release_excess(arg0: &mut Bond, arg1: &0x2::accumulator::AccumulatorRoot, arg2: address, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowWindow, arg4: &0x2::deny_list::DenyList, arg5: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::settled_funds_value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::object::uid_to_address(&arg0.id));
        release_excess_settled(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun release_excess_settled(arg0: &mut Bond, arg1: u64, arg2: address, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowWindow, arg4: &0x2::deny_list::DenyList, arg5: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg5);
        if (arg0.unbonding_since_ms == 0) {
            assert!(is_funded(arg0, arg5), 4);
        } else {
            assert!(0x2::clock::timestamp_ms(arg6) >= arg0.unbonding_since_ms + 1209600000, 2);
        };
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::payee(arg3) == arg2, 6);
        if (is_denied(arg4, arg2, arg7)) {
            return
        };
        if (arg1 == 0) {
            return
        };
        let v0 = ExcessReleasedV1{
            bond   : 0x2::object::id<Bond>(arg0),
            amount : arg1,
            sent   : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::pay(arg3, arg5, 0x2::balance::redeem_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_funds_from_object<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.id, arg1)), arg6),
            to     : arg2,
        };
        0x2::event::emit<ExcessReleasedV1>(v0);
    }

    public(friend) fun replace_rating(arg0: &mut Bond, arg1: u8, arg2: u8) {
        arg0.rating_sum = arg0.rating_sum - (arg1 as u64) + (arg2 as u64);
    }

    public(friend) fun request_withdraw(arg0: &mut Bond, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        assert!(arg0.unbonding_since_ms == 0, 9);
        arg0.unbonding_since_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = UnbondingV1{
            bond     : 0x2::object::id<Bond>(arg0),
            since_ms : arg0.unbonding_since_ms,
        };
        0x2::event::emit<UnbondingV1>(v0);
    }

    public(friend) fun return_capacity(arg0: &mut Bond, arg1: u64) {
        arg0.open_jobs = arg0.open_jobs - 1;
        arg0.in_flight = arg0.in_flight - arg1;
    }

    public fun score_milli(arg0: &Bond, arg1: &0x2::clock::Clock) : u64 {
        score_milli_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun score_milli_at(arg0: &Bond, arg1: u64) : u64 {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::expect<u64>(try_score_milli_at(arg0, arg1))
    }

    public fun scored_jobs(arg0: &Bond) : u64 {
        arg0.scored_jobs
    }

    fun set_buyer(arg0: &mut Bond, arg1: BuyerKey, arg2: u128, arg3: u128) {
        *0x2::dynamic_field::borrow_mut<BuyerKey, u128>(&mut arg0.id, arg1) = arg2;
        arg0.score_root_sum = arg3;
    }

    public(friend) fun take_capacity(arg0: &mut Bond, arg1: u64, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) {
        assert!(arg0.unbonding_since_ms == 0, 5);
        if (!is_funded(arg0, arg2)) {
            assert!(arg0.open_jobs == 0 && arg1 <= 25000000, 7);
        } else {
            assert!(arg0.in_flight + arg1 <= 20 * 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.funds), 7);
        };
        arg0.open_jobs = arg0.open_jobs + 1;
        arg0.in_flight = arg0.in_flight + arg1;
    }

    public fun tier(arg0: &Bond, arg1: &0x2::clock::Clock) : u8 {
        tier_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun tier_at(arg0: &Bond, arg1: u64) : u8 {
        let v0 = score_milli_at(arg0, arg1);
        if (v0 >= 85000 && arg0.distinct_buyers >= 10) {
            2
        } else if (v0 >= 18000 && arg0.distinct_buyers >= 3) {
            1
        } else {
            0
        }
    }

    public(friend) fun top_up(arg0: &mut Bond, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        assert!(arg0.unbonding_since_ms == 0, 5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds, arg1);
        let v0 = ToppedUpV1{
            bond   : 0x2::object::id<Bond>(arg0),
            amount : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1),
            total  : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.funds),
        };
        0x2::event::emit<ToppedUpV1>(v0);
        if (!is_funded(arg0, arg2) && is_funded(arg0, arg2)) {
            let v1 = FundedV1{
                bond  : 0x2::object::id<Bond>(arg0),
                total : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.funds),
            };
            0x2::event::emit<FundedV1>(v1);
        };
    }

    fun try_correct(arg0: &mut Bond, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : bool {
        let v0 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_growth_q32(arg3, 15552000000);
        let v1 = BuyerKey{buyer: arg1};
        if (0x1::option::is_none<u128>(&v0) || !0x2::dynamic_field::exists<BuyerKey>(&arg0.id, v1)) {
            return false
        };
        let v2 = (0x1::option::destroy_some<u128>(v0) as u256);
        let v3 = *0x2::dynamic_field::borrow<BuyerKey, u128>(&arg0.id, v1);
        let v4 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_fit((v3 as u256) - (arg2 as u256) * (arg4 as u256) * v2 + (arg2 as u256) * (arg5 as u256) * v2);
        if (0x1::option::is_none<u128>(&v4)) {
            return false
        };
        let v5 = 0x1::option::destroy_some<u128>(v4);
        let v6 = try_root_sum(arg0, v3, v5);
        if (0x1::option::is_none<u128>(&v6)) {
            return false
        };
        set_buyer(arg0, v1, v5, 0x1::option::destroy_some<u128>(v6));
        true
    }

    fun try_credit(arg0: &mut Bond, arg1: address, arg2: u64, arg3: u64) : bool {
        let v0 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_growth_q32(arg3, 15552000000);
        if (0x1::option::is_none<u128>(&v0)) {
            return false
        };
        let v1 = BuyerKey{buyer: arg1};
        let v2 = 0x2::dynamic_field::exists<BuyerKey>(&arg0.id, v1);
        let v3 = if (v2) {
            *0x2::dynamic_field::borrow<BuyerKey, u128>(&arg0.id, v1)
        } else {
            0
        };
        let v4 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_fit((v3 as u256) + (arg2 as u256) * (0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::unrated_tenths() as u256) * (0x1::option::destroy_some<u128>(v0) as u256));
        if (0x1::option::is_none<u128>(&v4)) {
            return false
        };
        let v5 = 0x1::option::destroy_some<u128>(v4);
        let v6 = try_root_sum(arg0, v3, v5);
        if (0x1::option::is_none<u128>(&v6)) {
            return false
        };
        if (!v2) {
            0x2::dynamic_field::add<BuyerKey, u128>(&mut arg0.id, v1, 0);
            arg0.distinct_buyers = arg0.distinct_buyers + 1;
        };
        set_buyer(arg0, v1, v5, 0x1::option::destroy_some<u128>(v6));
        arg0.scored_jobs = arg0.scored_jobs + 1;
        true
    }

    fun try_penalise(arg0: &mut Bond, arg1: u64) : bool {
        if (arg0.scored_jobs == 0) {
            return false
        };
        let v0 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_growth_q32(arg1, 31536000000);
        let v1 = try_score_milli_at(arg0, arg1);
        if (0x1::option::is_none<u128>(&v0) || 0x1::option::is_none<u64>(&v1)) {
            return false
        };
        let v2 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_fit((arg0.score_penalty as u256) + (5 as u256) * (0x1::option::destroy_some<u64>(v1) as u256) / (arg0.scored_jobs as u256) * (0x1::option::destroy_some<u128>(v0) as u256));
        if (0x1::option::is_none<u128>(&v2)) {
            return false
        };
        arg0.score_penalty = 0x1::option::destroy_some<u128>(v2);
        true
    }

    fun try_root_sum(arg0: &Bond, arg1: u128, arg2: u128) : 0x1::option::Option<u128> {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_fit((arg0.score_root_sum as u256) + (0x1::u128::sqrt(arg2) as u256) - (0x1::u128::sqrt(arg1) as u256))
    }

    fun try_score_milli_at(arg0: &Bond, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_half_growth_q32(arg1, 15552000000);
        let v1 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_growth_q32(arg1, 31536000000);
        if (0x1::option::is_none<u128>(&v0) || 0x1::option::is_none<u128>(&v1)) {
            return 0x1::option::none<u64>()
        };
        let v2 = ((arg0.score_root_sum as u256) << 32) / (0x1::option::destroy_some<u128>(v0) as u256);
        let v3 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::try_fit(v2 * v2 / 42949672960);
        if (0x1::option::is_none<u128>(&v3)) {
            return 0x1::option::none<u64>()
        };
        let v4 = 0x1::option::destroy_some<u128>(v3);
        let v5 = 0x1::u128::sqrt(v4);
        let v6 = if (v4 - v5 * v5 > v5) {
            v5 + 1
        } else {
            v5
        };
        let v7 = (v6 as u256);
        let v8 = (arg0.score_penalty as u256) / (0x1::option::destroy_some<u128>(v1) as u256);
        let v9 = if (v7 > v8) {
            v7 - v8
        } else {
            0
        };
        if (v9 > 18446744073709551615) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((v9 as u64))
    }

    public(friend) fun withdraw(arg0: &mut Bond, arg1: &0x2::accumulator::AccumulatorRoot, arg2: address, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowWindow, arg4: &0x2::deny_list::DenyList, arg5: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::settled_funds_value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::object::uid_to_address(&arg0.id));
        withdraw_settled(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun withdraw_settled(arg0: &mut Bond, arg1: u64, arg2: address, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowWindow, arg4: &0x2::deny_list::DenyList, arg5: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg5);
        assert!(arg0.unbonding_since_ms != 0, 1);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg0.unbonding_since_ms + 1209600000, 2);
        assert!(arg0.open_jobs == 0, 3);
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::payee(arg3) == arg2, 6);
        assert!(!is_denied(arg4, arg2, arg7), 8);
        let v0 = 0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds);
        if (arg1 > 0) {
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, 0x2::balance::redeem_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_funds_from_object<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.id, arg1)));
        };
        arg0.unbonding_since_ms = 0;
        let v1 = WithdrawnV1{
            bond   : 0x2::object::id<Bond>(arg0),
            amount : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0),
            sent   : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::pay(arg3, arg5, v0, arg6),
            to     : arg2,
        };
        0x2::event::emit<WithdrawnV1>(v1);
    }

    // decompiled from Move bytecode v7
}

