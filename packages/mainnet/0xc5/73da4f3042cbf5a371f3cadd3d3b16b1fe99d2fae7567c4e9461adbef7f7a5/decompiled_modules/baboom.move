module 0xc573da4f3042cbf5a371f3cadd3d3b16b1fe99d2fae7567c4e9461adbef7f7a5::baboom {
    struct BABOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABOOM>(arg0, 6, b"BABOOM", b"BANANA BOOM", b"The BANANA ZONE HAS COME TO SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BABOOM_2827baf103.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

