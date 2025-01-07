module 0xea505f505a0a33bb312e45217bec0e8bbc0034cbb69e0b8368ed6fce367f750f::sneiro {
    struct SNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEIRO>(arg0, 9, b"SNEIRO", b"Neiro First in Sui", b"Neiro Token Is meme Famoust ,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmYm9rJSdYv8byfhLg7GKSQKxGDRbSdvHfs3G9wwWagFXx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNEIRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

