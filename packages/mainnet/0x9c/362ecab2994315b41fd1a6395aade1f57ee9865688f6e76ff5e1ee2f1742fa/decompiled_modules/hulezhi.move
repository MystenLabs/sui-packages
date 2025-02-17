module 0x9c362ecab2994315b41fd1a6395aade1f57ee9865688f6e76ff5e1ee2f1742fa::hulezhi {
    struct HULEZHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HULEZHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HULEZHI>(arg0, 6, b"HULEZHI", b"HU LE ZHI", x"412070726f6772616d6d6572206e616d6564204875204c655a6869206d616465206869732066696e616c207374616e6420616761696e7374207468652073797374656d6275726e696e6720363030204554482c20646f6e6174696e6720373030204554480a49276d20676f696e6720746f206c61756e636820696e2053554920696e206d656d6f7279206f662068696d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cab75640_0b02_4c33_ac13_65b9efa27aca_086a3e5a4c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HULEZHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HULEZHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

