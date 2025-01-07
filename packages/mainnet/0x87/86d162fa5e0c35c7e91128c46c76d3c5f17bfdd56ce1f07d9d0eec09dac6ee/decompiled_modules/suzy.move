module 0x8786d162fa5e0c35c7e91128c46c76d3c5f17bfdd56ce1f07d9d0eec09dac6ee::suzy {
    struct SUZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZY>(arg0, 6, b"SUZY", b"Suzy Seahorse", b" Ridin the waves of the Sui chain, Dive in and ride the tide with the swiftest sea horse of the sea, Suzy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_8c4e1f6df4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

