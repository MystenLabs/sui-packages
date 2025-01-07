module 0xb61a0596d2e048f55c6aed39f4b265a667e3521f33370a1e530178a95053c394::chococat {
    struct CHOCOCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHOCOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHOCOCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CHOCOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHOCOCAT>(arg0, 9, b"ChocoCat", b"ChocoCat", b"ChocoCat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHOCOCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOCOCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCOCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHOCOCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHOCOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHOCOCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

