module 0x4d1ec21fa2607a87c308b87d5bd21928f56a21e185a4665bdcf646b62f8dc096::zogi {
    struct ZOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOGI>(arg0, 6, b"ZOGI", b"Zogi on sui", b"Zogi came from a distant corner of the galaxy Sui gma 9.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigwzt42ru3asjq3kxjbenqp24sjtbskkoztc2yepbs3hrlnh2cqni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZOGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

