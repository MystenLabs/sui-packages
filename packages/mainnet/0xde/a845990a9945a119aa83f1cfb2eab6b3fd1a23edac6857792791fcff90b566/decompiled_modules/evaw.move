module 0xdea845990a9945a119aa83f1cfb2eab6b3fd1a23edac6857792791fcff90b566::evaw {
    struct EVAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAW>(arg0, 9, b"EVAW", b"evaw meme", b"evaw on wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/102131db-20d6-47c1-931c-d6b4288383cb-GQ-tQ9DbwAQggAN.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

