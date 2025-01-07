module 0xbc4fe88e279d8c2ccca4edb7b988b7dc4f28924ee0e4c69df5afacf5d1bda928::memek_rfeasrb {
    struct MEMEK_RFEASRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRB>(arg0, 6, b"MEMEKRFEASRB", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRB>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

