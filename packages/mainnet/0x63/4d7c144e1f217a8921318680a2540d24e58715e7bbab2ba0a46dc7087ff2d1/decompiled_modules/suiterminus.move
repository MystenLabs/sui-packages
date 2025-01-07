module 0x634d7c144e1f217a8921318680a2540d24e58715e7bbab2ba0a46dc7087ff2d1::suiterminus {
    struct SUITERMINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITERMINUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITERMINUS>(arg0, 6, b"SUITERMINUS", b"TERMINUS", b"Belonging to the first terminal of human civilization, the door of the universe will open here and lead everyone to explore the universe together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1727270645722_c6033e824a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITERMINUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITERMINUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

