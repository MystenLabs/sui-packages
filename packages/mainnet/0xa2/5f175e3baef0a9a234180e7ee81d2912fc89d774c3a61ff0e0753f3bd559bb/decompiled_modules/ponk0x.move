module 0xa25f175e3baef0a9a234180e7ee81d2912fc89d774c3a61ff0e0753f3bd559bb::ponk0x {
    struct PONK0X has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONK0X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONK0X>(arg0, 6, b"Ponk0x", b"Ponk", b"Ponk a meme!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031066_463092720f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONK0X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONK0X>>(v1);
    }

    // decompiled from Move bytecode v6
}

