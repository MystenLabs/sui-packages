module 0xa91884a34aac918251b05f470afb319a3750a64d6ee87bf7924661f4d49d7486::turkey {
    struct TURKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURKEY>(arg0, 6, b"TURKEY", b"Thanksgiving turkey", b"Happy  Thanksgiving", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048489_ccce188ba7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

