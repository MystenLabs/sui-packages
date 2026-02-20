module 0xca613a02499d18b2d6977d0b49fa2d3d0c46d5bdd5ceaf155911b3533bbf426f::main_coin {
    struct MAIN_COIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAIN_COIN>, arg1: 0x2::coin::Coin<MAIN_COIN>) {
        0x2::coin::burn<MAIN_COIN>(arg0, arg1);
    }

    fun init(arg0: MAIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN_COIN>(arg0, 9, b"CSTM", b"Custom Token", b"My Custom SUI Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAIN_COIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIN_COIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIN_COIN>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<MAIN_COIN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MAIN_COIN>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

