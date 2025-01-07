module 0x2c69d456bf4526d52b6ad926e54fa35a4e05dc82c7ab252f082514b98b538225::tremp {
    struct TREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMP>(arg0, 9, b"TREMP", b"Doland Tremp", x"7472656d7027732074696d6520697320636f6d696e672e20707265736964656e74206f66207375690a6d656b206d656d657320677265617420616761696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7d81e6f059aae287081d43942eef546bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

