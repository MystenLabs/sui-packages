module 0x33f8293b195ffbc769a2ce73690b89132d1b00ba3b283dbd62e5b56db1e3f3f::lily {
    struct LILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILY>(arg0, 9, b"LILY", b"LILY Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZkNejmPt4wGCYfw3F28qio76p1YkXGqe8ZsZ4oJqLPmg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LILY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LILY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

