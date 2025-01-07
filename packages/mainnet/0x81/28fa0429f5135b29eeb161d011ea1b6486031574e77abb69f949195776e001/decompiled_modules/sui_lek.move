module 0x8128fa0429f5135b29eeb161d011ea1b6486031574e77abb69f949195776e001::sui_lek {
    struct SUI_LEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_LEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_LEK>(arg0, 6, b"SUILEK", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_LEK>>(v1);
        0x2::coin::mint_and_transfer<SUI_LEK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_LEK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

