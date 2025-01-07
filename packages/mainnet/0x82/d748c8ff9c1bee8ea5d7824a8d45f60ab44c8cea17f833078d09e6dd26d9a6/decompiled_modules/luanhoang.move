module 0x82d748c8ff9c1bee8ea5d7824a8d45f60ab44c8cea17f833078d09e6dd26d9a6::luanhoang {
    struct LUANHOANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUANHOANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUANHOANG>(arg0, 9, b"LUANHOANG", b"Neirro", x"48c3a0692068c6b0e1bb9b6320767569206e68e1bb996e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3800f1aa-50b7-49c6-a9c7-414b3a4e94aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUANHOANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUANHOANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

