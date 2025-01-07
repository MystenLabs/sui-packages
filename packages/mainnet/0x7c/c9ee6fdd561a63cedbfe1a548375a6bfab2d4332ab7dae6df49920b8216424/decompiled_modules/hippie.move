module 0x7cc9ee6fdd561a63cedbfe1a548375a6bfab2d4332ab7dae6df49920b8216424::hippie {
    struct HIPPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPIE>(arg0, 6, b"HIPPIE", b"Hippie Pepe", b"Just a hippie dude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hippiepepeprof_5b8de1ed53.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

