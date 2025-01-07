module 0x7341a9b128007d30f78eb7501a77a7d3d61312922bb2ffb32e0dd5f2cc873ff5::sux {
    struct SUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUX>(arg0, 6, b"SUX", b"SUI XSP", b"First XSP on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0095_160d0649d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

