module 0xf14974d73e920e952b06b3c760e86c6a9a8a810c73a0d4bba269b276fdbb6df::rt {
    struct RT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT>(arg0, 6, b"Rt", b"Robotaxi", b"Robot taxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7135_389575da52.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RT>>(v1);
    }

    // decompiled from Move bytecode v6
}

