module 0x4cc8ef6d3cca9aca8a5000123d741f952f59f0ef32923308f2276428e30997d0::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LOOPY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LOOPY>(arg0, b"Loopy", b"LoopySUI", x"ec9e94eba79deba3a8ed94bc20eab3b5ec8b9d2058e29ca8f09f988e20205a616e6d616e67204c6f6f7079204f6666696369616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma16pKhn3eGLrHxobZwd5mApvhhVaCTMvDznRbxizqpUh")), b"https://www.youtube.com/watch?v=7XW493t8NW0&feature=youtu.be", b"https://x.com/ZM_Loopy", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bb30ef38e891e9f92754628a7ca0dc086a0316118825a94f2e2fe589fae142041602b0e6752fe3a05a642972327c6a7d274682496a0fee8be9767e385409070ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758754"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

