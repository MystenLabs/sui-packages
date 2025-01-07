module 0x3a66bf7bb198ec17cbfe24252104a2a24efb2993349e31277822403d290a1c91::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAP>(arg0, 6, b"CAP", b"Captain sui", b"Captain Sui, a giant burger superhero, embarks on an epic quest to conquer the world of cryptocurrency. Armed with secret sauce and blockchain strategy, he battles hackers and virtual scams!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013467_f1d8d22143.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

