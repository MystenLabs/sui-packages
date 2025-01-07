module 0x40d4587c786e6ddbd111f7fecf1d86a745827cac4491d5bd4cbbfc13791caa6d::pakdidi {
    struct PAKDIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAKDIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAKDIDI>(arg0, 9, b"PAKDIDI", b"Pakadiidi", b"Pak didik ayah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2aaaa705-9f48-437d-b19e-2fb5c124b26e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAKDIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAKDIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

