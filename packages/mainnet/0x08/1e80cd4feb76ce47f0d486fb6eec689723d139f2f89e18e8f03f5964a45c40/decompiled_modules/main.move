module 0x81e80cd4feb76ce47f0d486fb6eec689723d139f2f89e18e8f03f5964a45c40::main {
    struct AnalysisEvent has copy, drop {
        wallet: address,
        scanner: address,
        timestamp: u64,
        metadata: vector<u8>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_admin(arg0: address) : bool {
        false
    }

    public entry fun record_scan(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 > 0, 1);
        assert!(v0 <= 1024, 2);
        let v1 = AnalysisEvent{
            wallet    : arg0,
            scanner   : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
            metadata  : arg1,
        };
        0x2::event::emit<AnalysisEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

