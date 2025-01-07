module 0x75fec51ce77068f4831f637dc503bd6af05ca2bdcd81bf77f884013d6fe6bb4d::w {
    struct W has drop {
        dummy_field: bool,
    }

    fun init(arg0: W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W>(arg0, 6, b"W", b"Gut's", x"20706172742074696d6520626c61636b736d6974682066756c6c2074696d65207375666665726572200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4797_b7d2145e74.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W>>(v1);
    }

    // decompiled from Move bytecode v6
}

