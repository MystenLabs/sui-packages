module 0x443634002e7d253d00d1c215b890d166528c42bcb02a7bf5457094c178c025eb::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"MOJO WIF HAT", b"$MOJO is a multi chained project with the aim of making $300k to save his house. Bank will get him out and crypto is his life. We pay the bills.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaazlwdxd2sp45zklrnteb5rx2v62zw2g3wm4xrxzjvsoader77wq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOJO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

