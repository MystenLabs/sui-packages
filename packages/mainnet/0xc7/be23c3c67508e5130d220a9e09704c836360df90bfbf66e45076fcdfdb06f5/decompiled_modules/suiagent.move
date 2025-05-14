module 0xc7be23c3c67508e5130d220a9e09704c836360df90bfbf66e45076fcdfdb06f5::suiagent {
    struct SUIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAGENT>(arg0, 9, b"SUIAGENT", b"0xd31630377c445d5e3e4812310452e8a09eef4c1f5616fb12d2912b9173c622ef", b"Groundbreaking AI Agent platform on SUInetwork, powered by $SUIAGENT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.mexc.com/api/platform/file/download/F20250513161017619ZEYeOMXDIe92oM")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIAGENT>>(0x2::coin::mint<SUIAGENT>(&mut v2, 1300000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIAGENT>>(v2);
    }

    // decompiled from Move bytecode v6
}

