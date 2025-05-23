module 0x1ee8a559b7e7079a0010dcc9aa918a1db2740cd291b4ab421afcff9b4d32b348::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POPPY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<POPPY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POPPY>(arg0, 9, b"POPPY", b"POPPY", b"POPPY MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<POPPY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPPY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POPPY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<POPPY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

