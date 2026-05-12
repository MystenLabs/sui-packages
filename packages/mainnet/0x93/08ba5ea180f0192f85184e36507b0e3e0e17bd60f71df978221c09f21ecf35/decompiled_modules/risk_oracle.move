module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::risk_oracle {
    struct RiskOracle has key {
        id: 0x2::object::UID,
        current_score: u8,
        published_at_ms: u64,
        publication_count: u64,
    }

    public fun current_score(arg0: &RiskOracle) : u8 {
        arg0.current_score
    }

    public fun init_risk_oracle(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RiskOracle{
            id                : 0x2::object::new(arg2),
            current_score     : 100,
            published_at_ms   : arg1,
            publication_count : 0,
        };
        0x2::transfer::share_object<RiskOracle>(v0);
    }

    public fun is_fresh(arg0: &RiskOracle, arg1: u64, arg2: u64) : bool {
        arg1 <= arg0.published_at_ms + arg2 * 86400000
    }

    public fun publish_skeleton(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut RiskOracle, arg2: u8, arg3: u64) {
        assert!(arg2 <= 100, 1);
        arg1.current_score = arg2;
        arg1.published_at_ms = arg3;
        arg1.publication_count = arg1.publication_count + 1;
    }

    public fun published_at_ms(arg0: &RiskOracle) : u64 {
        arg0.published_at_ms
    }

    // decompiled from Move bytecode v7
}

