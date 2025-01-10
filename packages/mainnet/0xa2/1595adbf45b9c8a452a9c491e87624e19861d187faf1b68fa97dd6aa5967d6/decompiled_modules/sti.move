module 0xa21595adbf45b9c8a452a9c491e87624e19861d187faf1b68fa97dd6aa5967d6::sti {
    struct STI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STI>(arg0, 6, b"STI", b"STI by SuiAI", b"STI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_12_0adf2d96d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

