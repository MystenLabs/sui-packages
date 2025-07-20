module 0xe5a36b247d3eec25c460bd521e80c5778011b3d9b12553185a80a40da049e7b7::down {
    struct DOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWN>(arg0, 6, b"DOWN", b"TrenchFi", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibycokcsaqiy3ebmrea6hdvvohlf6krntfigquwqs47rjf4sfjnti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOWN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

