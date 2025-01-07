module 0x1714489619fae0be6197585a9385f2c6efbaf6b293c5c227f8c287d7214f6052::smilio {
    struct SMILIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILIO>(arg0, 6, b"Smilio", b"Suimilio", b"Yes, I am him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8731_5c1af3a8b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

