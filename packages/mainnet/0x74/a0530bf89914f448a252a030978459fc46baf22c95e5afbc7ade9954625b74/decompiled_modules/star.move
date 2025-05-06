module 0x74a0530bf89914f448a252a030978459fc46baf22c95e5afbc7ade9954625b74::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<STAR>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<STAR>(arg0, b"STAR", b"Star", b"Star Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaGwTh6Y5g5L2JFDYYqfLehbxMC2cTy6f2UHs2PJmvyoW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0047d88f417795eefab5c613f280f9f918316f62a76be3124060465490b54531642e3b52130cce9150848f9a176c3c95c5556f2e4a5782240c00a8bf2420a59009ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746530071"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

