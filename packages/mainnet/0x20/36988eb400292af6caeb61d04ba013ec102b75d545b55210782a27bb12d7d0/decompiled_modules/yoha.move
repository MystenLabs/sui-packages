module 0x2036988eb400292af6caeb61d04ba013ec102b75d545b55210782a27bb12d7d0::yoha {
    struct YOHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOHA>(arg0, 6, b"Yoha", b"Jea Yoha", b"Jea hi measter Yoha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_2_e777737d99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

