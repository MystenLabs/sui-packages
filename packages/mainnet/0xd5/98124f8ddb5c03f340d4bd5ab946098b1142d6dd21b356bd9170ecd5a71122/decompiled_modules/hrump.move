module 0xd598124f8ddb5c03f340d4bd5ab946098b1142d6dd21b356bd9170ecd5a71122::hrump {
    struct HRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRUMP>(arg0, 6, b"Hrump", b"Hrumpp", b"Hrump on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5497_1115b821b1_5899285898.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

