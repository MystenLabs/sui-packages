module 0xb934c58660e54ee1acbddd5af4b319e03267fd683de361ac56348e006568f941::blobo {
    struct BLOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBO>(arg0, 6, b"BLOBO", b"Blobo", b"Fishiest man on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blobo_c7c0012441.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

