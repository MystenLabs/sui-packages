module 0xd3f333ee36fa5a1b2b9719813770e09611cf4b85d991d8d26d1b89202d57108f::cookieape {
    struct COOKIEAPE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COOKIEAPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<COOKIEAPE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: COOKIEAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<COOKIEAPE>(arg0, 9, b"CookieApe", b"CookieApe", b"CookieApe Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<COOKIEAPE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOKIEAPE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKIEAPE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COOKIEAPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COOKIEAPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<COOKIEAPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

