module 0x7e95385a16ab2b22ad9e5fba40d227520eeef044151a06349925319ff5b13fbf::suiville {
    struct SUIVILLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVILLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVILLE>(arg0, 6, b"SUIVILLE", b"SuiVille", x"53756956696c6c65206973206120706c616365207768696368206973207365706172617465642066726f6d2074686520776f726c642c207769746820612064656570206c616b652061726f756e6420697420736f206e6f6f6e652063616e206861726d207468652076696c6c616765727320696e736964650a436f6d6520616e64206a6f696e2074686520636f6d6d756e6974792c20616e64206d6179626520736574746c6520646f776e20776974682075722066616d696c792061742053756956696c6c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_f94cbb48cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVILLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVILLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

