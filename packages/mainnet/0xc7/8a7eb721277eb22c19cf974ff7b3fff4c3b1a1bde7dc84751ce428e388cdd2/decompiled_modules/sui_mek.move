module 0xc78a7eb721277eb22c19cf974ff7b3fff4c3b1a1bde7dc84751ce428e388cdd2::sui_mek {
    struct SUI_MEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_MEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_MEK>(arg0, 6, b"SUIMEK", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_MEK>>(v1);
        0x2::coin::mint_and_transfer<SUI_MEK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_MEK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

