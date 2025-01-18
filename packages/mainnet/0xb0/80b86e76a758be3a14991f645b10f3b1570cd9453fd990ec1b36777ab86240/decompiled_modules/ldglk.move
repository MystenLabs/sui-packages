module 0xb080b86e76a758be3a14991f645b10f3b1570cd9453fd990ec1b36777ab86240::ldglk {
    struct LDGLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDGLK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LDGLK>(arg0, 6, b"LDGLK", b"Ledger Link AI by SuiAI", x"f09f8c9020456d706f776572696e672065766572796f6e6520746f206578706c6f726520626c6f636b636861696e202620736d61727420636f6e7472616374732e20f09fa49620596f75722062726964676520746f206120646563656e7472616c697a6564206675747572652e2023426c6f636b636861696e2023536d617274436f6e74726163747320234149", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ledger_Link_6d6ba6b383.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LDGLK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDGLK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

