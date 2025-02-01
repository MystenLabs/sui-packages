module 0x2e6960ca1afa5caaa2cab4ec9f5b4e2899a68b8186c9404e573eafa0980893e3::ana {
    struct ANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANA>(arg0, 9, b"Ana", b"Ana Destierro", b"Latest ICE arrest has Arizonans questioning deportation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUkPtPnJyKmHBfpGdz8LTT4KrUNYVGcUc1ymkvqSHyVUQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

