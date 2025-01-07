module 0x1bbb5fb0b82aa2a331387c5279c2e8f4be3f56644ae4e5966a3489090cfb8540::makkakka {
    struct MAKKAKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKKAKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKKAKKA>(arg0, 6, b"MAKKAKKA", b"MAKKAKKAMAKKAKKA", b"MAKKAKKAMAKKAKKAMAKKAKKAMAKKAKKA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/solana_sol_logo_59dbfe208e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKKAKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKKAKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

