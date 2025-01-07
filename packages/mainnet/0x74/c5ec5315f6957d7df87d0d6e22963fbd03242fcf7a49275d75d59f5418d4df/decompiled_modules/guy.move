module 0x74c5ec5315f6957d7df87d0d6e22963fbd03242fcf7a49275d75d59f5418d4df::guy {
    struct GUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUY>(arg0, 6, b"GUY", b"SUIGUY", b"GUY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_22_23_09_29_417a9549b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

