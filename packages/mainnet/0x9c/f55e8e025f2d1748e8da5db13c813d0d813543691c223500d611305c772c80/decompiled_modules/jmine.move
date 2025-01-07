module 0x9cf55e8e025f2d1748e8da5db13c813d0d813543691c223500d611305c772c80::jmine {
    struct JMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMINE>(arg0, 9, b"JMINE", b"Jauwalmini", b"For birthday party celebrating", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cd5d0d4-6c7a-45d5-9063-33c44ffb772a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

