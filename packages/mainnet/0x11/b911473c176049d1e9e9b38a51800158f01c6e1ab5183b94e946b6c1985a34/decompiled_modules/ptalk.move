module 0x11b911473c176049d1e9e9b38a51800158f01c6e1ab5183b94e946b6c1985a34::ptalk {
    struct PTALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTALK>(arg0, 9, b"PTALK", b"PitchTalk", b"18", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/431c26e6-5681-4a6b-b58a-164c8770035f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

