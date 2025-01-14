module 0x96ccdc0fe82f3dcc035e0455cb6c8dcc933141c0ed35b299f6079f057f18a804::xgptai {
    struct XGPTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGPTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XGPTAI>(arg0, 6, b"XGPTAI", b"XGPTAI by SuiAI", b"XGPTAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250115_021725_da6b3e62f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XGPTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGPTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

