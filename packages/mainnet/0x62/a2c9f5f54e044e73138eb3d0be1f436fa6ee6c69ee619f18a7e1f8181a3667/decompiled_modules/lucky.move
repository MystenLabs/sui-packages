module 0x62a2c9f5f54e044e73138eb3d0be1f436fa6ee6c69ee619f18a7e1f8181a3667::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY>(arg0, 6, b"LUCKY", b"Lucky on Sui", b"Together with Lucky, a memecoin full of intelligence, is here to make all traders always LUCKY against other meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigjphkjqlbc72qonk3kpskfxu3brxyzdvfoxg235hhpjzyofyadha")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

