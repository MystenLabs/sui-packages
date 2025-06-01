module 0x6b562cf61b890e5814a45614b6743d5e7bf66a813c257f56b9861acc98e1feff::sugi {
    struct SUGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGI>(arg0, 6, b"SUGI", b"Sugi The dog", x"535547492069732061206d656d652d626173656420746f6b656e2c206372656174656420707572656c7920666f720a656e7465727461696e6d656e7420707572706f7365732c2077697468206e6f20696e7472696e7369632066696e616e6369616c2076616c7565206f720a6578706563746174696f6e206f662070726f666974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiagwefwrpqmjqabsufbutqjq7lobuwzxrbhlh4tyofjveih4wsybm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

