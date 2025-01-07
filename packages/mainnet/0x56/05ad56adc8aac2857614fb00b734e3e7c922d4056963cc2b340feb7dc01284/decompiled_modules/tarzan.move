module 0x5605ad56adc8aac2857614fb00b734e3e7c922d4056963cc2b340feb7dc01284::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TARZAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TARZAN>(arg0, arg1, arg2, arg3);
    }

    fun init_internal(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TARZAN>(arg0, 9, b"symbol", b"token name", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TARZAN>(&mut v3, 1000000000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TARZAN>>(v1, v4);
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TARZAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TARZAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

