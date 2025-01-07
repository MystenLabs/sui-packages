module 0x85b6d53ae7bdda8d752350818a13bfb4cf847db28e21b9e5f6159c873c3cd691::aaaaaa {
    struct AAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAA>(arg0, 6, b"AAAAAA", b"Hhh", b"Iidhbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0441_05c357f28b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

