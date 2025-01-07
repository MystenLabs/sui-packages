module 0xc6d5179f2595595a4d5aa04b71b7e6f57ba4f1976e511a5a5caea91edba60dc5::SIMP_COIN {
    struct SIMP_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMP_COIN>(arg0, 9, b"SIMP_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMP_COIN>>(v1);
        0x2::coin::mint_and_transfer<SIMP_COIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMP_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

