module 0xca24c519b8203fec7cee35f45d6ab61e5746207cbb8b9b88081712c54b1dfaba::onepiece {
    struct ONEPIECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ONEPIECE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ONEPIECE>(arg0, b"OnePiece", b"Splash One piece", b"One Piece Token official launch on SUI. Join with us to great togheter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU3sgrP1TTxrKtiVbfvj9wdEE3RoXJhfFsDhi4mnB3oL4")), b"https://onepiecesui.fun/", b"https://x.com/onepiecesui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0081c226cb2b78a5846a794e5077aafefbf2303a5d7a66859d4010c0a98d02156bd9f94f10b502b43f2b72b8ab946f3f1e7577d0342ea9cbdfded412e44483b90bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747761886"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

