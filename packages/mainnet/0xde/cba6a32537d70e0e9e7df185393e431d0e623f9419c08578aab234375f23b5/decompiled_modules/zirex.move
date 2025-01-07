module 0xdecba6a32537d70e0e9e7df185393e431d0e623f9419c08578aab234375f23b5::zirex {
    struct ZIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIREX>(arg0, 6, b"ZIREX", b"Zirex", x"57656c636f6d6520746f20247a69726578207468650a626f78696e6720647261676f6e21205468650a6669727374206f6620697473206b696e642c0a6c616e64696e67206f6e2074686520626173650a6e6574776f726b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_20_35_43_6b361f594c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

