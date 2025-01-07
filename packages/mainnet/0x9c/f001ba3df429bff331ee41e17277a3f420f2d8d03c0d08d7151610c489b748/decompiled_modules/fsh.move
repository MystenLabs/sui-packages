module 0x9cf001ba3df429bff331ee41e17277a3f420f2d8d03c0d08d7151610c489b748::fsh {
    struct FSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSH>(arg0, 6, b"FSH", b"Fsh", b"A fish with no eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_20_230120_8f8fd0e830.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

