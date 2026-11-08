module 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation {
    struct ReservationRecord has copy, drop, store {
        effect: address,
        envelope_id: address,
        holder: 0x1::string::String,
        kind: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind,
        effector: 0x1::string::String,
        counterparty: 0x1::string::String,
        value: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        terms: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>,
        amount: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        seq: u64,
        proposal: address,
        charter_version: u64,
        state: u8,
        expires: 0x1::option::Option<0x1::string::String>,
        closed_by: 0x1::option::Option<address>,
        agreement: 0x1::option::Option<address>,
        replaces: 0x1::option::Option<address>,
        commitment: 0x1::option::Option<address>,
    }

    struct Reservation has store, key {
        id: 0x2::object::UID,
        record: ReservationRecord,
    }

    public fun amount(arg0: &ReservationRecord) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.amount
    }

    public fun terms(arg0: &ReservationRecord) : &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField> {
        &arg0.terms
    }

    public fun agreement(arg0: &ReservationRecord) : &0x1::option::Option<address> {
        &arg0.agreement
    }

    public(friend) fun bind_agreement(arg0: &mut Reservation, arg1: address) {
        arg0.record.agreement = 0x1::option::some<address>(arg1);
    }

    public fun charter_version(arg0: &ReservationRecord) : u64 {
        arg0.charter_version
    }

    public(friend) fun close(arg0: &mut Reservation, arg1: u8, arg2: address) {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 4
        };
        assert!(v0, 0);
        arg0.record.state = arg1;
        arg0.record.closed_by = 0x1::option::some<address>(arg2);
    }

    public fun closed_by(arg0: &ReservationRecord) : &0x1::option::Option<address> {
        &arg0.closed_by
    }

    public fun commitment(arg0: &ReservationRecord) : &0x1::option::Option<address> {
        &arg0.commitment
    }

    public fun counterparty(arg0: &ReservationRecord) : &0x1::string::String {
        &arg0.counterparty
    }

    public fun effect(arg0: &ReservationRecord) : address {
        arg0.effect
    }

    public fun effector(arg0: &ReservationRecord) : &0x1::string::String {
        &arg0.effector
    }

    public fun envelope_id(arg0: &ReservationRecord) : address {
        arg0.envelope_id
    }

    public fun expires(arg0: &ReservationRecord) : &0x1::option::Option<0x1::string::String> {
        &arg0.expires
    }

    public fun finalized() : u8 {
        1
    }

    public fun holder(arg0: &ReservationRecord) : &0x1::string::String {
        &arg0.holder
    }

    public fun is_closed(arg0: &Reservation) : bool {
        if (arg0.record.state == 1) {
            true
        } else if (arg0.record.state == 2) {
            true
        } else {
            arg0.record.state == 4
        }
    }

    public fun is_reserved(arg0: &Reservation) : bool {
        arg0.record.state == 0
    }

    public fun is_stuck(arg0: &Reservation) : bool {
        arg0.record.state == 3
    }

    public fun kind(arg0: &ReservationRecord) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind {
        &arg0.kind
    }

    public(friend) fun mark_stuck(arg0: &mut Reservation) {
        assert!(arg0.record.state == 0, 0);
        arg0.record.state = 3;
    }

    public(friend) fun new_record(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg7: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>, arg8: u64, arg9: address, arg10: u64, arg11: 0x1::option::Option<0x1::string::String>, arg12: 0x1::option::Option<address>, arg13: 0x1::option::Option<address>, arg14: 0x1::option::Option<address>) : ReservationRecord {
        ReservationRecord{
            effect          : arg0,
            envelope_id     : arg1,
            holder          : arg2,
            kind            : arg3,
            effector        : arg4,
            counterparty    : arg5,
            value           : arg6,
            terms           : arg7,
            amount          : arg6,
            seq             : arg8,
            proposal        : arg9,
            charter_version : arg10,
            state           : 0,
            expires         : arg11,
            closed_by       : 0x1::option::none<address>(),
            agreement       : arg12,
            replaces        : arg13,
            commitment      : arg14,
        }
    }

    public(friend) fun open(arg0: ReservationRecord, arg1: &mut 0x2::tx_context::TxContext) : Reservation {
        Reservation{
            id     : 0x2::object::new(arg1),
            record : arg0,
        }
    }

    public fun proposal(arg0: &ReservationRecord) : address {
        arg0.proposal
    }

    public fun record(arg0: &Reservation) : &ReservationRecord {
        &arg0.record
    }

    public fun refunded() : u8 {
        4
    }

    public fun released() : u8 {
        2
    }

    public fun replaces(arg0: &ReservationRecord) : &0x1::option::Option<address> {
        &arg0.replaces
    }

    public fun reserved() : u8 {
        0
    }

    public fun seq(arg0: &ReservationRecord) : u64 {
        arg0.seq
    }

    public fun state(arg0: &ReservationRecord) : u8 {
        arg0.state
    }

    public fun stuck() : u8 {
        3
    }

    public fun value(arg0: &ReservationRecord) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        &arg0.value
    }

    // decompiled from Move bytecode v7
}

