module 0xf37c9e70e13a5c98c93f68fa9c042ce27a0263d94d6364026f57022a67ccdaf9::ye {
    struct YE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YE>(arg0, 9, b"YE", b"Kanye West", b"My name is Kanye and i love walking around completely naked.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcqjuRo4JRWqDS7nZPBGySE986QQ1ZvNYNoKhcX4ytwdd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

