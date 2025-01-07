module 0xf3c7a8834752affd55b9c5d57a6d8ecf2dbbcaf342ffe6c78f6b06dd56cb2915::clob {
    struct CLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOB>(arg0, 9, b"CLOB", b"CLOB onSUI", b"Central Liquidity Ordered Book, exclusive on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8fac948-f729-430f-b4b7-096ad981fb13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

