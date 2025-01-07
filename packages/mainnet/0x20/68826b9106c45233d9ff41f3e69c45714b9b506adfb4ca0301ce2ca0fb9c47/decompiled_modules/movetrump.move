module 0x2068826b9106c45233d9ff41f3e69c45714b9b506adfb4ca0301ce2ca0fb9c47::movetrump {
    struct MOVETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVETRUMP>(arg0, 6, b"MOVETRUMP", b"MOVE TRUMP", b"TRUMP SUI ON MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4080_cb56c63777.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVETRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVETRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

