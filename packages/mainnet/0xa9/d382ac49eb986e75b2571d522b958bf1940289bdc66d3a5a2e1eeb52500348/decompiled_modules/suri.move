module 0xa9d382ac49eb986e75b2571d522b958bf1940289bdc66d3a5a2e1eeb52500348::suri {
    struct SURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURI>(arg0, 6, b"SURI", b"SURI ON SUI", b"Feeling low? Let SURIAN's vibrant charm lift your spirits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001913249.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

