module 0x4342d5eb562084df01be04a18c810bc96d51a2129f3649707f13f1bad69e2e4d::bitdog {
    struct BITDOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BITDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BITDOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BITDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BITDOG>(arg0, 9, b"BITDOG", b"BITDOG", b"BITDOG MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BITDOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITDOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BITDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BITDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BITDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

