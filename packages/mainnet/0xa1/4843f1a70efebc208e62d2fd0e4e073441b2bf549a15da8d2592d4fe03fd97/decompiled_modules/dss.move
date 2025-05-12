module 0xa14843f1a70efebc208e62d2fd0e4e073441b2bf549a15da8d2592d4fe03fd97::dss {
    struct DSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<DSS>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<DSS>(arg0, b"DSS", b"ASdS", b"SDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b648d9ad7585c65d71e81e0b94f1effae1dd5e694a252660a7e33c7d6e3e18e0dd3ec81618cb4800fad69b4cfb9246efcdfd80ea3cb374e989cb02814ed1b702ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747082252"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

