module 0x506bee0d967e42a2d172db801e9cb7a28b59e9ebe0a802ed6ddc7d266fc0cbb3::NEIRO {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    public fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NEIRO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<NEIRO>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public fun calculate_eligibility<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64, u8) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 1000000000000000000, 9)
    }

    public fun check_eligibility<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 7, b"Sui Neiro", b"SUINEIRO", b"Neiro is a Suimemecoin combining Neiro token's community-driven approach with the popular Shiba Inu dog meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmbZqfdHARmLK2iHJVvkgLPc5fJZeGiv4kekXQasRUMC8i")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEIRO>(&mut v2, 1000000000000000000, @0xb98f2cc8b568d50b4bba8098e8388dd07a97d540ef00e88bf11e5671f8062631, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v2, @0x0);
    }

    public fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NEIRO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_remove<NEIRO>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

