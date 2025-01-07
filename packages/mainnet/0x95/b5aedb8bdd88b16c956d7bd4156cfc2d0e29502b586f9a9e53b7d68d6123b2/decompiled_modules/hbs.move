module 0x95b5aedb8bdd88b16c956d7bd4156cfc2d0e29502b586f9a9e53b7d68d6123b2::hbs {
    struct HBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBS>(arg0, 6, b"HBS", b"Hello bulls", b"The bear says hello bulls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3827_88125d9810.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

