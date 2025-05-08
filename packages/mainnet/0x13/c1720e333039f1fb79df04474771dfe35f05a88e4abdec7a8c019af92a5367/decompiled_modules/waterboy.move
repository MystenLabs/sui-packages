module 0x13c1720e333039f1fb79df04474771dfe35f05a88e4abdec7a8c019af92a5367::waterboy {
    struct WATERBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERBOY>(arg0, 6, b"Waterboy", b"Water boy", b"Mamamamamamasaid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000093224_10c4ab757c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

