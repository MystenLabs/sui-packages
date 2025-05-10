module 0x3dd51bbad638aadc95a39c17a7e35a39ca4442eb41fe33a57c28ab7b914b825b::tto {
    struct TTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTO>(arg0, 6, b"TTO", b"SUITTO", x"4d454c54494e4720504f4b454d4f4e532046414345530a537569206e65656465642061207265616c20706f6b656d656d65636f696e2c2053756974746f20737061776e65642e0a0a4e6f2070726f6d697365730a4e6f2062756c6c736869740a4e6f20726f61646d61700a496620736f6d656f6e6520646f657320736f6d657468696e672c2053756974746f20636f7069657320697420616e64206d616b6573206974206265747465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib6foeddebkkuasd2teshmu3qs7zqo5kc2fipp75yobm2yuc5wkl4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

