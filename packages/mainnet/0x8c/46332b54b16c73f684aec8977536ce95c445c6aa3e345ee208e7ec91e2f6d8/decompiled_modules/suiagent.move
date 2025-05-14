module 0x8c46332b54b16c73f684aec8977536ce95c445c6aa3e345ee208e7ec91e2f6d8::suiagent {
    struct SUIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAGENT>(arg0, 9, b"SUIAGENT", b"aiSUI", b"Groundbreaking AI Agent platform on SUInetwork, powered by $SUIAGENT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.mexc.com/api/platform/file/download/F20250513161017619ZEYeOMXDIe92oM")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIAGENT>>(0x2::coin::mint<SUIAGENT>(&mut v2, 1300000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIAGENT>>(v2);
    }

    // decompiled from Move bytecode v6
}

