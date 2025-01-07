module 0x70da3874fc5cdb89af21800b1f77cb51fe6e4c20ae7c7f0ea432f2e8f1633e5d::baln {
    struct BALN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALN>(arg0, 9, b"BALN", b"Ballooon ", b"Balloons go high into the sky when they're pumped. Ballooon is the next big thing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dedb271e-d302-4b75-9521-a04edf26fc32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALN>>(v1);
    }

    // decompiled from Move bytecode v6
}

