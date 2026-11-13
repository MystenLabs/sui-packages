module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::governance {
    struct Governance has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        seal_registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        paid_mint_id: 0x2::object::ID,
        voting_period_ms: u64,
        timelock_ms: u64,
        exec_window_ms: u64,
        quorum_bps: u64,
        min_quorum_votes: u64,
        threshold_bps: u64,
        super_threshold_bps: u64,
        proposer_cooldown_ms: u64,
        deposit_coin: 0x1::ascii::String,
        deposit_amount: u64,
        excluded_voters: 0x2::vec_set::VecSet<address>,
        non_voting_supply: u64,
        treasury_btc_bps: u64,
        proposal_count: u64,
        last_proposed_ms: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        gov_id: 0x2::object::ID,
        number: u64,
        kind: u8,
        title: 0x1::string::String,
        body_uri: 0x1::string::String,
        body_hash: vector<u8>,
        payload: vector<u8>,
        proposer: address,
        proposer_seal: 0x1::option::Option<0x2::object::ID>,
        created_ms: u64,
        start_ms: u64,
        end_ms: u64,
        timelock_ms: u64,
        exec_window_ms: u64,
        snapshot_issued: u64,
        quorum_needed: u64,
        threshold_bps: u64,
        yes: u64,
        no: u64,
        abstain: u64,
        votes: 0x2::table::Table<0x2::object::ID, VoteRecord>,
        status: u8,
        finalized_ms: u64,
        executed_ms: u64,
        evidence: 0x1::string::String,
    }

    struct VoteRecord has copy, drop, store {
        choice: u8,
        voter: address,
        serial: u64,
        at_ms: u64,
    }

    struct DepositKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Params has copy, drop {
        voting_period_ms: u64,
        timelock_ms: u64,
        exec_window_ms: u64,
        quorum_bps: u64,
        min_quorum_votes: u64,
        threshold_bps: u64,
        super_threshold_bps: u64,
        proposer_cooldown_ms: u64,
        deposit_amount: u64,
    }

    struct ExecTicket {
        gov_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        kind: u8,
        payload: vector<u8>,
    }

    struct ExecReceipt {
        gov_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        evidence: 0x1::string::String,
    }

    struct GovernanceCreated has copy, drop {
        gov_id: 0x2::object::ID,
        by: address,
    }

    struct ParamsUpdated has copy, drop {
        gov_id: 0x2::object::ID,
        via_proposal: 0x1::option::Option<0x2::object::ID>,
    }

    struct ProposalCreated has copy, drop {
        gov_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        number: u64,
        kind: u8,
        title: 0x1::string::String,
        body_uri: 0x1::string::String,
        body_hash: vector<u8>,
        proposer: address,
        proposer_seal: 0x1::option::Option<0x2::object::ID>,
        start_ms: u64,
        end_ms: u64,
        snapshot_issued: u64,
        quorum_needed: u64,
        threshold_bps: u64,
    }

    struct VoteCast has copy, drop {
        proposal_id: 0x2::object::ID,
        seal_id: 0x2::object::ID,
        serial: u64,
        choice: u8,
        voter: address,
    }

    struct ProposalFinalized has copy, drop {
        proposal_id: 0x2::object::ID,
        status: u8,
        yes: u64,
        no: u64,
        abstain: u64,
    }

    struct ProposalCancelled has copy, drop {
        proposal_id: 0x2::object::ID,
        by: address,
    }

    struct ProposalVetoed has copy, drop {
        proposal_id: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct ExecutionStarted has copy, drop {
        proposal_id: 0x2::object::ID,
        kind: u8,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        kind: u8,
        evidence: 0x1::string::String,
    }

    struct ProposalExpired has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    struct DepositReturned has copy, drop {
        proposal_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct DepositSlashed has copy, drop {
        proposal_id: 0x2::object::ID,
        amount: u64,
    }

    struct Migrated has copy, drop {
        gov_id: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    public fun admin_propose(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Governance, arg2: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealRegistry, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_live(arg1);
        assert!(0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealRegistry>(arg2) == arg1.seal_registry_id, 27);
        let v0 = 0x2::tx_context::sender(arg9);
        share_and_emit(new_proposal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, 0x1::option::none<0x2::object::ID>(), 0x2::clock::timestamp_ms(arg8), arg9))
    }

    public fun apply_advisory(arg0: &Governance, arg1: ExecTicket, arg2: 0x1::string::String) : ExecReceipt {
        assert!(0x1::string::length(&arg2) <= 512, 28);
        let v0 = if (arg1.kind == 5) {
            5
        } else {
            0
        };
        let (v1, _) = open_ticket(arg0, arg1, v0);
        ExecReceipt{
            gov_id      : 0x2::object::id<Governance>(arg0),
            proposal_id : v1,
            evidence    : arg2,
        }
    }

    public fun apply_gov_params(arg0: &mut Governance, arg1: ExecTicket) : ExecReceipt {
        let (v0, v1) = open_ticket(arg0, arg1, 3);
        let v2 = 0x2::bcs::new(v1);
        let v3 = &mut v2;
        let v4 = peel_params(v3);
        check_params(&v4);
        write_params(arg0, &v4);
        let v5 = ParamsUpdated{
            gov_id       : 0x2::object::id<Governance>(arg0),
            via_proposal : 0x1::option::some<0x2::object::ID>(v0),
        };
        0x2::event::emit<ParamsUpdated>(v5);
        ExecReceipt{
            gov_id      : 0x2::object::id<Governance>(arg0),
            proposal_id : v0,
            evidence    : 0x1::string::utf8(b""),
        }
    }

    public fun apply_market_fees(arg0: &Governance, arg1: ExecTicket, arg2: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::Market) : ExecReceipt {
        let (v0, v1) = open_ticket(arg0, arg1, 1);
        assert!(0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::Market>(arg2) == arg0.market_id, 27);
        let v2 = 0x2::bcs::new(v1);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::set_fees(arg2, 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2));
        ExecReceipt{
            gov_id      : 0x2::object::id<Governance>(arg0),
            proposal_id : v0,
            evidence    : 0x1::string::utf8(b""),
        }
    }

    public fun apply_paid_mint_prices(arg0: &Governance, arg1: ExecTicket, arg2: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg3: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::paid_mint::PaidMint) : ExecReceipt {
        let (v0, v1) = open_ticket(arg0, arg1, 2);
        assert!(0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::paid_mint::PaidMint>(arg3) == arg0.paid_mint_id, 27);
        let v2 = 0x2::bcs::new(v1);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::paid_mint::set_params(arg2, arg3, 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::paid_mint::treasury(arg3));
        ExecReceipt{
            gov_id      : 0x2::object::id<Governance>(arg0),
            proposal_id : v0,
            evidence    : 0x1::string::utf8(b""),
        }
    }

    public fun apply_treasury_split(arg0: &mut Governance, arg1: ExecTicket, arg2: 0x1::string::String) : ExecReceipt {
        assert!(0x1::string::length(&arg2) <= 512, 28);
        let (v0, v1) = open_ticket(arg0, arg1, 4);
        let v2 = 0x2::bcs::new(v1);
        arg0.treasury_btc_bps = 0x2::bcs::peel_u64(&mut v2);
        ExecReceipt{
            gov_id      : 0x2::object::id<Governance>(arg0),
            proposal_id : v0,
            evidence    : arg2,
        }
    }

    fun assert_live(arg0: &Governance) {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
    }

    fun assert_mine(arg0: &Governance, arg1: &Proposal) {
        assert!(arg1.gov_id == 0x2::object::id<Governance>(arg0), 3);
    }

    fun assert_version(arg0: &Governance) {
        assert!(arg0.version == 1, 1);
    }

    public fun begin_execution(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &Governance, arg2: &Proposal, arg3: &0x2::clock::Clock) : ExecTicket {
        assert_live(arg1);
        assert_mine(arg1, arg2);
        assert!(arg2.status == 1, 17);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg2.end_ms + arg2.timelock_ms;
        assert!(v0 >= v1, 18);
        assert!(v0 <= v1 + arg2.exec_window_ms, 19);
        let v2 = ExecutionStarted{
            proposal_id : 0x2::object::id<Proposal>(arg2),
            kind        : arg2.kind,
        };
        0x2::event::emit<ExecutionStarted>(v2);
        ExecTicket{
            gov_id      : 0x2::object::id<Governance>(arg1),
            proposal_id : 0x2::object::id<Proposal>(arg2),
            kind        : arg2.kind,
            payload     : arg2.payload,
        }
    }

    public fun body(arg0: &Proposal) : (0x1::string::String, 0x1::string::String, vector<u8>) {
        (arg0.title, arg0.body_uri, arg0.body_hash)
    }

    public fun cancel(arg0: &Governance, arg1: &mut Proposal, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_mine(arg0, arg1);
        assert!(arg1.status == 0, 10);
        assert!(arg1.proposer_seal == 0x1::option::some<0x2::object::ID>(arg4), 22);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::prove(arg2, arg3, arg4);
        assert!(arg1.yes + arg1.no + arg1.abstain == 0, 21);
        arg1.status = 5;
        let v0 = ProposalCancelled{
            proposal_id : 0x2::object::id<Proposal>(arg1),
            by          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ProposalCancelled>(v0);
    }

    fun check_params(arg0: &Params) {
        assert!(arg0.voting_period_ms >= 86400000 && arg0.voting_period_ms <= 1209600000, 23);
        assert!(arg0.timelock_ms <= 604800000, 23);
        assert!(arg0.exec_window_ms >= 86400000 && arg0.exec_window_ms <= 2592000000, 23);
        assert!(arg0.quorum_bps <= 10000 && arg0.min_quorum_votes >= 1, 23);
        assert!(arg0.threshold_bps >= 5000 && arg0.threshold_bps < 10000, 23);
        assert!(arg0.super_threshold_bps >= arg0.threshold_bps && arg0.super_threshold_bps < 10000, 23);
        assert!(arg0.proposer_cooldown_ms <= 2592000000, 23);
    }

    fun check_vote(arg0: &Governance, arg1: &Proposal, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        assert_live(arg0);
        assert_mine(arg0, arg1);
        assert!(arg1.status == 0, 10);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.start_ms && v0 < arg1.end_ms, 11);
        assert!(arg2 <= 2, 15);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_set::contains<address>(&arg0.excluded_voters, &v1), 16);
        v0
    }

    fun coin_name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    public fun create(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealRegistry, arg2: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::Market, arg3: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::paid_mint::PaidMint, arg4: 0x1::ascii::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, arg5);
        let v1 = Governance{
            id                   : 0x2::object::new(arg6),
            version              : 1,
            paused               : false,
            seal_registry_id     : 0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealRegistry>(arg1),
            market_id            : 0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::Market>(arg2),
            paid_mint_id         : 0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::paid_mint::PaidMint>(arg3),
            voting_period_ms     : 259200000,
            timelock_ms          : 86400000,
            exec_window_ms       : 604800000,
            quorum_bps           : 2000,
            min_quorum_votes     : 3,
            threshold_bps        : 5000,
            super_threshold_bps  : 6666,
            proposer_cooldown_ms : 86400000,
            deposit_coin         : arg4,
            deposit_amount       : 0,
            excluded_voters      : v0,
            non_voting_supply    : 0,
            treasury_btc_bps     : 3820,
            proposal_count       : 0,
            last_proposed_ms     : 0x2::table::new<0x2::object::ID, u64>(arg6),
        };
        let v2 = 0x2::object::id<Governance>(&v1);
        let v3 = GovernanceCreated{
            gov_id : v2,
            by     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<GovernanceCreated>(v3);
        0x2::transfer::share_object<Governance>(v1);
        v2
    }

    public fun create_proposal<T0>(arg0: &mut Governance, arg1: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealRegistry, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u8, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: vector<u8>, arg10: 0x2::coin::Coin<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_live(arg0);
        assert!(0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealRegistry>(arg1) == arg0.seal_registry_id, 27);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::prove(arg2, arg3, arg4);
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(!0x2::vec_set::contains<address>(&arg0.excluded_voters, &v0), 16);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_proposed_ms, arg4)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.last_proposed_ms, arg4);
            assert!(v1 >= *v2 + arg0.proposer_cooldown_ms, 8);
            *v2 = v1;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.last_proposed_ms, arg4, v1);
        };
        assert!(0x2::coin::value<T0>(&arg10) == arg0.deposit_amount, 9);
        assert!(0x2::coin::value<T0>(&arg10) == 0 || coin_name<T0>() == arg0.deposit_coin, 9);
        let v3 = 0x2::tx_context::sender(arg12);
        let v4 = new_proposal(arg0, arg1, arg5, arg6, arg7, arg8, arg9, v3, 0x1::option::some<0x2::object::ID>(arg4), v1, arg12);
        if (0x2::coin::value<T0>(&arg10) > 0) {
            let v5 = DepositKey{dummy_field: false};
            0x2::dynamic_field::add<DepositKey, 0x2::balance::Balance<T0>>(&mut v4.id, v5, 0x2::coin::into_balance<T0>(arg10));
        } else {
            0x2::coin::destroy_zero<T0>(arg10);
        };
        share_and_emit(v4)
    }

    public fun evidence(arg0: &Proposal) : 0x1::string::String {
        arg0.evidence
    }

    public fun exec_window(arg0: &Proposal) : (u64, u64) {
        (arg0.end_ms + arg0.timelock_ms, arg0.end_ms + arg0.timelock_ms + arg0.exec_window_ms)
    }

    public fun expire(arg0: &Governance, arg1: &mut Proposal, arg2: &0x2::clock::Clock) {
        assert_mine(arg0, arg1);
        assert!(arg1.status == 1, 17);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.end_ms + arg1.timelock_ms + arg1.exec_window_ms, 30);
        arg1.status = 7;
        let v0 = ProposalExpired{proposal_id: 0x2::object::id<Proposal>(arg1)};
        0x2::event::emit<ProposalExpired>(v0);
    }

    public fun finalize(arg0: &Governance, arg1: &mut Proposal, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_mine(arg0, arg1);
        assert!(arg1.status == 0, 10);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.end_ms, 12);
        let v1 = if (arg1.yes + arg1.no + arg1.abstain < arg1.quorum_needed) {
            3
        } else if (passes(arg1.yes, arg1.no, arg1.threshold_bps)) {
            1
        } else {
            2
        };
        arg1.status = v1;
        arg1.finalized_ms = v0;
        let v2 = ProposalFinalized{
            proposal_id : 0x2::object::id<Proposal>(arg1),
            status      : arg1.status,
            yes         : arg1.yes,
            no          : arg1.no,
            abstain     : arg1.abstain,
        };
        0x2::event::emit<ProposalFinalized>(v2);
    }

    public fun finish_execution(arg0: &Governance, arg1: &mut Proposal, arg2: ExecReceipt, arg3: &0x2::clock::Clock) {
        let ExecReceipt {
            gov_id      : v0,
            proposal_id : v1,
            evidence    : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<Governance>(arg0) && v1 == 0x2::object::id<Proposal>(arg1), 20);
        assert!(arg1.status == 1, 17);
        arg1.status = 4;
        arg1.executed_ms = 0x2::clock::timestamp_ms(arg3);
        arg1.evidence = v2;
        let v3 = ProposalExecuted{
            proposal_id : v1,
            kind        : arg1.kind,
            evidence    : v2,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public fun gov_id(arg0: &Proposal) : 0x2::object::ID {
        arg0.gov_id
    }

    public fun has_deposit(arg0: &Proposal) : bool {
        let v0 = DepositKey{dummy_field: false};
        0x2::dynamic_field::exists<DepositKey>(&arg0.id, v0)
    }

    public fun has_voted(arg0: &Proposal, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, VoteRecord>(&arg0.votes, arg1)
    }

    public fun is_excluded(arg0: &Governance, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.excluded_voters, &arg1)
    }

    public fun is_paused(arg0: &Governance) : bool {
        arg0.paused
    }

    public fun kind(arg0: &Proposal) : u8 {
        arg0.kind
    }

    public fun migrate(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Governance) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
        let v0 = Migrated{
            gov_id : 0x2::object::id<Governance>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    fun needs_super(arg0: u8) : bool {
        if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun new_proposal(arg0: &mut Governance, arg1: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealRegistry, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: address, arg8: 0x1::option::Option<0x2::object::ID>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Proposal {
        assert!(arg2 <= 5, 4);
        assert!(0x1::string::length(&arg3) > 0 && 0x1::string::length(&arg3) <= 120, 6);
        assert!(0x1::string::length(&arg4) <= 256, 7);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 29);
        validate_payload(arg2, &arg6);
        arg0.proposal_count = arg0.proposal_count + 1;
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::issued(arg1);
        let v1 = if (needs_super(arg2)) {
            arg0.super_threshold_bps
        } else {
            arg0.threshold_bps
        };
        Proposal{
            id              : 0x2::object::new(arg10),
            gov_id          : 0x2::object::id<Governance>(arg0),
            number          : arg0.proposal_count,
            kind            : arg2,
            title           : arg3,
            body_uri        : arg4,
            body_hash       : arg5,
            payload         : arg6,
            proposer        : arg7,
            proposer_seal   : arg8,
            created_ms      : arg9,
            start_ms        : arg9,
            end_ms          : arg9 + arg0.voting_period_ms,
            timelock_ms     : arg0.timelock_ms,
            exec_window_ms  : arg0.exec_window_ms,
            snapshot_issued : v0,
            quorum_needed   : quorum_for(arg0, v0),
            threshold_bps   : v1,
            yes             : 0,
            no              : 0,
            abstain         : 0,
            votes           : 0x2::table::new<0x2::object::ID, VoteRecord>(arg10),
            status          : 0,
            finalized_ms    : 0,
            executed_ms     : 0,
            evidence        : 0x1::string::utf8(b""),
        }
    }

    public fun non_voting_supply(arg0: &Governance) : u64 {
        arg0.non_voting_supply
    }

    public fun number(arg0: &Proposal) : u64 {
        arg0.number
    }

    fun open_ticket(arg0: &Governance, arg1: ExecTicket, arg2: u8) : (0x2::object::ID, vector<u8>) {
        let ExecTicket {
            gov_id      : v0,
            proposal_id : v1,
            kind        : v2,
            payload     : v3,
        } = arg1;
        let v4 = v3;
        assert!(v0 == 0x2::object::id<Governance>(arg0), 3);
        assert!(v2 == arg2, 20);
        validate_payload(v2, &v4);
        (v1, v4)
    }

    public fun params(arg0: &Governance) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.voting_period_ms, arg0.timelock_ms, arg0.exec_window_ms, arg0.quorum_bps, arg0.min_quorum_votes, arg0.threshold_bps, arg0.super_threshold_bps)
    }

    public fun passes(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 + arg1 > 0 && (arg0 as u128) * (10000 as u128) > (arg2 as u128) * ((arg0 + arg1) as u128)
    }

    public fun payload(arg0: &Proposal) : vector<u8> {
        arg0.payload
    }

    fun peel_params(arg0: &mut 0x2::bcs::BCS) : Params {
        Params{
            voting_period_ms     : 0x2::bcs::peel_u64(arg0),
            timelock_ms          : 0x2::bcs::peel_u64(arg0),
            exec_window_ms       : 0x2::bcs::peel_u64(arg0),
            quorum_bps           : 0x2::bcs::peel_u64(arg0),
            min_quorum_votes     : 0x2::bcs::peel_u64(arg0),
            threshold_bps        : 0x2::bcs::peel_u64(arg0),
            super_threshold_bps  : 0x2::bcs::peel_u64(arg0),
            proposer_cooldown_ms : 0x2::bcs::peel_u64(arg0),
            deposit_amount       : 0x2::bcs::peel_u64(arg0),
        }
    }

    public fun proposal_count(arg0: &Governance) : u64 {
        arg0.proposal_count
    }

    public fun proposer(arg0: &Proposal) : (address, 0x1::option::Option<0x2::object::ID>) {
        (arg0.proposer, arg0.proposer_seal)
    }

    public fun proposer_rules(arg0: &Governance) : (u64, 0x1::ascii::String, u64) {
        (arg0.proposer_cooldown_ms, arg0.deposit_coin, arg0.deposit_amount)
    }

    fun quorum_for(arg0: &Governance, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0.non_voting_supply) {
            arg1 - arg0.non_voting_supply
        } else {
            0
        };
        let v1 = ((((v0 as u128) * (arg0.quorum_bps as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64);
        if (v1 < arg0.min_quorum_votes) {
            arg0.min_quorum_votes
        } else {
            v1
        }
    }

    public fun quorum_preview(arg0: &Governance, arg1: u64) : u64 {
        quorum_for(arg0, arg1)
    }

    public fun reclaim_deposit<T0>(arg0: &Governance, arg1: &mut Proposal, arg2: &mut 0x2::tx_context::TxContext) {
        assert_mine(arg0, arg1);
        assert!(arg1.status != 0 && arg1.status != 6, 10);
        let v0 = DepositKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<DepositKey, 0x2::balance::Balance<T0>>(&arg1.id, v0), 24);
        let v1 = DepositKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<DepositKey, 0x2::balance::Balance<T0>>(&mut arg1.id, v1);
        let v3 = DepositReturned{
            proposal_id : 0x2::object::id<Proposal>(arg1),
            amount      : 0x2::balance::value<T0>(&v2),
            to          : arg1.proposer,
        };
        0x2::event::emit<DepositReturned>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), arg1.proposer);
    }

    fun record(arg0: &mut Proposal, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u8, arg5: u64, arg6: address) {
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::serial(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::prove(arg1, arg2, arg3));
        assert!(v0 <= arg0.snapshot_issued, 14);
        assert!(!0x2::table::contains<0x2::object::ID, VoteRecord>(&arg0.votes, arg3), 13);
        let v1 = VoteRecord{
            choice : arg4,
            voter  : arg6,
            serial : v0,
            at_ms  : arg5,
        };
        0x2::table::add<0x2::object::ID, VoteRecord>(&mut arg0.votes, arg3, v1);
        if (arg4 == 1) {
            arg0.yes = arg0.yes + 1;
        } else if (arg4 == 0) {
            arg0.no = arg0.no + 1;
        } else {
            arg0.abstain = arg0.abstain + 1;
        };
        let v2 = VoteCast{
            proposal_id : 0x2::object::id<Proposal>(arg0),
            seal_id     : arg3,
            serial      : v0,
            choice      : arg4,
            voter       : arg6,
        };
        0x2::event::emit<VoteCast>(v2);
    }

    public fun requirements(arg0: &Proposal) : (u64, u64, u64) {
        (arg0.snapshot_issued, arg0.quorum_needed, arg0.threshold_bps)
    }

    public fun set_excluded_voter(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Governance, arg2: address, arg3: bool) {
        assert_version(arg1);
        if (arg3) {
            if (!0x2::vec_set::contains<address>(&arg1.excluded_voters, &arg2)) {
                0x2::vec_set::insert<address>(&mut arg1.excluded_voters, arg2);
            };
        } else if (0x2::vec_set::contains<address>(&arg1.excluded_voters, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.excluded_voters, &arg2);
        };
    }

    public fun set_non_voting_supply(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Governance, arg2: u64) {
        assert_version(arg1);
        arg1.non_voting_supply = arg2;
    }

    public fun set_params(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Governance, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::ascii::String, arg11: u64) {
        assert_version(arg1);
        let v0 = Params{
            voting_period_ms     : arg2,
            timelock_ms          : arg3,
            exec_window_ms       : arg4,
            quorum_bps           : arg5,
            min_quorum_votes     : arg6,
            threshold_bps        : arg7,
            super_threshold_bps  : arg8,
            proposer_cooldown_ms : arg9,
            deposit_amount       : arg11,
        };
        check_params(&v0);
        write_params(arg1, &v0);
        arg1.deposit_coin = arg10;
        let v1 = ParamsUpdated{
            gov_id       : 0x2::object::id<Governance>(arg1),
            via_proposal : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<ParamsUpdated>(v1);
    }

    public fun set_paused(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Governance, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
    }

    public fun set_targets(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Governance, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert_version(arg1);
        arg1.market_id = arg2;
        arg1.paid_mint_id = arg3;
    }

    fun share_and_emit(arg0: Proposal) : 0x2::object::ID {
        let v0 = 0x2::object::id<Proposal>(&arg0);
        let v1 = ProposalCreated{
            gov_id          : arg0.gov_id,
            proposal_id     : v0,
            number          : arg0.number,
            kind            : arg0.kind,
            title           : arg0.title,
            body_uri        : arg0.body_uri,
            body_hash       : arg0.body_hash,
            proposer        : arg0.proposer,
            proposer_seal   : arg0.proposer_seal,
            start_ms        : arg0.start_ms,
            end_ms          : arg0.end_ms,
            snapshot_issued : arg0.snapshot_issued,
            quorum_needed   : arg0.quorum_needed,
            threshold_bps   : arg0.threshold_bps,
        };
        0x2::event::emit<ProposalCreated>(v1);
        0x2::transfer::share_object<Proposal>(arg0);
        v0
    }

    public fun slash_deposit<T0>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &Governance, arg2: &mut Proposal, arg3: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::Revenue, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_mine(arg1, arg2);
        assert!(arg2.status == 6, 25);
        let v0 = DepositKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<DepositKey, 0x2::balance::Balance<T0>>(&arg2.id, v0), 24);
        let v1 = DepositKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<DepositKey, 0x2::balance::Balance<T0>>(&mut arg2.id, v1);
        let v3 = DepositSlashed{
            proposal_id : 0x2::object::id<Proposal>(arg2),
            amount      : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<DepositSlashed>(v3);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::deposit<T0>(arg3, v2, arg4, arg5);
    }

    public fun status(arg0: &Proposal) : u8 {
        arg0.status
    }

    public fun tally(arg0: &Proposal) : (u64, u64, u64) {
        (arg0.yes, arg0.no, arg0.abstain)
    }

    public fun targets(arg0: &Governance) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        (arg0.seal_registry_id, arg0.market_id, arg0.paid_mint_id)
    }

    public fun treasury_btc_bps(arg0: &Governance) : u64 {
        arg0.treasury_btc_bps
    }

    fun validate_payload(arg0: u8, arg1: &vector<u8>) {
        if (arg0 == 0) {
            assert!(0x1::vector::length<u8>(arg1) == 0, 5);
            return
        };
        let v0 = 0x2::bcs::new(*arg1);
        if (arg0 == 1) {
            assert!(0x2::bcs::peel_u64(&mut v0) <= 1000 && 0x2::bcs::peel_u64(&mut v0) <= 1000, 5);
        } else if (arg0 == 2) {
            let v1 = if (0x2::bcs::peel_u64(&mut v0) > 0) {
                if (0x2::bcs::peel_u64(&mut v0) > 0) {
                    0x2::bcs::peel_u64(&mut v0) <= 2000
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 5);
        } else if (arg0 == 3) {
            let v2 = &mut v0;
            let v3 = peel_params(v2);
            check_params(&v3);
        } else if (arg0 == 4) {
            assert!(0x2::bcs::peel_u64(&mut v0) <= 10000, 5);
        } else {
            assert!(arg0 == 5, 4);
            0x2::bcs::peel_vec_u8(&mut v0);
            0x2::bcs::peel_address(&mut v0);
            let v4 = 0x2::bcs::peel_vec_u8(&mut v0);
            assert!(0x2::bcs::peel_u64(&mut v0) > 0 && 0x1::vector::length<u8>(&v4) <= 256, 5);
        };
        let v5 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v5) == 0, 5);
    }

    public fun version(arg0: &Governance) : u64 {
        arg0.version
    }

    public fun veto(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &Governance, arg2: &mut Proposal, arg3: 0x1::string::String) {
        assert_version(arg1);
        assert_mine(arg1, arg2);
        assert!(arg2.status == 0 || arg2.status == 1, 10);
        assert!(0x1::string::length(&arg3) <= 512, 28);
        arg2.status = 6;
        let v0 = ProposalVetoed{
            proposal_id : 0x2::object::id<Proposal>(arg2),
            reason      : arg3,
        };
        0x2::event::emit<ProposalVetoed>(v0);
    }

    public fun vote(arg0: &Governance, arg1: &mut Proposal, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = check_vote(arg0, arg1, arg5, arg6, arg7);
        record(arg1, arg2, arg3, arg4, arg5, v0, 0x2::tx_context::sender(arg7));
    }

    public fun vote_choice(arg0: &VoteRecord) : u8 {
        arg0.choice
    }

    public fun vote_many(arg0: &Governance, arg1: &mut Proposal, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: vector<0x2::object::ID>, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg4);
        assert!(v0 > 0 && v0 <= 50, 26);
        let v1 = check_vote(arg0, arg1, arg5, arg6, arg7);
        let v2 = 0;
        while (v2 < v0) {
            record(arg1, arg2, arg3, *0x1::vector::borrow<0x2::object::ID>(&arg4, v2), arg5, v1, 0x2::tx_context::sender(arg7));
            v2 = v2 + 1;
        };
        v0
    }

    public fun vote_of(arg0: &Proposal, arg1: 0x2::object::ID) : 0x1::option::Option<VoteRecord> {
        if (0x2::table::contains<0x2::object::ID, VoteRecord>(&arg0.votes, arg1)) {
            0x1::option::some<VoteRecord>(*0x2::table::borrow<0x2::object::ID, VoteRecord>(&arg0.votes, arg1))
        } else {
            0x1::option::none<VoteRecord>()
        }
    }

    public fun window(arg0: &Proposal) : (u64, u64) {
        (arg0.start_ms, arg0.end_ms)
    }

    fun write_params(arg0: &mut Governance, arg1: &Params) {
        arg0.voting_period_ms = arg1.voting_period_ms;
        arg0.timelock_ms = arg1.timelock_ms;
        arg0.exec_window_ms = arg1.exec_window_ms;
        arg0.quorum_bps = arg1.quorum_bps;
        arg0.min_quorum_votes = arg1.min_quorum_votes;
        arg0.threshold_bps = arg1.threshold_bps;
        arg0.super_threshold_bps = arg1.super_threshold_bps;
        arg0.proposer_cooldown_ms = arg1.proposer_cooldown_ms;
        arg0.deposit_amount = arg1.deposit_amount;
    }

    // decompiled from Move bytecode v7
}

