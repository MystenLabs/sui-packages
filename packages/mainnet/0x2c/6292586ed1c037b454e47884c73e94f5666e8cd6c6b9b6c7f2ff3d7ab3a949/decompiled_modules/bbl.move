module 0x2c6292586ed1c037b454e47884c73e94f5666e8cd6c6b9b6c7f2ff3d7ab3a949::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BBL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BBL>(arg0, b"BBL", b"bulbasaur", b"bulbasaur bulbasaur bulbasaur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcKX9ypiWUNbU59kjUrc4F7pjG42iumoQBxXj8W7i3Hch")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00376bf54a0028b053e651d4c9694d3804cba4265dc0cd9f1fc11dd3e1537fa4514c72ac649e144b215a4e72474f1e13e8cf67a90ddb17ca89133ac79a27c7a50dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757152"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

