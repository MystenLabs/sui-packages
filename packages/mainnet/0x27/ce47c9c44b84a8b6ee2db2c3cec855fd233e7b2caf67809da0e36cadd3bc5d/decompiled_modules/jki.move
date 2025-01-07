module 0x27ce47c9c44b84a8b6ee2db2c3cec855fd233e7b2caf67809da0e36cadd3bc5d::jki {
    struct JKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKI>(arg0, 6, b"JKI", b"JUST KEK IT", x"4a555354204b454b2049540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/_8685d7fd01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

