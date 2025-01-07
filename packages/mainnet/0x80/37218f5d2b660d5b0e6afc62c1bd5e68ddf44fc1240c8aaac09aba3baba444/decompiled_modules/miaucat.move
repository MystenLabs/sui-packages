module 0x8037218f5d2b660d5b0e6afc62c1bd5e68ddf44fc1240c8aaac09aba3baba444::miaucat {
    struct MIAUCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MIAUCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MIAUCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MIAUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MIAUCAT>(arg0, 9, b"MIAU", b"MIAU CAT", b"MIAU CAT MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MIAUCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIAUCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAUCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MIAUCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MIAUCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MIAUCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

