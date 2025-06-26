module 0xa7dcec13a47365198a86eff4652c8fabb07eac950993ab6daef4b2ab1754e2d3::fgd {
    struct FGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGD>(arg0, 6, b"FGD", b"sdfsdf", b"sdfsdf sdfsdf sdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidlmjjwtnwdn5cdzt32e33yziz77c5nnx2wvvzluanevrtt4iswfi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FGD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

