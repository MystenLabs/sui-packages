module 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant {
    struct TermsBytes has copy, drop, store {
        effector: 0x1::string::String,
        bytes: vector<u8>,
    }

    struct ReservationBudget has copy, drop, store {
        effect: address,
        budget_before: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        budget_after: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
    }

    struct Grant has store, key {
        id: 0x2::object::UID,
        envelope_id: address,
        record: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord,
        terms: vector<TermsBytes>,
        cap: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money,
        reserved: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money,
        spent: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money,
        attempt_quota: u64,
        attempts_used: u64,
        parent: 0x1::option::Option<address>,
        retired: bool,
        standing_class: 0x1::option::Option<0x1::string::String>,
        budgets: vector<ReservationBudget>,
        hidden_nonces: vector<address>,
        hidden_receipts: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>,
    }

    struct BudgetView has copy, drop, store {
        value_cap: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        reserved: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        spent: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        available: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        attempts_used: u64,
        attempt_quota: u64,
        attempts_remaining: u64,
    }

    public(friend) fun new(arg0: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg1: address, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg3: 0x1::option::Option<address>, arg4: bool, arg5: 0x1::option::Option<0x1::string::String>, arg6: vector<TermsBytes>, arg7: &mut 0x2::tx_context::TxContext) : Grant {
        Grant{
            id              : 0x2::object::new(arg7),
            envelope_id     : arg1,
            record          : arg0,
            terms           : arg6,
            cap             : arg2,
            reserved        : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::zero_like(&arg2),
            spent           : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::zero_like(&arg2),
            attempt_quota   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_attempt_quota(&arg0),
            attempts_used   : 0,
            parent          : arg3,
            retired         : arg4,
            standing_class  : arg5,
            budgets         : 0x1::vector::empty<ReservationBudget>(),
            hidden_nonces   : vector[],
            hidden_receipts : 0x1::vector::empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(),
        }
    }

    public fun attempt_quota(arg0: &Grant) : u64 {
        arg0.attempt_quota
    }

    public fun attempts_used(arg0: &Grant) : u64 {
        arg0.attempts_used
    }

    public fun available(arg0: &Grant) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money {
        if (arg0.retired) {
            return 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::zero_like(&arg0.cap)
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::sub(&arg0.cap, &arg0.reserved);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v0)) {
            return 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::zero_like(&arg0.cap)
        };
        let v1 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0);
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::sub(&v1, &arg0.spent);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v2)) {
            return 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::zero_like(&arg0.cap)
        };
        0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v2)
    }

    public fun budget_after(arg0: &ReservationBudget) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.budget_after
    }

    public fun budget_before(arg0: &ReservationBudget) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.budget_before
    }

    public fun budget_effect(arg0: &ReservationBudget) : address {
        arg0.effect
    }

    public fun budget_of(arg0: &Grant, arg1: address) : 0x1::option::Option<ReservationBudget> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ReservationBudget>(&arg0.budgets)) {
            if (0x1::vector::borrow<ReservationBudget>(&arg0.budgets, v0).effect == arg1) {
                return 0x1::option::some<ReservationBudget>(*0x1::vector::borrow<ReservationBudget>(&arg0.budgets, v0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<ReservationBudget>()
    }

    public fun budgets(arg0: &Grant) : &vector<ReservationBudget> {
        &arg0.budgets
    }

    public fun cap(arg0: &Grant) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money {
        &arg0.cap
    }

    public(friend) fun carry(arg0: &mut Grant, arg1: &Grant) {
        arg0.reserved = arg1.reserved;
        arg0.spent = arg1.spent;
        arg0.attempts_used = arg1.attempts_used;
        arg0.parent = arg1.parent;
        arg0.terms = arg1.terms;
        arg0.budgets = arg1.budgets;
        arg0.hidden_nonces = arg1.hidden_nonces;
        arg0.hidden_receipts = arg1.hidden_receipts;
    }

    public(friend) fun consume_attempt(arg0: &mut Grant) {
        arg0.attempts_used = arg0.attempts_used + 1;
    }

    public(friend) fun consume_hidden(arg0: &mut Grant, arg1: address, arg2: 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment) {
        0x1::vector::push_back<address>(&mut arg0.hidden_nonces, arg1);
        0x1::vector::push_back<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(&mut arg0.hidden_receipts, arg2);
    }

    public fun consumed_hidden(arg0: &Grant, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.hidden_nonces, &arg1)
    }

    public fun envelope_id(arg0: &Grant) : address {
        arg0.envelope_id
    }

    public fun hidden_receipt(arg0: &Grant, arg1: address) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(&arg0.hidden_receipts)) {
            if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::commitment_nonce(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(&arg0.hidden_receipts, v0)) == arg1) {
                return 0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(*0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(&arg0.hidden_receipts, v0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>()
    }

    public fun hidden_receipts(arg0: &Grant) : &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment> {
        &arg0.hidden_receipts
    }

    public fun holder(arg0: &Grant) : address {
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_holder(&arg0.record)
    }

    public fun is_floor(arg0: &Grant) : bool {
        0x1::option::is_some<u64>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(&arg0.record))
    }

    public(friend) fun note_budget(arg0: &mut Grant, arg1: address, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg3: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount) {
        let v0 = ReservationBudget{
            effect        : arg1,
            budget_before : arg2,
            budget_after  : arg3,
        };
        0x1::vector::push_back<ReservationBudget>(&mut arg0.budgets, v0);
    }

    public fun parent(arg0: &Grant) : &0x1::option::Option<address> {
        &arg0.parent
    }

    public fun record(arg0: &Grant) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord {
        &arg0.record
    }

    public(friend) fun reserve(arg0: &mut Grant, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money) : bool {
        if (!is_floor(arg0)) {
            let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::add(&arg0.reserved, arg1);
            if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v0)) {
                return false
            };
            arg0.reserved = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0);
        };
        arg0.attempts_used = arg0.attempts_used + 1;
        true
    }

    public fun reserved(arg0: &Grant) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money {
        &arg0.reserved
    }

    public(friend) fun retire(arg0: &mut Grant) {
        arg0.retired = true;
    }

    public fun retired(arg0: &Grant) : bool {
        arg0.retired
    }

    public(friend) fun settle(arg0: &mut Grant, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg2: bool) : bool {
        if (is_floor(arg0)) {
            return true
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::sub(&arg0.reserved, arg1);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v0)) {
            return false
        };
        arg0.reserved = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0);
        if (arg2) {
            let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::add(&arg0.spent, arg1);
            if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1)) {
                return false
            };
            arg0.spent = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v1);
        };
        true
    }

    public(friend) fun settle_for(arg0: &mut Grant, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money) : bool {
        if (is_floor(arg0)) {
            return true
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::sub(&arg0.reserved, arg1);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v0)) {
            return false
        };
        arg0.reserved = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::add(&arg0.spent, arg2);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1)) {
            return false
        };
        arg0.spent = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v1);
        true
    }

    public fun spent(arg0: &Grant) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money {
        &arg0.spent
    }

    public fun standing_class(arg0: &Grant) : &0x1::option::Option<0x1::string::String> {
        &arg0.standing_class
    }

    public fun terms(arg0: &Grant) : &vector<TermsBytes> {
        &arg0.terms
    }

    public fun terms_bytes(arg0: 0x1::string::String, arg1: vector<u8>) : TermsBytes {
        TermsBytes{
            effector : arg0,
            bytes    : arg1,
        }
    }

    public fun terms_effector(arg0: &TermsBytes) : &0x1::string::String {
        &arg0.effector
    }

    public fun terms_for(arg0: &Grant, arg1: &0x1::string::String) : 0x1::option::Option<vector<u8>> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TermsBytes>(&arg0.terms)) {
            if (&0x1::vector::borrow<TermsBytes>(&arg0.terms, v0).effector == arg1) {
                return 0x1::option::some<vector<u8>>(0x1::vector::borrow<TermsBytes>(&arg0.terms, v0).bytes)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<vector<u8>>()
    }

    public fun terms_value(arg0: &TermsBytes) : &vector<u8> {
        &arg0.bytes
    }

    public fun view_attempt_quota(arg0: &BudgetView) : u64 {
        arg0.attempt_quota
    }

    public fun view_attempts_remaining(arg0: &BudgetView) : u64 {
        arg0.attempts_remaining
    }

    public fun view_attempts_used(arg0: &BudgetView) : u64 {
        arg0.attempts_used
    }

    public fun view_available(arg0: &BudgetView) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.available
    }

    public fun view_reserved(arg0: &BudgetView) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.reserved
    }

    public fun view_spent(arg0: &BudgetView) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.spent
    }

    public fun view_value_cap(arg0: &BudgetView) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.value_cap
    }

    public fun view_with(arg0: &Grant, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money) : BudgetView {
        let v0 = if (arg0.attempt_quota > arg0.attempts_used) {
            arg0.attempt_quota - arg0.attempts_used
        } else {
            0
        };
        BudgetView{
            value_cap          : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::format(&arg0.cap),
            reserved           : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::format(&arg0.reserved),
            spent              : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::format(&arg0.spent),
            available          : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::format(arg1),
            attempts_used      : arg0.attempts_used,
            attempt_quota      : arg0.attempt_quota,
            attempts_remaining : v0,
        }
    }

    // decompiled from Move bytecode v7
}

