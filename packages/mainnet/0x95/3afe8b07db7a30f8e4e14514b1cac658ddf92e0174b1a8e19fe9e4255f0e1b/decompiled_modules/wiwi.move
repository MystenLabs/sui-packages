module 0x953afe8b07db7a30f8e4e14514b1cac658ddf92e0174b1a8e19fe9e4255f0e1b::wiwi {
    struct WIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIWI>(arg0, 9, b"WIWI", b"WIWI AI", b"WIWI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f18b42b-f0f0-4cea-81e8-6e0ca3ad59ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

