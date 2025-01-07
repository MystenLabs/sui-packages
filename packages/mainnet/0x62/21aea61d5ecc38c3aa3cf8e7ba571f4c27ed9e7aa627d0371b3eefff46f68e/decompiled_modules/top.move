module 0x6221aea61d5ecc38c3aa3cf8e7ba571f4c27ed9e7aa627d0371b3eefff46f68e::top {
    struct TOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOP>(arg0, 6, b"TOP", b"TOP2", x"544f500a696d672d73656c65637465640a4368616e67652066696c650a20200a4465736372697074696f6e202a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_76b109b1c7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

