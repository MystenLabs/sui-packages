module 0x1da150db13ad4d54e46ecdad759ac0fa34ad04da996671781fca62343c1719a8::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 6, b"GAY", b"Gay Fish", x"446f20796f75206c696b652070757474696e672066697368737469636b7320696e20796f7572206d6f7574683f0a20202020202020596561682e0a576861742061726520796f752c20612067617920666973683f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/logogay_2f90131fff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

