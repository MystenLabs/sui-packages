module 0x810f94670340dbb89a4df108b12079863c1c48e4f9d4fba51e736f2d00734006::tons {
    struct TONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONS>(arg0, 6, b"TONs", b"TON SUI", x"20425559204e4f57204e4f57202024544f4e730a2b313030302520206e657874206d6f6e74687320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5414_15f575a44e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

