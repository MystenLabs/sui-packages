module 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt {
    struct DecisionReceipt has copy, drop, store {
        effect: address,
        proposal: address,
        envelope_id: address,
        agreement: 0x1::option::Option<address>,
        allow: bool,
        reason: 0x1::option::Option<0x1::string::String>,
        budget_before: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        budget_after: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        charter_version: u64,
        fact_snapshot_hashes: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef>,
        effector: 0x1::string::String,
        terms_hash: 0x1::option::Option<address>,
        refused_by: 0x1::option::Option<0x1::string::String>,
        visibility: 0x1::string::String,
        nonce: address,
        seq: u64,
    }

    struct ReceiptCommitment has copy, drop, store {
        effect: address,
        nonce: address,
        digest: address,
    }

    struct GrantAdmitted has copy, drop {
        envelope_id: address,
        parent: 0x1::option::Option<address>,
        retired: bool,
    }

    struct GrantWidened has copy, drop {
        old: address,
        new: address,
        record: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord,
    }

    struct GrantRevoked has copy, drop {
        envelope_id: address,
        decision_id: address,
        kind: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::HelmKind,
        admitted: bool,
    }

    struct ReservationStuck has copy, drop {
        effect: address,
    }

    struct ReservationClosed has copy, drop {
        effect: address,
        state: u8,
        by: address,
    }

    struct ReservationSettledFor has copy, drop {
        effect: address,
        settled: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
    }

    public(friend) fun emit(arg0: DecisionReceipt) : ReceiptCommitment {
        let v0 = 0x2::bcs::to_bytes<DecisionReceipt>(&arg0);
        let v1 = ReceiptCommitment{
            effect : arg0.effect,
            nonce  : arg0.nonce,
            digest : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_id(&v0),
        };
        0x2::event::emit<DecisionReceipt>(arg0);
        v1
    }

    public fun allow(arg0: &DecisionReceipt) : bool {
        arg0.allow
    }

    public fun budget_after(arg0: &DecisionReceipt) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.budget_after
    }

    public fun budget_before(arg0: &DecisionReceipt) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.budget_before
    }

    public fun charter_version(arg0: &DecisionReceipt) : u64 {
        arg0.charter_version
    }

    public fun closed_state(arg0: &ReservationClosed) : u8 {
        arg0.state
    }

    public fun commitment_digest(arg0: &ReceiptCommitment) : address {
        arg0.digest
    }

    public fun commitment_effect(arg0: &ReceiptCommitment) : address {
        arg0.effect
    }

    public fun commitment_nonce(arg0: &ReceiptCommitment) : address {
        arg0.nonce
    }

    public fun effect(arg0: &DecisionReceipt) : address {
        arg0.effect
    }

    public fun effector(arg0: &DecisionReceipt) : &0x1::string::String {
        &arg0.effector
    }

    public(friend) fun emit_admitted(arg0: address, arg1: 0x1::option::Option<address>, arg2: bool) {
        let v0 = GrantAdmitted{
            envelope_id : arg0,
            parent      : arg1,
            retired     : arg2,
        };
        0x2::event::emit<GrantAdmitted>(v0);
    }

    public(friend) fun emit_closed(arg0: address, arg1: u8, arg2: address) {
        let v0 = ReservationClosed{
            effect : arg0,
            state  : arg1,
            by     : arg2,
        };
        0x2::event::emit<ReservationClosed>(v0);
    }

    public(friend) fun emit_revoked(arg0: address, arg1: address, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::HelmKind, arg3: bool) {
        let v0 = GrantRevoked{
            envelope_id : arg0,
            decision_id : arg1,
            kind        : arg2,
            admitted    : arg3,
        };
        0x2::event::emit<GrantRevoked>(v0);
    }

    public(friend) fun emit_settled_for(arg0: address, arg1: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount) {
        let v0 = ReservationSettledFor{
            effect  : arg0,
            settled : arg1,
        };
        0x2::event::emit<ReservationSettledFor>(v0);
    }

    public(friend) fun emit_stuck(arg0: address) {
        let v0 = ReservationStuck{effect: arg0};
        0x2::event::emit<ReservationStuck>(v0);
    }

    public(friend) fun emit_widened(arg0: address, arg1: address, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord) {
        let v0 = GrantWidened{
            old    : arg0,
            new    : arg1,
            record : arg2,
        };
        0x2::event::emit<GrantWidened>(v0);
    }

    public fun envelope_id(arg0: &DecisionReceipt) : address {
        arg0.envelope_id
    }

    public fun fact_snapshot_hashes(arg0: &DecisionReceipt) : &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef> {
        &arg0.fact_snapshot_hashes
    }

    public(friend) fun new(arg0: address, arg1: address, arg2: address, arg3: 0x1::option::Option<address>, arg4: bool, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg7: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg8: u64, arg9: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef>, arg10: 0x1::string::String, arg11: 0x1::option::Option<address>, arg12: 0x1::option::Option<0x1::string::String>, arg13: 0x1::string::String, arg14: address, arg15: u64) : DecisionReceipt {
        DecisionReceipt{
            effect               : arg0,
            proposal             : arg1,
            envelope_id          : arg2,
            agreement            : arg3,
            allow                : arg4,
            reason               : arg5,
            budget_before        : arg6,
            budget_after         : arg7,
            charter_version      : arg8,
            fact_snapshot_hashes : arg9,
            effector             : arg10,
            terms_hash           : arg11,
            refused_by           : arg12,
            visibility           : arg13,
            nonce                : arg14,
            seq                  : arg15,
        }
    }

    public fun nonce(arg0: &DecisionReceipt) : address {
        arg0.nonce
    }

    public fun proposal(arg0: &DecisionReceipt) : address {
        arg0.proposal
    }

    public fun reason(arg0: &DecisionReceipt) : &0x1::option::Option<0x1::string::String> {
        &arg0.reason
    }

    public fun refused_by(arg0: &DecisionReceipt) : &0x1::option::Option<0x1::string::String> {
        &arg0.refused_by
    }

    public fun seq(arg0: &DecisionReceipt) : u64 {
        arg0.seq
    }

    public fun terms_hash(arg0: &DecisionReceipt) : &0x1::option::Option<address> {
        &arg0.terms_hash
    }

    public fun visibility(arg0: &DecisionReceipt) : &0x1::string::String {
        &arg0.visibility
    }

    public fun widened_new(arg0: &GrantWidened) : address {
        arg0.new
    }

    public fun widened_record(arg0: &GrantWidened) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord {
        &arg0.record
    }

    // decompiled from Move bytecode v7
}

