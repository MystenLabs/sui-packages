module 0x8398cecd060bc82724e780024f1fc5be38a8d91a700d140d6473db4db0176817::suilander {
    struct SUILANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANDER>(arg0, 6, b"SUILANDER", b"Sui Homelander", b"The ultimate power on Suiruthless, unstoppable, and always in control. Bow down, because Sui Homelander plays by his own rules!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluedown_1_1697710a56.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

