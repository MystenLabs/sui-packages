module 0x38d750c7f7f43635544d252fa9b113183166997000f3f41d50d6cd358942279b::Minioonz {
    struct MINIOONZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIOONZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIOONZ>(arg0, 9, b"MNOON", b"Minioonz", x"536d616c6c2079656c6c6f77206368616f7320776f726b6572732077686f2070726573732072616e646f6d20627574746f6e7320616e6420736f6d65686f772070756d702065766572797468696e672e204a757374204d4e4f4f4f4e2120f09f8d8c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://patara.app/images/meme-coin-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINIOONZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIOONZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

