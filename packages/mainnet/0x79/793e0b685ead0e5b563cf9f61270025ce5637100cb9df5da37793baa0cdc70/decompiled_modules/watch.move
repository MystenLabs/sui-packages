module 0x79793e0b685ead0e5b563cf9f61270025ce5637100cb9df5da37793baa0cdc70::watch {
    struct WATCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATCH>(arg0, 6, b"WATCH", b"FIRST COIN ON A WATCH", b"First coin launched on a watch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036839_8cbb636693.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

