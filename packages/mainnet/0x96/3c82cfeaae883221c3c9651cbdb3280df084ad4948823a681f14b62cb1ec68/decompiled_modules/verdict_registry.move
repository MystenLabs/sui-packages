module 0x963c82cfeaae883221c3c9651cbdb3280df084ad4948823a681f14b62cb1ec68::verdict_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<0x1::string::String, VerdictEntry>,
    }

    struct VerdictEntry has drop, store {
        verdict: u8,
        score: u8,
        timestamp_ms: u64,
        checker: address,
    }

    struct VerdictWritten has copy, drop {
        token: 0x1::string::String,
        verdict: u8,
        score: u8,
        timestamp_ms: u64,
        checker: address,
    }

    public fun get_verdict(arg0: &Registry, arg1: 0x1::string::String) : (u8, u8, u64, address) {
        let v0 = 0x2::table::borrow<0x1::string::String, VerdictEntry>(&arg0.records, arg1);
        (v0.verdict, v0.score, v0.timestamp_ms, v0.checker)
    }

    public fun has_verdict(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, VerdictEntry>(&arg0.records, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            records : 0x2::table::new<0x1::string::String, VerdictEntry>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public entry fun record_verdict(arg0: &mut Registry, arg1: 0x1::string::String, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 0);
        assert!(arg3 <= 100, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = VerdictEntry{
            verdict      : arg2,
            score        : arg3,
            timestamp_ms : v0,
            checker      : v1,
        };
        if (0x2::table::contains<0x1::string::String, VerdictEntry>(&arg0.records, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, VerdictEntry>(&mut arg0.records, arg1) = v2;
        } else {
            0x2::table::add<0x1::string::String, VerdictEntry>(&mut arg0.records, arg1, v2);
        };
        let v3 = VerdictWritten{
            token        : arg1,
            verdict      : arg2,
            score        : arg3,
            timestamp_ms : v0,
            checker      : v1,
        };
        0x2::event::emit<VerdictWritten>(v3);
    }

    // decompiled from Move bytecode v7
}

