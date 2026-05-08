module 0xa7d139d72ebfc0d3cf6ea10b88f708bd36a3f44ed582682e281e433423d0e474::ggg {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGG>(arg0, 6, b"GGG", b"aaa", b"SSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiffctnrlk3cnhzdi7eywfxmsns4ac46w2om4xd5lyfhu632itf5ky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GGG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

