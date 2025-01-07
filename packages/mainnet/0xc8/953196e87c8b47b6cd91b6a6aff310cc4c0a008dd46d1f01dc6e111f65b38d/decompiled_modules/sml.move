module 0xc8953196e87c8b47b6cd91b6a6aff310cc4c0a008dd46d1f01dc6e111f65b38d::sml {
    struct SML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SML>(arg0, 9, b"SML", b"Small mush", b"Small mushroom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ee7d25a-5f2c-4d7b-b683-7f02ce5c6a07.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SML>>(v1);
    }

    // decompiled from Move bytecode v6
}

