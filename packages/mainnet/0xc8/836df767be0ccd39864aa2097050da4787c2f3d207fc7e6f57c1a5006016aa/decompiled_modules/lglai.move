module 0xc8836df767be0ccd39864aa2097050da4787c2f3d207fc7e6f57c1a5006016aa::lglai {
    struct LGLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LGLAI>(arg0, 6, b"LGLAI", b"LedgerLinkAI by SuiAI", x"f09f8c9020456d706f776572696e672065766572796f6e6520746f206578706c6f726520626c6f636b636861696e202620736d61727420636f6e7472616374732e20f09fa49620596f75722062726964676520746f206120646563656e7472616c697a6564206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ledger_Link_5b4e20ffdb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LGLAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGLAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

