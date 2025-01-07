module 0xaa7475ec3b81367900efc9a8bfa80b0a0295e5ce48ba97a88850085da396d43d::catwave {
    struct CATWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWAVE>(arg0, 9, b"CATWAVE", b"catwave", b"cat meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f82b2d3c-626d-40c2-9987-7b1e2ad1d4a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

