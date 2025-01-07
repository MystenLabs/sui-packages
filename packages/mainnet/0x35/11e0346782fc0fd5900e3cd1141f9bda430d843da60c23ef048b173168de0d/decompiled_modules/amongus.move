module 0x3511e0346782fc0fd5900e3cd1141f9bda430d843da60c23ef048b173168de0d::amongus {
    struct AMONGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMONGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMONGUS>(arg0, 6, b"AMONGUS", b"AMONGUS SUI", x"24414d4f4e472048415320434f4d4520544f2053554921205448452056455259204649525354204f4620495453204b494e442e0a0a455645525920323420484f5552532041204c55434b5920484f4c4445522057494c4c2042452052414e444f4d4c45592053454c4543544544204153205448452020414e442041495244524f505045442024414d4f4e470a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6895_0ff4f6424d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMONGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMONGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

