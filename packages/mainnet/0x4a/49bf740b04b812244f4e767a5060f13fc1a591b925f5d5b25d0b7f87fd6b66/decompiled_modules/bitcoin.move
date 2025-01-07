module 0x4a49bf740b04b812244f4e767a5060f13fc1a591b925f5d5b25d0b7f87fd6b66::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 6, b"BITCOIN", b"HPOS10I", x"5449434b45523a20424954434f494e2020286f6e2024535549290a5061726f646963616c2073617469726963616c206d756c746966616365746564206d656d652070726f6a656374202a6e6f7420616666696c6961746564207769746820486172727920506f747465722c2053656761206f72204f62616d610a5472696275746520546f6b656e3a20405265616c48504f53313049202e2e6275742024535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7603_f4d921530f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

