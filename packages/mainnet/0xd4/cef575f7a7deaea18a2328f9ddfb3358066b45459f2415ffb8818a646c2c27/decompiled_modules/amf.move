module 0xd4cef575f7a7deaea18a2328f9ddfb3358066b45459f2415ffb8818a646c2c27::amf {
    struct AMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMF, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AMF>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AMF>(arg0, b"AMF", b"AMF Rollers", b"Remember the thrill of knocking down pins with your best buds? The taste of greasy fries and the flashing lights of the arcade? AMF Rollers captures that feeling of pure, unadulterated fun. It's a token for anyone who's ever laughed until their sides hurt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYGNkc3Uo5yYS2SYY3qy5GZ5gf4kJb3uZLqLb41n6KiAh")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007cf29494497bebe73254fc4532ad5c460f5b9b4b298be5778929be5948214e8dba1d61e704ca3db84e75a783e6db4af45b510e733d28778836bb3c876ae1a600d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747776803"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

