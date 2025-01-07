module 0xc9537c7ec8370dd9cdf531aa5da11eb67fc643146b705de42dda8a523ae2d919::wdogs {
    struct WDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOGS>(arg0, 9, b"WDOGS", b"WORK DOGS", b"Telegram Original MeMe Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e17782c-7bf6-4c8b-a2c3-23e0ee12140b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

