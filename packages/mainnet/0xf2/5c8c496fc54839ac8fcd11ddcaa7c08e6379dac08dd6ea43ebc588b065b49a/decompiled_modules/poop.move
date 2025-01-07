module 0xf25c8c496fc54839ac8fcd11ddcaa7c08e6379dac08dd6ea43ebc588b065b49a::poop {
    struct POOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOP>(arg0, 6, b"POOP", b"PoopBerry", x"5468697320746f6b656e2069732064656469636174656420666f7220616c6c2074686520706574206f776e657273206f7574207468657265210a576520616c6c2068616420746f206465616c20776974682069742061746c65617374206f6e636520696e206f7572206c69666574696d652c20736f6d65206c6f766520697420736f6d6520686174652069742c20627574206974732074686572652c20506f6f704265727279206973206c69666521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_1_7eeba4fe42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

