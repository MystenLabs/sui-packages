module 0x849340ea9d8ab5bed76b54f6162acf535760e02d52274c23978d8cc1cd2e42fa::gemfighter {
    struct GEMFIGHTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMFIGHTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMFIGHTER>(arg0, 6, b"GEMFIGHTER", b"Gem Fighter", b"A fractured world. Hidden tech. The spark of something bigger.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgnqh4z73zddgq7f6fdig2mbp6zaw4fpotiq7azh6lmdapu6yjxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMFIGHTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEMFIGHTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

