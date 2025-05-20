module 0x6eee25e989b7586b06ad3c4c6d863f9c411e173b131d40dd4102fa847a32421a::suiri {
    struct SUIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIRI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIRI>(arg0, b"SUIRI", b"Suiri", x"5375697269202d205468652053706c6173686965737420536c696d65206f6e205355492020f09f9886", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXJ5AYXYvb3pyTG4bCNKejpbmDY1yrNUhxWRtWzRYhR7h")), b"https://www.suiri.fun/", b"https://x.com/SuiriOnSui", b"DISCORD", b"https://t.me/SuiriOnSui", 0x1::string::utf8(b"001f172e690fd4a202093fcb7b5a1022374cdc4f93be264c805646de09c4f21ef2c3819c7530f6f815b34c7975c1e902646b5db0fffe1363b4b26fe6cd9c907a04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758294"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

