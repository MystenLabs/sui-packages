module 0x65a7c20a7620797fbba8edd12f918f19ed9cdfeedf2ae1b54d1a21ed5e4fbd40::jd {
    struct JD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JD>(arg0, 9, b"JD", b"Jdao", b"Making a community happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f724e47-41d4-43a0-b654-a574cd0e6ce1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JD>>(v1);
    }

    // decompiled from Move bytecode v6
}

