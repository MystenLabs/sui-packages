module 0x2e884850e268d67708d527770bbf3e9e991e0aa845c88c5b68bdaed62943696f::anchor {
    struct Report has copy, drop {
        merchant: 0x1::string::String,
        evidence_sha256: vector<u8>,
        pay_tx_digest: vector<u8>,
        verdict: u8,
    }

    public fun report(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1);
        assert!(arg3 <= 1, 2);
        let v0 = Report{
            merchant        : arg0,
            evidence_sha256 : arg1,
            pay_tx_digest   : arg2,
            verdict         : arg3,
        };
        0x2::event::emit<Report>(v0);
    }

    // decompiled from Move bytecode v7
}

