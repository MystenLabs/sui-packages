module 0x6c886bea575f4bd5d15566b06889a7b31e5c8c07307e24b543fb5c02c1f7ab3b::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGD>(arg0, 6, b"SGD", b"SUIGOD", b"GOD TOKEN IS RILLLL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/god_7353a9ee5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

