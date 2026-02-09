module 0x1c2daa46de15ac7feb4a9d78664a91609315efbe54e6ce6bc502c0dfc7954b9d::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT>, arg1: 0x2::coin::Coin<VAULT>) {
        0x2::coin::burn<VAULT>(arg0, arg1);
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT>(arg0, 9, b"SUI_R2620", b"Sui (Reserve)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-Wrxk4a_-BM.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT>>(v1);
    }

    public fun process(arg0: &mut 0x2::coin::TreasuryCap<VAULT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT> {
        0x2::coin::mint<VAULT>(arg0, arg1, arg2)
    }

    public entry fun process_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

