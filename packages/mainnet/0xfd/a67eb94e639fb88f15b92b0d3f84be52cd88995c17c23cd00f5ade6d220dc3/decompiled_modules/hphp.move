module 0xfda67eb94e639fb88f15b92b0d3f84be52cd88995c17c23cd00f5ade6d220dc3::hphp {
    struct HPHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPHP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<HPHP>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<HPHP>(arg0, b"HPHP", b"HOP", b"Test twss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"https://science.nasa.gov/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0025776bdfe4bcf6331943f6a3692a7cb95f373e9097ef08f0a8e797cd77b040c07882914604c18e598fd5bbdc6024a5f971a2fe2a693908519e9b4bb075fa1a00ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1745946639"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

