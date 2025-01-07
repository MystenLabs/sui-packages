module 0x3e473d6509a662b3f74ac67bd1f2cce5bd4edcd2bad5bbdc61f52ff951c8aad4::chick {
    struct CHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICK>(arg0, 6, b"CHICK", b"CHICKEN", b"not a meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/87524b6c7ede352393c6b4c9397b22c5_8858a5b03e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

