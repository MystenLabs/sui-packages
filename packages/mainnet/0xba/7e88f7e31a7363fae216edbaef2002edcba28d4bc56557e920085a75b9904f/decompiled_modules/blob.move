module 0xba7e88f7e31a7363fae216edbaef2002edcba28d4bc56557e920085a75b9904f::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"BLOB", b"THE BLOB", b"Looking for something more memeable than a blob underwater. Found nothing !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_21_01_23_04_0623a997f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

