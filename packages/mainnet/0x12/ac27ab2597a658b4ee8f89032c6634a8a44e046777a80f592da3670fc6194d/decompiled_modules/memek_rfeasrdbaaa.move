module 0x12ac27ab2597a658b4ee8f89032c6634a8a44e046777a80f592da3670fc6194d::memek_rfeasrdbaaa {
    struct MEMEK_RFEASRDBAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRDBAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRDBAAA>(arg0, 6, b"MEMEKRFEASRDBAAA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRDBAAA>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRDBAAA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRDBAAA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

