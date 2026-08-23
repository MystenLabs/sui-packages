module 0xf9c05eba59c4172c5bac6739507979c9cce52f5defb25ec8e36cdd135da45aa8::scmqa {
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

    // decompiled from Move bytecode v7
}

