module 0xccafa686c690e2337b9d6a38c2320987203f074f4e2d576f4888bdca16b169e7::jokowi {
    struct JOKOWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKOWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKOWI>(arg0, 9, b"JOKOWI", b"JOKOWI ", b"JOKO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e7f3f20-39f9-4e88-938d-b20c6f1d4463.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKOWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKOWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

