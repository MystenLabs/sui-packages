module 0x917a5196253df5346e3df6241d1e7c11e008e28c469966b75445719edca7d830::rtwr {
    struct RTWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTWR>(arg0, 9, b"RTWR", b"RED TOWER", b"REEEED TOWEEEER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f827eeb-7821-4a3a-b339-2ddeb05574f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

