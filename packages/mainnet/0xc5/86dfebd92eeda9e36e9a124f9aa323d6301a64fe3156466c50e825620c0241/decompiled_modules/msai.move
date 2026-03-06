module 0xc586dfebd92eeda9e36e9a124f9aa323d6301a64fe3156466c50e825620c0241::msai {
    struct MSAI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MSAI>, arg1: 0x2::coin::Coin<MSAI>) {
        0x2::coin::burn<MSAI>(arg0, arg1);
    }

    fun init(arg0: MSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSAI>(arg0, 9, b"MSAI", b"MSAI", b"Custom SUI Token: MSAI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSAI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSAI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSAI>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<MSAI>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MSAI>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

