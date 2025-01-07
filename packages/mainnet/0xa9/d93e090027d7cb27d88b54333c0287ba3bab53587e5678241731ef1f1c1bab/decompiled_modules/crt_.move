module 0xa9d93e090027d7cb27d88b54333c0287ba3bab53587e5678241731ef1f1c1bab::crt_ {
    struct CRT_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRT_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRT_>(arg0, 9, b"CRT_", b"Creative ", b"Creative is a fun meme depicting a new technology ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a66822e-b98c-4bcd-adf2-ce81cc082e32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRT_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRT_>>(v1);
    }

    // decompiled from Move bytecode v6
}

