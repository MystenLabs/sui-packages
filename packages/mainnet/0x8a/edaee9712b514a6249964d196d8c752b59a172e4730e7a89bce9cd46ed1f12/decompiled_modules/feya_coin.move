module 0x8aedaee9712b514a6249964d196d8c752b59a172e4730e7a89bce9cd46ed1f12::feya_coin {
    struct FEYA_COIN has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FEYA_COIN>, arg1: &OwnerCap, arg2: 0x2::coin::Coin<FEYA_COIN>) : u64 {
        0x2::coin::burn<FEYA_COIN>(arg0, arg2)
    }

    fun init(arg0: FEYA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<FEYA_COIN>(arg0, 9, b"FYC", b"Feya Coin", b"Feya's first coin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEYA_COIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEYA_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FEYA_COIN>, arg1: &OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FEYA_COIN>(arg0, arg2, 0x2::tx_context::sender(arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

