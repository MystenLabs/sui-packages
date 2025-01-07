module 0x44e9fb2dce24aae2b61dca6321fda5022c0814b704618e99174d13fc2fd883fa::melonape {
    struct MELONAPE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MELONAPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MELONAPE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MELONAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MELONAPE>(arg0, 9, b"MelonApe", b"Melon Ape", b"Melon Ape Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MELONAPE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELONAPE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELONAPE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MELONAPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MELONAPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MELONAPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

