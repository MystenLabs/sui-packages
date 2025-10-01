module 0xf210891e05a480c2acc04f28ebb3202e825685041898d1fdfe9d944bac728123::pumpto000006 {
    struct PUMPTO000006 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPTO000006, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPTO000006>(arg0, 9, b"PUMP TO 000006", b"PUMP", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMPTO000006>>(0x2::coin::mint<PUMPTO000006>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMPTO000006>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMPTO000006>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

