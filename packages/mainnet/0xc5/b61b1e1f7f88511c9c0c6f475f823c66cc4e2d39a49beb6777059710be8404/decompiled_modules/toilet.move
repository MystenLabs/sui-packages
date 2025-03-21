module 0xc5b61b1e1f7f88511c9c0c6f475f823c66cc4e2d39a49beb6777059710be8404::toilet {
    struct TOILET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOILET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOILET>(arg0, 6, b"Toilet", b"Toilet Dust", b"The first degen coin on Sui perfect for those who believe the only thing more volatile than the market is their bathroom habits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4034_ef8df5844a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOILET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOILET>>(v1);
    }

    // decompiled from Move bytecode v6
}

