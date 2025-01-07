module 0x96df06ca88e066a7641a84dce68cc05f1694449938f04aaa68b2d5b0fa922395::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"SUIPER", b"Suiperman On Sui", x"4f7572206d697373696f6e3f20546f206d616b65202453554950455220612070726f6a6563742074686174207265776172647320594f552e204761696e732061726520636f6d696e672c2073746179207769746820757320666f72207468652072696465210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Opga_fd_C_400x400_1406c10b06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

