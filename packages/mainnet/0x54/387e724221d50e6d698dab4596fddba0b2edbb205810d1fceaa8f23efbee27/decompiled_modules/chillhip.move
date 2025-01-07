module 0x54387e724221d50e6d698dab4596fddba0b2edbb205810d1fceaa8f23efbee27::chillhip {
    struct CHILLHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLHIP>(arg0, 6, b"CHILLHIP", b"CHILLHIPP", b"CHILLING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6236_3b69f70392.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

