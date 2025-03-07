module 0x1ef42c0016f781c0b202940cfee9f72a831c2706c1818906809e5aa342f80e52::coffee {
    struct COFFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFEE>(arg0, 6, b"Coffee", b"CoffeeUp", b"Fueling the crypto scene with robust energy, we rise above the blandness of matcha. Join the caffeinated revolution Coffee up, matcha down!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_coffee_king_0fcc97116f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COFFEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

