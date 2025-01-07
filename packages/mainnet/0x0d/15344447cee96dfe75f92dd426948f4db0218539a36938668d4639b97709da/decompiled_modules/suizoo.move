module 0xd15344447cee96dfe75f92dd426948f4db0218539a36938668d4639b97709da::suizoo {
    struct SUIZOO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIZOO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIZOO>>(0x2::coin::mint<SUIZOO>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<SUIZOO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZOO>>(arg0, arg1);
    }

    fun init(arg0: SUIZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZOO>(arg0, 8, b"SUIZOO", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

