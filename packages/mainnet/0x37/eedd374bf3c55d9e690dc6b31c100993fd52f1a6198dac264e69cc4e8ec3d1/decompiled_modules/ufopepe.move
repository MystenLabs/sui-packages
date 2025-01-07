module 0x37eedd374bf3c55d9e690dc6b31c100993fd52f1a6198dac264e69cc4e8ec3d1::ufopepe {
    struct UFOPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFOPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFOPEPE>(arg0, 6, b"UFOPEPE", b"UFO PEPE", x"2455464f205045504520626c656e64732055464f2063756c747572652077697468207468652069636f6e69632050455045207468652046726f6721200a4a6f696e2074686520636f736d696320616476656e747572652077686572652055464f20656e7468757369617374732026206d656d65206c6f7665727320756e6974652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ufo_219ec28b92.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFOPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFOPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

