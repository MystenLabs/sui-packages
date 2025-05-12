module 0x4e573e88f5e9276dd38b61d675315db7708c8d935a2ee7a6d951d0453e04fdd3::h {
    struct H has drop {
        dummy_field: bool,
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<H>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<H>(arg0, b"H", b"HHH", b"Hh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00aaab5966eeecc4762dca8bc38066d8646237a87f64fff8ede1d8cb87864db363ecbf1e56ecefc35e85d7016add1a19ab0445d249695b6ecc74e782bbfe1add00ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747075282"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

