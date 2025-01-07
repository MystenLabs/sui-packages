module 0x4e8bf02be7e4fb23a9d66b235b4065fb0532fcd2a6447a552bf25ac3e5e9eb56::blup {
    struct BLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUP>(arg0, 6, b"BLUP", b"Blup", b"Welcome to my world! Im your fun-loving, blue-furred pup with tons of energy and a big heart. My tail never stops wagging, and while Im all about the cuteness, dont underestimate me, Ive got some serious bite when its time to get fierce!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037743_e1ae77d640.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

