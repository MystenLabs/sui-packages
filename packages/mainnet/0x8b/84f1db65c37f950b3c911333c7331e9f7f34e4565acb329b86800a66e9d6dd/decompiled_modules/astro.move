module 0x8b84f1db65c37f950b3c911333c7331e9f7f34e4565acb329b86800a66e9d6dd::astro {
    struct ASTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRO>(arg0, 6, b"ASTRO", b"Astronout Coin", b"$ASTRO $ASTRO $ASTRO $ASTRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_2c9b62b648.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

