module 0x8e79884b35ee18f00763c5353e3ead8c8031f181ef195579acf5cf1968913fa9::xx {
    struct XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XX>(arg0, 6, b"XX", b"Chromosome", b"From double helix to double gains. Join the $XX revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib3rtlzyr46bz3yu7oofc7kpdqalbtenfokjatk3mnqllknetshxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

