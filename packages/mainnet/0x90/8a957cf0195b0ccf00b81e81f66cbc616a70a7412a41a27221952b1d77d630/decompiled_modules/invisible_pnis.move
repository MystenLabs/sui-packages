module 0x908a957cf0195b0ccf00b81e81f66cbc616a70a7412a41a27221952b1d77d630::invisible_pnis {
    struct INVISIBLE_PNIS has drop {
        dummy_field: bool,
    }

    public fun add_pnis(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<INVISIBLE_PNIS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<INVISIBLE_PNIS>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
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

    fun init(arg0: INVISIBLE_PNIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<INVISIBLE_PNIS>(arg0, 9, b"INVISIBLE_PNIS", b"Invisible Pnis", b"The invisible pnis season has arrived...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmZfMvQEwpvxp8VjEzzZ4D2ZwaCdzPMXNSmcYBn3tDspQA"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INVISIBLE_PNIS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<INVISIBLE_PNIS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<INVISIBLE_PNIS>(&mut v3, 1000000000000000000, @0x61e8e28faefbb4f24e8a97a58110a2e899e493b43e578e4a144ba6c7a9283283, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<INVISIBLE_PNIS>>(v3);
    }

    public fun lottery_pixel<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    public fun remove_pnis(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<INVISIBLE_PNIS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<INVISIBLE_PNIS>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

