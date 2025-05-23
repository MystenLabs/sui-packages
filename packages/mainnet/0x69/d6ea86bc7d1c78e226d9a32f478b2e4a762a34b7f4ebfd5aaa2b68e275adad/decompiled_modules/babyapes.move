module 0x69d6ea86bc7d1c78e226d9a32f478b2e4a762a34b7f4ebfd5aaa2b68e275adad::babyapes {
    struct BABYAPES has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYAPES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BABYAPES>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BABYAPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BABYAPES>(arg0, 9, b"BabyApes", b"BabyApes", b"BabyApes Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BABYAPES>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYAPES>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAPES>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABYAPES>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYAPES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BABYAPES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

