module 0x6b48a21600c6994166ff872d69fbb3eeaa85ca828e966aa12fd4eec17dd9e9ac::btq {
    struct BTQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTQ>(arg0, 6, b"BTQ", b"$BTQ", b"OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752174551240.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

