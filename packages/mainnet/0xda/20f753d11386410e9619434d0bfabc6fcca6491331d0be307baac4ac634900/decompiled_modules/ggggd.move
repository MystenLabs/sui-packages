module 0xda20f753d11386410e9619434d0bfabc6fcca6491331d0be307baac4ac634900::ggggd {
    struct GGGGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGGGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGGGD>(arg0, 6, b"GGGGD", b"Gedagedigedagedado", b"Gedagedigeda geda do", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gggd_6810f1cbc2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGGGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGGGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

