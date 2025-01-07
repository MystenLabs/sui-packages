module 0x3ee07f7a9d6bebe41cc21f2e2a7792d824f3443062589c65b88dd809c6388e05::messi {
    struct MESSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSI>(arg0, 6, b"MESSI", b"MESSI ON SUI", b"The one and only Goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2275_3a0a14239f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

