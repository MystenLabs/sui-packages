module 0xf89a080970daf3d0aa4e64c63256329ed4e82c97229cf266c320eb5d3aca839c::suik {
    struct SUIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIK>(arg0, 6, b"Suik", b"Sui-king", b"The king of all meme in sui ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1865_16c45308f1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

