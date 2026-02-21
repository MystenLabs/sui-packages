module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::ledger {
    struct LedgerEntry has store, key {
        id: 0x2::object::UID,
        kind: u8,
        actor: address,
        ref_id: address,
        amount: u64,
        timestamp: u64,
    }

    struct LedgerRecorded has copy, drop {
        entry_id: address,
        kind: u8,
        actor: address,
        ref_id: address,
        amount: u64,
    }

    public fun actor(arg0: &LedgerEntry) : address {
        arg0.actor
    }

    public fun amount(arg0: &LedgerEntry) : u64 {
        arg0.amount
    }

    public fun kind(arg0: &LedgerEntry) : u8 {
        arg0.kind
    }

    entry fun record(arg0: u8, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = LedgerEntry{
            id        : 0x2::object::new(arg4),
            kind      : arg0,
            actor     : v0,
            ref_id    : arg1,
            amount    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        let v2 = LedgerRecorded{
            entry_id : 0x2::object::uid_to_address(&v1.id),
            kind     : arg0,
            actor    : v0,
            ref_id   : arg1,
            amount   : arg2,
        };
        0x2::event::emit<LedgerRecorded>(v2);
        0x2::transfer::freeze_object<LedgerEntry>(v1);
    }

    public fun ref_id(arg0: &LedgerEntry) : address {
        arg0.ref_id
    }

    public fun timestamp(arg0: &LedgerEntry) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

