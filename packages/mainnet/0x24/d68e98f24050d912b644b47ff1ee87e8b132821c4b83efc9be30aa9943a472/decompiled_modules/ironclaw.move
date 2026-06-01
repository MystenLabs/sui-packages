module 0x24d68e98f24050d912b644b47ff1ee87e8b132821c4b83efc9be30aa9943a472::ironclaw {
    struct IRONCLAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRONCLAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRONCLAW>(arg0, 6, b"IRONCLAW", b"IronClaw", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IRONCLAW>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRONCLAW>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IRONCLAW>>(v2);
    }

    // decompiled from Move bytecode v6
}

