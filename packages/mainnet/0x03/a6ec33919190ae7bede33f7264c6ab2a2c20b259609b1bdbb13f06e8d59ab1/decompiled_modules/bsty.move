module 0x3a6ec33919190ae7bede33f7264c6ab2a2c20b259609b1bdbb13f06e8d59ab1::bsty {
    struct BSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSTY>(arg0, 9, b"BSTY", b"Besties", b"For besties just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6595f9e4-45b1-4b2f-9df7-be088d9e0d7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

