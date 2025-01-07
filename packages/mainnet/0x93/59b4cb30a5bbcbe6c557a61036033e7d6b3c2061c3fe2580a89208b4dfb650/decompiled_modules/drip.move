module 0x9359b4cb30a5bbcbe6c557a61036033e7d6b3c2061c3fe2580a89208b4dfb650::drip {
    struct DRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIP>(arg0, 6, b"DRIP", b"Drip", b"Little Drip wanted to challenge his big brother, Plop. Plop was loud and made big waves, but Drip felt small and brave. With a happy jump, he splashed into the world, ready to show that even tiny droplets could have fun and make their own waves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_6_512365a02b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

