module 0xed3dae706a59b21a493e3655a755fa47af2f3fccee31e19faf9e67f11f1515b1::ssd {
    struct SSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSD>(arg0, 6, b"SSD", b"SoulSeed", b"UGC Gaming Platform for creators, collectors and online communities. Building on SUI network for maximum cross-chain power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia6ygzqnouarnsz6zduw3mpiiarsdhnermude4xbfr47texgacwpq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

