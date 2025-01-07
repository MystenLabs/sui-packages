module 0x7a177d529943abebbd9b7ca78bf9f3966f6a820592be988a3bc0ed37429c1f20::btram {
    struct BTRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTRAM>(arg0, 9, b"BTRAM", b"BTr", b"B tram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df65d0ac-baf0-4bff-bbf5-7ad1644a628e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTRAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTRAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

