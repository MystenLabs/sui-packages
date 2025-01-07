module 0xbc33e5dcabca18d1b941caa44acc779e879425f5047abb5a95cabbd5a6184ec2::scifi {
    struct SCIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCIFI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SCIFI>(arg0, 1389192786036093306, b"Scifier", b"scifi", b"The token for science fiction fans", b"https://images.hop.ag/ipfs/Qme9L2iutfT9UgU9UVbTtmVchVHN7DbS3EqWa8DRBDXmTr", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/scifier_info"), arg1);
    }

    // decompiled from Move bytecode v6
}

