module 0xe147a1c7dc1393540acc8fc4ef73a176625fd63fb2f6550ea4bf4ca5c0edd416::milky {
    struct MILKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKY>(arg0, 6, b"Milky", b"Milky Sui", x"4d696c6b7920697320616c6c207765206e65656420746f2072656761696e20656e657267790a616e6420636f6e74696e75652074726164696e67206c696b6520610a70726f66657373696f6e616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifd4sa4zb4fnmojgjd25mv63aq42gfsjdcz6p2tlb6ksvntyafac4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MILKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

