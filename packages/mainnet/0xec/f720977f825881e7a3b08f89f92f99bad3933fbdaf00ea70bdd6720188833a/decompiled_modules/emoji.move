module 0xecf720977f825881e7a3b08f89f92f99bad3933fbdaf00ea70bdd6720188833a::emoji {
    struct EMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOJI>(arg0, 6, b"EMOJI", b"SUI $EMOJI", x"496e207468652076696272616e7420776f726c64206f6620456d6f6a696c616e642c207468657265206c69766564206120636865657266756c20656d6f6a69206f6e2053756920636861696e0a0a57656273697465200a68747470733a2f2f7777772e656d6f6a697375692e78797a2f0a547769747465720a68747470733a2f2f782e636f6d2f537569456d6f6a690a54656c656772616d200a68747470733a2f2f742e6d652f537569656d6f6a69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3636_385a434d2a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

