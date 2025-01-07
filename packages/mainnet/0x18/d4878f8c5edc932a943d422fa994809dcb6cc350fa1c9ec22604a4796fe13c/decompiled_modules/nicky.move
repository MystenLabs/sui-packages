module 0x18d4878f8c5edc932a943d422fa994809dcb6cc350fa1c9ec22604a4796fe13c::nicky {
    struct NICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICKY>(arg0, 6, b"NICKY", b"Nicki Sui", x"4461207175656e206f66206e6865772079686f726b2069732062616b21204d7920616e614c63754e7464612064657227742e0a0a4d7920616e614c63754e7464612064657227742e204d7920616e614c63754e7464612064657227742077756e74206e6f6e652065726e6c6573732079687220676f742050554d50532c2068756e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_230010_586_49b55914eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

