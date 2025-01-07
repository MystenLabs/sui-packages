module 0x7699345c774c22903869ea376d639bc43ec0557f01117ab34c34c9f734a0b2b1::bspl {
    struct BSPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSPL>(arg0, 9, b"BSPL", b"SLEEP", b"BABY SLEEP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/202f4167-6f9c-47db-9302-c0b2fa236c74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

