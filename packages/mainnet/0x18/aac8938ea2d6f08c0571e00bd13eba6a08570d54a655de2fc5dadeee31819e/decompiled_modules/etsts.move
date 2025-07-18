module 0x18aac8938ea2d6f08c0571e00bd13eba6a08570d54a655de2fc5dadeee31819e::etsts {
    struct ETSTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETSTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETSTS>(arg0, 6, b"ETSTS", b"TEST", b"testst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifp7vikcbdknupudjetcx5oujfadfmfytwi5bvk37qqndue6fp2u4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETSTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ETSTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

