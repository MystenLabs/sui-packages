module 0x7b27cc5358dcaa4b6b6eee7ac38011114fb5d5ab46a6acba5411d65a6611090f::verdict_log {
    struct VerdictLoggedEvent has copy, drop, store {
        scan_id: vector<u8>,
        mint_b58: 0x1::string::String,
        decision: u8,
        internal_bucket: u8,
        rugcheck_score: u32,
        rugcheck_cluster_pct: u8,
        detection_latency_ms: u32,
        pre_entry_liquidity_micro_sol: u64,
        scanner_id: 0x1::string::String,
        claimed_timestamp_ms: u64,
        sui_consensus_timestamp_ms: u64,
    }

    public fun bucket_conviction() : u8 {
        3
    }

    public fun bucket_max() : u8 {
        4
    }

    public fun bucket_moonshot() : u8 {
        4
    }

    public fun bucket_safe() : u8 {
        1
    }

    public fun bucket_skip() : u8 {
        0
    }

    public fun bucket_standard() : u8 {
        2
    }

    public fun decision_avoid() : u8 {
        0
    }

    public fun decision_caution() : u8 {
        1
    }

    public fun decision_clear() : u8 {
        2
    }

    public fun decision_elite() : u8 {
        4
    }

    public fun decision_max() : u8 {
        4
    }

    public fun decision_strong() : u8 {
        3
    }

    public fun log_verdict(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: u32, arg6: u8, arg7: u32, arg8: u64, arg9: 0x1::string::String, arg10: u64) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1);
        assert!(arg3 <= 4, 2);
        assert!(arg4 <= 4, 3);
        assert!(arg6 <= 100, 4);
        let v0 = 0x1::string::as_bytes(&arg2);
        assert!(0x1::vector::length<u8>(v0) >= 32, 5);
        assert!(0x1::vector::length<u8>(v0) <= 50, 5);
        let v1 = 0x1::string::as_bytes(&arg9);
        assert!(0x1::vector::length<u8>(v1) >= 1, 6);
        assert!(0x1::vector::length<u8>(v1) <= 32, 6);
        let v2 = VerdictLoggedEvent{
            scan_id                       : arg1,
            mint_b58                      : arg2,
            decision                      : arg3,
            internal_bucket               : arg4,
            rugcheck_score                : arg5,
            rugcheck_cluster_pct          : arg6,
            detection_latency_ms          : arg7,
            pre_entry_liquidity_micro_sol : arg8,
            scanner_id                    : arg9,
            claimed_timestamp_ms          : arg10,
            sui_consensus_timestamp_ms    : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<VerdictLoggedEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

