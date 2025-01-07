module 0x813c0d7a177a7b07fea6ffa868167b70a8923326fb776dbb7f3a409e2106891::mecat {
    struct MECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MECAT>(arg0, 6, b"MECAT", b"Mecat", x"4d656361742c207468652066697273742069646f6c206d656d65636f696e206f6e20426173652c2069732072656c61756e6368696e67207769746820612066616972206c61756e6368210a0a204d757369632053656e736174696f6e3a20456e6a6f79204d65636174277320747261636b73206f6e2053706f746966792c204170706c65204d757369632c20416d617a6f6e204d757369632c20616e64206d6f72652e204a6f696e20746865206465646963617465642066616e646f6d207468617427732067726f77696e672065766572792064617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722882062462_53ee80b6279ab47c882f309ba1bdedb4_11aa35bfc6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

