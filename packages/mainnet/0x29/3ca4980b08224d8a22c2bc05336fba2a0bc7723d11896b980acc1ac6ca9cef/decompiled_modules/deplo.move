module 0x293ca4980b08224d8a22c2bc05336fba2a0bc7723d11896b980acc1ac6ca9cef::deplo {
    struct DEPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPLO>(arg0, 6, b"Deplo", b"The Deplorables", b"World war 3 are coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4713_63a4ea1514.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

