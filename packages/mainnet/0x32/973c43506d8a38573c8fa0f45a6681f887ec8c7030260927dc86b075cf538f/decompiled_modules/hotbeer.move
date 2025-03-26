module 0x32973c43506d8a38573c8fa0f45a6681f887ec8c7030260927dc86b075cf538f::hotbeer {
    struct HOTBEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTBEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTBEER>(arg0, 6, b"HOTBEER", b"HOT BEER", b"Hot Girl Drink BEER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_7ff0095cc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTBEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOTBEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

