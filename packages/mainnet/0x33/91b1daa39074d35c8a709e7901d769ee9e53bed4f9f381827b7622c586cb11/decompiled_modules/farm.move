module 0x3391b1daa39074d35c8a709e7901d769ee9e53bed4f9f381827b7622c586cb11::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARM>(arg0, 9, b"FARM", b"FARM", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FARM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FARM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

