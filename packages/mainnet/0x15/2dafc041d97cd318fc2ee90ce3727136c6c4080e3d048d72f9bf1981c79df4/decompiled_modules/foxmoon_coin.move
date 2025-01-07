module 0x152dafc041d97cd318fc2ee90ce3727136c6c4080e3d048d72f9bf1981c79df4::foxmoon_coin {
    struct FOXMOON_COIN has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOXMOON_COIN>, arg1: &OwnerCap, arg2: 0x2::coin::Coin<FOXMOON_COIN>) : u64 {
        0x2::coin::burn<FOXMOON_COIN>(arg0, arg2)
    }

    fun init(arg0: FOXMOON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<FOXMOON_COIN>(arg0, 9, b"FXM", b"Foxmoon Coin", b"Foxmoon's first coin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOXMOON_COIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXMOON_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOXMOON_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOXMOON_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

