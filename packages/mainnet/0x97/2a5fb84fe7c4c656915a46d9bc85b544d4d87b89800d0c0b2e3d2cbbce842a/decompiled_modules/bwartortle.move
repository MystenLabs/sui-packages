module 0x972a5fb84fe7c4c656915a46d9bc85b544d4d87b89800d0c0b2e3d2cbbce842a::bwartortle {
    struct BWARTORTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWARTORTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWARTORTLE>(arg0, 6, b"BWARTORTLE", b"Baby Wartortle Sui", b"Baby Squirtle Evolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7yzzzzkpxyxaov4ffk5qshgvv5o2jqjlvxgtpd4u52mugyqypki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWARTORTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWARTORTLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

