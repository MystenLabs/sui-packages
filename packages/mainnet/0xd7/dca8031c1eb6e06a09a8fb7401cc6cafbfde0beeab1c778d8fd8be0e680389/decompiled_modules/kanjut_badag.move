module 0xd7dca8031c1eb6e06a09a8fb7401cc6cafbfde0beeab1c778d8fd8be0e680389::kanjut_badag {
    struct KANJUT_BADAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANJUT_BADAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANJUT_BADAG>(arg0, 6, b"KANJUTBADAG", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KANJUT_BADAG>>(v1);
        0x2::coin::mint_and_transfer<KANJUT_BADAG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANJUT_BADAG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

