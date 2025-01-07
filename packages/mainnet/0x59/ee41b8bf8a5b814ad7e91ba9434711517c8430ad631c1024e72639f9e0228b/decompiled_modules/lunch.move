module 0x59ee41b8bf8a5b814ad7e91ba9434711517c8430ad631c1024e72639f9e0228b::lunch {
    struct LUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNCH>(arg0, 6, b"LUNCH", b"Lunch Money", x"446f6e27742073656c6c20666f72204c756e6368204d6f6e6579210a43616c6c696e67206f7574206a6565747321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030541_d5c54e71ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

