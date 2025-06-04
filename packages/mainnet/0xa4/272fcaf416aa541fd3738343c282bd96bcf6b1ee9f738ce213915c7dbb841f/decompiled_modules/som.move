module 0xa4272fcaf416aa541fd3738343c282bd96bcf6b1ee9f738ce213915c7dbb841f::som {
    struct SOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOM>(arg0, 6, b"SOM", b"Sui orca mookie", b"Jajana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgdkpbmmxv766vlmlgaro3sxbunbbutumqphs5b6dm4avooosp3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

