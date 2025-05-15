module 0x9a3253c1f4b6773ceb45e181a3f75f514179e95c433bcaa48ff21a0e29b0982e::ydnc {
    struct YDNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YDNC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<YDNC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<YDNC>(arg0, b"YDNC", b"YDNC Token", b"this is YDNC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00766b408aad7116bba756a9fb68b3d01c28dbe5b6aceea89984e5137f061417bc600284eefd2aa7392005860e66ba1babf68b44e97682e26a5ce4a53e1b69c802d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747315238"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

