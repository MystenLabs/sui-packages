module 0xa48345d36f87dd84b3a03f70f40ec0c364d09a5ae36e7d406e2d0a90dd67de0::suiset {
    struct SUISET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISET>(arg0, 6, b"Suiset", b"Suisetdotxyz", b"This is suiset meme token on moonbags. just meme pure meme no bullshit no rug no pain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie64uixcaryzo7n7hhlz3hc5g7hbbmohhx4gtovwvcfu6rnpk5zqm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

