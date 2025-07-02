module 0x3f7c14fd5eb3bbc14897405dae31833ce5ad89aea20bef1e6bc0ca18b5d4e48b::sniper {
    struct SNIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPER>(arg0, 6, b"Sniper", b"Snip", b"Dont buy this shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifc2hximc4ph6bebh2whfgrgq7x3rj4432rofxcl4fz3cnccn5tha")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

