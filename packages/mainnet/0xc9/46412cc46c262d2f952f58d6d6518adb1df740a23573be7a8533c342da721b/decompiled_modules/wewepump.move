module 0xc946412cc46c262d2f952f58d6d6518adb1df740a23573be7a8533c342da721b::wewepump {
    struct WEWEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEPUMP>(arg0, 9, b"WEWEPUMP", b"Dabai", b"WEWE COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2c4c8ee-f680-40a4-99b9-c91450094f2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

