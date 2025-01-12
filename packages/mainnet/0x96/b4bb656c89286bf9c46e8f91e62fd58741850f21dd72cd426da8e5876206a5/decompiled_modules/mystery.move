module 0x96b4bb656c89286bf9c46e8f91e62fd58741850f21dd72cd426da8e5876206a5::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTERY>(arg0, 6, b"MYSTERY", b"Mystery Project", b"The mystery SUI project of 2025.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mys_594d0259b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYSTERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

