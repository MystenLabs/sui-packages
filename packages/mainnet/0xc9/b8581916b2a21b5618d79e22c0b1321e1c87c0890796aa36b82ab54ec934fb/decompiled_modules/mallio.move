module 0xc9b8581916b2a21b5618d79e22c0b1321e1c87c0890796aa36b82ab54ec934fb::mallio {
    struct MALLIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALLIO>(arg0, 6, b"MALLIO", b"Mallio", x"696e74726f647563696e6720246d616c6c696f2c2074686520696e7465726e65742773206c617465737420646f67676f206f6273657373696f6e206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/malliologo_801f5e25b8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALLIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALLIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

