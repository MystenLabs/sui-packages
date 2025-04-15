module 0x763428582fc6156ce7716a77fd24e8a94b25ffbc9059eff41a4360ce9c5845b::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 6, b"CCC", b"CHA CHA CHA", b"let me cha cha cha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreibqnvgc3qbnwdekio2i5mbstia2czmsesu2xorijfjzr26dvs5hiq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CCC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

