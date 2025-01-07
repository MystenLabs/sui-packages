module 0xab371a5076566bebd93e510e19e1da1d76c3bcae4c6711d21f0eb5eaa00408e2::hboi {
    struct HBOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBOI>(arg0, 9, b"HBOI", b"HEHE BOI", b"HEHE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3961ed9f-1f87-4717-89aa-b2cb23c58dbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HBOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

