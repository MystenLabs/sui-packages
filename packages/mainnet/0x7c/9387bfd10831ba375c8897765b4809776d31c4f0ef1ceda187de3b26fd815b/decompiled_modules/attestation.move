module 0x7c9387bfd10831ba375c8897765b4809776d31c4f0ef1ceda187de3b26fd815b::attestation {
    struct ReportAttested has copy, drop {
        blob_id: 0x1::string::String,
        report_hash: 0x1::string::String,
        chain: 0x1::string::String,
        risk_score: u64,
        timestamp: 0x1::string::String,
        attested_by: address,
    }

    struct Attestation has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        report_hash: 0x1::string::String,
        chain: 0x1::string::String,
        risk_score: u64,
        timestamp: 0x1::string::String,
        attested_by: address,
    }

    public fun attest(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = ReportAttested{
            blob_id     : arg0,
            report_hash : arg1,
            chain       : arg2,
            risk_score  : arg3,
            timestamp   : arg4,
            attested_by : v0,
        };
        0x2::event::emit<ReportAttested>(v1);
        let v2 = Attestation{
            id          : 0x2::object::new(arg5),
            blob_id     : arg0,
            report_hash : arg1,
            chain       : arg2,
            risk_score  : arg3,
            timestamp   : arg4,
            attested_by : v0,
        };
        0x2::transfer::share_object<Attestation>(v2);
    }

    // decompiled from Move bytecode v6
}

