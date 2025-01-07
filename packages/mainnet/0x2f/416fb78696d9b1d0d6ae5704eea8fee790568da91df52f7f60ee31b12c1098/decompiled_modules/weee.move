module 0x2f416fb78696d9b1d0d6ae5704eea8fee790568da91df52f7f60ee31b12c1098::weee {
    struct WEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEE>(arg0, 9, b"WEEE", b"Weeders", b"A token to legalize marijuana across the globe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/405a0911-39c7-4013-93c2-d5e7d63c6237.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

