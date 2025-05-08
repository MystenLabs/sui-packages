module 0x5196bf6cd2e80527aab61692e20d0a013ac8574d5c2275a813fb7605fec29567::kab {
    struct KAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAB>(arg0, 6, b"KAB", b"ksl", b"gawd of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigfemago7blpuujij367ihmgfenaubwjmqah7ehnlgm3jf7wsvzkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

