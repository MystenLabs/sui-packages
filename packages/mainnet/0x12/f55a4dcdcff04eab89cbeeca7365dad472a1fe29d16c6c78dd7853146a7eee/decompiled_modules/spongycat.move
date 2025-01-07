module 0x12f55a4dcdcff04eab89cbeeca7365dad472a1fe29d16c6c78dd7853146a7eee::spongycat {
    struct SPONGYCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPONGYCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SPONGYCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SPONGYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SPONGYCAT>(arg0, 9, b"SpongyCat", b"SpongyCat", b"SpongyCat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SPONGYCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONGYCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGYCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SPONGYCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPONGYCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SPONGYCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

