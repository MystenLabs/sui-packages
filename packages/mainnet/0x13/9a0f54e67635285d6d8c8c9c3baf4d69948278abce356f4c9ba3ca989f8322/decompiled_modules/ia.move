module 0x139a0f54e67635285d6d8c8c9c3baf4d69948278abce356f4c9ba3ca989f8322::ia {
    struct IA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IA>(arg0, 6, b"IA", b"VerseIA", x"53756954656e736f725665727365207265766f6c7574696f6e697a6573206163636573736962696c69747920746f206172746966696369616c20696e74656c6c6967656e63652c206f70656e696e672074686520646f6f727320666f7220616c6c20696e646976696475616c732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitensor_6accaee148.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IA>>(v1);
    }

    // decompiled from Move bytecode v6
}

