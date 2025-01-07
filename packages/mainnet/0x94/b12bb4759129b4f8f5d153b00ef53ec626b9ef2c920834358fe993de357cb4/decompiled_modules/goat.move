module 0x94b12bb4759129b4f8f5d153b00ef53ec626b9ef2c920834358fe993de357cb4::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Greatest Of All Tickers", b"Greatest Of All Tickers - GOAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Bw482yytoa_W3as_Y_Bx_PQ_9jz66_Zt_Xeg6_Z7_MXF_7b9_Xpump_7ed8eeae40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

