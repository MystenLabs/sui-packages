module 0x1d022d585ea528404d2ea250b01098ed62348c0a52bf934d797cec374261d7d::desci {
    struct DESCI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DESCI>, arg1: 0x2::coin::Coin<DESCI>) {
        0x2::coin::burn<DESCI>(arg0, arg1);
    }

    fun init(arg0: DESCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESCI>(arg0, 9, b"DESCI", b"SUI Desci Agents", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DESCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DESCI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DESCI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<DESCI>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DESCI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

