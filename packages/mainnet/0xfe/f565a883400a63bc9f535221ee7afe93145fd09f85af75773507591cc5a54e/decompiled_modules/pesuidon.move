module 0xfef565a883400a63bc9f535221ee7afe93145fd09f85af75773507591cc5a54e::pesuidon {
    struct PESUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESUIDON>(arg0, 6, b"PESUIDON", b"PESUID0N", b"The god of seven seas and memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_02_02_15_acf3aa8540.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

