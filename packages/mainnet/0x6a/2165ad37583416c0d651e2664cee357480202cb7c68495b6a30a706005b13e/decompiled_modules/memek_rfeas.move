module 0x6a2165ad37583416c0d651e2664cee357480202cb7c68495b6a30a706005b13e::memek_rfeas {
    struct MEMEK_RFEAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEAS>(arg0, 6, b"MEMEKRFEAS", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEAS>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

