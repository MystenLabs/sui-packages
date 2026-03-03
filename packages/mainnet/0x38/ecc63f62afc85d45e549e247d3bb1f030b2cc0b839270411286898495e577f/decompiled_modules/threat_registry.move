module 0x38ecc63f62afc85d45e549e247d3bb1f030b2cc0b839270411286898495e577f::threat_registry {
    struct ThreatAlert has store, key {
        id: 0x2::object::UID,
        phase: 0x1::string::String,
        details: 0x1::string::String,
        timestamp: u64,
        mitigated: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mitigate_threat(arg0: &mut ThreatAlert, arg1: &AdminCap) {
        arg0.mitigated = true;
    }

    public fun register_threat(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ThreatAlert{
            id        : 0x2::object::new(arg3),
            phase     : arg0,
            details   : arg1,
            timestamp : arg2,
            mitigated : false,
        };
        0x2::transfer::share_object<ThreatAlert>(v0);
    }

    // decompiled from Move bytecode v6
}

