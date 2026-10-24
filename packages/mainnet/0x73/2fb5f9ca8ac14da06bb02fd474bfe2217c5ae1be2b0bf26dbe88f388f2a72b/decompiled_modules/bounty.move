module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::bounty {
    struct Bounty has key {
        id: 0x2::object::UID,
        rules_version: u64,
        buyer: address,
        funder: address,
        funds: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        budget: u64,
        slots: u64,
        claimed: u64,
        spec_hash: vector<u8>,
        open_until_ms: u64,
        deliver_by_ms: u64,
        review_window_ms: u64,
        reject_split_bps: u64,
        gate: u8,
        state: u8,
        owed: u64,
        closed_at_ms: u64,
    }

    struct NoDecryptKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BountyNoDecryptMarkedV1 has copy, drop {
        bounty: 0x2::object::ID,
    }

    struct BountyOpenedV1 has copy, drop {
        bounty: 0x2::object::ID,
        rules_version: u64,
        buyer: address,
        funder: address,
        budget: u64,
        slots: u64,
        spec_hash: vector<u8>,
        open_until_ms: u64,
        deliver_by_ms: u64,
        review_window_ms: u64,
        reject_split_bps: u64,
        gate: u8,
    }

    struct BountyFilledV1 has copy, drop {
        bounty: 0x2::object::ID,
    }

    struct BountyCancelledV1 has copy, drop {
        bounty: 0x2::object::ID,
        slots: u64,
        amount: u64,
    }

    struct BountyExpiredV1 has copy, drop {
        bounty: 0x2::object::ID,
        slots: u64,
        amount: u64,
    }

    struct BountyWithdrawnV1 has copy, drop {
        bounty: 0x2::object::ID,
        payee: address,
        amount: u64,
        sent: u64,
    }

    struct BountyReapedV1 has copy, drop {
        bounty: 0x2::object::ID,
        closed_at_ms: u64,
    }

    entry fun cancel_bounty(arg0: &mut Bounty, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.buyer || v0 == arg0.funder, 1);
        assert!(arg0.state == 0, 0);
        let (v1, v2) = close_unclaimed(arg0, 2, 0x2::clock::timestamp_ms(arg2));
        let v3 = BountyCancelledV1{
            bounty : 0x2::object::id<Bounty>(arg0),
            slots  : v1,
            amount : v2,
        };
        0x2::event::emit<BountyCancelledV1>(v3);
    }

    entry fun claim_slot(arg0: &mut Bounty, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg2: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg3);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_open_for_new_work(arg3, arg4);
        assert!(arg0.state == 0, 0);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg0.open_until_ms, 4);
        let v0 = NoDecryptKey{dummy_field: false};
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::mint_bounty_job(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds, arg0.budget), arg0.rules_version, arg0.buyer, arg0.funder, arg0.spec_hash, arg0.open_until_ms, arg0.deliver_by_ms, arg0.review_window_ms, arg0.reject_split_bps, arg0.gate, 0x2::object::id<Bounty>(arg0), 0x2::dynamic_field::exists<NoDecryptKey>(&arg0.id, v0), arg1, arg2, arg3, arg4, arg5);
        arg0.claimed = arg0.claimed + 1;
        if (arg0.claimed == arg0.slots) {
            arg0.state = 1;
            arg0.closed_at_ms = 0x2::clock::timestamp_ms(arg4);
            let v1 = BountyFilledV1{bounty: 0x2::object::id<Bounty>(arg0)};
            0x2::event::emit<BountyFilledV1>(v1);
        };
    }

    public fun claimed(arg0: &Bounty) : u64 {
        arg0.claimed
    }

    fun close_unclaimed(arg0: &mut Bounty, arg1: u8, arg2: u64) : (u64, u64) {
        let v0 = arg0.slots - arg0.claimed;
        let v1 = v0 * arg0.budget;
        arg0.owed = arg0.owed + v1;
        arg0.state = arg1;
        arg0.closed_at_ms = arg2;
        (v0, v1)
    }

    public fun create_bounty(arg0: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg10);
        create_bounty_marked(arg0, v0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, arg8, arg9, arg10)
    }

    public(friend) fun create_bounty_marked(arg0: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: address, arg2: address, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: bool, arg11: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg11);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_open_for_new_work(arg11, arg12);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::assert_treasury_set(arg11);
        let v0 = if (arg3 >= 1) {
            if (arg3 <= 250) {
                0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0) % arg3 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0) / arg3;
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::check_posting_terms(v1, &arg4, arg5, arg6, arg7, arg8, arg9, arg11, 0x2::clock::timestamp_ms(arg12));
        let v2 = Bounty{
            id               : 0x2::object::new(arg13),
            rules_version    : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::rules_version_now(),
            buyer            : arg1,
            funder           : arg2,
            funds            : arg0,
            budget           : v1,
            slots            : arg3,
            claimed          : 0,
            spec_hash        : arg4,
            open_until_ms    : arg5,
            deliver_by_ms    : arg6,
            review_window_ms : arg7,
            reject_split_bps : arg8,
            gate             : arg9,
            state            : 0,
            owed             : 0,
            closed_at_ms     : 0,
        };
        let v3 = 0x2::object::id<Bounty>(&v2);
        let v4 = BountyOpenedV1{
            bounty           : v3,
            rules_version    : v2.rules_version,
            buyer            : arg1,
            funder           : arg2,
            budget           : v1,
            slots            : arg3,
            spec_hash        : v2.spec_hash,
            open_until_ms    : arg5,
            deliver_by_ms    : arg6,
            review_window_ms : arg7,
            reject_split_bps : arg8,
            gate             : arg9,
        };
        0x2::event::emit<BountyOpenedV1>(v4);
        if (arg10) {
            let v5 = NoDecryptKey{dummy_field: false};
            0x2::dynamic_field::add<NoDecryptKey, bool>(&mut v2.id, v5, true);
            let v6 = BountyNoDecryptMarkedV1{bounty: v3};
            0x2::event::emit<BountyNoDecryptMarkedV1>(v6);
        };
        0x2::transfer::share_object<Bounty>(v2);
        v3
    }

    entry fun reap_bounty(arg0: Bounty, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        assert!(arg0.state != 0, 0);
        assert!(arg0.owed == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.closed_at_ms + 4838400000, 2);
        let v0 = NoDecryptKey{dummy_field: false};
        if (0x2::dynamic_field::exists<NoDecryptKey>(&arg0.id, v0)) {
            let v1 = NoDecryptKey{dummy_field: false};
            0x2::dynamic_field::remove<NoDecryptKey, bool>(&mut arg0.id, v1);
        };
        let Bounty {
            id               : v2,
            rules_version    : _,
            buyer            : _,
            funder           : _,
            funds            : v6,
            budget           : _,
            slots            : _,
            claimed          : _,
            spec_hash        : _,
            open_until_ms    : _,
            deliver_by_ms    : _,
            review_window_ms : _,
            reject_split_bps : _,
            gate             : _,
            state            : _,
            owed             : _,
            closed_at_ms     : v18,
        } = arg0;
        let v19 = v2;
        let v20 = BountyReapedV1{
            bounty       : 0x2::object::uid_to_inner(&v19),
            closed_at_ms : v18,
        };
        0x2::event::emit<BountyReapedV1>(v20);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v6);
        0x2::object::delete(v19);
    }

    entry fun refund_bounty(arg0: &mut Bounty, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        assert!(arg0.state == 0, 0);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.open_until_ms, 2);
        let (v0, v1) = close_unclaimed(arg0, 3, 0x2::clock::timestamp_ms(arg2));
        let v2 = BountyExpiredV1{
            bounty : 0x2::object::id<Bounty>(arg0),
            slots  : v0,
            amount : v1,
        };
        0x2::event::emit<BountyExpiredV1>(v2);
    }

    public fun slots(arg0: &Bounty) : u64 {
        arg0.slots
    }

    public fun status(arg0: &Bounty) : 0x1::string::String {
        let v0 = arg0.state;
        let v1 = if (v0 == 0) {
            b"open"
        } else if (v0 == 1) {
            b"filled"
        } else if (v0 == 2) {
            b"cancelled"
        } else {
            b"expired"
        };
        0x1::string::utf8(v1)
    }

    fun take_owed(arg0: &mut Bounty, arg1: &0x2::deny_list::DenyList, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg0.funder, arg2) && !0x2::coin::deny_list_v2_contains_next_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg0.funder), 7);
        assert!(arg0.owed > 0, 6);
        arg0.owed = 0;
        arg0.owed
    }

    entry fun withdraw(arg0: &mut Bounty, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowWindow, arg3: &0x2::deny_list::DenyList, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::payee(arg2) == arg0.funder, 5);
        let v0 = take_owed(arg0, arg3, arg5);
        let v1 = BountyWithdrawnV1{
            bounty : 0x2::object::id<Bounty>(arg0),
            payee  : arg0.funder,
            amount : v0,
            sent   : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::pay(arg2, arg1, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds, v0), arg4),
        };
        0x2::event::emit<BountyWithdrawnV1>(v1);
    }

    entry fun withdraw_first(arg0: &mut Bounty, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowRegistry, arg3: &0x2::deny_list::DenyList, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        let v0 = take_owed(arg0, arg3, arg5);
        let v1 = arg0.funder;
        let v2 = BountyWithdrawnV1{
            bounty : 0x2::object::id<Bounty>(arg0),
            payee  : v1,
            amount : v0,
            sent   : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::pay_new(arg2, v1, arg1, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds, v0), arg4),
        };
        0x2::event::emit<BountyWithdrawnV1>(v2);
    }

    // decompiled from Move bytecode v7
}

