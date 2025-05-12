module 0x81d44279821b9f1c4c0246621069f0b661f76946260deeee8f831696b4e86315::hii {
    struct HII has drop {
        dummy_field: bool,
    }

    fun init(arg0: HII, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<HII>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<HII>(arg0, b"HII", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000de451306a61a34fa4802e48b17802cfb7425d48eaaa2f826e8c7a494de7491cb769d91cb7375ec6063b12c48ef4b092f8cf38d5918bf0fce3b01d681c834602ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747072446"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

