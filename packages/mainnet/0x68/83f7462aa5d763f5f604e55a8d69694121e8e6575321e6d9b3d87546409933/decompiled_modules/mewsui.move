module 0x6883f7462aa5d763f5f604e55a8d69694121e8e6575321e6d9b3d87546409933::mewsui {
    struct MEWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWSUI>(arg0, 9, b"MEWSUI", b"JustinMoon", b"Mew mew mew !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/898b7777-ce1a-4d72-9c9e-1b1758054cc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

