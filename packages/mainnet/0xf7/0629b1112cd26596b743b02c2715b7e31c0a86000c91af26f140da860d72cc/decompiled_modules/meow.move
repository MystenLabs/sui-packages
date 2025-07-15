module 0xf70629b1112cd26596b743b02c2715b7e31c0a86000c91af26f140da860d72cc::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEOW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<MEOW>(0x2::coin::mint<MEOW>(arg0, arg1, arg3), arg3);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<MEOW>(arg0, v1, arg3);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<MEOW>(arg0, 0x2::token::transfer<MEOW>(v0, arg2, arg3), arg3);
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 2, b"MEOW", b"MEOW", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW>>(v1);
        let (v3, v4) = 0x2::token::new_policy<MEOW>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<MEOW>(&mut v6, &v5, 0x1::string::utf8(b"split"), arg1);
        0x2::token::allow<MEOW>(&mut v6, &v5, 0x1::string::utf8(b"from_coin"), arg1);
        0x2::token::allow<MEOW>(&mut v6, &v5, 0x1::string::utf8(b"to_coin"), arg1);
        0x2::token::allow<MEOW>(&mut v6, &v5, 0x1::string::utf8(b"spend"), arg1);
        0x2::token::add_rule_for_action<MEOW, 0xf70629b1112cd26596b743b02c2715b7e31c0a86000c91af26f140da860d72cc::limit_transfer::LimitTransfer>(&mut v6, &v5, 0x1::string::utf8(b"transfer"), arg1);
        0x2::token::share_policy<MEOW>(v6);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<MEOW>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

