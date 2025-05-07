module 0xce169f1b9698181d4f5910ed602ccb917438dc75a8331aa327f9a77eaf4c7361::suivee {
    struct SUIVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVEE>(arg0, 6, b"SUIVEE", x"53756976656520506f6bc3a96d6f6e", x"537569766565206973206120736d616c6c2c206d616d6d616c69616e2c20717561647275706564616c20506f6bc3a96d6f6e2077697468207072696d6172696c7920626c7565206675722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidu7ti3drpkupnz4phqchuyh25yab6cwwrtrrzyqvmupj42psy6um")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIVEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

