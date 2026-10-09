module 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::tokens {
    public fun airdrop<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 13906834346142072833);
        0x1::vector::reverse<u64>(&mut arg2);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 13906834354732007423);
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(arg0, 0x2::token::transfer<T0>(0x2::token::mint<T0>(arg0, 0x1::vector::pop_back<u64>(&mut arg2), arg3), 0x1::vector::pop_back<address>(&mut arg1), arg3), arg3);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
        0x1::vector::destroy_empty<u64>(arg2);
    }

    public(friend) fun setup<T0>(arg0: 0x2::coin_registry::CurrencyInitializer<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::new_policy<T0>(&arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::token::allow<T0>(&mut v3, &v2, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::shop::Purchase>(&mut v3, &v2, 0x2::token::spend_action(), arg2);
        0x2::token::share_policy<T0>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T0>>(0x2::coin_registry::finalize<T0>(arg0, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

