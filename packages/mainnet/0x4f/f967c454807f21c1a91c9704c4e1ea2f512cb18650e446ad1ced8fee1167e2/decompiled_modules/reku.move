module 0x4ff967c454807f21c1a91c9704c4e1ea2f512cb18650e446ad1ced8fee1167e2::reku {
    struct REKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKU>(arg0, 9, b"REKU", b"Rekucoon", b"Reku racoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72c8d4c9-5f06-4b21-acdc-5345f0153ec4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

