module 0x2702a987e2bc974e69294fa0ed3cbcb2a799aba5caf27a28fe62b75e8562d15::subao {
    struct SUBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBAO>(arg0, 6, b"SUBAO", b"suibao", b"The dev are gone, but we will complete the mission of sending the SUBAO Project to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_03_01_37_03_6fd99dfba2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

