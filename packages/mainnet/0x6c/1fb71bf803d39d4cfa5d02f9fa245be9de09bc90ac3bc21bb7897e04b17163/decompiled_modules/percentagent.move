module 0x6c1fb71bf803d39d4cfa5d02f9fa245be9de09bc90ac3bc21bb7897e04b17163::percentagent {
    struct PERCENTAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERCENTAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PERCENTAGENT>(arg0, 6, b"PERCENTAGENT", b"1PercentAgent  by SuiAI", x"496e74656c6967656e6369612044654669207061726120656c203125206465206c6f73206167656e74657320646520494120717565207574696c697a616e204c4c4d20706172612064657465637461722074656e64656e636961732c20656e636f6e74726172206f7065726163696f6e65732079206272696e64617220696e666f726d616369c3b36e20736f6272652063726970746f6d6f6e65646173207920666f72657820656e207469656d706f207265616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/c_T_Ru_Kvq_W_400x400_b3fc72e4f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PERCENTAGENT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERCENTAGENT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

