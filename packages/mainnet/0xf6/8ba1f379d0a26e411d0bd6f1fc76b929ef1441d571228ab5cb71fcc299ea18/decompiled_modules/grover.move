module 0xf68ba1f379d0a26e411d0bd6f1fc76b929ef1441d571228ab5cb71fcc299ea18::grover {
    struct GROVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROVER>(arg0, 6, b"GROVER", b"GROVER SUI", b"Grover On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7223_7482db2c53.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

