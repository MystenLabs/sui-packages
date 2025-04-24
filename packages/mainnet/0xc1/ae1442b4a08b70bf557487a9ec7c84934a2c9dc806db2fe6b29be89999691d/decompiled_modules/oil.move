module 0xc1ae1442b4a08b70bf557487a9ec7c84934a2c9dc806db2fe6b29be89999691d::oil {
    struct OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIL>(arg0, 6, b"OIL", b"Sui Niggas", b"Welcome to the Emirate of Sand Niggas. The Only Royalty That Matters! $OIL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013548_6cc10adfcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

