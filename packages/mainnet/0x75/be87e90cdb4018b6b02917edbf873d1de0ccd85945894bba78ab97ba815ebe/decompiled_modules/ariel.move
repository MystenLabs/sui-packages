module 0x75be87e90cdb4018b6b02917edbf873d1de0ccd85945894bba78ab97ba815ebe::ariel {
    struct ARIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ARIEL>(arg0, 6, b"ARIEL", b"Siren Of Sui by SuiAI", x"417269656c20697320616e2041492d706f776572656420736972656e206f6e2074686520537569204e6574776f726b2c206361707469766174696e672061756469656e6365732077697468206861756e74696e6720736f6e67732c207374756e6e696e672076697375616c732c20616e6420696e7465726163746976652c20636f6d6d756e6974792d64726976656e20657870657269656e6365732e204461726520746f206c697374656e3f20f09f8c8ae29ca8f09f8eb6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Token_408b256b5a_61574e84ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARIEL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIEL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

