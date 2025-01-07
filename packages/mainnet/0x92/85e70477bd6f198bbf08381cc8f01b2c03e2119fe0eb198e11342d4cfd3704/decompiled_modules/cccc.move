module 0x9285e70477bd6f198bbf08381cc8f01b2c03e2119fe0eb198e11342d4cfd3704::cccc {
    struct CCCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCCC>(arg0, 9, b"CCCC", b"CCC", b"CCCCCC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file.walletapp.waveonsui.com/images/wave-pumps/6edbd2a5-2ec6-4a30-9971-60121bd5a160.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

