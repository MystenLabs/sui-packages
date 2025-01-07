module 0x689743a62b08b7794f50f22d725f58976ad4881b1a0141d4de357180e5412196::tinny {
    struct TINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINNY>(arg0, 6, b"TINNY", b"TinnyTheRhino", b"Meet Tinny! The newest Baby Rhino in town.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tin_b6f01039e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

