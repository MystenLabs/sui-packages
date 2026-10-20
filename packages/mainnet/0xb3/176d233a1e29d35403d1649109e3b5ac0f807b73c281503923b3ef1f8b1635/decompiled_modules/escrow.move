module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow {
    struct Receipt has drop, store {
        blob_id: vector<u8>,
        payload_hash: vector<u8>,
    }

    struct Job has key {
        id: 0x2::object::UID,
        rules_version: u64,
        terms_version: u16,
        buyer: address,
        funder: address,
        seller: address,
        funds: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        budget: u64,
        reject_split_bps: u64,
        open_until_ms: u64,
        owed: 0x2::vec_map::VecMap<address, u64>,
        spec_hash: vector<u8>,
        funded_at_ms: u64,
        deliver_by_ms: u64,
        review_window_ms: u64,
        delivered_at_ms: u64,
        receipt: 0x1::option::Option<Receipt>,
        state: u8,
        outcome: u8,
        reject_reason: u8,
        rejected_at_ms: u64,
        revision_used: bool,
        revision_by_ms: u64,
        closed_at_ms: u64,
        self_test: bool,
        gate: u8,
        scored_for: address,
        posted: bool,
    }

    struct JobFundedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        terms_version: u16,
        status: 0x1::string::String,
        buyer: address,
        funder: address,
        seller: address,
        budget: u64,
        reject_split_bps: u64,
        spec_hash: vector<u8>,
        funded_at_ms: u64,
        deliver_by_ms: u64,
        review_window_ms: u64,
        self_test: bool,
    }

    struct DeliveredV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        blob_id: vector<u8>,
        payload_hash: vector<u8>,
        delivered_at_ms: u64,
    }

    struct RevisionRequestedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        revision_by_ms: u64,
    }

    struct RevisionDeclinedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        review_from_ms: u64,
    }

    struct RevisionLapsedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        review_from_ms: u64,
    }

    struct RejectedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        reason: u8,
        rejected_at_ms: u64,
    }

    struct ReleasedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        auto: bool,
    }

    struct ConcededV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        by_default: bool,
        strike: bool,
    }

    struct SplitV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        buyer_share: u64,
        seller_share: u64,
        fee: u64,
    }

    struct DeclinedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
    }

    struct ExpiredV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
    }

    struct SettledV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        closed_at_ms: u64,
        payees: vector<address>,
        amounts: vector<u64>,
        to_deposit: u64,
    }

    struct WithdrawnV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        payee: address,
        amount: u64,
        sent: u64,
    }

    struct ReapedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        closed_at_ms: u64,
    }

    struct JobOpenedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        terms_version: u16,
        status: 0x1::string::String,
        buyer: address,
        funder: address,
        budget: u64,
        reject_split_bps: u64,
        spec_hash: vector<u8>,
        open_until_ms: u64,
        deliver_by_ms: u64,
        review_window_ms: u64,
        gate: u8,
        reposted_from: 0x1::option::Option<0x2::object::ID>,
    }

    struct JobClaimedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        terms_version: u16,
        status: 0x1::string::String,
        seller: address,
        funded_at_ms: u64,
        self_test: bool,
        bounty: 0x1::option::Option<0x2::object::ID>,
    }

    struct JobCancelledV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
    }

    fun assert_seller(arg0: &Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.seller != @0x0, 1);
        assert!(0x2::tx_context::sender(arg2) == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::operator_of(arg1, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::number_of(arg1, arg0.seller)), 0);
    }

    public(friend) fun assert_treasury_set(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) {
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::treasury(arg0) != @0x0, 22);
    }

    entry fun auto_release(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg4: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(arg0.state == 1, 1);
        assert!(!0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::storage_outage(arg1, arg4), 7);
        assert!(0x2::clock::timestamp_ms(arg4) > review_deadline(arg0, arg1), 2);
        let v0 = settle_for_seller(arg0, arg2, arg3, arg1, 2, 0x2::clock::timestamp_ms(arg4));
        emit_released(arg0, true);
        emit_settled(arg0, v0);
    }

    public(friend) fun budget(arg0: &Job) : u64 {
        arg0.budget
    }

    public(friend) fun buyer(arg0: &Job) : address {
        arg0.buyer
    }

    public fun buyer_side(arg0: &Job, arg1: address) : bool {
        arg1 == arg0.buyer || arg1 == arg0.funder
    }

    public fun can_decrypt(arg0: &Job, arg1: address) : bool {
        buyer_side(arg0, arg1) && 0x1::option::is_some<Receipt>(&arg0.receipt)
    }

    entry fun cancel(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(buyer_side(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(arg0.state == 6, 1);
        let v0 = arg0.funder;
        let v1 = arg0.budget;
        credit(arg0, v0, v1);
        close(arg0, 8, 0x2::clock::timestamp_ms(arg2));
        let v2 = JobCancelledV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
        };
        0x2::event::emit<JobCancelledV1>(v2);
        emit_settled(arg0, 0);
    }

    public(friend) fun check_posting_terms(arg0: u64, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg8: u64) {
        assert!(arg0 <= 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::job_cap(arg7), 12);
        assert!(arg0 >= 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::min_budget(), 26);
        assert!(arg6 <= 2, 23);
        let v0 = if (arg2 >= arg8 + 3600000) {
            if (arg2 - arg8 <= 2592000000) {
                if (arg3 >= arg2 + 3600000) {
                    if (arg3 - arg8 <= 31536000000) {
                        if (arg4 <= 2592000000) {
                            if (arg5 <= 10000) {
                                0x1::vector::length<u8>(arg1) == 32
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 18);
    }

    fun check_rules(arg0: &Job) {
        assert!(arg0.rules_version <= 1, 9);
    }

    entry fun claim(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg2: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg3);
        check_rules(arg0);
        assert!(arg0.state == 6, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg0.open_until_ms, 3);
        let v1 = 0x2::tx_context::sender(arg5);
        claim_checks(arg1, arg2, arg0.gate, v0, v1);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::take_capacity(arg2, arg0.budget, arg3);
        arg0.seller = v1;
        arg0.funded_at_ms = v0;
        arg0.state = 0;
        arg0.self_test = is_self(arg1, v1, arg0.buyer, arg0.funder);
        let v2 = JobClaimedV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            terms_version : arg0.terms_version,
            status        : status(arg0),
            seller        : v1,
            funded_at_ms  : v0,
            self_test     : arg0.self_test,
            bounty        : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<JobClaimedV1>(v2);
    }

    public(friend) fun claim_checks(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg2: u8, arg3: u64, arg4: address) {
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::is_current_operator(arg0, arg4), 14);
        assert!(0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond>(arg1) == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::bond_of(arg0, arg4), 15);
        assert!(!0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::is_suspended(arg1, arg3), 24);
        if (arg2 > 0) {
            assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::tier_at(arg1, arg3) >= arg2, 25);
        };
    }

    fun close(arg0: &mut Job, arg1: u8, arg2: u64) {
        arg0.state = 4;
        arg0.outcome = arg1;
        arg0.closed_at_ms = arg2;
    }

    public(friend) fun closed_at_ms(arg0: &Job) : u64 {
        arg0.closed_at_ms
    }

    entry fun concede(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert_seller(arg0, arg2, arg5);
        assert!(arg0.state == 2, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg0.rejected_at_ms + 259200000, 3);
        settle_for_buyer(arg0, arg2, arg3, 3, v0);
        let v1 = !arg0.self_test && 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::record_concession(arg3, v0);
        if (v1) {
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::record_strike(arg3, strike_by(arg0, arg2), v0);
        };
        emit_conceded(arg0, false, v1);
        emit_settled(arg0, 0);
    }

    entry fun concede_by_default(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg4: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(arg0.state == 2, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 > arg0.rejected_at_ms + 259200000, 2);
        settle_for_buyer(arg0, arg2, arg3, 4, v0);
        let v1 = !arg0.self_test;
        if (v1) {
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::record_concession(arg3, v0);
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::record_strike(arg3, strike_by(arg0, arg2), v0);
        };
        emit_conceded(arg0, true, v1);
        emit_settled(arg0, 0);
    }

    entry fun contest(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert_seller(arg0, arg2, arg5);
        assert!(arg0.state == 2, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg0.rejected_at_ms + 259200000, 3);
        assert!(0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond>(arg3) == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::bond_of(arg2, arg0.seller), 15);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::return_capacity(arg3, arg0.budget);
        let v1 = mul_bps(arg0.budget, arg0.reject_split_bps);
        let v2 = arg0.budget - v1;
        let v3 = if (arg0.self_test) {
            0
        } else {
            mul_bps(v2, 500)
        };
        let v4 = v2 - v3;
        let v5 = arg0.funder;
        credit(arg0, v5, v1);
        credit(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::treasury(arg1), v3);
        let v6 = pay_seller(arg0, arg2, arg3, arg1, v4);
        close(arg0, 9, v0);
        if (!arg0.self_test) {
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::record_strike(arg3, strike_by(arg0, arg2), v0);
        };
        let v7 = score_buyer(arg0, arg2);
        if (v7 != @0x0) {
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::penalise(arg3, 0x2::object::id<Job>(arg0), v7, v0);
        };
        let v8 = SplitV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
            buyer_share   : v1,
            seller_share  : v4,
            fee           : v3,
        };
        0x2::event::emit<SplitV1>(v8);
        emit_settled(arg0, v6);
    }

    public fun create(arg0: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg7: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg8: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg10);
        create_job(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg8, arg9, arg10)
    }

    public(friend) fun create_job(arg0: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg8: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg9: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg9);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_open_for_new_work(arg9, arg10);
        assert_treasury_set(arg9);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0);
        assert!(v1 <= 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::job_cap(arg9), 12);
        assert!(v1 >= 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::min_budget(), 26);
        let v2 = if (arg3 >= v0 + 3600000) {
            if (arg3 - v0 <= 31536000000) {
                if (arg4 <= 2592000000) {
                    if (arg5 <= 10000) {
                        0x1::vector::length<u8>(&arg2) == 32
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 18);
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::is_current_operator(arg7, arg1), 14);
        assert!(0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond>(arg8) == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::bond_of(arg7, arg1), 15);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::take_capacity(arg8, v1, arg9);
        let v3 = 0x2::tx_context::sender(arg11);
        let v4 = is_self(arg7, arg1, v3, arg6);
        let v5 = Job{
            id               : 0x2::object::new(arg11),
            rules_version    : 1,
            terms_version    : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::terms_version(arg9),
            buyer            : v3,
            funder           : arg6,
            seller           : arg1,
            funds            : arg0,
            budget           : v1,
            reject_split_bps : arg5,
            open_until_ms    : 0,
            owed             : 0x2::vec_map::empty<address, u64>(),
            spec_hash        : arg2,
            funded_at_ms     : v0,
            deliver_by_ms    : arg3,
            review_window_ms : arg4,
            delivered_at_ms  : 0,
            receipt          : 0x1::option::none<Receipt>(),
            state            : 0,
            outcome          : 0,
            reject_reason    : 0,
            rejected_at_ms   : 0,
            revision_used    : false,
            revision_by_ms   : 0,
            closed_at_ms     : 0,
            self_test        : v4,
            gate             : 0,
            scored_for       : @0x0,
            posted           : false,
        };
        let v6 = 0x2::object::id<Job>(&v5);
        let v7 = JobFundedV1{
            job              : v6,
            rules_version    : 1,
            terms_version    : v5.terms_version,
            status           : status(&v5),
            buyer            : v3,
            funder           : arg6,
            seller           : arg1,
            budget           : v1,
            reject_split_bps : arg5,
            spec_hash        : v5.spec_hash,
            funded_at_ms     : v0,
            deliver_by_ms    : arg3,
            review_window_ms : arg4,
            self_test        : v4,
        };
        0x2::event::emit<JobFundedV1>(v7);
        0x2::transfer::share_object<Job>(v5);
        v6
    }

    public fun create_open(arg0: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg9);
        create_open_job(arg0, v0, v0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<0x2::object::ID>(), arg7, arg8, arg9)
    }

    public(friend) fun create_open_job(arg0: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: address, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: 0x1::option::Option<0x2::object::ID>, arg10: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg10);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_open_for_new_work(arg10, arg11);
        assert_treasury_set(arg10);
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0);
        check_posting_terms(v0, &arg3, arg4, arg5, arg6, arg7, arg8, arg10, 0x2::clock::timestamp_ms(arg11));
        let v1 = Job{
            id               : 0x2::object::new(arg12),
            rules_version    : 1,
            terms_version    : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::terms_version(arg10),
            buyer            : arg1,
            funder           : arg2,
            seller           : @0x0,
            funds            : arg0,
            budget           : v0,
            reject_split_bps : arg7,
            open_until_ms    : arg4,
            owed             : 0x2::vec_map::empty<address, u64>(),
            spec_hash        : arg3,
            funded_at_ms     : 0,
            deliver_by_ms    : arg5,
            review_window_ms : arg6,
            delivered_at_ms  : 0,
            receipt          : 0x1::option::none<Receipt>(),
            state            : 6,
            outcome          : 0,
            reject_reason    : 0,
            rejected_at_ms   : 0,
            revision_used    : false,
            revision_by_ms   : 0,
            closed_at_ms     : 0,
            self_test        : false,
            gate             : arg8,
            scored_for       : @0x0,
            posted           : true,
        };
        let v2 = 0x2::object::id<Job>(&v1);
        let v3 = JobOpenedV1{
            job              : v2,
            rules_version    : 1,
            terms_version    : v1.terms_version,
            status           : status(&v1),
            buyer            : arg1,
            funder           : arg2,
            budget           : v0,
            reject_split_bps : arg7,
            spec_hash        : v1.spec_hash,
            open_until_ms    : arg4,
            deliver_by_ms    : arg5,
            review_window_ms : arg6,
            gate             : arg8,
            reposted_from    : arg9,
        };
        0x2::event::emit<JobOpenedV1>(v3);
        0x2::transfer::share_object<Job>(v1);
        v2
    }

    fun credit(arg0: &mut Job, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::vec_map::contains<address, u64>(&arg0.owed, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.owed, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.owed, arg1, arg2);
        };
    }

    entry fun decline(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert_seller(arg0, arg2, arg5);
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg0.deliver_by_ms, 3);
        settle_for_buyer(arg0, arg2, arg3, 7, v0);
        let v1 = DeclinedV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
        };
        0x2::event::emit<DeclinedV1>(v1);
        emit_settled(arg0, 0);
    }

    entry fun decline_revision(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert_seller(arg0, arg2, arg4);
        assert!(arg0.state == 5, 1);
        restart_review(arg0, arg3);
        let v0 = RevisionDeclinedV1{
            job            : 0x2::object::id<Job>(arg0),
            rules_version  : arg0.rules_version,
            status         : status(arg0),
            review_from_ms : arg0.delivered_at_ms,
        };
        0x2::event::emit<RevisionDeclinedV1>(v0);
    }

    entry fun deliver(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert_seller(arg0, arg2, arg6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (arg0.state == 0) {
            assert!(v0 <= arg0.deliver_by_ms, 3);
        } else {
            assert!(arg0.state == 5, 1);
            assert!(v0 <= arg0.revision_by_ms, 3);
        };
        assert!(!0x1::vector::is_empty<u8>(&arg3) && 0x1::vector::length<u8>(&arg4) == 32, 19);
        let v1 = Receipt{
            blob_id      : arg3,
            payload_hash : arg4,
        };
        arg0.receipt = 0x1::option::some<Receipt>(v1);
        arg0.delivered_at_ms = v0;
        arg0.state = 1;
        let v2 = DeliveredV1{
            job             : 0x2::object::id<Job>(arg0),
            rules_version   : arg0.rules_version,
            status          : status(arg0),
            blob_id         : arg3,
            payload_hash    : arg4,
            delivered_at_ms : v0,
        };
        0x2::event::emit<DeliveredV1>(v2);
    }

    fun emit_conceded(arg0: &Job, arg1: bool, arg2: bool) {
        let v0 = ConcededV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
            by_default    : arg1,
            strike        : arg2,
        };
        0x2::event::emit<ConcededV1>(v0);
    }

    fun emit_released(arg0: &Job, arg1: bool) {
        let v0 = ReleasedV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
            auto          : arg1,
        };
        0x2::event::emit<ReleasedV1>(v0);
    }

    fun emit_settled(arg0: &Job, arg1: u64) {
        let v0 = 0x2::vec_map::keys<address, u64>(&arg0.owed);
        let v1 = &v0;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(v1)) {
            0x1::vector::push_back<u64>(&mut v2, *0x2::vec_map::get<address, u64>(&arg0.owed, 0x1::vector::borrow<address>(v1, v3)));
            v3 = v3 + 1;
        };
        let v4 = SettledV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
            closed_at_ms  : arg0.closed_at_ms,
            payees        : v0,
            amounts       : v2,
            to_deposit    : arg1,
        };
        0x2::event::emit<SettledV1>(v4);
    }

    fun emit_withdrawn(arg0: &Job, arg1: address, arg2: u64, arg3: u64) {
        let v0 = WithdrawnV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
            payee         : arg1,
            amount        : arg2,
            sent          : arg3,
        };
        0x2::event::emit<WithdrawnV1>(v0);
    }

    public(friend) fun ext<T0: copy + drop + store, T1: store>(arg0: &Job, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun ext_add<T0: copy + drop + store, T1: store>(arg0: &mut Job, arg1: T0, arg2: T1) {
        check_rules(arg0);
        assert!(arg0.rules_version >= introduced_in<T0>(), 10);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun ext_exists<T0: copy + drop + store>(arg0: &Job, arg1: T0) : bool {
        0x2::dynamic_field::exists<T0>(&arg0.id, arg1)
    }

    public(friend) fun ext_mut<T0: copy + drop + store, T1: store>(arg0: &mut Job, arg1: T0) : &mut T1 {
        check_rules(arg0);
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun funder(arg0: &Job) : address {
        arg0.funder
    }

    fun funder_passport(arg0: &Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry) : address {
        if (0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::is_registered(arg1, arg0.funder)) {
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::payout_address(arg1, arg0.funder)
        } else {
            arg0.funder
        }
    }

    fun introduced_in<T0>() : u64 {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey>(), 11);
        1
    }

    public(friend) fun is_closed_with_delivery(arg0: &Job) : bool {
        arg0.state == 4 && 0x1::option::is_some<Receipt>(&arg0.receipt)
    }

    public(friend) fun is_machine_funded(arg0: &Job) : bool {
        arg0.funder != arg0.buyer
    }

    fun is_self(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg1: address, arg2: address, arg3: address) : bool {
        let v0 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::payout_address(arg0, arg1);
        if (arg2 == arg1) {
            true
        } else if (arg2 == v0) {
            true
        } else if (arg3 == arg1) {
            true
        } else {
            arg3 == v0
        }
    }

    public(friend) fun is_self_test(arg0: &Job) : bool {
        arg0.self_test
    }

    public(friend) fun mint_bounty_job(arg0: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: u64, arg2: address, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: 0x2::object::ID, arg11: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg12: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg13: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_treasury_set(arg13);
        let v0 = 0x2::clock::timestamp_ms(arg14);
        let v1 = 0x2::tx_context::sender(arg15);
        claim_checks(arg11, arg12, arg9, v0, v1);
        let v2 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::take_capacity(arg12, v2, arg13);
        let v3 = is_self(arg11, v1, arg2, arg3);
        let v4 = Job{
            id               : 0x2::object::new(arg15),
            rules_version    : arg1,
            terms_version    : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::terms_version(arg13),
            buyer            : arg2,
            funder           : arg3,
            seller           : v1,
            funds            : arg0,
            budget           : v2,
            reject_split_bps : arg8,
            open_until_ms    : arg5,
            owed             : 0x2::vec_map::empty<address, u64>(),
            spec_hash        : arg4,
            funded_at_ms     : v0,
            deliver_by_ms    : arg6,
            review_window_ms : arg7,
            delivered_at_ms  : 0,
            receipt          : 0x1::option::none<Receipt>(),
            state            : 0,
            outcome          : 0,
            reject_reason    : 0,
            rejected_at_ms   : 0,
            revision_used    : false,
            revision_by_ms   : 0,
            closed_at_ms     : 0,
            self_test        : v3,
            gate             : arg9,
            scored_for       : @0x0,
            posted           : true,
        };
        let v5 = 0x2::object::id<Job>(&v4);
        let v6 = JobClaimedV1{
            job           : v5,
            rules_version : arg1,
            terms_version : v4.terms_version,
            status        : status(&v4),
            seller        : v1,
            funded_at_ms  : v0,
            self_test     : v3,
            bounty        : 0x1::option::some<0x2::object::ID>(arg10),
        };
        0x2::event::emit<JobClaimedV1>(v6);
        0x2::transfer::share_object<Job>(v4);
        v5
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun pay_seller(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg4: u64) : u64 {
        if (arg4 == 0) {
            return 0
        };
        if (0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::is_funded(arg2, arg3)) {
            let v1 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::payout_address(arg1, arg0.seller);
            credit(arg0, v1, arg4);
            0
        } else {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds, arg4), 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::deposit_address(arg2));
            arg4
        }
    }

    entry fun reap(arg0: Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(&arg0);
        assert!(arg0.state == 4, 1);
        assert!(0x2::vec_map::is_empty<address, u64>(&arg0.owed), 17);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.closed_at_ms + 4838400000, 2);
        let v0 = ReapedV1{
            job           : 0x2::object::id<Job>(&arg0),
            rules_version : arg0.rules_version,
            status        : status(&arg0),
            closed_at_ms  : arg0.closed_at_ms,
        };
        0x2::event::emit<ReapedV1>(v0);
        if (0x2::dynamic_field::exists<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey>(&arg0.id, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::key())) {
            0x2::dynamic_field::remove<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::Review>(&mut arg0.id, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::key());
        };
        let Job {
            id               : v1,
            rules_version    : _,
            terms_version    : _,
            buyer            : _,
            funder           : _,
            seller           : _,
            funds            : v7,
            budget           : _,
            reject_split_bps : _,
            open_until_ms    : _,
            owed             : _,
            spec_hash        : _,
            funded_at_ms     : _,
            deliver_by_ms    : _,
            review_window_ms : _,
            delivered_at_ms  : _,
            receipt          : _,
            state            : _,
            outcome          : _,
            reject_reason    : _,
            rejected_at_ms   : _,
            revision_used    : _,
            revision_by_ms   : _,
            closed_at_ms     : _,
            self_test        : _,
            gate             : _,
            scored_for       : _,
            posted           : _,
        } = arg0;
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v7);
        0x2::object::delete(v1);
    }

    entry fun refund_on_timeout(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg4: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 > arg0.deliver_by_ms, 2);
        settle_for_buyer(arg0, arg2, arg3, 5, v0);
        let v1 = if (arg0.posted) {
            arg0.open_until_ms
        } else {
            arg0.funded_at_ms
        };
        if (!arg0.self_test && arg0.deliver_by_ms - v1 >= 86400000) {
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::record_strike(arg3, strike_by(arg0, arg2), v0);
        };
        let v2 = ExpiredV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
        };
        0x2::event::emit<ExpiredV1>(v2);
        emit_settled(arg0, 0);
    }

    entry fun refund_unclaimed(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(arg0.state == 6, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg0.open_until_ms, 2);
        let v1 = arg0.funder;
        let v2 = arg0.budget;
        credit(arg0, v1, v2);
        close(arg0, 6, v0);
        let v3 = ExpiredV1{
            job           : 0x2::object::id<Job>(arg0),
            rules_version : arg0.rules_version,
            status        : status(arg0),
        };
        0x2::event::emit<ExpiredV1>(v3);
        emit_settled(arg0, 0);
    }

    entry fun reject(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(buyer_side(arg0, 0x2::tx_context::sender(arg4)), 0);
        assert!(arg0.state == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= review_deadline(arg0, arg1), 3);
        assert!(arg2 == 0, 16);
        arg0.reject_reason = arg2;
        arg0.rejected_at_ms = v0;
        arg0.state = 2;
        let v1 = RejectedV1{
            job            : 0x2::object::id<Job>(arg0),
            rules_version  : arg0.rules_version,
            status         : status(arg0),
            reason         : arg2,
            rejected_at_ms : v0,
        };
        0x2::event::emit<RejectedV1>(v1);
    }

    entry fun release(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(buyer_side(arg0, 0x2::tx_context::sender(arg5)), 0);
        assert!(arg0.state == 1, 1);
        let v0 = settle_for_seller(arg0, arg2, arg3, arg1, 1, 0x2::clock::timestamp_ms(arg4));
        emit_released(arg0, false);
        emit_settled(arg0, v0);
    }

    public fun repost(arg0: &Job, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: u64, arg4: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg4);
        let v0 = if (arg0.posted) {
            if (arg0.state == 4) {
                if (arg0.outcome == 8) {
                    true
                } else if (arg0.outcome == 6) {
                    true
                } else if (arg0.outcome == 7) {
                    true
                } else {
                    arg0.outcome == 5
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(buyer_side(arg0, 0x2::tx_context::sender(arg6)), 0);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) == arg0.budget, 18);
        let v1 = 0x2::tx_context::sender(arg6);
        create_open_job(arg1, v1, arg0.funder, arg0.spec_hash, arg2, arg3, arg0.review_window_ms, arg0.reject_split_bps, arg0.gate, 0x1::option::some<0x2::object::ID>(0x2::object::id<Job>(arg0)), arg4, arg5, arg6)
    }

    entry fun request_revision(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(buyer_side(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(arg0.state == 1, 1);
        assert!(!arg0.revision_used, 8);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 <= review_deadline(arg0, arg1), 3);
        arg0.revision_used = true;
        arg0.revision_by_ms = v0 + 259200000;
        arg0.state = 5;
        let v1 = RevisionRequestedV1{
            job            : 0x2::object::id<Job>(arg0),
            rules_version  : arg0.rules_version,
            status         : status(arg0),
            revision_by_ms : arg0.revision_by_ms,
        };
        0x2::event::emit<RevisionRequestedV1>(v1);
    }

    fun restart_review(arg0: &mut Job, arg1: &0x2::clock::Clock) {
        arg0.delivered_at_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.state = 1;
    }

    fun review_deadline(arg0: &Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) : u64 {
        let v0 = arg0.delivered_at_ms + arg0.review_window_ms;
        let v1 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::storage_outage_until_ms(arg1);
        if (v1 > arg0.delivered_at_ms && 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::storage_outage_since_ms(arg1) < v0) {
            0x1::u64::max(v0, v1 + arg0.review_window_ms)
        } else {
            v0
        }
    }

    entry fun revision_lapsed(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0x2::clock::Clock) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(arg0.state == 5, 1);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.revision_by_ms, 2);
        restart_review(arg0, arg2);
        let v0 = RevisionLapsedV1{
            job            : 0x2::object::id<Job>(arg0),
            rules_version  : arg0.rules_version,
            status         : status(arg0),
            review_from_ms : arg0.delivered_at_ms,
        };
        0x2::event::emit<RevisionLapsedV1>(v0);
    }

    public fun rules_version(arg0: &Job) : u64 {
        arg0.rules_version
    }

    public(friend) fun rules_version_now() : u64 {
        1
    }

    fun score_buyer(arg0: &Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry) : address {
        if (arg0.self_test) {
            return @0x0
        };
        let v0 = funder_passport(arg0, arg1);
        if (v0 == arg0.seller || v0 == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::payout_address(arg1, arg0.seller)) {
            @0x0
        } else {
            v0
        }
    }

    public(friend) fun scored_for(arg0: &Job) : address {
        arg0.scored_for
    }

    public(friend) fun seller(arg0: &Job) : address {
        arg0.seller
    }

    fun settle_for_buyer(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg2: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg3: u8, arg4: u64) {
        assert!(0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond>(arg2) == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::bond_of(arg1, arg0.seller), 15);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::return_capacity(arg2, arg0.budget);
        let v0 = arg0.funder;
        let v1 = arg0.budget;
        credit(arg0, v0, v1);
        close(arg0, arg3, arg4);
    }

    fun settle_for_seller(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg2: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg4: u8, arg5: u64) : u64 {
        assert!(0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond>(arg2) == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::bond_of(arg1, arg0.seller), 15);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::return_capacity(arg2, arg0.budget);
        let v0 = if (arg0.self_test) {
            0
        } else {
            mul_bps(arg0.budget, 500)
        };
        credit(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::treasury(arg3), v0);
        let v1 = arg0.budget - v0;
        let v2 = pay_seller(arg0, arg1, arg2, arg3, v1);
        close(arg0, arg4, arg5);
        if (arg4 == 1 || arg4 == 2) {
            let v3 = score_buyer(arg0, arg1);
            if (v3 != @0x0 && 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::credit_job(arg2, 0x2::object::id<Job>(arg0), v3, arg0.budget, arg5)) {
                arg0.scored_for = v3;
            };
        };
        v2
    }

    public fun status(arg0: &Job) : 0x1::string::String {
        status_of(arg0.state, arg0.outcome)
    }

    fun status_of(arg0: u8, arg1: u8) : 0x1::string::String {
        let v0 = if (arg0 == 6) {
            b"open"
        } else if (arg0 == 0) {
            b"funded"
        } else if (arg0 == 1) {
            b"submitted"
        } else if (arg0 == 5) {
            b"revision"
        } else if (arg0 == 2) {
            b"rejection_pending"
        } else {
            assert!(arg0 == 4, 1);
            if (arg1 == 1 || arg1 == 2) {
                b"completed"
            } else if (arg1 == 3 || arg1 == 4) {
                b"rejected"
            } else if (arg1 == 5 || arg1 == 6) {
                b"expired"
            } else if (arg1 == 7) {
                b"declined"
            } else if (arg1 == 8) {
                b"cancelled"
            } else {
                assert!(arg1 == 9, 1);
                b"split"
            }
        };
        0x1::string::utf8(v0)
    }

    fun strike_by(arg0: &Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry) : address {
        funder_passport(arg0, arg1)
    }

    fun take_owed(arg0: &mut Job, arg1: &0x2::deny_list::DenyList, arg2: address, arg3: &0x2::tx_context::TxContext) : u64 {
        assert!(!0x2::coin::deny_list_v2_contains_current_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3) && !0x2::coin::deny_list_v2_contains_next_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2), 20);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.owed, &arg2), 21);
        let (_, v1) = 0x2::vec_map::remove<address, u64>(&mut arg0.owed, &arg2);
        v1
    }

    public fun terms_version(arg0: &Job) : u16 {
        arg0.terms_version
    }

    entry fun withdraw(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowWindow, arg3: &0x2::deny_list::DenyList, arg4: address, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::payee(arg2) == arg4, 13);
        let v0 = take_owed(arg0, arg3, arg4, arg6);
        emit_withdrawn(arg0, arg4, v0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::pay(arg2, arg1, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds, v0), arg5));
    }

    entry fun withdraw_first(arg0: &mut Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowRegistry, arg3: &0x2::deny_list::DenyList, arg4: address, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        check_rules(arg0);
        let v0 = take_owed(arg0, arg3, arg4, arg6);
        emit_withdrawn(arg0, arg4, v0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::pay_new(arg2, arg4, arg1, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.funds, v0), arg5));
    }

    // decompiled from Move bytecode v7
}

