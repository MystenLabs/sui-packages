module 0xc89c9a40b51b748aa3646e6f05486e895816640c7e65b35cbd07694be773d0cf::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MOO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MOO>(arg0, b"MOO", b"MOo On Sui", b"MOo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPmWR8gKNsYQgXmKjB1L176Unhk5MdwgMhNLo8wnHYzoy")), b"WEBSITE", b"https://x.com/moo_on_sui", b"DISCORD", b"https://t.me/moo_sui", 0x1::string::utf8(b"00e384b958bd338ba7999c372c91ea4005de326bc273737af88c3dab1a8d3b58ed24982637f073f1faebc47306f34e0c897d66ebb8217ebf8cd791e26674b1c40ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757762"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

