module 0xe293a7130db15c01ee8da1401c820e0932ae70240af5c9fb56f751034bd69439::hiphop {
    struct HIPHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPHOP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HIPHOP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HIPHOP>(arg0, b"HIPHOP", b"Hip Hop", x"4669727374206d6f766572206f66205355492054484520484950504f205448415420484f5053207c204a6f696e207468652024484950484f50f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYESSdM8ScCY1ViJMzLrr6B7v6zoYcbcZwe4p1SGf5ASq")), b"https://www.hippocto.meme/", b"https://x.com/hippo_cto", b"DISCORD", b"https://t.me/hippo_cto_bot", 0x1::string::utf8(b"005a970cf77ffbeff3abe3ec9892f5a875a3ef40c1547d7a0d363436bb57d12444a510fc076bd1ad95101b9a11754c7eaf25e23c98e44e14016f496b1fda0bb40ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747764455"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

