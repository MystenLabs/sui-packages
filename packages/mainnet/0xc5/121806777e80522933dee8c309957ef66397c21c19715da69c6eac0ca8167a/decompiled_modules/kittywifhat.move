module 0xc5121806777e80522933dee8c309957ef66397c21c19715da69c6eac0ca8167a::kittywifhat {
    struct KITTYWIFHAT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KITTYWIFHAT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KITTYWIFHAT>>(0x2::coin::mint<KITTYWIFHAT>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KITTYWIFHAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KITTYWIFHAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: KITTYWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KITTYWIFHAT>(arg0, 9, b"KittyWifHat", b"KittyWifHat", b"The Kitty With Hat", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<KITTYWIFHAT>(&mut v3, 400000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITTYWIFHAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTYWIFHAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KITTYWIFHAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KITTYWIFHAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<KITTYWIFHAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

