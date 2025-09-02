module 0xfa5b32bc74d486365d8051571a68ae6960e09b3eede04505256c9772b405300e::suiarmy {
    struct SUIARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARMY>(arg0, 6, b"SUIARMY", b"Sui Army", x"5375692041726d792069732061206d6f76656d656e7420746861742077617320666f7267656420696e207468652066697265206f6620747269616c73206e6f77207765207269736520616761696e202d207374726f6e6765722c20626f6c64657220616e6420756e73746f707061626c652e0a546f6765746865722077652077696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidt2e767oojwwaw4kt6rks75thbqbc3zk3vbxzwqj67dkb66scgs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIARMY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

