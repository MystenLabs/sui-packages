module 0x558243da9a1beafcb1a80a6ba2cd8aebc011435160544f0b8cc9175a5f82a81d::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"BREAD", b"Bready", b"If life feeling raw. maybe you need a little $BREAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkgdzemyfevchgyckp7p7vpn7jll5dky4xtvolcvgvz4wjbwvxgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BREAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

