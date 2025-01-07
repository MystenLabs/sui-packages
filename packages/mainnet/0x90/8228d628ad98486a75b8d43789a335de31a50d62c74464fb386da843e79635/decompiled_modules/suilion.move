module 0x908228d628ad98486a75b8d43789a335de31a50d62c74464fb386da843e79635::suilion {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 6, b"SUILION", b"SUI Lion", x"535549204c494f4e20546f6b656e206973206120706c617966756c20616e642076696272616e742063727970746f63757272656e6379207468617420656d627261636573206d656d652063756c747572652c20696e766974696e6720757365727320746f206a6f696e20612066756e20636f6d6d756e6974792e2057697468206578636974696e6720636f6e746573747320616e6420726577617264732c206974277320616c6c2061626f75742063656c6562726174696e67206372656174697669747920616e6420636f6e6e656374696f6e20696e207468652063727970746f207370616365210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUNLION_T_Prsn6_K7_CZ_5kgy1s_Fw_31329d81c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILION>>(v1);
    }

    // decompiled from Move bytecode v6
}

