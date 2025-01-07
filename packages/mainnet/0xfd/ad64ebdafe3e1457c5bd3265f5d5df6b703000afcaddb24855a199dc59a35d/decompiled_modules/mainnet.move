module 0xfdad64ebdafe3e1457c5bd3265f5d5df6b703000afcaddb24855a199dc59a35d::mainnet {
    struct MAINNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAINNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAINNET>(arg0, 9, b"MAINNET", b"MAINNET", b"test test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXQ9AdD79cJJFuvvKK7mT4bcY7Q4bJJBxGNYJjbntGgPs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAINNET>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAINNET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAINNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

