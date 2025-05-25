module 0xb0bb8eaa359a909b5dfbdcb0a08494f29b8038818176d6b675f386253fbcdd06::sapa {
    struct SAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SAPA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SAPA>(arg0, b"SAPA", b"SAPA DEY", b"SAPA is a Nigerian slang used when things are not going on well financially.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVuFZqm2HRVSwDkMQbUTxbikJGk4jJoynVPcEswZnoNif")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001daa5157da0658e898c4b89f87aba5595714c2c1ed8c758a891fd20aaed141c9f69e796be031c9f68f04c26bd68d8aa042759594989f2a97a6b938fb8348f708d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748179569"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

