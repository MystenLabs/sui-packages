module 0x8f2a04c812713610fe814c8ea05ca4e5345e7616bec0d15140ac931e6d285b3c::hfgd {
    struct HFGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFGD>(arg0, 9, b"HFGD", b"HFJH", b"DHFDH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c715ac99-4d2a-4826-b8f8-732eafa1af63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

