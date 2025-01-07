module 0x8ed4852443c174df5cdf98879cad2a18704d7e3d3aa04d43238213052e3ffa75::SUIEP {
    struct SUIEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEP>(arg0, 9, b"SUIEP", b"SuiGameEquityPoints", b"SuiGame Equity Points", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIEP>>(v1);
        0x2::coin::mint_and_transfer<SUIEP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIEP>>(v2);
    }

    // decompiled from Move bytecode v6
}

