module 0x8fe4ed9c372fc5f1fb4c41161b21ebab8489e914d1e5e38c33e41789bfe27760::lordy {
    struct LORDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORDY>(arg0, 6, b"LORDY", b"BLUE LORDY", b"IM THE ORIGINAL FROG ON BASE...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frog_34b4d05d12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

