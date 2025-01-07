module 0xb7f02a1cb2204ff84256d28b9d630d6498ad7442ae4efb7f3f2fdb71f17f7d8c::cigbwutt {
    struct CIGBWUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIGBWUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIGBWUTT>(arg0, 6, b"CIGBWUTT", b"CIGAWETTE BWUTT", b"just a lil viral cigawette butt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cwug_5c819f4f0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIGBWUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIGBWUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

