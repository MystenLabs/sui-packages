module 0xd45009a4d1515e5d3f0252bf5219311a87d64bfc0a06e57993625a971b456ae0::gb {
    struct GB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GB>(arg0, 6, b"GB", b"Grand Blue", b"Grand Blue Anime", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidpsbxxhsgsan3frhisnylyawr7dor4g2f7gyj6ockstdxj5vju4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

