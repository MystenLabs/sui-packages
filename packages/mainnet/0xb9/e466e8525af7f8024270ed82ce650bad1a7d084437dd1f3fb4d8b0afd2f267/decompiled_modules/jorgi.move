module 0xb9e466e8525af7f8024270ed82ce650bad1a7d084437dd1f3fb4d8b0afd2f267::jorgi {
    struct JORGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORGI>(arg0, 9, b"JORGI", b"Jorgi dog", b"Jorgidog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20bfac39-6d5d-4b2f-bf0f-58b0665ffbb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JORGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

