module 0xb231ada85090179e247677b7e3cd688d0eb347cac13a01a1d4c176f94f734b2::ufop {
    struct UFOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFOP>(arg0, 6, b"UFOP", b"UFO Pepe", x"2455464f5020626c656e64732055464f2063756c747572652077697468207468652069636f6e69632050455045207468652046726f6721200a0a4a6f696e2074686520636f736d696320616476656e747572652077686572652055464f20656e7468757369617374732026206d656d65206c6f7665727320756e6974652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_50d99dc58a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

