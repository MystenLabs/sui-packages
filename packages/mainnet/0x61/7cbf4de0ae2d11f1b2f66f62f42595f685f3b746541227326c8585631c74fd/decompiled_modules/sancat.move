module 0x617cbf4de0ae2d11f1b2f66f62f42595f685f3b746541227326c8585631c74fd::sancat {
    struct SANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANCAT>(arg0, 6, b"SANCAT", b"SANTA POPCAT", x"53414e544120504f5043415420696e20616e6f7468657220756e6976657273652069732074686520504f5043415420756e697665727365212120496620796f75206d69737320504f5043415420646f6e2774206d6973732053414e544120504f504341542e2048652077696c6c206c65616420757320746f207765616c746820746f67657468657220776974682053414e544120504f504341542e202453414e43415420544f20544845204d4f4f4e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xblov5o2_400x400_8904e53d27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

