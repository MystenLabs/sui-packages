module 0xb8f32827409ccbac091f0d49c32486ff72a7e3ca2604e0ae9317ac997b56a6f6::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<RR>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<RR>(arg0, b"RR", b"Token", b"Desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00395db7487cfb05753fdad93e94b000b0acea5fb95811c30933237e798b4a8f0c2b5e78fb954abd0027409ed7992791f280d1b9f827e2d336923be823b5ea1a02ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1745945317"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

