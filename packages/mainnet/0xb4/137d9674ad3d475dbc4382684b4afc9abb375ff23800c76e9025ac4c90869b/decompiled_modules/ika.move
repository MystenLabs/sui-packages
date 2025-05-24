module 0xb4137d9674ad3d475dbc4382684b4afc9abb375ff23800c76e9025ac4c90869b::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<IKA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<IKA>(arg0, b"IKA", b"IKA CHAIN", b"Ika Chain is a samurai-themed crypto-fantasy narrative that symbolizes blockchain interoperability through the journey of a lone warrior named Ika. Set in a mythic world where digital realms (representing various blockchains) are fragmented and isolated", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWg5LcsinVFmnt5PAG6xPzd2gUS3fYWSBauXMrWUtPp48")), b"https://ika.xyz/", b"https://x.com/ikadotxyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009cd3733ee3961b1212a5d1ab333617d40ece8f32936d2731554d6e4ceee382878dde6b9746814d821ba17cbb9609165aaaf2ea39f15872d624d45509355b8b0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748078120"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

