module 0x3f448d0c9782891a9a819b31c4626366c4b36aefcae0e375f787e455797373e3::shitter {
    struct SHITTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITTER>(arg0, 6, b"Shitter", b"500 MC Shitter", b"Just a $500 MC Shitter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4520_996b6d4ece.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

