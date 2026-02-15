module 0xa6d00d6ee0a93652ab32bd24d41effb26df2e832bedbf76e8a2cc1c5a8a81902::asset_118 {
    struct ASSET_118 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET_118>, arg1: 0x2::coin::Coin<ASSET_118>) {
        0x2::coin::burn<ASSET_118>(arg0, arg1);
    }

    fun init(arg0: ASSET_118, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET_118>(arg0, 9, b"WAL", b"WAL Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-qSXI6Ryw-i.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET_118>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET_118>>(v1);
    }

    public fun issue(arg0: &mut 0x2::coin::TreasuryCap<ASSET_118>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET_118> {
        0x2::coin::mint<ASSET_118>(arg0, arg1, arg2)
    }

    public entry fun issue_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET_118>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET_118>>(0x2::coin::mint<ASSET_118>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

