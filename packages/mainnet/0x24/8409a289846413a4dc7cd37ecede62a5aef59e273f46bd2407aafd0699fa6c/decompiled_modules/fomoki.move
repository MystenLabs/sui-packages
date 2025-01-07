module 0x248409a289846413a4dc7cd37ecede62a5aef59e273f46bd2407aafd0699fa6c::fomoki {
    struct FOMOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMOKI>(arg0, 6, b"FOMOKI", b"FomokiOnSui", x"464f4d4f6b692069732061206d697363686965766f75732c0a636f6d6d756e6974792d64726976656e206d656d65636f696e0a6275696c74206f6e207468652053554920626c6f636b636861696e2c0a64657369676e656420746f206675656c206578636974656d656e740a616e6420464f4d4f20776974682073757270726973650a7265776172647320616e64206275726e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000506_b232bbf0c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

