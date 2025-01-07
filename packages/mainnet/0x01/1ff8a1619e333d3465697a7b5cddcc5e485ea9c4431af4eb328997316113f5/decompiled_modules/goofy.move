module 0x11ff8a1619e333d3465697a7b5cddcc5e485ea9c4431af4eb328997316113f5::goofy {
    struct GOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFY>(arg0, 6, b"GOOFY", b"Captain GOOFY", b"The greatest fisherman of the ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sf_Y01_K6_C_400x400_180197122d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

