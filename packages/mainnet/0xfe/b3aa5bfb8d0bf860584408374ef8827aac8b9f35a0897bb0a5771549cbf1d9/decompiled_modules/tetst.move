module 0xfeb3aa5bfb8d0bf860584408374ef8827aac8b9f35a0897bb0a5771549cbf1d9::tetst {
    struct TETST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETST>(arg0, 6, b"TETST", b"TEST", b"AFSFASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifp7vikcbdknupudjetcx5oujfadfmfytwi5bvk37qqndue6fp2u4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TETST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

