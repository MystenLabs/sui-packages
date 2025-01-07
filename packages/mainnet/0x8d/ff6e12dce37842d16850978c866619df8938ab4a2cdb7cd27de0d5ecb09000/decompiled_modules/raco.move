module 0x8dff6e12dce37842d16850978c866619df8938ab4a2cdb7cd27de0d5ecb09000::raco {
    struct RACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACO>(arg0, 6, b"RACO", b"RACO SUI", x"5241434f2069736e2774206a7573742061206d656d65636f696e3b20697420726570726573656e747320612062726f61646572206d6f76656d656e742e2057652061726520636f6e666964656e742074686174205375692063616e207369676e69666963616e746c7920696d70726f76652074686520776f726c6420616e64206172652064656469636174656420746f206372656174696e672061206d6f726520696e636c757369766520616e642077656c636f6d696e6720656e7669726f6e6d656e7420666f7220616c6c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_1_20eb52eec3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

