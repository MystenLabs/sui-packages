module 0x338a2df46f4c5fb19ea348a7ed0dc6a52f3b213e53b0d1de22b3b6217abe77df::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FARM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FARM>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARM>(arg0, 9, b"FARM", b"FARM", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FARM>>(0x2::coin::mint<FARM>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FARM>>(v2);
    }

    // decompiled from Move bytecode v6
}

