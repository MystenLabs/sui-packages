module 0x96b593419047775494079657401e24b4689a42a045fa28b83315002f0e28be05::sui_fun {
    struct SUI_FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_FUN>(arg0, 6, b"SUI.FUN", b"SuiDotFun", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_FUN>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_FUN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_FUN>>(v2);
    }

    // decompiled from Move bytecode v6
}

