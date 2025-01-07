module 0x1b30f771285af1371bdf4bbc0315e4a2945555eb0a6ad91578d161078557c261::slop {
    struct SLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOP>(arg0, 6, b"SLOP", b"slop", b"SLOP is the story of a unique project in the blockchain world, which began as a failed smart contract experiment but grew into a vibrant digital ecosystem through community resilience and innovation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/type_default_350_0_752c794c78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

