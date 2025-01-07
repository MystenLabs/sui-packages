module 0x61c3bd9450146f1bffd5534c6b7c72ee10cc8f3887faf29ff53f786b33d44656::bmd {
    struct BMD has drop {
        dummy_field: bool,
    }

    public fun add_deng(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BMD>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<BMD>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
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

    public fun claim_reward<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    fun init(arg0: BMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BMD>(arg0, 9, b"BMD", b"Baby Moo Deng", b"Baby Moo Deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmNgDKBaobD6Xo7FNta7ANKgL7SPYemoSJzTMtXNpyNMT2"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BMD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<BMD>(&mut v3, 1000000000000000000, @0xd8e5827d5855991db17b658a94ca588d25533cd1ca7d967dc48057a8bd100949, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BMD>>(v3);
    }

    public fun lottery_pixel<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    public fun remove_deng(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BMD>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<BMD>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

