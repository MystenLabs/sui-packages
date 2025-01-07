module 0x37b6cb2b2d81575055f977880c4ce79046611f1506bbd2bc23c045e0f9d744d7::nineteen {
    struct NINETEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINETEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINETEEN>(arg0, 6, b"Nineteen", b"#19", b"19", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000375_5a62f39715.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINETEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINETEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

