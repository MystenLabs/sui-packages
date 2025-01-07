module 0x2dea56e70da88e1a0a6a478efff1e79f3f1e6a05502fe80015dfe99320e393f1::tuzki {
    struct TUZKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUZKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUZKI>(arg0, 6, b"TUZKI", b"Sui Tuzki", x"53656e64696e67206c6f766520616e6420706561636520746f20616c6c206f660a796f752077686f2062656c6965766520696e20757321204c65747320636f6d650a746f67657468657220616e642063726561746520616e20696e6372656469626c650a636f6d6d756e6974792c20667269656e647321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_2_c3e7cdfd92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUZKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUZKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

