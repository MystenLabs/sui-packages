module 0xd31630377c445d5e3e4812310452e8a09eef4c1f5616fb12d2912b9173c622ef::suiagent {
    struct SUIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAGENT>(arg0, 9, b"SUIAGENT", b"aiSUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIAGENT>(&mut v2, 910000000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAGENT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIAGENT>>(v2);
    }

    // decompiled from Move bytecode v6
}

