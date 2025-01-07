module 0xf94058de925c5deb39a4e0476ed8c63fee8c479a86b5c20f2d8bccd15b2c35ab::bwob {
    struct BWOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWOB>(arg0, 6, b"BWOB", b"Bwob", b"just a BWOB on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_Zquu_CO_400x400_3218a351ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

