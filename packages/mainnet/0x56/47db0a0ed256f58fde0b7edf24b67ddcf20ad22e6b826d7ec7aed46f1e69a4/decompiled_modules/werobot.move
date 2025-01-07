module 0x5647db0a0ed256f58fde0b7edf24b67ddcf20ad22e6b826d7ec7aed46f1e69a4::werobot {
    struct WEROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEROBOT>(arg0, 6, b"WeRobot", b"Robot", b"We, Robot. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6482_ebb7d1b8d6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

