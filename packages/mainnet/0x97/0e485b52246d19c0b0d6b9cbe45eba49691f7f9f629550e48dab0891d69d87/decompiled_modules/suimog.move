module 0x970e485b52246d19c0b0d6b9cbe45eba49691f7f9f629550e48dab0891d69d87::suimog {
    struct SUIMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOG>(arg0, 6, b"SuiMOG", b"MOG ON SUI", b"The first Mog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1784_984e70445a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

