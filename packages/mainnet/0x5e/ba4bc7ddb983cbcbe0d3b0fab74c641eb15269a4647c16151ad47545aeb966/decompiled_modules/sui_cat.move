module 0x5eba4bc7ddb983cbcbe0d3b0fab74c641eb15269a4647c16151ad47545aeb966::sui_cat {
    struct SUI_CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_CAT>(arg0, 6, b"SUICAT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_CAT>>(v1);
        0x2::coin::mint_and_transfer<SUI_CAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_CAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

