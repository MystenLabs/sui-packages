module 0x3bd45e948a0bfdca7c76e6c8c5089a4ebea00ad5ecde137d10db9bf21ea088ed::agreement {
    struct Protocol has key {
        id: 0x2::object::UID,
        version: u64,
        fee_cap_mist: u64,
        bond_bps: u64,
        dispute_window_ms: u64,
        arbitration_window_ms: u64,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Agreement has key {
        id: 0x2::object::UID,
        version: u64,
        terms: 0x1::string::String,
        position_a: 0x1::string::String,
        position_b: 0x1::string::String,
        proposer: address,
        allowed_counterparty: 0x1::option::Option<address>,
        acceptor: 0x1::option::Option<address>,
        arbiter: 0x1::option::Option<address>,
        arbiter_terms_hash: vector<u8>,
        contribution: u64,
        bond_amount: u64,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        bonds: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_cap_mist: u64,
        arbiter_fee_mist: u64,
        dispute_window_ms: u64,
        arbitration_window_ms: u64,
        accept_deadline_ms: u64,
        outcome_opens_at_ms: u64,
        resolution_deadline_ms: u64,
        status: u8,
        proposed_outcome: 0x1::option::Option<u8>,
        outcome_proposer: 0x1::option::Option<address>,
        disputer: 0x1::option::Option<address>,
        outcome_proposed_at_ms: u64,
        disputed_at_ms: u64,
    }

    struct AgreementProposed has copy, drop {
        agreement_id: 0x2::object::ID,
        proposer: address,
        contribution: u64,
        arbiter: 0x1::option::Option<address>,
    }

    struct TermsAccepted has copy, drop {
        agreement_id: 0x2::object::ID,
        acceptor: address,
        arbiter: 0x1::option::Option<address>,
    }

    struct OutcomeProposed has copy, drop {
        agreement_id: 0x2::object::ID,
        by: address,
        outcome: u8,
    }

    struct Disputed has copy, drop {
        agreement_id: 0x2::object::ID,
        by: address,
    }

    struct ArbiterRuled has copy, drop {
        agreement_id: 0x2::object::ID,
        arbiter: address,
        verdict: u8,
        arbiter_fee: u64,
    }

    struct Settled has copy, drop {
        agreement_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        fee: u64,
    }

    struct Voided has copy, drop {
        agreement_id: 0x2::object::ID,
    }

    struct FaultAttributed has copy, drop {
        agreement_id: 0x2::object::ID,
        party: address,
        attributed_by: address,
    }

    struct TimedOut has copy, drop {
        agreement_id: 0x2::object::ID,
    }

    struct Cancelled has copy, drop {
        agreement_id: 0x2::object::ID,
    }

    struct Expired has copy, drop {
        agreement_id: 0x2::object::ID,
    }

    public fun accept_terms(arg0: &mut Agreement, arg1: &Protocol, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<address>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        assert_protocol_version(arg1);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.accept_deadline_ms, 7);
        assert!(v0 != arg0.proposer, 4);
        if (0x1::option::is_some<address>(&arg0.allowed_counterparty)) {
            assert!(v0 == *0x1::option::borrow<address>(&arg0.allowed_counterparty), 9);
        };
        assert!(arg4 == arg0.arbiter, 15);
        assert!(arg5 == arg0.arbiter_fee_mist, 22);
        if (0x1::option::is_some<address>(&arg0.arbiter)) {
            assert!(*0x1::option::borrow<address>(&arg0.arbiter) != v0, 23);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.contribution, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg0.bond_amount, 10);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bonds, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg0.acceptor = 0x1::option::some<address>(v0);
        arg0.status = 1;
        let v1 = TermsAccepted{
            agreement_id : 0x2::object::id<Agreement>(arg0),
            acceptor     : v0,
            arbiter      : arg0.arbiter,
        };
        0x2::event::emit<TermsAccepted>(v1);
    }

    public fun arbiter(arg0: &Agreement) : 0x1::option::Option<address> {
        arg0.arbiter
    }

    public fun arbiter_fee_mist(arg0: &Agreement) : u64 {
        arg0.arbiter_fee_mist
    }

    public fun arbiter_rule(arg0: &mut Agreement, arg1: &mut Protocol, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        assert_protocol_version(arg1);
        assert!(arg0.status == 3, 2);
        assert!(0x1::option::is_some<address>(&arg0.arbiter), 16);
        assert!(0x2::tx_context::sender(arg4) == *0x1::option::borrow<address>(&arg0.arbiter), 17);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.disputed_at_ms + arg0.arbitration_window_ms, 7);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 12);
        let v1 = *0x1::option::borrow<address>(&arg0.arbiter);
        let v2 = ArbiterRuled{
            agreement_id : 0x2::object::id<Agreement>(arg0),
            arbiter      : v1,
            verdict      : arg2,
            arbiter_fee  : arg0.arbiter_fee_mist,
        };
        0x2::event::emit<ArbiterRuled>(v2);
        let v3 = arg0.arbiter_fee_mist;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v3), arg4), v1);
        };
        if (arg2 == 2) {
            arg0.status = 5;
            refund_all(arg0, arg4);
            let v4 = Voided{agreement_id: 0x2::object::id<Agreement>(arg0)};
            0x2::event::emit<Voided>(v4);
            return
        };
        let (v5, v6, v7) = if (arg2 == 0) {
            let v7 = *0x1::option::borrow<u8>(&arg0.proposed_outcome);
            (*0x1::option::borrow<address>(&arg0.outcome_proposer), *0x1::option::borrow<address>(&arg0.disputer), v7)
        } else {
            let v8 = if (*0x1::option::borrow<u8>(&arg0.proposed_outcome) == 0) {
                1
            } else {
                0
            };
            (*0x1::option::borrow<address>(&arg0.disputer), *0x1::option::borrow<address>(&arg0.outcome_proposer), v8)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bonds), arg4), v5);
        let v9 = FaultAttributed{
            agreement_id  : 0x2::object::id<Agreement>(arg0),
            party         : v6,
            attributed_by : v1,
        };
        0x2::event::emit<FaultAttributed>(v9);
        pay_beneficiary(arg0, arg1, v7, arg4);
    }

    public fun arbiter_terms_hash(arg0: &Agreement) : vector<u8> {
        arg0.arbiter_terms_hash
    }

    fun assert_admin_version(arg0: &AdminCap) {
        assert!(arg0.version == 4, 14);
    }

    fun assert_agreement_version(arg0: &Agreement) {
        assert!(arg0.version == 4, 14);
    }

    fun assert_protocol_version(arg0: &Protocol) {
        assert!(arg0.version == 4, 14);
    }

    public fun bond_amount(arg0: &Agreement) : u64 {
        arg0.bond_amount
    }

    public fun bonds_value(arg0: &Agreement) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bonds)
    }

    fun calculate_bond(arg0: u64, arg1: u64) : u64 {
        let v0 = mul_bps(arg0, arg1);
        if (v0 < 1000000) {
            1000000
        } else {
            v0
        }
    }

    public fun cancel_agreement(arg0: &mut Agreement, arg1: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        assert!(arg0.status == 0, 2);
        assert!(0x2::tx_context::sender(arg1) == arg0.proposer, 0);
        arg0.status = 7;
        refund_proposal(arg0, arg1);
        let v0 = Cancelled{agreement_id: 0x2::object::id<Agreement>(arg0)};
        0x2::event::emit<Cancelled>(v0);
    }

    fun cobrar_tarifa(arg0: &mut Agreement, arg1: &mut Protocol) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v1 = mul_bps(arg0.contribution * 2, 100);
        let v2 = if (v1 > arg0.fee_cap_mist) {
            arg0.fee_cap_mist
        } else {
            v1
        };
        let v3 = if (v2 > v0) {
            v0
        } else {
            v2
        };
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v3));
        };
        v3
    }

    public fun confirm_outcome(arg0: &mut Agreement, arg1: &mut Protocol, arg2: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        assert_protocol_version(arg1);
        assert!(arg0.status == 2, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.proposer || v0 == *0x1::option::borrow<address>(&arg0.acceptor), 3);
        assert!(v0 != *0x1::option::borrow<address>(&arg0.outcome_proposer), 13);
        settle_proposed(arg0, arg1, arg2);
    }

    public fun contribution(arg0: &Agreement) : u64 {
        arg0.contribution
    }

    public fun dispute(arg0: &mut Agreement, arg1: &mut Protocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        assert_protocol_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 2, 2);
        assert!(v0 < arg0.outcome_proposed_at_ms + arg0.dispute_window_ms, 7);
        assert!(v1 == arg0.proposer || v1 == *0x1::option::borrow<address>(&arg0.acceptor), 3);
        assert!(v1 != *0x1::option::borrow<address>(&arg0.outcome_proposer), 13);
        arg0.disputer = 0x1::option::some<address>(v1);
        arg0.disputed_at_ms = v0;
        let v2 = Disputed{
            agreement_id : 0x2::object::id<Agreement>(arg0),
            by           : v1,
        };
        0x2::event::emit<Disputed>(v2);
        if (0x1::option::is_none<address>(&arg0.arbiter)) {
            arg0.status = 5;
            refund_all(arg0, arg3);
            let v3 = Voided{agreement_id: 0x2::object::id<Agreement>(arg0)};
            0x2::event::emit<Voided>(v3);
            return
        };
        arg0.status = 3;
    }

    public fun fee_bps() : u64 {
        100
    }

    public fun fee_cap_mist(arg0: &Protocol) : u64 {
        arg0.fee_cap_mist
    }

    public fun fees_value(arg0: &Protocol) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees)
    }

    public fun finalize(arg0: &mut Agreement, arg1: &mut Protocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        assert_protocol_version(arg1);
        assert!(arg0.status == 2, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.outcome_proposed_at_ms + arg0.dispute_window_ms, 6);
        settle_proposed(arg0, arg1, arg3);
    }

    public fun frozen_fee_cap_mist(arg0: &Agreement) : u64 {
        arg0.fee_cap_mist
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Protocol{
            id                    : 0x2::object::new(arg0),
            version               : 4,
            fee_cap_mist          : 5000000000,
            bond_bps              : 1000,
            dispute_window_ms     : 86400000,
            arbitration_window_ms : 604800000,
            fees                  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Protocol>(v0);
        let v1 = AdminCap{
            id      : 0x2::object::new(arg0),
            version : 4,
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun max_fee_cap_mist() : u64 {
        10000000000
    }

    public fun min_contribution_mist() : u64 {
        1000000000
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun pay_beneficiary(arg0: &mut Agreement, arg1: &mut Protocol, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.status = 4;
        let v0 = if (arg2 == 0) {
            arg0.proposer
        } else {
            *0x1::option::borrow<address>(&arg0.acceptor)
        };
        let v1 = cobrar_tarifa(arg0, arg1);
        let v2 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot);
        let v3 = Settled{
            agreement_id : 0x2::object::id<Agreement>(arg0),
            beneficiary  : v0,
            amount       : 0x2::balance::value<0x2::sui::SUI>(&v2),
            fee          : v1,
        };
        0x2::event::emit<Settled>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3), v0);
    }

    public fun pot_value(arg0: &Agreement) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun propose_agreement(arg0: &Protocol, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<address>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_protocol_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x2::tx_context::sender(arg14);
        assert!(arg8 > v0, 8);
        assert!(arg8 <= v0 + 3600000, 8);
        assert!(arg8 <= arg9, 8);
        assert!(arg9 < arg10, 8);
        if (0x1::option::is_some<address>(&arg4)) {
            assert!(*0x1::option::borrow<address>(&arg4) != v1, 4);
        };
        if (0x1::option::is_some<address>(&arg5)) {
            assert!(*0x1::option::borrow<address>(&arg5) != @0x0, 24);
            assert!(0x1::vector::length<u8>(&arg6) == 32, 25);
            assert!(*0x1::option::borrow<address>(&arg5) != v1, 23);
            if (0x1::option::is_some<address>(&arg4)) {
                assert!(*0x1::option::borrow<address>(&arg5) != *0x1::option::borrow<address>(&arg4), 23);
            };
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg11);
        assert!(v2 >= 1000000000, 20);
        if (0x1::option::is_none<address>(&arg5)) {
            assert!(arg7 == 0, 21);
            assert!(0x1::vector::length<u8>(&arg6) == 0, 25);
        } else {
            assert!(arg7 <= mul_bps(v2 * 2, 1000), 18);
        };
        let v3 = calculate_bond(v2, arg0.bond_bps);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg12) == v3, 10);
        let v4 = Agreement{
            id                     : 0x2::object::new(arg14),
            version                : 4,
            terms                  : arg1,
            position_a             : arg2,
            position_b             : arg3,
            proposer               : v1,
            allowed_counterparty   : arg4,
            acceptor               : 0x1::option::none<address>(),
            arbiter                : arg5,
            arbiter_terms_hash     : arg6,
            contribution           : v2,
            bond_amount            : v3,
            pot                    : 0x2::coin::into_balance<0x2::sui::SUI>(arg11),
            bonds                  : 0x2::coin::into_balance<0x2::sui::SUI>(arg12),
            fee_cap_mist           : arg0.fee_cap_mist,
            arbiter_fee_mist       : arg7,
            dispute_window_ms      : arg0.dispute_window_ms,
            arbitration_window_ms  : arg0.arbitration_window_ms,
            accept_deadline_ms     : arg8,
            outcome_opens_at_ms    : arg9,
            resolution_deadline_ms : arg10,
            status                 : 0,
            proposed_outcome       : 0x1::option::none<u8>(),
            outcome_proposer       : 0x1::option::none<address>(),
            disputer               : 0x1::option::none<address>(),
            outcome_proposed_at_ms : 0,
            disputed_at_ms         : 0,
        };
        let v5 = AgreementProposed{
            agreement_id : 0x2::object::id<Agreement>(&v4),
            proposer     : v1,
            contribution : v2,
            arbiter      : arg5,
        };
        0x2::event::emit<AgreementProposed>(v5);
        0x2::transfer::share_object<Agreement>(v4);
    }

    public fun propose_outcome(arg0: &mut Agreement, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 1, 2);
        assert!(arg1 == 0 || arg1 == 1, 11);
        assert!(v0 >= arg0.outcome_opens_at_ms, 6);
        assert!(v0 < arg0.resolution_deadline_ms, 7);
        assert!(v1 == arg0.proposer || v1 == *0x1::option::borrow<address>(&arg0.acceptor), 3);
        arg0.proposed_outcome = 0x1::option::some<u8>(arg1);
        arg0.outcome_proposer = 0x1::option::some<address>(v1);
        arg0.outcome_proposed_at_ms = v0;
        arg0.status = 2;
        let v2 = OutcomeProposed{
            agreement_id : 0x2::object::id<Agreement>(arg0),
            by           : v1,
            outcome      : arg1,
        };
        0x2::event::emit<OutcomeProposed>(v2);
    }

    public fun proposed_outcome(arg0: &Agreement) : 0x1::option::Option<u8> {
        arg0.proposed_outcome
    }

    public fun proposer(arg0: &Agreement) : address {
        arg0.proposer
    }

    public fun reclaim_expired(arg0: &mut Agreement, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        assert!(arg0.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.accept_deadline_ms, 6);
        arg0.status = 7;
        refund_proposal(arg0, arg2);
        let v0 = Expired{agreement_id: 0x2::object::id<Agreement>(arg0)};
        0x2::event::emit<Expired>(v0);
    }

    fun refund_all(arg0: &mut Agreement, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot) / 2;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v0), arg1), arg0.proposer);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.pot) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot), arg1), *0x1::option::borrow<address>(&arg0.acceptor));
        };
        return_bonds(arg0, arg1);
    }

    fun refund_proposal(arg0: &mut Agreement, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot), arg1), arg0.proposer);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.bonds) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bonds), arg1), arg0.proposer);
        };
    }

    fun return_bonds(arg0: &mut Agreement, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.bond_amount;
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.bonds) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bonds, v0), arg1), arg0.proposer);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.bonds) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bonds), arg1), *0x1::option::borrow<address>(&arg0.acceptor));
        };
    }

    public fun set_arbitration_window(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64) {
        assert_admin_version(arg0);
        assert_protocol_version(arg1);
        assert!(arg2 > 0 && arg2 <= 7776000000, 8);
        arg1.arbitration_window_ms = arg2;
    }

    public fun set_bond_bps(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64) {
        assert_admin_version(arg0);
        assert_protocol_version(arg1);
        assert!(arg2 <= 5000, 19);
        arg1.bond_bps = arg2;
    }

    public fun set_dispute_window(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64) {
        assert_admin_version(arg0);
        assert_protocol_version(arg1);
        assert!(arg2 > 0 && arg2 <= 2592000000, 8);
        arg1.dispute_window_ms = arg2;
    }

    public fun set_fee_cap(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64) {
        assert_admin_version(arg0);
        assert_protocol_version(arg1);
        assert!(arg2 <= 10000000000, 19);
        arg1.fee_cap_mist = arg2;
    }

    fun settle_proposed(arg0: &mut Agreement, arg1: &mut Protocol, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x1::option::borrow<u8>(&arg0.proposed_outcome);
        return_bonds(arg0, arg2);
        pay_beneficiary(arg0, arg1, v0, arg2);
    }

    public fun status(arg0: &Agreement) : u8 {
        arg0.status
    }

    public fun timeout_refund(arg0: &mut Agreement, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_agreement_version(arg0);
        if (arg0.status == 1) {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.resolution_deadline_ms, 6);
        } else {
            assert!(arg0.status == 3, 2);
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.disputed_at_ms + arg0.arbitration_window_ms, 6);
        };
        arg0.status = 6;
        refund_all(arg0, arg2);
        let v0 = TimedOut{agreement_id: 0x2::object::id<Agreement>(arg0)};
        0x2::event::emit<TimedOut>(v0);
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut Protocol, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_admin_version(arg0);
        assert_protocol_version(arg1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fees), arg2)
    }

    // decompiled from Move bytecode v7
}

