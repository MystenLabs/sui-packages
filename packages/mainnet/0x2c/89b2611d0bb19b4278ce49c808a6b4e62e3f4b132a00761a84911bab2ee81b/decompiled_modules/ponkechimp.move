module 0x2c89b2611d0bb19b4278ce49c808a6b4e62e3f4b132a00761a84911bab2ee81b::ponkechimp {
    struct PONKECHIMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PONKECHIMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PONKECHIMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PONKECHIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PONKECHIMP>(arg0, 9, b"PonkeChimp", b"PonkeChimp", b"PonkeChimp Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PONKECHIMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONKECHIMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKECHIMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PONKECHIMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PONKECHIMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PONKECHIMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

