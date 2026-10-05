module 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::reserve {
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

    struct RefundedWindowKey has copy, drop, store {
        window_id: u64,
    }

    struct AttestedWindowKey has copy, drop, store {
        window_id: u64,
    }

    struct ExecutionReserve has key {
        id: 0x2::object::UID,
        execution_id: vector<u8>,
        tunnel_id: 0x2::object::ID,
        frontier_store_id: 0x2::object::ID,
        issuer: address,
        budget: u64,
        deadline_ms: u64,
        status: u8,
        module_version: u64,
        contributions: 0x2::table::Table<address, u64>,
        contribution_keys: 0x2::table::Table<ContributionKey, bool>,
        swept_keys: 0x2::table::Table<SweptKey, bool>,
        settle_nonces: 0x2::table::Table<SettleKey, bool>,
        debit_nonces: 0x2::table::Table<SettleKey, bool>,
        reconcile_debit_nonces: 0x2::table::Table<SettleKey, bool>,
        settled_positions: 0x2::table::Table<SettledPosition, bool>,
        refunded_windows: 0x2::table::Table<RefundedWindowKey, bool>,
        refunding_windows: 0x2::table::Table<RefundedWindowKey, bool>,
        leg_paid: 0x2::table::Table<SettledPosition, bool>,
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

    public(friend) fun assert_admitted_version(arg0: &ExecutionReserve) {
        assert!(is_admitted_version(arg0), 13906836901653708894);
    }

    public fun discharge_execution_credit(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg7: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg8: &0x2::clock::Clock) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg7);
        assert_store_is_canonical(arg0, arg7);
        assert_registry_is_canonical(arg7, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg6));
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::verify_wallet_envelope(arg7, arg1, arg6, arg8, arg3, 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::record_digest(b"dopa_predict::credit_discharge_v1", credit_discharge_message(&arg0.execution_id, arg3)), arg4, arg5);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::execution_credit(arg2, arg3, arg0.execution_id) > 0, 13906844237457195092);
        let v0 = outstanding_execution_credit(arg0);
        let v1 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::discharge_execution_credit(arg2, arg3, arg0.execution_id, 18446744073709551615);
        if (arg0.status == 0) {
            let v2 = if (v1 > v0) {
                0
            } else {
                v0 - v1
            };
            set_outstanding_execution_credit(arg0, v2);
        };
    }

    public(friend) fun frontier_store_id(arg0: &ExecutionReserve) : 0x2::object::ID {
        arg0.frontier_store_id
    }

    public(friend) fun uid(arg0: &ExecutionReserve) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut ExecutionReserve) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun abort_if_duplicate_payouts(arg0: &vector<Payout>) {
        let v0 = 0x2::vec_set::empty<SettledPosition>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Payout>(arg0)) {
            let v2 = 0x1::vector::borrow<Payout>(arg0, v1);
            let v3 = SettledPosition{
                window_id : v2.window_id,
                holder    : v2.holder,
            };
            assert!(!0x2::vec_set::contains<SettledPosition>(&v0, &v3), 13906848090042466382);
            0x2::vec_set::insert<SettledPosition>(&mut v0, v3);
            v1 = v1 + 1;
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
        assert!(arg0.recorded_stake <= arg1, 13906844550986661924);
    }

    fun assert_binding_names_reserve(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: &ExecutionReserve, arg2: vector<u8>) : vector<u8> {
        let v0 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::decode_binding(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::assert_deployment_identity(arg0, 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_chain_id(&v0), 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_environment_id(&v0), 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_package_id(&v0));
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_execution_id(&v0) == arg1.execution_id, 13906844722788630614);
        let v1 = 0x2::object::id<ExecutionReserve>(arg1);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_reserve_id(&v0) == 0x2::object::id_to_bytes(&v1), 13906844739968499798);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_digest(arg2)
    }

    fun assert_frontiers_match(arg0: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: &vector<u8>, arg2: &vector<FrontierCheck>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FrontierCheck>(arg2)) {
            let v1 = 0x1::vector::borrow<FrontierCheck>(arg2, v0);
            assert!(!0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::requires_refund(arg0, *arg1, v1.market_id, v1.window_id, v1.selection_anchor_revision, v1.expected_frontier_digest), 13906847961190957096);
            0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::consume_for_reconciliation(arg0, *arg1, v1.market_id, v1.window_id, v1.selection_anchor_revision, v1.expected_frontier_digest);
            v0 = v0 + 1;
        };
    }

    fun assert_not_attested(arg0: &mut ExecutionReserve) {
        if (is_attested(arg0)) {
            let v0 = AttestedGatePermit{dummy_field: false};
            assert!(0x2::dynamic_field::exists_with_type<AttestedGatePermit, bool>(&arg0.id, v0), 13906844585349283920);
            0x2::dynamic_field::remove<AttestedGatePermit, bool>(&mut arg0.id, v0);
        };
    }

    public(friend) fun assert_not_attested_reserve(arg0: &ExecutionReserve) {
        assert!(!is_attested(arg0), 13906843876680990820);
    }

    public(friend) fun assert_open(arg0: &ExecutionReserve) {
        assert!(arg0.status == 0, 13906844353417510938);
    }

    public(friend) fun assert_registry_is_canonical(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: 0x2::object::ID) {
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::attestation_registry_id(arg0) == arg1, 13906843842321383526);
    }

    fun assert_settle_row_is_payable(arg0: &ExecutionReserve, arg1: SettleKey, arg2: SettledPosition) {
        if (0x2::table::contains<SettleKey, bool>(&arg0.settle_nonces, arg1) && 0x2::table::contains<SettledPosition, bool>(&arg0.settled_positions, arg2)) {
            return
        };
        assert!(!0x2::table::contains<SettleKey, bool>(&arg0.settle_nonces, arg1), 13906842004072497210);
        assert!(!0x2::table::contains<SettledPosition, bool>(&arg0.settled_positions, arg2), 13906842008367726654);
    }

    public(friend) fun assert_store_is_canonical(arg0: &ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore) {
        assert!(arg0.frontier_store_id == 0x2::object::id<0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore>(arg1), 13906843812256219232);
    }

    public(friend) fun budget(arg0: &ExecutionReserve) : u64 {
        arg0.budget
    }

    public(friend) fun canonical_store_binding(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger) : 0x2::object::ID {
        let v0 = 0x2::object::id_from_address(@0x0);
        let v1 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::frontier_store_id(arg0);
        let v2 = if (v1 != v0) {
            v1
        } else {
            0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::local_frontier_store_id(arg0)
        };
        assert!(v2 != v0, 13906843756421644384);
        v2
    }

    fun claim_execution_identity(arg0: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg1: &vector<u8>, arg2: 0x2::object::ID) {
        let v0 = ExecutionReserveKey{execution_id: *arg1};
        0x2::dynamic_field::add<ExecutionReserveKey, 0x2::object::ID>(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::uid_mut(arg0), v0, arg2);
    }

    public fun claim_with_receipt(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::outcome_records::ActionOutcomeRecord, arg6: FrontierCheck, arg7: address, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: RuntimeAuth) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert!(arg0.status == 0, 13906841462904520730);
        assert_not_attested(arg0);
        assert_store_is_canonical(arg0, arg4);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::outcome_records::action_record_tunnel_id(arg5) == arg0.tunnel_id, 13906841484384075874);
        assert!(arg12 > 0, 13906841492972437578);
        assert!(arg11 > 0, 13906841497264128024);
        assert!(arg12 <= arg11 * 100, 13906841531627274316);
        let v0 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::intake_receipt::accept_message(arg7, &arg0.execution_id, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16.runtime_generation);
        verify_receipt_auth(arg4, arg0.execution_id, &v0, &arg16);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::outcome_records::action_record_execution_id(arg5) == arg0.execution_id, 13906841634705702976);
        assert!(arg6.market_id == 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::intake_receipt::u64_identity(arg9) && arg6.window_id == 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::intake_receipt::u64_identity(arg8), 13906841651885703234);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::verify_frontier_status(arg4, arg0.execution_id, arg6.market_id, arg6.window_id, arg6.selection_anchor_revision, arg6.expected_frontier_digest) == 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::verify_match(), 13906841694835507268);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::outcome_records::action_record_previous_state_commitment(arg5) == arg6.expected_frontier_digest, 13906841712015507526);
        let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::outcome_records::action_record_outcome(arg5);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::action_outcome::decode_outcome_index(&v1) == arg10, 13906841737785442376);
        consume_settled_position(arg0, arg8, arg7, true);
        let v2 = 0x2::object::id<ExecutionReserve>(arg0);
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, arg7), 13906841763552362524);
        debit_contribution(arg0, arg7, arg11);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::emit_inplay_stake_settled(v2, arg7, arg11);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::release_to_holder(arg1, arg2, arg3, v2, arg7, arg12);
        let v3 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_account_balance(arg3, v2);
        assert!(arg12 + v3 == 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_account_balance(arg3, v2), 13906841785028116522);
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

    public fun claim_with_receipt_attested(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::outcome_records::ActionOutcomeRecord, arg6: FrontierCheck, arg7: address, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: RuntimeAuth, arg17: vector<u8>, arg18: vector<u8>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert!(is_attested(arg0), 13906845787940126800);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::terminal_gate::require_endorsement(arg4, arg0.frontier_store_id, assert_binding_names_reserve(arg4, arg0, arg17), arg18);
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
            assert!(!0x2::table::contains<SettledPosition, bool>(&arg0.settled_positions, v0), 13906842055612235836);
        } else {
            assert!(!0x2::table::contains<SettledPosition, bool>(&arg0.settled_positions, v0), 13906842064202301502);
        };
        0x2::table::add<SettledPosition, bool>(&mut arg0.settled_positions, v0, true);
    }

    public(friend) fun contribute(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::eligibility::EligibilityRegistry, arg5: address, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64) {
        assert!(arg0.status == 0, 13906838550916694042);
        assert!(arg9 > 0, 13906838555211530264);
        let v0 = ContributionKey{
            holder    : arg5,
            window_id : arg6,
            nonce     : arg10,
        };
        assert!(!0x2::table::contains<ContributionKey, bool>(&arg0.contribution_keys, v0), 13906838563803299892);
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

    public fun create(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinIssuerCap, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: address, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<ExecutionReserve>(new_reserve(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun create_attested(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinIssuerCap, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: address, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = new_reserve(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = AttestedProfileKey{dummy_field: false};
        0x2::dynamic_field::add<AttestedProfileKey, bool>(&mut v0.id, v1, true);
        0x2::transfer::share_object<ExecutionReserve>(v0);
    }

    public fun credit_discharge_domain() : vector<u8> {
        b"dopa_predict::credit_discharge_v1"
    }

    public fun credit_discharge_message(arg0: &vector<u8>, arg1: address) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        v0
    }

    public fun current_module_version() : u64 {
        2
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
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, arg1), 13906844443612217376);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg1);
        assert!(*v0 >= arg2, 13906844452202283042);
        *v0 = *v0 - arg2;
        arg0.total_contributed = arg0.total_contributed - arg2;
        arg0.recorded_stake = arg0.recorded_stake - arg2;
    }

    fun discharge_holder_credit(arg0: &mut ExecutionReserve, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg2: address) {
        if (0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::execution_credit(arg1, arg2, arg0.execution_id) == 0) {
            return
        };
        let v0 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::discharge_execution_credit(arg1, arg2, arg0.execution_id, 18446744073709551615);
        if (v0 > 0) {
            let v1 = outstanding_execution_credit(arg0);
            let v2 = if (v0 > v1) {
                0
            } else {
                v1 - v0
            };
            set_outstanding_execution_credit(arg0, v2);
        };
    }

    fun do_full_refund(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: u8) {
        let v0 = 0x2::object::id<ExecutionReserve>(arg0);
        let v1 = RefundCursorKey{shard: 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::shard_index(arg2)};
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
                    0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::emit_inplay_stake_settled(v0, v7, v8);
                    0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::release_to_holder(arg1, arg2, arg3, v0, v7, v8);
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, v7) = 0;
                    arg0.recorded_stake = arg0.recorded_stake - v8;
                    v6 = v6 + v8;
                };
            };
            discharge_holder_credit(arg0, arg2, v7);
        };
        if (0x2::dynamic_field::exists_with_type<RefundCursorKey, u64>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow_mut<RefundCursorKey, u64>(&mut arg0.id, v1) = v4;
        } else if (v4 < v2) {
            0x2::dynamic_field::add<RefundCursorKey, u64>(&mut arg0.id, v1, v4);
        };
        let v9 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_account_balance(arg3, v0);
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
            0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::release_to_holder(arg1, arg2, arg3, v0, arg0.issuer, v9);
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

    fun escrow_and_record(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::eligibility::EligibilityRegistry, arg5: address, arg6: u64) {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_contribution(arg1, arg2, arg3, arg4, 0x2::object::id<ExecutionReserve>(arg0), arg5, arg6);
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

    fun full_refund_authorized(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &vector<u8>, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        if (arg0.status != 0) {
            return
        };
        assert_not_attested(arg0);
        assert_store_is_canonical(arg0, arg4);
        verify_admitted_auth(arg4, arg9, arg8, arg0.execution_id, arg6, &arg5);
        do_full_refund(arg0, arg1, arg2, arg3, arg7);
    }

    fun full_refund_authorized_local(arg0: &mut ExecutionReserve, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &vector<u8>, arg7: u8, arg8: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        if (arg0.status != 0) {
            return
        };
        assert_not_attested(arg0);
        assert_store_is_canonical(arg0, arg4);
        verify_admitted_auth_local(arg4, arg8, arg0.execution_id, arg6, &arg5);
        do_full_refund(arg0, arg1, arg2, arg3, arg7);
    }

    public(friend) fun holds_contribution(arg0: &ExecutionReserve, arg1: address, arg2: u64) : bool {
        0x2::table::contains<address, u64>(&arg0.contributions, arg1) && *0x2::table::borrow<address, u64>(&arg0.contributions, arg1) >= arg2
    }

    public fun is_admitted_version(arg0: &ExecutionReserve) : bool {
        version_is_admitted(2, arg0.module_version)
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

    public fun migrate_version(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinIssuerCap) : u64 {
        if (arg0.module_version == 2) {
            return 2
        };
        assert!(arg0.module_version < 2, 13906836983258087518);
        arg0.module_version = 2;
        2
    }

    public fun module_version(arg0: &ExecutionReserve) : u64 {
        arg0.module_version
    }

    fun new_reserve(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinIssuerCap, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: address, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : ExecutionReserve {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906837515828920336);
        assert!(arg7 > 0, 13906837520124149780);
        assert!(arg7 <= arg8, 13906837524419248150);
        assert!(arg9 > 0, 13906837528715919408);
        let v0 = reserved_execution_reserve(arg1, &arg5);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 13906837541598855186);
        let v1 = canonical_store_binding(arg1);
        let v2 = 0x2::object::new(arg11);
        let v3 = 0x2::object::uid_to_inner(&v2);
        claim_execution_identity(arg1, &arg5, v3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::issue_into_escrow(arg0, arg1, arg2, arg3, v3, arg4, arg7, arg10);
        let v4 = ExecutionReserve{
            id                     : v2,
            execution_id           : arg5,
            tunnel_id              : arg6,
            frontier_store_id      : v1,
            issuer                 : arg4,
            budget                 : arg7,
            deadline_ms            : arg9,
            status                 : 0,
            module_version         : 2,
            contributions          : 0x2::table::new<address, u64>(arg11),
            contribution_keys      : 0x2::table::new<ContributionKey, bool>(arg11),
            swept_keys             : 0x2::table::new<SweptKey, bool>(arg11),
            settle_nonces          : 0x2::table::new<SettleKey, bool>(arg11),
            debit_nonces           : 0x2::table::new<SettleKey, bool>(arg11),
            reconcile_debit_nonces : 0x2::table::new<SettleKey, bool>(arg11),
            settled_positions      : 0x2::table::new<SettledPosition, bool>(arg11),
            refunded_windows       : 0x2::table::new<RefundedWindowKey, bool>(arg11),
            refunding_windows      : 0x2::table::new<RefundedWindowKey, bool>(arg11),
            leg_paid               : 0x2::table::new<SettledPosition, bool>(arg11),
            contributor_ids        : vector[],
            recorded_stake         : 0,
            total_contributed      : 0,
            contributor_count      : 0,
        };
        let v5 = ReserveCreated{
            reserve_id   : v3,
            execution_id : v4.execution_id,
            budget       : arg7,
            deadline_ms  : arg9,
        };
        0x2::event::emit<ReserveCreated>(v5);
        v4
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

    public fun receipt_payout_cap_multiple() : u64 {
        100
    }

    public fun reconcile(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: RuntimeAuth, arg10: &0x2::clock::Clock, arg11: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert_open(arg0);
        assert_not_attested(arg0);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_attested_profile(arg4);
        assert_registry_is_canonical(arg4, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg11));
        assert_frontiers_match(arg4, &arg0.execution_id, arg5);
        let v0 = reconcile_message(&arg0.execution_id, arg9.runtime_generation, arg8, &arg6, &arg7);
        verify_admitted_auth(arg4, arg11, arg10, arg0.execution_id, &v0, &arg9);
        reconcile_payouts(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
    }

    public fun reconcile_attested(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: &0x2::clock::Clock, arg10: RuntimeAuth, arg11: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg12: vector<u8>, arg13: vector<u8>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert!(is_attested(arg0), 13906846006983458896);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::terminal_gate::require_endorsement(arg4, arg0.frontier_store_id, assert_binding_names_reserve(arg4, arg0, arg12), arg13);
        arm_attested_gate(arg0);
        reconcile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg9, arg11);
        mark_attested_settled(arg0);
    }

    public fun reconcile_by_issuer(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinIssuerCap, arg1: &mut ExecutionReserve, arg2: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg4: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg5: u64, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64) {
        assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg4);
        assert_open(arg1);
        assert_not_attested(arg1);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::issuer_cap_ledger_id(arg0) == 0x2::object::id<0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger>(arg2), 13906839847998390322);
        assert!(arg1.total_contributed == arg5, 13906839852293619766);
        reconcile_payouts(arg1, arg2, arg3, arg4, arg6, arg7, arg8);
    }

    public fun reconcile_by_issuer_attested(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinIssuerCap, arg1: &mut ExecutionReserve, arg2: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg4: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg5: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg6: u64, arg7: vector<Payout>, arg8: vector<Debit>, arg9: u64, arg10: vector<u8>, arg11: vector<u8>) {
        assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg5);
        assert!(is_attested(arg1), 13906845401393070160);
        assert_store_is_canonical(arg1, arg5);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::terminal_gate::require_endorsement(arg5, arg1.frontier_store_id, assert_binding_names_reserve(arg5, arg1, arg10), arg11);
        arm_attested_gate(arg1);
        reconcile_by_issuer(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        mark_attested_settled(arg1);
    }

    public fun reconcile_local(arg0: &mut ExecutionReserve, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: RuntimeAuth, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert_open(arg0);
        assert_not_attested(arg0);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_local_profile(arg4);
        assert_registry_is_canonical(arg4, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>>(arg10));
        assert_frontiers_match(arg4, &arg0.execution_id, arg5);
        let v0 = reconcile_message(&arg0.execution_id, arg9.runtime_generation, arg8, &arg6, &arg7);
        verify_admitted_auth_local(arg4, arg10, arg0.execution_id, &v0, &arg9);
        reconcile_payouts(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
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

    fun reconcile_payouts(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: vector<Payout>, arg5: vector<Debit>, arg6: u64) {
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
                    0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::emit_inplay_stake_settled(0x2::object::id<ExecutionReserve>(arg0), v5.holder, v5.amount);
                    0x2::table::add<SettleKey, bool>(&mut arg0.reconcile_debit_nonces, v6, true);
                };
            };
            v4 = v4 + 1;
        };
        while (v2 < v3) {
            let v7 = 0x1::vector::borrow<Payout>(&arg4, v2);
            if (v7.amount > 0) {
                assert!(0x2::table::contains<address, u64>(&arg0.contributions, v7.holder), 13906840062745313308);
                if (!shard_holds(arg2, v7.holder)) {
                    v2 = v2 + 1;
                    continue
                };
                consume_settled_position(arg0, v7.window_id, v7.holder, false);
                0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::release_to_holder(arg1, arg2, arg3, v0, v7.holder, v7.amount);
                v1 = v1 + v7.amount;
            };
            v2 = v2 + 1;
        };
        let v8 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_account_balance(arg3, v0);
        assert!(v1 + v8 == 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_account_balance(arg3, v0), 13906840122875772970);
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
        assert!(arg0.recorded_stake == 0, 13906840225954725926);
        let v13 = 0;
        if (v8 > 0) {
            if (!shard_holds(arg2, arg0.issuer)) {
                return
            };
            0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::release_to_holder(arg1, arg2, arg3, v0, arg0.issuer, v8);
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

    public(friend) fun record_domain_contribution(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::eligibility::EligibilityRegistry, arg5: address, arg6: u64) {
        assert!(arg0.status == 0, 13906844847338749978);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_contribution_for_domain(arg1, arg2, arg3, arg4, 0x2::object::id<ExecutionReserve>(arg0), arg5, arg6);
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
        assert!(arg0.status == 0, 13906845006252539930);
        let v0 = outstanding_execution_credit(arg0);
        assert!(v0 >= arg2, 13906845014846144594);
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

    public fun recorded_stake(arg0: &ExecutionReserve) : u64 {
        arg0.recorded_stake
    }

    fun refund_all_authorized(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: u8, arg7: &0x2::clock::Clock, arg8: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        let v0 = refund_message(&arg0.execution_id, arg5.runtime_generation, arg6);
        full_refund_authorized(arg0, arg1, arg2, arg3, arg4, arg5, &v0, arg6, arg7, arg8);
    }

    fun refund_all_authorized_local(arg0: &mut ExecutionReserve, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: u8, arg7: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        let v0 = refund_message(&arg0.execution_id, arg5.runtime_generation, arg6);
        full_refund_authorized_local(arg0, arg1, arg2, arg3, arg4, arg5, &v0, arg6, arg7);
    }

    fun refund_attested(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &0x2::clock::Clock, arg7: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg8: vector<u8>, arg9: u8) {
        assert!(is_attested(arg0), 13906846337695940688);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::terminal_gate::require_cancelled(arg4, arg0.frontier_store_id, assert_binding_names_reserve(arg4, arg0, arg8));
        arm_attested_gate(arg0);
        refund_all_authorized(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg6, arg7);
        mark_attested_settled(arg0);
    }

    public fun refund_for_frontier(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &0x2::clock::Clock, arg7: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_attested_profile(arg4);
        refund_all_authorized(arg0, arg1, arg2, arg3, arg4, arg5, 2, arg6, arg7);
    }

    public fun refund_for_frontier_attested(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &0x2::clock::Clock, arg7: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg8: vector<u8>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        refund_attested(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 2);
    }

    public fun refund_for_frontier_local(arg0: &mut ExecutionReserve, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_local_profile(arg4);
        refund_all_authorized_local(arg0, arg1, arg2, arg3, arg4, arg5, 2, arg6);
    }

    public fun refund_invalidated(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &0x2::clock::Clock, arg7: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_attested_profile(arg4);
        refund_all_authorized(arg0, arg1, arg2, arg3, arg4, arg5, 0, arg6, arg7);
    }

    public fun refund_invalidated_attested(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &0x2::clock::Clock, arg7: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg8: vector<u8>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        refund_attested(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0);
    }

    public fun refund_invalidated_local(arg0: &mut ExecutionReserve, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_local_profile(arg4);
        refund_all_authorized_local(arg0, arg1, arg2, arg3, arg4, arg5, 0, arg6);
    }

    public(friend) fun refund_message(arg0: &vector<u8>, arg1: u64, arg2: u8) : vector<u8> {
        let v0 = b"dopan718/reserve-refund/v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        v0
    }

    public fun release_frontierless_attested(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: RuntimeAuth, arg6: vector<u8>, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert!(arg0.status == 0, 13906846646930047002);
        assert!(is_attested(arg0), 13906846651228553296);
        assert_store_is_canonical(arg0, arg4);
        assert!(0x1::vector::length<u8>(&arg8) == 32, 13906846672704176220);
        let v0 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::decode_binding(arg6);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_window_id(&v0) == arg7, 13906846685588947034);
        assert!(!store_holds_frontier_commitment(arg4, arg0, arg6), 13906846698473717848);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::terminal_gate::require_endorsement(arg4, arg0.frontier_store_id, assert_binding_names_reserve(arg4, arg0, arg6), arg8);
        let v1 = release_message(&arg0.execution_id, arg5.runtime_generation, arg7, &arg8);
        arm_attested_gate(arg0);
        full_refund_authorized(arg0, arg1, arg2, arg3, arg4, arg5, &v1, 3, arg9, arg10);
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

    public(friend) fun reserve_execution_credit(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg3: u64) {
        assert!(arg0.status == 0, 13906845186641166362);
        assert!(arg3 > 0, 13906845190936002584);
        let v0 = outstanding_execution_credit(arg0) + arg3;
        assert!(arg0.total_contributed + v0 <= 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_account_balance(arg2, 0x2::object::id<ExecutionReserve>(arg0)), 13906845203824705618);
        set_outstanding_execution_credit(arg0, v0);
    }

    public fun reserved_execution_reserve(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg1: &vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = ExecutionReserveKey{execution_id: *arg1};
        if (0x2::dynamic_field::exists_with_type<ExecutionReserveKey, 0x2::object::ID>(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::uid(arg0), v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<ExecutionReserveKey, 0x2::object::ID>(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::uid(arg0), v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun runtime_auth(arg0: u64, arg1: u8, arg2: vector<u8>, arg3: vector<u8>) : RuntimeAuth {
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(arg1), 13906838937465061422);
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

    public(friend) fun set_frontier_store_id(arg0: &mut ExecutionReserve, arg1: 0x2::object::ID) {
        arg0.frontier_store_id = arg1;
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

    public fun settle_resolved_windows(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: RuntimeAuth, arg12: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert_open(arg0);
        assert_not_attested(arg0);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_attested_profile(arg4);
        assert_registry_is_canonical(arg4, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg12));
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 13906840569551585310);
        assert_frontiers_match(arg4, &arg0.execution_id, arg5);
        let v0 = settle_message(&arg0.execution_id, arg11.runtime_generation, arg8, arg9, &arg6, &arg7);
        verify_admitted_auth(arg4, arg12, arg10, arg0.execution_id, &v0, &arg11);
        settle_resolved_windows_body(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
    }

    public fun settle_resolved_windows_attested(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: RuntimeAuth, arg12: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg13: vector<u8>, arg14: vector<u8>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert!(is_attested(arg0), 13906845577486729296);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::terminal_gate::require_endorsement(arg4, arg0.frontier_store_id, assert_binding_names_reserve(arg4, arg0, arg13), arg14);
        arm_attested_gate(arg0);
        settle_resolved_windows(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        mark_attested_settled(arg0);
    }

    fun settle_resolved_windows_body(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: vector<Payout>, arg5: vector<Debit>, arg6: u64) {
        let v0 = 0x2::object::id<ExecutionReserve>(arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<Payout>(&arg4);
        abort_if_duplicate_payouts(&arg4);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = 0x1::vector::borrow<Payout>(&arg4, v4);
            if (v5.amount > 0 && shard_holds(arg2, v5.holder)) {
                assert!(0x2::table::contains<address, u64>(&arg0.contributions, v5.holder), 13906841059177725980);
                let v6 = SettleKey{
                    holder : v5.holder,
                    nonce  : arg6,
                };
                let v7 = SettledPosition{
                    window_id : v5.window_id,
                    holder    : v5.holder,
                };
                assert_settle_row_is_payable(arg0, v6, v7);
            };
            v4 = v4 + 1;
        };
        let v8 = 0;
        while (v8 < 0x1::vector::length<Debit>(&arg5)) {
            let v9 = 0x1::vector::borrow<Debit>(&arg5, v8);
            if (v9.amount > 0) {
                let v10 = SettleKey{
                    holder : v9.holder,
                    nonce  : arg6,
                };
                if (!0x2::table::contains<SettleKey, bool>(&arg0.debit_nonces, v10)) {
                    debit_contribution(arg0, v9.holder, v9.amount);
                    0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::emit_inplay_stake_settled(0x2::object::id<ExecutionReserve>(arg0), v9.holder, v9.amount);
                    0x2::table::add<SettleKey, bool>(&mut arg0.debit_nonces, v10, true);
                };
            };
            v8 = v8 + 1;
        };
        while (v2 < v3) {
            let v11 = 0x1::vector::borrow<Payout>(&arg4, v2);
            if (v11.amount > 0 && shard_holds(arg2, v11.holder)) {
                assert!(0x2::table::contains<address, u64>(&arg0.contributions, v11.holder), 13906841170846875676);
                let v12 = SettleKey{
                    holder : v11.holder,
                    nonce  : arg6,
                };
                if (!0x2::table::contains<SettleKey, bool>(&arg0.settle_nonces, v12)) {
                    0x2::table::add<SettleKey, bool>(&mut arg0.settle_nonces, v12, true);
                    consume_settled_position(arg0, v11.window_id, v11.holder, false);
                    0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::release_to_holder(arg1, arg2, arg3, v0, v11.holder, v11.amount);
                    v1 = v1 + v11.amount;
                    let v13 = WindowsSettled{
                        reserve_id   : v0,
                        execution_id : arg0.execution_id,
                        holder       : v11.holder,
                        amount       : v11.amount,
                        settle_nonce : arg6,
                    };
                    0x2::event::emit<WindowsSettled>(v13);
                };
            };
            v2 = v2 + 1;
        };
        let v14 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_account_balance(arg3, v0);
        assert!(v1 + v14 == 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::escrow_account_balance(arg3, v0), 13906841273927008298);
        assert_backed(arg0, v14);
    }

    public fun settle_resolved_windows_local(arg0: &mut ExecutionReserve, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: &vector<FrontierCheck>, arg6: vector<Payout>, arg7: vector<Debit>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: RuntimeAuth, arg12: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        assert_open(arg0);
        assert_not_attested(arg0);
        assert_store_is_canonical(arg0, arg4);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_local_profile(arg4);
        assert_registry_is_canonical(arg4, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>>(arg12));
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 13906840788594917406);
        assert_frontiers_match(arg4, &arg0.execution_id, arg5);
        let v0 = settle_message(&arg0.execution_id, arg11.runtime_generation, arg8, arg9, &arg6, &arg7);
        verify_admitted_auth_local(arg4, arg12, arg0.execution_id, &v0, &arg11);
        settle_resolved_windows_body(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
    }

    fun shard_holds(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg1: address) : bool {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::holder_shard_index(arg1) == (0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::shard_index(arg0) as u64)
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

    fun store_holds_frontier_commitment(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: &ExecutionReserve, arg2: vector<u8>) : bool {
        let v0 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::decode_binding(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::has_commitment(arg0, arg1.execution_id, 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::intake_receipt::u64_identity(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_market_local_id(&v0)), 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::intake_receipt::u64_identity(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_window_id(&v0)), 0)
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

    public fun sweep_window(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::eligibility::EligibilityRegistry, arg5: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg6: u64, arg7: vector<address>, arg8: vector<u64>, arg9: u64, arg10: RuntimeAuth, arg11: &0x2::clock::Clock, arg12: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg5);
        assert!(arg0.status == 0, 13906837919556501530);
        assert_not_attested_reserve(arg0);
        assert_store_is_canonical(arg0, arg5);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_attested_profile(arg5);
        assert_registry_is_canonical(arg5, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg12));
        assert!(0x1::vector::length<address>(&arg7) == 0x1::vector::length<u64>(&arg8), 13906837941033304120);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg7)) {
            0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_not_enrolled(arg1, *0x1::vector::borrow<address>(&arg7, v0));
            v0 = v0 + 1;
        };
        let v1 = sweep_message(&arg0.execution_id, arg10.runtime_generation, arg6, arg9, &arg7, &arg8);
        verify_admitted_auth(arg5, arg12, arg11, arg0.execution_id, &v1, &arg10);
        sweep_window_body(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
    }

    fun sweep_window_body(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::eligibility::EligibilityRegistry, arg5: u64, arg6: vector<address>, arg7: vector<u64>, arg8: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg6)) {
            let v1 = *0x1::vector::borrow<address>(&arg6, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg7, v0);
            v0 = v0 + 1;
            if (0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::is_enrolled(arg1, v1)) {
                0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_not_enrolled(arg1, v1);
            };
            if (v2 == 0 || v2 > arg8) {
                continue
            };
            if (0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::eligibility::is_excluded(arg4, v1)) {
                continue
            };
            if (!shard_holds(arg2, v1)) {
                continue
            };
            if (0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::balance_of(arg2, v1) < v2) {
                continue
            };
            let v3 = SweptKey{
                window_id : arg5,
                holder    : v1,
            };
            if (0x2::table::contains<SweptKey, bool>(&arg0.swept_keys, v3)) {
                continue
            };
            0x2::table::add<SweptKey, bool>(&mut arg0.swept_keys, v3, true);
            escrow_and_record(arg0, arg1, arg2, arg3, arg4, v1, v2);
            let v4 = ReserveSwept{
                reserve_id        : 0x2::object::id<ExecutionReserve>(arg0),
                holder            : v1,
                window_id         : arg5,
                amount            : v2,
                total_contributed : arg0.total_contributed,
            };
            0x2::event::emit<ReserveSwept>(v4);
            0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::emit_inplay_stake_opened(0x2::object::id<ExecutionReserve>(arg0), v1, v2);
        };
    }

    public fun sweep_window_local(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::eligibility::EligibilityRegistry, arg5: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg6: u64, arg7: vector<address>, arg8: vector<u64>, arg9: u64, arg10: RuntimeAuth, arg11: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg5);
        assert!(arg0.status == 0, 13906838142894800922);
        assert_not_attested_reserve(arg0);
        assert_store_is_canonical(arg0, arg5);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_local_profile(arg5);
        assert_registry_is_canonical(arg5, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>>(arg11));
        assert!(0x1::vector::length<address>(&arg7) == 0x1::vector::length<u64>(&arg8), 13906838164371603512);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg7)) {
            0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_not_enrolled(arg1, *0x1::vector::borrow<address>(&arg7, v0));
            v0 = v0 + 1;
        };
        let v1 = sweep_message(&arg0.execution_id, arg10.runtime_generation, arg6, arg9, &arg7, &arg8);
        verify_admitted_auth_local(arg5, arg11, arg0.execution_id, &v1, &arg10);
        sweep_window_body(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
    }

    public fun timeout(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0x2::clock::Clock) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        if (arg0.status != 0) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.deadline_ms, 13906842652611641388);
        assert!(!is_attested(arg0), 13906842656908968016);
        do_full_refund(arg0, arg1, arg2, arg3, 1);
    }

    public fun timeout_attested(arg0: &mut ExecutionReserve, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinShard, arg3: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinEscrowBook, arg4: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        assert_admitted_version(arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_shard_admitted_version(arg2);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_book_admitted_version(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg4);
        if (arg0.status != 0) {
            return
        };
        assert!(is_attested(arg0), 13906842768578117712);
        assert_store_is_canonical(arg0, arg4);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg0.deadline_ms, 13906842777165692972);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::terminal_gate::require_cancelled(arg4, arg0.frontier_store_id, assert_binding_names_reserve(arg4, arg0, arg5));
        do_full_refund(arg0, arg1, arg2, arg3, 1);
    }

    public fun total_contributed(arg0: &ExecutionReserve) : u64 {
        arg0.total_contributed
    }

    public(friend) fun tunnel_id(arg0: &ExecutionReserve) : 0x2::object::ID {
        arg0.tunnel_id
    }

    public(friend) fun verify_admitted_auth(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &vector<u8>, arg5: &RuntimeAuth) {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::verify_admitted_runtime_signature(arg0, arg1, arg2, arg3, arg5.runtime_generation, arg5.signature_type, arg5.public_key, *arg4, arg5.signature);
    }

    public(friend) fun verify_admitted_auth_local(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg2: vector<u8>, arg3: &vector<u8>, arg4: &RuntimeAuth) {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::verify_admitted_runtime_signature_local(arg0, arg1, arg2, arg4.runtime_generation, arg4.signature_type, arg4.public_key, *arg3, arg4.signature);
    }

    public(friend) fun verify_receipt_auth(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>, arg2: &vector<u8>, arg3: &RuntimeAuth) {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::verify_receipt_signature(arg0, arg1, arg3.runtime_generation, arg3.signature_type, arg3.public_key, *arg2, arg3.signature);
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 <= arg0
    }

    public fun window_all() : u64 {
        18446744073709551615
    }

    // decompiled from Move bytecode v7
}

