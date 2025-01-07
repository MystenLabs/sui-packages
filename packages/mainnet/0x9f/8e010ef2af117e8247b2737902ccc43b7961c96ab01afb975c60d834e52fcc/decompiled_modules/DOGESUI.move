module 0x9f8e010ef2af117e8247b2737902ccc43b7961c96ab01afb975c60d834e52fcc::DOGESUI {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGESUI>, arg1: 0x2::coin::Coin<DOGESUI>) {
        0x2::coin::burn<DOGESUI>(arg0, arg1);
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 2, b"DOGESUI", b"BestSuiOfDoge", b"https://i.imgur.com/T7etzYT.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGESUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGESUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

