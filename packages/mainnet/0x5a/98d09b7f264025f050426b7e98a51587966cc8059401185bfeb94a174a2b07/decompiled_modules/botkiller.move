module 0x5a98d09b7f264025f050426b7e98a51587966cc8059401185bfeb94a174a2b07::botkiller {
    struct BOTKILLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTKILLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTKILLER>(arg0, 6, b"BOTKILLLER", b"BOT", b"botkiller", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOTKILLER>(&mut v2, 10000000000000, @0x8f09eee8fbe461df224ca3ae14c7c609d05c77dd76b6fc242ec5936f4428d689, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOTKILLER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTKILLER>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

