module 0x77a7ed0ac99e3cb7fceb1b1933238a4edd6a5415a94bb97dc8c0d7af9c86071c::ejjsjd {
    struct EJJSJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EJJSJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EJJSJD>(arg0, 9, b"EJJSJD", b"Rahwjw", b"Dncnnvmg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11c8928a-26cb-4f2a-a4bd-38f8c538d03c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EJJSJD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EJJSJD>>(v1);
    }

    // decompiled from Move bytecode v6
}

