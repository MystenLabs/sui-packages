module 0xeb2c6b30872157d44b698b0d4061c74cd0628ba9255d9f753dd1a43619749fff::toon {
    struct TOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOON>(arg0, 6, b"TOON", b"Sui Toon", b"Launch on sui $TOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000380_4841767d8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

