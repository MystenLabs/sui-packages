module 0xa0222e56b3187337ea38b53240216f3aebd30a2b858b745f72dd23831e94429c::crumb {
    struct CRUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUMB>(arg0, 6, b"CRUMB", b"BreadChain", b"Everyone wants a piece of bread", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifwryk42lsdbwa7jllx7pek23z72uyvhwq3swhnlcvvihfykydsyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRUMB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

