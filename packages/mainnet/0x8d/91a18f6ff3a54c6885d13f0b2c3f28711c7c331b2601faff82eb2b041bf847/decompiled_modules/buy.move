module 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::buy {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun buy<T0>(arg0: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::vault::GoldVault, arg2: &mut Treasury<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_paused(arg0);
        assert_coin_type<T0>(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_treasury(arg0, 0x2::object::id<Treasury<T0>>(arg2));
        let v0 = 0x2::tx_context::sender(arg6);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_blacklisted(arg0, v0);
        let v1 = price_of(arg0, arg3);
        assert!(0x2::coin::value<T0>(&arg4) >= v1, 17);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::enforce_limit(arg0, 1, arg5);
        let v2 = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::vault::take_one_of_denom(arg1, arg3);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v1, arg6)));
        settle_change<T0>(arg4, v0);
        0x2::transfer::public_transfer<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(v2, v0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::purchased(0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::id(&v2), v0, arg3, v1);
    }

    fun assert_coin_type<T0>(arg0: &0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig) {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::coin_type(arg0), 21);
    }

    public fun buy_many<T0>(arg0: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::vault::GoldVault, arg2: &mut Treasury<T0>, arg3: vector<u8>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_paused(arg0);
        assert_coin_type<T0>(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_treasury(arg0, 0x2::object::id<Treasury<T0>>(arg2));
        let v0 = 0x2::tx_context::sender(arg7);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_blacklisted(arg0, v0);
        assert!(0x1::vector::length<u8>(&arg3) == 0x1::vector::length<u64>(&arg4), 15);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&arg3)) {
            let v4 = *0x1::vector::borrow<u64>(&arg4, v3);
            v1 = v1 + price_of(arg0, *0x1::vector::borrow<u8>(&arg3, v3)) * v4;
            v2 = v2 + v4;
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<T0>(&arg5) >= v1, 17);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::enforce_limit(arg0, v2, arg6);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&arg3)) {
            let v6 = *0x1::vector::borrow<u8>(&arg3, v5);
            let v7 = 0;
            while (v7 < *0x1::vector::borrow<u64>(&arg4, v5)) {
                let v8 = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::vault::take_one_of_denom(arg1, v6);
                0x2::transfer::public_transfer<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(v8, v0);
                0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::purchased(0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::id(&v8), v0, v6, price_of(arg0, v6));
                v7 = v7 + 1;
            };
            v5 = v5 + 1;
        };
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v1, arg7)));
        settle_change<T0>(arg5, v0);
    }

    public fun create_treasury<T0>(arg0: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert_coin_type<T0>(arg0);
        let v0 = 0x2::object::new(arg1);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::register_treasury(arg0, 0x2::object::uid_to_inner(&v0));
        let v1 = Treasury<T0>{
            id      : v0,
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v1);
    }

    public fun execute_withdraw<T0>(arg0: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut Treasury<T0>, arg2: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::Proposal, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        assert_coin_type<T0>(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_treasury(arg0, 0x2::object::id<Treasury<T0>>(arg1));
        let (v0, v1) = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::withdraw_params(arg2);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::consume(arg0, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v0), arg4), v1);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::treasury_withdrawn(v0, v1);
    }

    public fun price_of(arg0: &0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: u8) : u64 {
        let v0 = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::mg_per_token(arg0);
        let v1 = (arg1 as u64) * 1000 * 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::unit_scale(arg0);
        if (v1 % v0 == 0) {
            v1 / v0
        } else {
            v1 / v0 + 1
        }
    }

    fun settle_change<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun treasury_value<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    // decompiled from Move bytecode v7
}

