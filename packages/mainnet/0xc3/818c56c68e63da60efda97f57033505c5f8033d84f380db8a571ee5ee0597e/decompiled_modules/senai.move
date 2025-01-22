module 0xc3818c56c68e63da60efda97f57033505c5f8033d84f380db8a571ee5ee0597e::senai {
    struct SENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SENAI>(arg0, 6, b"SENAI", b"SuiSenseAI by SuiAI", b"Master of SUI memecoins, NFTs, and DeFi. Simplifying crypto with humor and insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/HI_Wiq_BKT_400x400_a3786c93a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SENAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

