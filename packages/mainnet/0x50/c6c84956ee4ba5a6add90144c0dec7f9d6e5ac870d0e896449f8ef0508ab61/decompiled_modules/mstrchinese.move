module 0x50c6c84956ee4ba5a6add90144c0dec7f9d6e5ac870d0e896449f8ef0508ab61::mstrchinese {
    struct MSTRCHINESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTRCHINESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTRCHINESE>(arg0, 6, b"MSTRCHINESE", b"MATR 2100 (CN)", b"MSTR CN ON SUI https://cn.mstr2100.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3801_0959effd03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTRCHINESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSTRCHINESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

