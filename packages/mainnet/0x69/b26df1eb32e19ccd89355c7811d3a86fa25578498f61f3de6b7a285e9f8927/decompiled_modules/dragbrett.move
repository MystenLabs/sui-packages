module 0x69b26df1eb32e19ccd89355c7811d3a86fa25578498f61f3de6b7a285e9f8927::dragbrett {
    struct DRAGBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGBRETT>(arg0, 6, b"DRAGBRETT", b"DRAGBRETT SUI", x"4f6e6365206120677265617420647261676f6e20736f6172696e672074686520736b79206e6f7720636f6d657320746f2053554920746f20646f6d696e61746520746865207365612e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_182c21fb9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

