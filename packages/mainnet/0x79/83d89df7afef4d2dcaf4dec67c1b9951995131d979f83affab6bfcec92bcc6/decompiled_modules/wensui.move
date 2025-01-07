module 0x7983d89df7afef4d2dcaf4dec67c1b9951995131d979f83affab6bfcec92bcc6::wensui {
    struct WENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENSUI>(arg0, 6, b"WENSUI", b"WEN SUI", b"Sui on Phantom WEN?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_29_16_16_29_01f8a44f8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

