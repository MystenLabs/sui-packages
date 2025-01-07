module 0xc5a061c327f93d1df34fe779ddaadd7730782e67c011a837cbc8c031459d12f8::babymilady {
    struct BABYMILADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMILADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMILADY>(arg0, 6, b"BABYMILADY", b"BABY MILADY", x"424142594d494c4144590a546865204d656d65436f696e2045766572796f6e6573206d697373696e6720466f72204d696c616479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3941_d34c49ae8c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMILADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMILADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

