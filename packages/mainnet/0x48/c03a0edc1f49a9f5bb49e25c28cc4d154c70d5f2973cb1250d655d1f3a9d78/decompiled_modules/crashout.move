module 0x48c03a0edc1f49a9f5bb49e25c28cc4d154c70d5f2973cb1250d655d1f3a9d78::crashout {
    struct CRASHOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASHOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASHOUT>(arg0, 6, b"CRASHOUT", b"CRASHOUTTT", b"IM GOING TO CRASHOUTTT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7089_644858e4c2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASHOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRASHOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

