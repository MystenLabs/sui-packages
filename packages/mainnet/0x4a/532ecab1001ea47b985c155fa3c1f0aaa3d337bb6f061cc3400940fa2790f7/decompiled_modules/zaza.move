module 0x4a532ecab1001ea47b985c155fa3c1f0aaa3d337bb6f061cc3400940fa2790f7::zaza {
    struct ZAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAZA>(arg0, 9, b"ZAZA", b"ZAZA VOU", b"TEAM WORK IS KEY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c0ac93e-e786-41a5-ad25-365914629f86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

