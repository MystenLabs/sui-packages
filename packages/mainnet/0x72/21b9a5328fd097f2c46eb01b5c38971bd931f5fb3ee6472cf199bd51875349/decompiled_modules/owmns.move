module 0x7221b9a5328fd097f2c46eb01b5c38971bd931f5fb3ee6472cf199bd51875349::owmns {
    struct OWMNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWMNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWMNS>(arg0, 9, b"OWMNS", b"geken", b"veve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a629c8d-8304-4632-9a2b-4a7a096833f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWMNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWMNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

