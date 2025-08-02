module 0xc7cfc2f59d2380abf59dd43e29b62d4d0bafaf5d641ce46ad440ef4423e762e9::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 6, b"Spx", b"Spx6900", b"THE POWER OF BELIEVE. BELIEVE IN SOMETHING!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiacfkl6kyhuqlxeaaapy2ysoxyf26gwcyoxvbelchsjscxfq6ciba")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

