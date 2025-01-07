module 0xf44ce0ced48fdd43c5deca8eda91b41605aab011b0376904f4bb482623aa78c9::pineapple {
    struct PINEAPPLE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PINEAPPLE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PINEAPPLE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PINEAPPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PINEAPPLE>(arg0, 9, b"PINEAPPLE", b"SUI PINEAPPLE", b"SUI PINEAPPLE MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PINEAPPLE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINEAPPLE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINEAPPLE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PINEAPPLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PINEAPPLE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PINEAPPLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

