module 0x2e3ddf27b9fe428f088109ce8ce94d82a224319f1924551a9f0c74c83d597186::gorciq {
    struct GORCIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORCIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORCIQ>(arg0, 6, b"GORCIQ", b"Gorcique", b"New fish on the block", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EB_401_BB_8_A396_469_C_8_BE_4_0889_F3_B7_AFCA_775978be1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORCIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORCIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

