module 0xb3ff775cc3bf6b8f2442818384419f1b927169763074e283cc017c7195853aad::np {
    struct NP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NP>(arg0, 9, b"NP", b"Phong", x"4e6869e1babf702050686f6e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b68db35d-87fd-4080-857f-06fd4198a823.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NP>>(v1);
    }

    // decompiled from Move bytecode v6
}

