module 0x6c1e72a9da52ac46ad0e88aa9e715b7074b3f161a2d1b73ec350ea0e9e1082b1::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TARZAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TARZAN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TARZAN>(arg0, 9, b"TARZAN po beli gasti", b"Tarzan", b"TARZAN po beli gasti deba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TARZAN>>(0x2::coin::mint<TARZAN>(&mut v3, 1000000000000000000, arg1), v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TARZAN>>(v1, v4);
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TARZAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TARZAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

