module 0x4bcdf5b788a79df3d6dc801e72b73e2c645f946de99a3436df05954a3a08eb8::dird {
    struct DIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIRD>(arg0, 9, b"DIRD", b"Dirdu Sweu", b"Probably something ))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00d4aeda-f8ee-4865-84a7-f059467a64cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

