module 0x93c079225cc7a03f50973884d23b33bce6d0cb2ee9f640ffd5682b2c7656b624::subi {
    struct SUBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBI>(arg0, 6, b"SUBI", b"BabySuisabi", b"baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_23_30_31_41f20352ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

