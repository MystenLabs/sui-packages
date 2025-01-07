module 0x892470e4a331d9c9da49764cd4dfa050834fe369758cb3ef15d3777ed3385b7d::babybomb {
    struct BABYBOMB has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYBOMB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BABYBOMB>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BABYBOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BABYBOMB>(arg0, 9, b"BabyBomb", b"Sui Baby Bomb", b"Sui Baby Bomb Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BABYBOMB>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYBOMB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBOMB>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABYBOMB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYBOMB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BABYBOMB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

