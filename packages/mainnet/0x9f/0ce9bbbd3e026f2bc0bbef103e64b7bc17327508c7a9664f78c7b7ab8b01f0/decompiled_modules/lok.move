module 0x9f0ce9bbbd3e026f2bc0bbef103e64b7bc17327508c7a9664f78c7b7ab8b01f0::lok {
    struct LOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOK>(arg0, 6, b"LOK", b"LOKI", b"Loki in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwytujztfoyuxma75u6zwzvvgwxrwkzmywjry7gaose3sbs3j2te")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

