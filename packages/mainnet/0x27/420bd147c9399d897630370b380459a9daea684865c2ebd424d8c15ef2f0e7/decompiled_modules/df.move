module 0x27420bd147c9399d897630370b380459a9daea684865c2ebd424d8c15ef2f0e7::df {
    struct DF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DF>(arg0, 9, b"DF", b"KJH", b"BBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10efef98-3dc9-46e8-a0d0-558d6d322fb2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DF>>(v1);
    }

    // decompiled from Move bytecode v6
}

