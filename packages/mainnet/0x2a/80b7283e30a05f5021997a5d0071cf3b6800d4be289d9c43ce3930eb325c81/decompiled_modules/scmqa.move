module 0x2a80b7283e30a05f5021997a5d0071cf3b6800d4be289d9c43ce3930eb325c81::scmqa {
    struct SCMQA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCMQA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCMQA>(arg0, 9, b"SCMQA", b"SolCreate Sui Media QA", b"Mainnet evidence for Sui creation-time token imagery.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SCMQA>>(0x2::coin::mint<SCMQA>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCMQA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCMQA>>(v1);
    }

    // decompiled from Move bytecode v6
}

