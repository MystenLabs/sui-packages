module 0xafa31b80e047598387be925c816d78c07b6cc6cb8d0e31a0eb26483799d33240::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"SUIN", b"SuiNeiro", x"4272696e67696e6720696e2074686520657468657265756d206e6172726174697665206f6620404e6569726f4f6e457468657265756d20746f2074686520245355492065636f73797374656d200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/View_recent_photos_97b32f5723.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

