module 0xe00c0b261b190f98ea667c7049faf1800046be5ac6f482a930829c8489b553fa::scqa {
    struct SCQA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCQA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCQA>(arg0, 6, b"SCQA", b"SolCreate SUI Mainnet QA", b"Protected SolCreate SUI Mainnet acceptance token.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<SCQA>>(0x2::coin::mint<SCQA>(&mut v3, 1000000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCQA>>(v3, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCQA>>(v2);
    }

    // decompiled from Move bytecode v6
}

