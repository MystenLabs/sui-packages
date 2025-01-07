module 0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin {
    struct FUNNYYANNE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUNNYYANNE_COIN>, arg1: 0x2::coin::Coin<FUNNYYANNE_COIN>) {
        0x2::coin::burn<FUNNYYANNE_COIN>(arg0, arg1);
    }

    fun init(arg0: FUNNYYANNE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNYYANNE_COIN>(arg0, 9, b"FUNNYYYANNE COIN", b"FUNNYYYANNE COIN", b"Funnyyanne Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNYYANNE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNYYANNE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<FUNNYYANNE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FUNNYYANNE_COIN>>(0x2::coin::mint<FUNNYYANNE_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

