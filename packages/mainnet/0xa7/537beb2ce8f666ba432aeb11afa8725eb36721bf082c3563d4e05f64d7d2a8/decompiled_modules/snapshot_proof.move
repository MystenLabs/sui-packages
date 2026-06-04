module 0xa7537beb2ce8f666ba432aeb11afa8725eb36721bf082c3563d4e05f64d7d2a8::snapshot_proof {
    struct SnapshotProofRecorded has copy, drop {
        protocol: 0x1::string::String,
        slug: 0x1::string::String,
        timestamp: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        health_score: u64,
        tvl_micro_usd: u64,
        apy_bps: u64,
        version: 0x1::string::String,
        created_by: address,
    }

    entry fun record_snapshot(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &0x2::tx_context::TxContext) {
        let v0 = SnapshotProofRecorded{
            protocol       : arg0,
            slug           : arg1,
            timestamp      : arg2,
            walrus_blob_id : arg3,
            health_score   : arg4,
            tvl_micro_usd  : arg5,
            apy_bps        : arg6,
            version        : arg7,
            created_by     : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<SnapshotProofRecorded>(v0);
    }

    // decompiled from Move bytecode v7
}

