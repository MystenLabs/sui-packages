module 0x2843ddc102e59a3e053a7a782ae9da90c7c2102f5f848ac7cb8c289cb0856eb9::hbdba {
    struct HBDBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBDBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBDBA>(arg0, 9, b"HBDBA", b"Fha", b"Hjavs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee810c5c-1a1c-453c-944c-ed7cee221854.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBDBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HBDBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

