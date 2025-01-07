module 0x4cbcaf12bc99fedce6bd1a5c9eef2c1dd4acfc9d2e48a4005aec26ab83764216::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"SUIPER", b"SuiperMan", x"5375692d7065726d616e206973206120706c617966756c2073757065726865726f206368617261637465722077697468206120626f6c6420225322206f6e206869732063686573742c20612072656420636170652c20616e642076696272616e7420636f6c6f72732e20486520666c696573207468726f7567682074686520736b792c20656d626f6479696e6720612066756e2c20636f6d69632d7374796c65206865726f2c2066756c6c206f6620656e6572677920616e6420616476656e747572652e0a0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e2517765_b9f3_4127_8c3d_50815dcf38c9_bbbeb050e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

