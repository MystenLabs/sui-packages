module 0x3a44df5f38d848e634ece131272fc26a42ba4dae55fea62ebfba176a3d90deb5::hana {
    struct HANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANA>(arg0, 9, b"HANA", b"HANASUI", b"This 100% community-driven memecoin is built to fulfill the community's mission. The developer will not sell any tokens, ensuring all control stays with the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/705f3f58-26a4-4876-b35b-cec114e9486d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

