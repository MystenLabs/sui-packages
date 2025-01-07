module 0xf76a2a870c671d3cc31f3aebc77fc9e4bd85e98ba49c01e9971bfbe9bb47483a::woofy {
    struct WOOFY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WOOFY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WOOFY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WOOFY>(arg0, 9, b"WOOFY", b"WOOFY", b"WOOFY MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WOOFY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOFY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WOOFY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WOOFY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WOOFY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

