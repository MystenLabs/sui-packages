module 0xb74c6a1d462d2e7125ea28ed2f9a23d8654f747c160e1f6be4326d1db6e1d4cd::ruble {
    struct RUBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBLE>(arg0, 6, b"RUBLE", b"RUBLE ON SUI", x"5765277265206f6e2061206d697373696f6e20746f206275696c64206f6e65206f6620746865206269676765737420616e64206d6f73742061637469766520636f6d6d756e6974696573206f6e20535549202e0a5769746820616e20617765736f6d65207465616d2c2061207374726f6e6720636f6d6d756e6974792c206120636f6f6c20746f6b656e2c20616e64206120706f70756c6172204e465420636f6c6c656374696f6e2c20776527726520726561647920746f206d616b652069742068617070656e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/welcome_little_one_2_bd3119f352.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

