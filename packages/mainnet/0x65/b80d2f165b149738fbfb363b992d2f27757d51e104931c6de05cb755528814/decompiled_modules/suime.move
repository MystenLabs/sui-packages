module 0x65b80d2f165b149738fbfb363b992d2f27757d51e104931c6de05cb755528814::suime {
    struct SUIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIME>(arg0, 6, b"Suime", b"Sui MemeFi", b"X10000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3157_31408a37d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

