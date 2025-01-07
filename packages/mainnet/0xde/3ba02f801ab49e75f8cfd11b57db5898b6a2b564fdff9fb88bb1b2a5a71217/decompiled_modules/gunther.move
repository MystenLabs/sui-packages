module 0xde3ba02f801ab49e75f8cfd11b57db5898b6a2b564fdff9fb88bb1b2a5a71217::gunther {
    struct GUNTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUNTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUNTHER>(arg0, 6, b"GUNTHER", b"GUNTHER VI FAN TOKEN", x"47756e7468657220564920697320746865207269636865737420646f67200a696e2074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_18_46_19_e0ecc667af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUNTHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUNTHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

