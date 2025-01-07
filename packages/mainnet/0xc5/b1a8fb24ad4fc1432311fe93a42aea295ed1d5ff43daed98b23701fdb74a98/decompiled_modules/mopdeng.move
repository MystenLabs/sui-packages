module 0xc5b1a8fb24ad4fc1432311fe93a42aea295ed1d5ff43daed98b23701fdb74a98::mopdeng {
    struct MOPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOPDENG>(arg0, 6, b"MOPDENG", b"MOPDENG SUI", b"Following the footsteps of moodeng, MOPDENG will wipe the floor in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240930_221135_913_c67cf42761.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

