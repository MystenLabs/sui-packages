module 0x9674389e898982b0d6db805e91cf5e5f2a4fa139d03c3048c664ba5cfa0bba4b::movedeng {
    struct MOVEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDENG>(arg0, 6, b"MOVEDENG", b"MoveDeng", b"Just a viral lil' hippo riding the power of Move language on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000196_8516bbe1ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

