module 0x31202931bd43c5536e6a2031bed44845afabf36047c532be2c0ddcef40f3a9c1::flat {
    struct FLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAT>(arg0, 9, b"FLAT", b"Flat land", b"And yet it is flat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e56e073-49d8-4491-9e99-fdb6bc5d8399.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

