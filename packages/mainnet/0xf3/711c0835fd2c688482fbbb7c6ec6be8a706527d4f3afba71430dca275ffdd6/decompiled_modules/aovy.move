module 0xf3711c0835fd2c688482fbbb7c6ec6be8a706527d4f3afba71430dca275ffdd6::aovy {
    struct AOVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOVY>(arg0, 6, b"AOVY", b"ANCHOVY", b"We are small, but if there are many we become big. $AOVY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000082523_5a8fd59e86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

