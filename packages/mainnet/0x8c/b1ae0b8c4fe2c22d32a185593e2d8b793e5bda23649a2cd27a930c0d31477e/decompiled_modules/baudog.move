module 0x8cb1ae0b8c4fe2c22d32a185593e2d8b793e5bda23649a2cd27a930c0d31477e::baudog {
    struct BAUDOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAUDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BAUDOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BAUDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BAUDOG>(arg0, 9, b"BAU", b"BAU DOG", b"BAU DOG MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BAUDOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAUDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAUDOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BAUDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAUDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BAUDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

