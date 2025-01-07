module 0x7777fbc306c599bc6e4fb12d657dd8af617068a731de17c21c963782b5413809::sui_ler {
    struct SUI_LER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_LER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_LER>(arg0, 6, b"SUILER", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_LER>>(v1);
        0x2::coin::mint_and_transfer<SUI_LER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_LER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

