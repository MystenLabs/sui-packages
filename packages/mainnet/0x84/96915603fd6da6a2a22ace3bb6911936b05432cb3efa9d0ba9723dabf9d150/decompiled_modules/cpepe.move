module 0x8496915603fd6da6a2a22ace3bb6911936b05432cb3efa9d0ba9723dabf9d150::cpepe {
    struct CPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPEPE>(arg0, 6, b"CPEPE", b"ClownPepe launches 6PM", b"Twitter: https://twitter.com/Sui_clownpepe, Telegram: https://t.me/Sui_ClownPepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/fQTA2Ih.png"))), arg1);
        let v2 = v0;
        let v3 = @0x5921bcf1793d277d6ceb78633e089233479ee33b1011b83dddf944eb4b6e9566;
        0x2::coin::mint_and_transfer<CPEPE>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPEPE>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

