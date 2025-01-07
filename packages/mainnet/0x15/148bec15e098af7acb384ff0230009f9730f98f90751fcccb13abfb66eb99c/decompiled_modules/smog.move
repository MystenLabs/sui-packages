module 0x15148bec15e098af7acb384ff0230009f9730f98f90751fcccb13abfb66eb99c::smog {
    struct SMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOG>(arg0, 6, b"SMOG", b"SmogonSui", x"534d4f470a546865204772656174657374205375692041697264726f70206f6620416c6c2054696d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Lv_Y_Lt_G_400x400_d76b3c7c4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

