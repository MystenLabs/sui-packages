module 0xc3f6985966dfd4fe43c49d25acadb61170dbbcb7a4968d7625e03df20c2b99d::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"doggy bread", b"doggy bread dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_19_41_53_af64f2d092.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

