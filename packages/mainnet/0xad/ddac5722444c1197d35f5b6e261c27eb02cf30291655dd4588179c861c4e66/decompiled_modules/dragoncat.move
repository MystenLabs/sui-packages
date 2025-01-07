module 0xadddac5722444c1197d35f5b6e261c27eb02cf30291655dd4588179c861c4e66::dragoncat {
    struct DRAGONCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DRAGONCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DRAGONCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DRAGONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DRAGONCAT>(arg0, 9, b"DragonCat", b"DragonCat", b"DragonCat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DRAGONCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAGONCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGONCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DRAGONCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DRAGONCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DRAGONCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

