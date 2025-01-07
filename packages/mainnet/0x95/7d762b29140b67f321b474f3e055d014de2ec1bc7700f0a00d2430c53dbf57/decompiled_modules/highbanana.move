module 0x957d762b29140b67f321b474f3e055d014de2ec1bc7700f0a00d2430c53dbf57::highbanana {
    struct HIGHBANANA has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HIGHBANANA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HIGHBANANA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HIGHBANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HIGHBANANA>(arg0, 9, b"HighBanana", b"Sui High Banana", b"Sui High Banana Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/cute-banana-relax-with-smoke-cartoon-fruit-vector-icon-illustration-isolated-premium-vector_244307-944.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HIGHBANANA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIGHBANANA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGHBANANA>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HIGHBANANA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HIGHBANANA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HIGHBANANA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

