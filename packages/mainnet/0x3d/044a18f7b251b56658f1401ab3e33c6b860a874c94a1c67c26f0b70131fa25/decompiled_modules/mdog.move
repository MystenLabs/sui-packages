module 0x3d044a18f7b251b56658f1401ab3e33c6b860a874c94a1c67c26f0b70131fa25::mdog {
    struct MDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDOG>(arg0, 6, b"MDOG", b"HANK", b"MicroStrategy DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_14_05_30_05_ebdc14c3d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

