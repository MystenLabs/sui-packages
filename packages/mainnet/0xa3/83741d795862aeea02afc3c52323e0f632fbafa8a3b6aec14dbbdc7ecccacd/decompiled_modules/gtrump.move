module 0xa383741d795862aeea02afc3c52323e0f632fbafa8a3b6aec14dbbdc7ecccacd::gtrump {
    struct GTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTRUMP>(arg0, 6, b"GTRUMP", b"Grand Theft Trump", x"57656c636f6d6520746f20475472756d702e20535549206d656d65636f696e2c206272696e67696e67207472756d70206e61727261746976657320616e6420766964656f2067616d65732e20596f752063616e20646f776e6c6f616420616e6420706c617920616e64206561726e2e206c65742773206d616b6520766964656f2067616d657320677265617420616761696e2e0a0a47616d65706c6179203a68747470733a2f2f706c61792e676f6f676c652e636f6d2f73746f72652f617070732f64657461696c733f69643d636f6d2e6d61747a652e7072657a5f63616d706169676e26686c3d656e5f555326706c693d31", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_gottrum_46865175bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

