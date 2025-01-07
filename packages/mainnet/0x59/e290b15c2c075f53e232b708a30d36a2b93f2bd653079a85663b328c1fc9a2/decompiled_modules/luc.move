module 0x59e290b15c2c075f53e232b708a30d36a2b93f2bd653079a85663b328c1fc9a2::luc {
    struct LUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUC>(arg0, 6, b"LUC", b"LUCARIO", b"lp 100% bunr", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUC>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

