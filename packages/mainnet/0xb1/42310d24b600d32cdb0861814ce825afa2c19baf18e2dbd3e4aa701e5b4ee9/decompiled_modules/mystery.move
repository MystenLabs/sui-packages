module 0xb142310d24b600d32cdb0861814ce825afa2c19baf18e2dbd3e4aa701e5b4ee9::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MYSTERY>(arg0, 6, b"MYSTERY", b"MYSTERY ON SUIAI", b"The next frog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo2_f2d557caac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYSTERY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

