module 0x7a7cb9f149a52754aed1859b98b7384986787f498f39bbfa2359933f59adfd8a::jjc {
    struct JJC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJC>(arg0, 6, b"JJC", b"Jeff Coin", b"May (or may not) be used to procure legal services.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiau2pxpysydiximvqlssxcf4caesqtu7fkb6r5nwgngpf4xuweuiy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JJC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

