module 0xd202a86cc1b6617d6606d2c8de04d86103fbd8107789fa6c2d5c85667c1dfa46::mooncake {
    struct MOONCAKE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOONCAKE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MOONCAKE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MOONCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MOONCAKE>(arg0, 9, b"MoonCake", b"Sui Moon Cake", b"Sui Moon Cake Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MOONCAKE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONCAKE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONCAKE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MOONCAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOONCAKE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MOONCAKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

