module 0x14470fd29d8117a84ecd64811b2a91d2d69657c80d98a611ac68f9cbe742a823::AIDOGE {
    struct AIDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIDOGE>, arg1: 0x2::coin::Coin<AIDOGE>) {
        0x2::coin::burn<AIDOGE>(arg0, arg1);
    }

    fun init(arg0: AIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGE>(arg0, 2, b"SLAMBO", b"SUILAMBO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

