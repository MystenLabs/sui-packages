module 0x637d309a74715c81510a3ec050877b79ddaf2f59fb878e8e7fe15680b068aea::sens {
    struct SENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENS>(arg0, 6, b"SENS", b"SENSUI", b"Our goal is to contribute to and grow the SUI ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4846_8388d0f020.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

