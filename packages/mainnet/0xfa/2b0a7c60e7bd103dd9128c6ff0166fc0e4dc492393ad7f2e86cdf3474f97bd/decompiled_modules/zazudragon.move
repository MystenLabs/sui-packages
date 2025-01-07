module 0xfa2b0a7c60e7bd103dd9128c6ff0166fc0e4dc492393ad7f2e86cdf3474f97bd::zazudragon {
    struct ZAZUDRAGON has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ZAZUDRAGON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ZAZUDRAGON>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ZAZUDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ZAZUDRAGON>(arg0, 9, b"ZAZU", b"ZAZU DRAGON", b"ZAZU DRAGON MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ZAZUDRAGON>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAZUDRAGON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZUDRAGON>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ZAZUDRAGON>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ZAZUDRAGON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ZAZUDRAGON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

