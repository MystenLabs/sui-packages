module 0x5869cb2ea34c605693a7b07a79f13678e3c4ec4b08ec426d20ac58f6a0ec35c1::lry {
    struct LRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LRY>(arg0, 6, b"LRY", b"Larry Sui", b"LRY THE COAST GUARD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie6c2d3mvadlqvbnxj4j2bgtookacsdmaybuxe6p7l6veww2s5bue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

