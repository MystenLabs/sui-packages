module 0x61c678602dd6a21f11d2d42bb3b11259cedec124ec9f5ffc145c472f99c9e88a::skrag {
    struct SKRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKRAG>(arg0, 6, b"Skrag", b"Skragles", b"Skragles was once a beautiful cat with spunk.  After clawing his way through the Sui trenches he became addicted to drugs and alcohol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihkwi2iybzfn4gg6qzkd75ejpb7mofpmeesd3pcff6xu6n42joswa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKRAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

