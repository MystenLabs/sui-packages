module 0xe8d7491510634b4ada26044f0150e0e1991741a0120e1e22ae459043c9de68b2::sbo {
    struct SBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBO>(arg0, 6, b"SBO", b"SUIBO", b"The First Ever SocialFi NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibo55py7yx2nygeimv6pizbzjx2qkr7y75okxeidzhp52m2qbspoe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

