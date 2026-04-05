module 0xb1fbd5b1f9aec7e563f8a88ba152f6bc92fb0fba31e5ae5aaf6438358868ddf8::opk {
    struct OPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPK>(arg0, 6, b"OPK", b"Obi Pnut Kenobi", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OPK>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OPK>>(v2);
    }

    // decompiled from Move bytecode v6
}

