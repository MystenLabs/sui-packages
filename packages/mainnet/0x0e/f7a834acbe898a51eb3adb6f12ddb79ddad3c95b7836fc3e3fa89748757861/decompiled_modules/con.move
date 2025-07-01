module 0xef7a834acbe898a51eb3adb6f12ddb79ddad3c95b7836fc3e3fa89748757861::con {
    struct CON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CON>(arg0, 6, b"CON", b"CLASH ON SUI", x"0a546865206d656d65207761722068697473207468652053554920636861696e210a3130302520636f6d6d756e6974792c203025206d657263792e0a506c61792c207374616b652c206d656d6520207265706561742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/02_ACD_179_8773_4420_A259_9_C709_BF_6_ADC_6_a386ecb0b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CON>>(v1);
    }

    // decompiled from Move bytecode v6
}

