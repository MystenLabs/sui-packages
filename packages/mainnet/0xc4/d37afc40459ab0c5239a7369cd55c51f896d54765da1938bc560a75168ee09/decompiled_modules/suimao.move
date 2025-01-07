module 0xc4d37afc40459ab0c5239a7369cd55c51f896d54765da1938bc560a75168ee09::suimao {
    struct SUIMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAO>(arg0, 6, b"Suimao", b"SuiMao", x"546865204d656d6520436174206f66207468652053756920426c6f636b636861696e2120f09f90b1f09f94a50a245375694d616f2c2074686520666561726c657373206d656d6520746f6b656e20696e737069726564206279204d616f204d616f2c20746865206865726f696320636172746f6f6e206361742e204a757374206c696b65206f75722062656c6f766564204d616f204d616f2c20245375694d616f206272696e677320636f75726167652c206368616f732c20616e6420636f6d6d756e69747920746f207468652063727970746f207363656e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731078902687.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

