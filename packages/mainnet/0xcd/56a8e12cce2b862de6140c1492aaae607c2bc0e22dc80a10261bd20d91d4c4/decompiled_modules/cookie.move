module 0xcd56a8e12cce2b862de6140c1492aaae607c2bc0e22dc80a10261bd20d91d4c4::cookie {
    struct COOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKIE>(arg0, 6, b"Cookie", b"Cookie Sui", b"COOKIE \"JUST OM NOM NOM!!!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihl6wq6yt7hyn6kzvkgwvvabrgs5jdp3yfwqrr2puvkzhutpruvuu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COOKIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

