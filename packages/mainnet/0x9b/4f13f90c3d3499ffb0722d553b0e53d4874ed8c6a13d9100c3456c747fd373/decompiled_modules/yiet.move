module 0x9b4f13f90c3d3499ffb0722d553b0e53d4874ed8c6a13d9100c3456c747fd373::yiet {
    struct YIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIET>(arg0, 6, b"YIET", b"YIET BEAR", b"Eat, sleep, yiet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2222222_379c75f7b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YIET>>(v1);
    }

    // decompiled from Move bytecode v6
}

