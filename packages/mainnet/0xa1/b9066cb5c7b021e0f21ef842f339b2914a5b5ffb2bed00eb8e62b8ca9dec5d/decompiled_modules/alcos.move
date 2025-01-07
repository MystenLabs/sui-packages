module 0xa1b9066cb5c7b021e0f21ef842f339b2914a5b5ffb2bed00eb8e62b8ca9dec5d::alcos {
    struct ALCOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALCOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALCOS>(arg0, 6, b"ALCOS", b"Alcoholics of SUI", x"57656c636f6d6520746f2074686520416c636f686f6c696373206f662053756920436c75620a4865726520776520616c6c2061726520616e6f6e796d6f75732c206e6f206d617474657220796f752061726520616c636f686f6c6963206f72206e6f74207965742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_16_22_24_30_f8c5738d61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALCOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALCOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

