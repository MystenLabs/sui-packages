module 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve {
    struct ContributionKey has copy, drop, store {
        holder: address,
        window_id: u64,
        nonce: u64,
    }

    struct SweptKey has copy, drop, store {
        window_id: u64,
        holder: address,
    }

    struct SettleKey has copy, drop, store {
        holder: address,
        nonce: u64,
    }

    struct SettledPosition has copy, drop, store {
        window_id: u64,
        holder: address,
    }

    struct ExecutionReserve has key {
        id: 0x2::object::UID,
        execution_id: vector<u8>,
        issuer: address,
        budget: u64,
        deadline_ms: u64,
        status: u8,
        contributions: 0x2::table::Table<address, u64>,
        contribution_keys: 0x2::table::Table<ContributionKey, bool>,
        swept_keys: 0x2::table::Table<SweptKey, bool>,
        settle_nonces: 0x2::table::Table<SettleKey, bool>,
        debit_nonces: 0x2::table::Table<SettleKey, bool>,
        reconcile_debit_nonces: 0x2::table::Table<SettleKey, bool>,
        settled_positions: 0x2::table::Table<SettledPosition, bool>,
        contributor_ids: vector<address>,
        recorded_stake: u64,
        total_contributed: u64,
        contributor_count: u64,
    }

    struct OutstandingCreditKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AttestedProfileKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AttestedSettlementKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AttestedGatePermit has copy, drop, store {
        dummy_field: bool,
    }

    struct RefundCursorKey has copy, drop, store {
        shard: u8,
    }

    struct ExecutionReserveKey has copy, drop, store {
        execution_id: vector<u8>,
    }

    struct ReserveCreated has copy, drop {
        reserve_id: 0x2::object::ID,
        execution_id: vector<u8>,
        budget: u64,
        deadline_ms: u64,
    }

    struct ReserveContributed has copy, drop {
        reserve_id: 0x2::object::ID,
        holder: address,
        window_id: u64,
        market_id: u64,
        outcome_index: u8,
        amount: u64,
        nonce: u64,
        total_contributed: u64,
    }

    struct ReserveSwept has copy, drop {
        reserve_id: 0x2::object::ID,
        holder: address,
        window_id: u64,
        amount: u64,
        total_contributed: u64,
    }

    struct ReserveReconciled has copy, drop {
        reserve_id: 0x2::object::ID,
        execution_id: vector<u8>,
        paid: u64,
        reclaimed: u64,
    }

    struct WindowsSettled has copy, drop {
        reserve_id: 0x2::object::ID,
        execution_id: vector<u8>,
        holder: address,
        amount: u64,
        settle_nonce: u64,
    }

    struct ReceiptClaimed has copy, drop {
        reserve_id: 0x2::object::ID,
        execution_id: vector<u8>,
        window_id: u64,
        holder: address,
        amount: u64,
        debited: u64,
    }

    struct ReserveRefunded has copy, drop {
        reserve_id: 0x2::object::ID,
        execution_id: vector<u8>,
        refunded: u64,
        reclaimed: u64,
        reason: u8,
    }

    struct Payout has copy, drop, store {
        window_id: u64,
        holder: address,
        amount: u64,
    }

    struct Debit has copy, drop, store {
        holder: address,
        amount: u64,
    }

    struct RuntimeAuth has copy, drop {
        runtime_generation: u64,
        signature_type: u8,
        public_key: vector<u8>,
        signature: vector<u8>,
    }

    struct FrontierCheck has copy, drop, store {
        market_id: vector<u8>,
        window_id: vector<u8>,
        selection_anchor_revision: u64,
        expected_frontier_digest: vector<u8>,
    }

    public(friend) fun uid(arg0: &ExecutionReserve) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut ExecutionReserve) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun abort_if_duplicate_payouts(arg0: &vector<Payout>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<Payout>(arg0);
        while (v0 < v1) {
            let v2 = v0 + 1;
            while (v2 < v1) {
                let v3 = 0x1::vector::borrow<Payout>(arg0, v0);
                let v4 = 0x1::vector::borrow<Payout>(arg0, v2);
                let v5 = v3.window_id == v4.window_id && v3.holder == v4.holder;
                assert!(!v5, 13906843807959679048);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun append_debit_lines(arg0: &mut vector<u8>, arg1: &vector<Debit>) {
        let v0 = 0x1::vector::length<Debit>(arg1);
        0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<u64>(&v0));
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<Debit>(arg1, v1);
            0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<address>(&v2.holder));
            0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<u64>(&v2.amount));
            v1 = v1 + 1;
        };
    }

    fun append_payout_lines(arg0: &mut vector<u8>, arg1: &vector<Payout>) {
        let v0 = 0x1::vector::length<Payout>(arg1);
        0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<u64>(&v0));
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<Payout>(arg1, v1);
            0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<u64>(&v2.window_id));
            0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<address>(&v2.holder));
            0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<u64>(&v2.amount));
            v1 = v1 + 1;
        };
    }

    fun arm_attested_gate(arg0: &mut ExecutionReserve) {
        let v0 = AttestedGatePermit{dummy_field: false};
        0x2::dynamic_field::add<AttestedGatePermit, bool>(&mut arg0.id, v0, true);
    }

    public(friend) fun assert_backed(arg0: &ExecutionReserve, arg1: u64) {
        assert!(arg0.recorded_stake <= arg1, 13906840702695702560);
    }

    fun assert_binding_names_reserve(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg1: &ExecutionReserve, arg2: vector<u8>) : vector<u8> {
        let v0 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::decode_binding(arg2);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::assert_deployment_identity(arg0, 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_chain_id(&v0), 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_environment_id(&v0), 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_package_id(&v0));
        assert!(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_execution_id(&v0) == arg1.execution_id, 13906840874497409102);
        let v1 = 0x2::object::id<ExecutionReserve>(arg1);
        assert!(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_reserve_id(&v0) == 0x2::object::id_to_bytes(&v1), 13906840891677278286);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_digest(arg2)
    }

    fun assert_frontiers_match(arg0: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg1: &vector<u8>, arg2: &vector<FrontierCheck>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FrontierCheck>(arg2)) {
            let v1 = 0x1::vector::borrow<FrontierCheck>(arg2, v0);
            assert!(!0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::requires_refund(arg0, *arg1, v1.market_id, v1.window_id, v1.selection_anchor_revision, v1.expected_frontier_digest), 13906843700583137316);
            0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::consume_for_reconciliation(arg0, *arg1, v1.market_id, v1.window_id, v1.selection_anchor_revision, v1.expected_frontier_digest);
            v0 = v0 + 1;
        };
    }

    fun assert_not_attested(arg0: &mut ExecutionReserve) {
        if (is_attested(arg0)) {
            let v0 = AttestedGatePermit{dummy_field: false};
            assert!(0x2::dynamic_field::exists_with_type<AttestedGatePermit, bool>(&arg0.id, v0), 13906840737058193482);
            0x2::dynamic_field::remove<AttestedGatePermit, bool>(&mut arg0.id, v0);
        };
    }

    public(friend) fun assert_open(arg0: &ExecutionReserve) {
        assert!(arg0.status == 0, 13906840505126551574);
    }

    public(friend) fun budget(arg0: &ExecutionReserve) : u64 {
        arg0.budget
    }

    fun claim_execution_identity(arg0: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg1: &vector<u8>, arg2: 0x2::object::ID) {
        let v0 = ExecutionReserveKey{execution_id: *arg1};
        0x2::dynamic_field::add<ExecutionReserveKey, 0x2::object::ID>(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::uid_mut(arg0), v0, arg2);
    }

    public fun claim_with_receipt(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: &0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::outcome_records::ActionOutcomeRecord, arg6: FrontierCheck, arg7: address, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: RuntimeAuth) {
        assert!(arg0.status == 0, 13906839014772899862);
        assert_not_attested(arg0);
        assert!(arg12 > 0, 13906839023365980230);
        assert!(arg11 > 0, 13906839027657670676);
        let v0 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::intake_receipt::accept_message(arg7, &arg0.execution_id, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16.runtime_generation);
        verify_admitted_auth(arg4, arg0.execution_id, &v0, &arg16);
        assert!(0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::outcome_records::action_record_execution_id(arg5) == arg0.execution_id, 13906839126444539964);
        assert!(arg6.market_id == 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::intake_receipt::u64_identity(arg9) && arg6.window_id == 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::intake_receipt::u64_identity(arg8), 13906839143624540222);
        assert!(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::verify_frontier_status(arg4, arg0.execution_id, arg6.market_id, arg6.window_id, arg6.selection_anchor_revision, arg6.expected_frontier_digest) == 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::verify_match(), 13906839186574344256);
        assert!(0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::outcome_records::action_record_previous_state_commitment(arg5) == arg6.expected_frontier_digest, 13906839203754344514);
        let v1 = 0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::outcome_records::action_record_outcome(arg5);
        assert!(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::action_outcome::decode_outcome_index(&v1) == arg10, 13906839229524279364);
        consume_settled_position(arg0, arg8, arg7, true);
        let v2 = 0x2::object::id<ExecutionReserve>(arg0);
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, arg7), 13906839255291199512);
        debit_contribution(arg0, arg7, arg11);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::emit_inplay_stake_settled(v2, arg7, arg11);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::release_to_holder(arg1, arg2, arg3, v2, arg7, arg12);
        let v3 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg3, v2);
        assert!(arg12 + v3 == 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg3, v2), 13906839276766953510);
        assert_backed(arg0, v3);
        let v4 = ReceiptClaimed{
            reserve_id   : v2,
            execution_id : arg0.execution_id,
            window_id    : arg8,
            holder       : arg7,
            amount       : arg12,
            debited      : arg11,
        };
        0x2::event::emit<ReceiptClaimed>(v4);
    }

    public fun claim_with_receipt_attested(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: &0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::outcome_records::ActionOutcomeRecord, arg6: FrontierCheck, arg7: address, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: RuntimeAuth, arg17: vector<u8>, arg18: vector<u8>) {
        assert!(is_attested(arg0), 13906841858044657738);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_endorsement(arg4, assert_binding_names_reserve(arg4, arg0, arg17), arg18);
        arm_attested_gate(arg0);
        claim_with_receipt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        mark_attested_settled(arg0);
    }

    fun consume_settled_position(arg0: &mut ExecutionReserve, arg1: u64, arg2: address, arg3: bool) {
        let v0 = SettledPosition{
            window_id : arg1,
            holder    : arg2,
        };
        if (arg3) {
            assert!(!0x2::table::contains<SettledPosition, bool>(&arg0.settled_positions, v0), 13906839379847348280);
        } else {
            assert!(!0x2::table::contains<SettledPosition, bool>(&arg0.settled_positions, v0), 13906839388437413946);
        };
        0x2::table::add<SettledPosition, bool>(&mut arg0.settled_positions, v0, true);
    }

    public(friend) fun contribute(arg0: &mut ExecutionReserve, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::EligibilityRegistry, arg5: address, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64) {
        assert!(arg0.status == 0, 13906837103512453142);
        assert!(arg9 > 0, 13906837107807289364);
        let v0 = ContributionKey{
            holder    : arg5,
            window_id : arg6,
            nonce     : arg10,
        };
        assert!(!0x2::table::contains<ContributionKey, bool>(&arg0.contribution_keys, v0), 13906837116399058992);
        0x2::table::add<ContributionKey, bool>(&mut arg0.contribution_keys, v0, true);
        escrow_and_record(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        let v1 = ReserveContributed{
            reserve_id        : 0x2::object::id<ExecutionReserve>(arg0),
            holder            : arg5,
            window_id         : arg6,
            market_id         : arg7,
            outcome_index     : arg8,
            amount            : arg9,
            nonce             : arg10,
            total_contributed : arg0.total_contributed,
        };
        0x2::event::emit<ReserveContributed>(v1);
    }

    public fun create(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinIssuerCap, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: address, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : ExecutionReserve {
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906836334712651788);
        assert!(arg6 > 0, 13906836339007881232);
        assert!(arg6 <= arg7, 13906836343302979602);
        assert!(arg8 > 0, 13906836347599650860);
        let v0 = reserved_execution_reserve(arg1, &arg5);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 13906836360482586638);
        let v1 = 0x2::object::new(arg10);
        let v2 = 0x2::object::uid_to_inner(&v1);
        claim_execution_identity(arg1, &arg5, v2);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::issue_into_escrow(arg0, arg1, arg2, arg3, v2, arg4, arg6, arg9);
        let v3 = ExecutionReserve{
            id                     : v1,
            execution_id           : arg5,
            issuer                 : arg4,
            budget                 : arg6,
            deadline_ms            : arg8,
            status                 : 0,
            contributions          : 0x2::table::new<address, u64>(arg10),
            contribution_keys      : 0x2::table::new<ContributionKey, bool>(arg10),
            swept_keys             : 0x2::table::new<SweptKey, bool>(arg10),
            settle_nonces          : 0x2::table::new<SettleKey, bool>(arg10),
            debit_nonces           : 0x2::table::new<SettleKey, bool>(arg10),
            reconcile_debit_nonces : 0x2::table::new<SettleKey, bool>(arg10),
            settled_positions      : 0x2::table::new<SettledPosition, bool>(arg10),
            contributor_ids        : vector[],
            recorded_stake         : 0,
            total_contributed      : 0,
            contributor_count      : 0,
        };
        let v4 = ReserveCreated{
            reserve_id   : v2,
            execution_id : v3.execution_id,
            budget       : arg6,
            deadline_ms  : arg8,
        };
        0x2::event::emit<ReserveCreated>(v4);
        v3
    }

    public fun create_attested(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinIssuerCap, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: address, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : ExecutionReserve {
        let v0 = create(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = AttestedProfileKey{dummy_field: false};
        0x2::dynamic_field::add<AttestedProfileKey, bool>(&mut v0.id, v1, true);
        v0
    }

    public fun deadline_ms(arg0: &ExecutionReserve) : u64 {
        arg0.deadline_ms
    }

    public fun debit(arg0: address, arg1: u64) : Debit {
        Debit{
            holder : arg0,
            amount : arg1,
        }
    }

    public(friend) fun debit_contribution(arg0: &mut ExecutionReserve, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, arg1), 13906840595321258012);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg1);
        assert!(*v0 >= arg2, 13906840603911323678);
        *v0 = *v0 - arg2;
        arg0.total_contributed = arg0.total_contributed - arg2;
        arg0.recorded_stake = arg0.recorded_stake - arg2;
    }

    fun do_full_refund(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: u8) {
        let v0 = 0x2::object::id<ExecutionReserve>(arg0);
        let v1 = RefundCursorKey{shard: 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::shard_index(arg2)};
        let v2 = 0x1::vector::length<address>(&arg0.contributor_ids);
        let v3 = if (0x2::dynamic_field::exists_with_type<RefundCursorKey, u64>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow<RefundCursorKey, u64>(&arg0.id, v1)
        } else {
            0
        };
        let v4 = v3;
        let v5 = if (v3 + 200 > v2) {
            v2
        } else {
            v3 + 200
        };
        let v6 = 0;
        while (v4 < v5) {
            let v7 = *0x1::vector::borrow<address>(&arg0.contributor_ids, v4);
            v4 = v4 + 1;
            if (!shard_holds(arg2, v7)) {
                continue
            };
            if (0x2::table::contains<address, u64>(&arg0.contributions, v7)) {
                let v8 = *0x2::table::borrow<address, u64>(&arg0.contributions, v7);
                if (v8 > 0) {
                    0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::emit_inplay_stake_settled(v0, v7, v8);
                    0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::release_to_holder(arg1, arg2, arg3, v0, v7, v8);
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, v7) = 0;
                    arg0.recorded_stake = arg0.recorded_stake - v8;
                    v6 = v6 + v8;
                };
            };
        };
        if (0x2::dynamic_field::exists_with_type<RefundCursorKey, u64>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow_mut<RefundCursorKey, u64>(&mut arg0.id, v1) = v4;
        } else if (v4 < v2) {
            0x2::dynamic_field::add<RefundCursorKey, u64>(&mut arg0.id, v1, v4);
        };
        let v9 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg3, v0);
        if (arg0.recorded_stake > 0) {
            let v10 = ReserveRefunded{
                reserve_id   : 0x2::object::id<ExecutionReserve>(arg0),
                execution_id : arg0.execution_id,
                refunded     : v6,
                reclaimed    : 0,
                reason       : arg4,
            };
            0x2::event::emit<ReserveRefunded>(v10);
            return
        };
        let v11 = 0;
        if (v9 > 0) {
            if (!shard_holds(arg2, arg0.issuer)) {
                let v12 = ReserveRefunded{
                    reserve_id   : 0x2::object::id<ExecutionReserve>(arg0),
                    execution_id : arg0.execution_id,
                    refunded     : v6,
                    reclaimed    : 0,
                    reason       : arg4,
                };
                0x2::event::emit<ReserveRefunded>(v12);
                return
            };
            0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::release_to_holder(arg1, arg2, arg3, v0, arg0.issuer, v9);
            v11 = v9;
        };
        let v13 = if (arg4 == 1) {
            3
        } else {
            2
        };
        arg0.status = v13;
        let v14 = ReserveRefunded{
            reserve_id   : 0x2::object::id<ExecutionReserve>(arg0),
            execution_id : arg0.execution_id,
            refunded     : v6,
            reclaimed    : v11,
            reason       : arg4,
        };
        0x2::event::emit<ReserveRefunded>(v14);
    }

    fun escrow_and_record(arg0: &mut ExecutionReserve, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::EligibilityRegistry, arg5: address, arg6: u64) {
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_contribution(arg1, arg2, arg3, arg4, 0x2::object::id<ExecutionReserve>(arg0), arg5, arg6);
        if (0x2::table::contains<address, u64>(&arg0.contributions, arg5)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg5);
            if (*v0 == 0) {
                0x1::vector::push_back<address>(&mut arg0.contributor_ids, arg5);
                arg0.contributor_count = arg0.contributor_count + 1;
            };
            *v0 = *v0 + arg6;
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributions, arg5, arg6);
            0x1::vector::push_back<address>(&mut arg0.contributor_ids, arg5);
            arg0.contributor_count = arg0.contributor_count + 1;
        };
        arg0.total_contributed = arg0.total_contributed + arg6;
        arg0.recorded_stake = arg0.recorded_stake + arg6;
    }

    public fun execution_id(arg0: &ExecutionReserve) : vector<u8> {
        arg0.execution_id
    }

    public fun frontier_check(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>) : FrontierCheck {
        FrontierCheck{
            market_id                 : arg0,
            window_id                 : arg1,
            selection_anchor_revision : arg2,
            expected_frontier_digest  : arg3,
        }
    }

    fun full_refund_authorized(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &vector<u8>, arg7: u8) {
        if (arg0.status != 0) {
            return
        };
        assert_not_attested(arg0);
        verify_admitted_auth(arg4, arg0.execution_id, arg6, &arg5);
        do_full_refund(arg0, arg1, arg2, arg3, arg7);
    }

    public(friend) fun holds_contribution(arg0: &ExecutionReserve, arg1: address, arg2: u64) : bool {
        0x2::table::contains<address, u64>(&arg0.contributions, arg1) && *0x2::table::borrow<address, u64>(&arg0.contributions, arg1) >= arg2
    }

    public(friend) fun is_attested(arg0: &ExecutionReserve) : bool {
        let v0 = AttestedProfileKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<AttestedProfileKey, bool>(&arg0.id, v0)
    }

    public(friend) fun issuer(arg0: &ExecutionReserve) : address {
        arg0.issuer
    }

    fun mark_attested_settled(arg0: &mut ExecutionReserve) {
        let v0 = AttestedSettlementKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<AttestedSettlementKey, bool>(&arg0.id, v0)) {
            let v1 = AttestedSettlementKey{dummy_field: false};
            0x2::dynamic_field::add<AttestedSettlementKey, bool>(&mut arg0.id, v1, true);
        };
    }

    public(friend) fun outstanding_execution_credit(arg0: &ExecutionReserve) : u64 {
        let v0 = OutstandingCreditKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<OutstandingCreditKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<OutstandingCreditKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun payout(arg0: u64, arg1: address, arg2: u64) : Payout {
        Payout{
            window_id : arg0,
            holder    : arg1,
            amount    : arg2,
        }
    }

    public(friend) fun reason_frontier() : u8 {
        2
    }

    public(friend) fun reason_invalidated() : u8 {
        0
    }

    public(friend) fun reason_timeout() : u8 {
        1
    }

    public fun reconcile(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: RuntimeAuth) {
        assert_open(arg0);
        assert_not_attested(arg0);
        assert_frontiers_match(arg4, &arg0.execution_id, arg5);
        let v0 = reconcile_message(&arg0.execution_id, arg9.runtime_generation, arg8, &arg6, &arg7);
        verify_admitted_auth(arg4, arg0.execution_id, &v0, &arg9);
        reconcile_payouts(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
    }

    public fun reconcile_attested(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: RuntimeAuth, arg10: vector<u8>, arg11: vector<u8>) {
        assert!(is_attested(arg0), 13906842042728251466);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_endorsement(arg4, assert_binding_names_reserve(arg4, arg0, arg10), arg11);
        arm_attested_gate(arg0);
        reconcile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        mark_attested_settled(arg0);
    }

    public fun reconcile_by_issuer(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinIssuerCap, arg1: &mut ExecutionReserve, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg4: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg5: u64, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64) {
        assert_open(arg1);
        assert_not_attested(arg1);
        assert!(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::issuer_cap_ledger_id(arg0) == 0x2::object::id<0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger>(arg2), 13906837919557812270);
        assert!(arg1.total_contributed == arg5, 13906837923853041714);
        reconcile_payouts(arg1, arg2, arg3, arg4, arg6, arg7, arg8);
    }

    public fun reconcile_by_issuer_attested(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinIssuerCap, arg1: &mut ExecutionReserve, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg4: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg5: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg6: u64, arg7: vector<Payout>, arg8: vector<Debit>, arg9: u64, arg10: vector<u8>, arg11: vector<u8>) {
        assert!(is_attested(arg1), 13906841531627143242);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_endorsement(arg5, assert_binding_names_reserve(arg5, arg1, arg10), arg11);
        arm_attested_gate(arg1);
        reconcile_by_issuer(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        mark_attested_settled(arg1);
    }

    public(friend) fun reconcile_message(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: &vector<Payout>, arg4: &vector<Debit>) : vector<u8> {
        let v0 = b"dopan718/reserve-reconcile/v3";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        let v1 = &mut v0;
        append_payout_lines(v1, arg3);
        let v2 = &mut v0;
        append_debit_lines(v2, arg4);
        v0
    }

    fun reconcile_payouts(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: vector<Payout>, arg5: vector<Debit>, arg6: u64) {
        let v0 = 0x2::object::id<ExecutionReserve>(arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<Payout>(&arg4);
        abort_if_duplicate_payouts(&arg4);
        let v4 = 0;
        while (v4 < 0x1::vector::length<Debit>(&arg5)) {
            let v5 = 0x1::vector::borrow<Debit>(&arg5, v4);
            if (v5.amount > 0) {
                let v6 = SettleKey{
                    holder : v5.holder,
                    nonce  : arg6,
                };
                if (!0x2::table::contains<SettleKey, bool>(&arg0.reconcile_debit_nonces, v6)) {
                    debit_contribution(arg0, v5.holder, v5.amount);
                    0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::emit_inplay_stake_settled(0x2::object::id<ExecutionReserve>(arg0), v5.holder, v5.amount);
                    0x2::table::add<SettleKey, bool>(&mut arg0.reconcile_debit_nonces, v6, true);
                };
            };
            v4 = v4 + 1;
        };
        while (v2 < v3) {
            let v7 = 0x1::vector::borrow<Payout>(&arg4, v2);
            if (v7.amount > 0) {
                assert!(0x2::table::contains<address, u64>(&arg0.contributions, v7.holder), 13906838134304735256);
                if (!shard_holds(arg2, v7.holder)) {
                    /* goto 18 */
                } else {
                    consume_settled_position(arg0, v7.window_id, v7.holder, false);
                    0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::release_to_holder(arg1, arg2, arg3, v0, v7.holder, v7.amount);
                    v1 = v1 + v7.amount;
                };
            };
            v2 = v2 + 1;
            continue;
            /* label 18 */
            v2 = v2 + 1;
        };
        let v8 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg3, v0);
        assert!(v1 + v8 == 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg3, v0), 13906838194435194918);
        assert_backed(arg0, v8);
        let v9 = false;
        let v10 = 0;
        while (v10 < v3) {
            let v11 = 0x1::vector::borrow<Payout>(&arg4, v10);
            if (v11.amount > 0) {
                let v12 = SettledPosition{
                    window_id : v11.window_id,
                    holder    : v11.holder,
                };
                if (!0x2::table::contains<SettledPosition, bool>(&arg0.settled_positions, v12)) {
                    v9 = true;
                    break
                };
            };
            v10 = v10 + 1;
        };
        if (v9) {
            return
        };
        assert!(arg0.recorded_stake == 0, 13906838297514147874);
        let v13 = 0;
        if (v8 > 0) {
            if (!shard_holds(arg2, arg0.issuer)) {
                return
            };
            0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::release_to_holder(arg1, arg2, arg3, v0, arg0.issuer, v8);
            v13 = v8;
        };
        let v14 = 0;
        let v15 = 0;
        while (v15 < v3) {
            let v16 = 0x1::vector::borrow<Payout>(&arg4, v15);
            if (v16.amount > 0) {
                v14 = v14 + v16.amount;
            };
            v15 = v15 + 1;
        };
        arg0.status = 1;
        let v17 = ReserveReconciled{
            reserve_id   : 0x2::object::id<ExecutionReserve>(arg0),
            execution_id : arg0.execution_id,
            paid         : v14,
            reclaimed    : v13,
        };
        0x2::event::emit<ReserveReconciled>(v17);
    }

    public(friend) fun record_domain_contribution(arg0: &mut ExecutionReserve, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::EligibilityRegistry, arg5: address, arg6: u64) {
        assert!(arg0.status == 0, 13906840999047790614);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_contribution_for_domain(arg1, arg2, arg3, arg4, 0x2::object::id<ExecutionReserve>(arg0), arg5, arg6);
        if (0x2::table::contains<address, u64>(&arg0.contributions, arg5)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg5);
            if (*v0 == 0) {
                0x1::vector::push_back<address>(&mut arg0.contributor_ids, arg5);
                arg0.contributor_count = arg0.contributor_count + 1;
            };
            *v0 = *v0 + arg6;
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributions, arg5, arg6);
            0x1::vector::push_back<address>(&mut arg0.contributor_ids, arg5);
            arg0.contributor_count = arg0.contributor_count + 1;
        };
        arg0.total_contributed = arg0.total_contributed + arg6;
        arg0.recorded_stake = arg0.recorded_stake + arg6;
    }

    public(friend) fun record_domain_credit_contribution(arg0: &mut ExecutionReserve, arg1: address, arg2: u64) {
        assert!(arg0.status == 0, 13906841157961580566);
        let v0 = outstanding_execution_credit(arg0);
        assert!(v0 >= arg2, 13906841166555054156);
        set_outstanding_execution_credit(arg0, v0 - arg2);
        if (0x2::table::contains<address, u64>(&arg0.contributions, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg1);
            if (*v1 == 0) {
                0x1::vector::push_back<address>(&mut arg0.contributor_ids, arg1);
                arg0.contributor_count = arg0.contributor_count + 1;
            };
            *v1 = *v1 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributions, arg1, arg2);
            0x1::vector::push_back<address>(&mut arg0.contributor_ids, arg1);
            arg0.contributor_count = arg0.contributor_count + 1;
        };
        arg0.total_contributed = arg0.total_contributed + arg2;
        arg0.recorded_stake = arg0.recorded_stake + arg2;
    }

    fun refund_all_authorized(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: u8) {
        let v0 = refund_message(&arg0.execution_id, arg5.runtime_generation, arg6);
        full_refund_authorized(arg0, arg1, arg2, arg3, arg4, arg5, &v0, arg6);
    }

    fun refund_attested(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: vector<u8>, arg7: u8) {
        assert!(is_attested(arg0), 13906842291836354634);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_cancelled(arg4, assert_binding_names_reserve(arg4, arg0, arg6));
        arm_attested_gate(arg0);
        refund_all_authorized(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        mark_attested_settled(arg0);
    }

    public fun refund_for_frontier(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth) {
        refund_all_authorized(arg0, arg1, arg2, arg3, arg4, arg5, 2);
    }

    public fun refund_for_frontier_attested(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: vector<u8>) {
        refund_attested(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 2);
    }

    public fun refund_invalidated(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth) {
        refund_all_authorized(arg0, arg1, arg2, arg3, arg4, arg5, 0);
    }

    public fun refund_invalidated_attested(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: vector<u8>) {
        refund_attested(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0);
    }

    public(friend) fun refund_message(arg0: &vector<u8>, arg1: u64, arg2: u8) : vector<u8> {
        let v0 = b"dopan718/reserve-refund/v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        v0
    }

    public fun release_frontierless_attested(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: vector<u8>, arg7: u64, arg8: vector<u8>) {
        assert!(arg0.status == 0, 13906842566710853654);
        assert!(is_attested(arg0), 13906842571009228874);
        assert!(0x1::vector::length<u8>(&arg8) == 32, 13906842588189753428);
        let v0 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::decode_binding(arg6);
        assert!(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_window_id(&v0) == arg7, 13906842601074524242);
        assert!(!store_holds_frontier_commitment(arg4, arg0, arg6), 13906842613959295056);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_endorsement(arg4, assert_binding_names_reserve(arg4, arg0, arg6), arg8);
        let v1 = release_message(&arg0.execution_id, arg5.runtime_generation, arg7, &arg8);
        arm_attested_gate(arg0);
        full_refund_authorized(arg0, arg1, arg2, arg3, arg4, arg5, &v1, 3);
        mark_attested_settled(arg0);
    }

    public(friend) fun release_message(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: &vector<u8>) : vector<u8> {
        let v0 = b"dopan718/reserve-release/v1";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::append<u8>(&mut v0, *arg3);
        v0
    }

    public(friend) fun reserve_execution_credit(arg0: &mut ExecutionReserve, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg3: u64) {
        assert!(arg0.status == 0, 13906841338350206998);
        assert!(arg3 > 0, 13906841342645043220);
        let v0 = outstanding_execution_credit(arg0) + arg3;
        assert!(arg0.total_contributed + v0 <= 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg2, 0x2::object::id<ExecutionReserve>(arg0)), 13906841355533615180);
        set_outstanding_execution_credit(arg0, v0);
    }

    public fun reserved_execution_reserve(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg1: &vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = ExecutionReserveKey{execution_id: *arg1};
        if (0x2::dynamic_field::exists_with_type<ExecutionReserveKey, 0x2::object::ID>(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::uid(arg0), v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<ExecutionReserveKey, 0x2::object::ID>(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::uid(arg0), v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun runtime_auth(arg0: u64, arg1: u8, arg2: vector<u8>, arg3: vector<u8>) : RuntimeAuth {
        assert!(0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::signature::is_valid_signature_type(arg1), 13906837490060820522);
        RuntimeAuth{
            runtime_generation : arg0,
            signature_type     : arg1,
            public_key         : arg2,
            signature          : arg3,
        }
    }

    public fun runtime_generation(arg0: &RuntimeAuth) : u64 {
        arg0.runtime_generation
    }

    fun set_outstanding_execution_credit(arg0: &mut ExecutionReserve, arg1: u64) {
        let v0 = OutstandingCreditKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<OutstandingCreditKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<OutstandingCreditKey, u64>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<OutstandingCreditKey, u64>(&mut arg0.id, v0, arg1);
        };
    }

    public(friend) fun settle_message(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: &vector<Payout>, arg5: &vector<Debit>) : vector<u8> {
        let v0 = b"dopamint-arena::inplay::reserve-settle::v2";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let v1 = &mut v0;
        append_payout_lines(v1, arg4);
        let v2 = &mut v0;
        append_debit_lines(v2, arg5);
        v0
    }

    public fun settle_resolved_windows(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: RuntimeAuth) {
        assert_open(arg0);
        assert_not_attested(arg0);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 13906838525146890266);
        assert_frontiers_match(arg4, &arg0.execution_id, arg5);
        let v0 = settle_message(&arg0.execution_id, arg11.runtime_generation, arg8, arg9, &arg6, &arg7);
        verify_admitted_auth(arg4, arg0.execution_id, &v0, &arg11);
        let v1 = 0x2::object::id<ExecutionReserve>(arg0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::length<Payout>(&arg6);
        abort_if_duplicate_payouts(&arg6);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = 0x1::vector::borrow<Payout>(&arg6, v5);
            if (v6.amount > 0 && shard_holds(arg2, v6.holder)) {
                assert!(0x2::table::contains<address, u64>(&arg0.contributions, v6.holder), 13906838675470614552);
                let v7 = SettleKey{
                    holder : v6.holder,
                    nonce  : arg8,
                };
                assert!(!0x2::table::contains<SettleKey, bool>(&arg0.settle_nonces, v7), 13906838684062515254);
                let v8 = SettledPosition{
                    window_id : v6.window_id,
                    holder    : v6.holder,
                };
                assert!(!0x2::table::contains<SettledPosition, bool>(&arg0.settled_positions, v8), 13906838692652711994);
            };
            v5 = v5 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<Debit>(&arg7)) {
            let v10 = 0x1::vector::borrow<Debit>(&arg7, v9);
            if (v10.amount > 0) {
                let v11 = SettleKey{
                    holder : v10.holder,
                    nonce  : arg8,
                };
                if (!0x2::table::contains<SettleKey, bool>(&arg0.debit_nonces, v11)) {
                    debit_contribution(arg0, v10.holder, v10.amount);
                    0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::emit_inplay_stake_settled(0x2::object::id<ExecutionReserve>(arg0), v10.holder, v10.amount);
                    0x2::table::add<SettleKey, bool>(&mut arg0.debit_nonces, v11, true);
                };
            };
            v9 = v9 + 1;
        };
        while (v3 < v4) {
            let v12 = 0x1::vector::borrow<Payout>(&arg6, v3);
            if (v12.amount > 0 && shard_holds(arg2, v12.holder)) {
                assert!(0x2::table::contains<address, u64>(&arg0.contributions, v12.holder), 13906838791434731544);
                let v13 = SettleKey{
                    holder : v12.holder,
                    nonce  : arg8,
                };
                assert!(!0x2::table::contains<SettleKey, bool>(&arg0.settle_nonces, v13), 13906838800026632246);
                0x2::table::add<SettleKey, bool>(&mut arg0.settle_nonces, v13, true);
                consume_settled_position(arg0, v12.window_id, v12.holder, false);
                0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::release_to_holder(arg1, arg2, arg3, v1, v12.holder, v12.amount);
                v2 = v2 + v12.amount;
                let v14 = WindowsSettled{
                    reserve_id   : v1,
                    execution_id : arg0.execution_id,
                    holder       : v12.holder,
                    amount       : v12.amount,
                    settle_nonce : arg8,
                };
                0x2::event::emit<WindowsSettled>(v14);
            };
            v3 = v3 + 1;
        };
        let v15 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg3, v1);
        assert!(v2 + v15 == 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg3, v1), 13906838873040027686);
        assert_backed(arg0, v15);
    }

    public fun settle_resolved_windows_attested(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: RuntimeAuth, arg12: vector<u8>, arg13: vector<u8>) {
        assert!(is_attested(arg0), 13906841677656031306);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_endorsement(arg4, assert_binding_names_reserve(arg4, arg0, arg12), arg13);
        arm_attested_gate(arg0);
        settle_resolved_windows(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        mark_attested_settled(arg0);
    }

    fun shard_holds(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg1: address) : bool {
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::holder_shard_index(arg1) == (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::shard_index(arg0) as u64)
    }

    public fun share(arg0: ExecutionReserve) {
        0x2::transfer::share_object<ExecutionReserve>(arg0);
    }

    public fun status(arg0: &ExecutionReserve) : u8 {
        arg0.status
    }

    public(friend) fun status_open() : u8 {
        0
    }

    public(friend) fun status_reconciled() : u8 {
        1
    }

    public(friend) fun status_refunded() : u8 {
        2
    }

    public(friend) fun status_timed_out() : u8 {
        3
    }

    fun store_holds_frontier_commitment(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg1: &ExecutionReserve, arg2: vector<u8>) : bool {
        let v0 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::decode_binding(arg2);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::has_commitment(arg0, arg1.execution_id, 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::intake_receipt::u64_identity(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_market_local_id(&v0)), 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::intake_receipt::u64_identity(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_window_id(&v0)), 0)
    }

    public(friend) fun sweep_message(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: &vector<address>, arg5: &vector<u64>) : vector<u8> {
        let v0 = b"dopamint-arena::inplay::reserve-sweep::v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let v1 = 0x1::vector::length<address>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(0x1::vector::borrow<address>(arg4, v2)));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(0x1::vector::borrow<u64>(arg5, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun sweep_window(arg0: &mut ExecutionReserve, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::EligibilityRegistry, arg5: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg6: u64, arg7: vector<address>, arg8: vector<u64>, arg9: u64, arg10: RuntimeAuth) {
        assert!(arg0.status == 0, 13906836785684873238);
        assert!(0x1::vector::length<address>(&arg7) == 0x1::vector::length<u64>(&arg8), 13906836789981806644);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg7)) {
            0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::assert_not_enrolled(arg1, *0x1::vector::borrow<address>(&arg7, v0));
            v0 = v0 + 1;
        };
        let v1 = sweep_message(&arg0.execution_id, arg10.runtime_generation, arg6, arg9, &arg7, &arg8);
        verify_admitted_auth(arg5, arg0.execution_id, &v1, &arg10);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg7)) {
            let v3 = *0x1::vector::borrow<address>(&arg7, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg8, v2);
            v2 = v2 + 1;
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::is_enrolled(arg1, v3)) {
                0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::assert_not_enrolled(arg1, v3);
            };
            if (v4 == 0 || v4 > arg9) {
                continue
            };
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::is_excluded(arg4, v3)) {
                continue
            };
            if (!shard_holds(arg2, v3)) {
                continue
            };
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::balance_of(arg2, v3) < v4) {
                continue
            };
            let v5 = SweptKey{
                window_id : arg6,
                holder    : v3,
            };
            if (0x2::table::contains<SweptKey, bool>(&arg0.swept_keys, v5)) {
                continue
            };
            0x2::table::add<SweptKey, bool>(&mut arg0.swept_keys, v5, true);
            escrow_and_record(arg0, arg1, arg2, arg3, arg4, v3, v4);
            let v6 = ReserveSwept{
                reserve_id        : 0x2::object::id<ExecutionReserve>(arg0),
                holder            : v3,
                window_id         : arg6,
                amount            : v4,
                total_contributed : arg0.total_contributed,
            };
            0x2::event::emit<ReserveSwept>(v6);
            0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::emit_inplay_stake_opened(0x2::object::id<ExecutionReserve>(arg0), v3, v4);
        };
    }

    public fun timeout(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0x2::clock::Clock) {
        if (arg0.status != 0) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.deadline_ms, 13906839736328585256);
        assert!(!is_attested(arg0), 13906839740625780810);
        do_full_refund(arg0, arg1, arg2, arg3, 1);
    }

    public fun timeout_attested(arg0: &mut ExecutionReserve, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        if (arg0.status != 0) {
            return
        };
        assert!(is_attested(arg0), 13906839830820094026);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg0.deadline_ms, 13906839835112833064);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_cancelled(arg4, assert_binding_names_reserve(arg4, arg0, arg5));
        do_full_refund(arg0, arg1, arg2, arg3, 1);
    }

    public(friend) fun total_contributed(arg0: &ExecutionReserve) : u64 {
        arg0.total_contributed
    }

    public(friend) fun verify_admitted_auth(arg0: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>, arg2: &vector<u8>, arg3: &RuntimeAuth) {
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::verify_admitted_runtime_signature(arg0, arg1, arg3.runtime_generation, arg3.signature_type, arg3.public_key, arg2, &arg3.signature);
    }

    // decompiled from Move bytecode v7
}

