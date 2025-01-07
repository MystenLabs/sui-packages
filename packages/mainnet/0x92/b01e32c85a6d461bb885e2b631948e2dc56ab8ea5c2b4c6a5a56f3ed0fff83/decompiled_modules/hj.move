module 0x92b01e32c85a6d461bb885e2b631948e2dc56ab8ea5c2b4c6a5a56f3ed0fff83::hj {
    struct HJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJ>(arg0, 6, b"HJ", b"Hj coming", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HJ_77712e9316.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

