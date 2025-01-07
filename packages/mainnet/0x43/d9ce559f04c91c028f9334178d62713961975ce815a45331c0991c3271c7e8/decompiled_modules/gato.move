module 0x43d9ce559f04c91c028f9334178d62713961975ce815a45331c0991c3271c7e8::gato {
    struct GATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATO>(arg0, 6, b"GATO", b"Cat-Goat", b"The Legend of the Cat-Goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250103_101559_720_ecab9440e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

