module 0x6fb6acf7c9b0b3fcbe2e1a7c94279daecfd040d0b3649b3184e6ca2695980eb2::bluechip {
    struct BLUECHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECHIP>(arg0, 6, b"BLUECHIP", b"Blue Chip", b"A blue potato mfer stands alone as the sole blue-chip memecoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ddbe276b_62ab_4b84_9c70_0a331283b11b_5f7f063e1d_c2632ba27c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

