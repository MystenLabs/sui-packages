module 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault {
    struct RebalanceToCex has copy, drop {
        operator: address,
        amount: u64,
        to_address: address,
        token: 0x1::type_name::TypeName,
    }

    struct BuyToAlphaEvent has copy, drop {
        order_id: u256,
        from_token: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token: 0x1::type_name::TypeName,
        to_amount: u64,
        account_id: u256,
        cloud_wallet: address,
    }

    struct SellToSelfFromAlpha has copy, drop {
        order_id: u256,
        from_token: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token: 0x1::type_name::TypeName,
        to_amount: u64,
        withdraw_id: u256,
        cloud_wallet: address,
    }

    struct BuyAlpha {
        id: 0x2::object::ID,
        order_id: u256,
        account_id: u256,
        checksum: vector<u8>,
    }

    struct SellAlpha {
        id: 0x2::object::ID,
        order_id: u256,
        withdraw_id: u256,
    }

    public fun after_buy<T0>(arg0: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultConfig, arg1: &0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet_config::CloudWalletConfig, arg2: &mut 0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet_config::CloudWalletTokenHolder, arg3: 0x2::coin::Coin<T0>, arg4: 0x1e439c11a7e0c89e659ea628439012d6ca6e22ce3ecaad8942b88e4eab250f90::swap::Swaping, arg5: BuyAlpha, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let BuyAlpha {
            id         : v0,
            order_id   : v1,
            account_id : v2,
            checksum   : v3,
        } = arg5;
        let (v4, v5, v6, v7) = 0x1e439c11a7e0c89e659ea628439012d6ca6e22ce3ecaad8942b88e4eab250f90::swap::after_swap<T0>(arg3, arg4);
        let v8 = v4;
        assert!(v0 == v5, 30002);
        let v9 = 0x2::coin::value<T0>(&v8);
        let v10 = 0x2::object::id<0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet_config::CloudWalletTokenHolder>(arg2);
        let v11 = BuyToAlphaEvent{
            order_id     : v1,
            from_token   : v6,
            from_amount  : v7,
            to_token     : 0x1::type_name::get<T0>(),
            to_amount    : v9,
            account_id   : v2,
            cloud_wallet : 0x2::object::id_to_address(&v10),
        };
        0x2::event::emit<BuyToAlphaEvent>(v11);
        0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet::deposit<T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v8), v1, v2, v3, arg6);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::mark_order_id_used(arg0, v1);
        v9
    }

    public fun after_sell<T0>(arg0: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultTokenHolder, arg1: &mut 0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet_config::CloudWalletTokenHolder, arg2: 0x2::coin::Coin<T0>, arg3: 0x1e439c11a7e0c89e659ea628439012d6ca6e22ce3ecaad8942b88e4eab250f90::swap::Swaping, arg4: SellAlpha, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let SellAlpha {
            id          : v0,
            order_id    : v1,
            withdraw_id : v2,
        } = arg4;
        let (v3, v4, v5, v6) = 0x1e439c11a7e0c89e659ea628439012d6ca6e22ce3ecaad8942b88e4eab250f90::swap::after_swap<T0>(arg2, arg3);
        let v7 = v3;
        assert!(v0 == v4, 30002);
        let v8 = 0x2::coin::value<T0>(&v7);
        let v9 = 0x2::object::id<0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet_config::CloudWalletTokenHolder>(arg1);
        let v10 = SellToSelfFromAlpha{
            order_id     : v1,
            from_token   : v5,
            from_amount  : v6,
            to_token     : 0x1::type_name::get<T0>(),
            to_amount    : v8,
            withdraw_id  : v2,
            cloud_wallet : 0x2::object::id_to_address(&v9),
        };
        0x2::event::emit<SellToSelfFromAlpha>(v10);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::deposit_token_from_vault<T0>(arg0, v7);
        v8
    }

    public fun before_buy<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultConfig, arg2: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultTokenHolder, arg3: u64, arg4: u64, arg5: u256, arg6: u256, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1e439c11a7e0c89e659ea628439012d6ca6e22ce3ecaad8942b88e4eab250f90::swap::Swaping, BuyAlpha) {
        swap_check<T0>(arg0, arg1, arg7, arg3, arg5, arg8);
        let v0 = 0x2::coin::from_balance<T0>(0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::get_token_to_vault<T0>(arg2, arg3), arg8);
        let v1 = 0x2::object::id<0x2::coin::Coin<T0>>(&v0);
        let v2 = BuyAlpha{
            id         : v1,
            order_id   : arg5,
            account_id : arg6,
            checksum   : get_checksum<T0>(arg3, arg7),
        };
        (v0, 0x1e439c11a7e0c89e659ea628439012d6ca6e22ce3ecaad8942b88e4eab250f90::swap::before_swap<T0, T1>(arg3, arg4, v1), v2)
    }

    public fun before_sell<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultConfig, arg2: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultTokenHolder, arg3: &mut 0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet_config::CloudWalletTokenHolder, arg5: u64, arg6: u64, arg7: u256, arg8: u256, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1e439c11a7e0c89e659ea628439012d6ca6e22ce3ecaad8942b88e4eab250f90::swap::Swaping, SellAlpha) {
        swap_check<T1>(arg0, arg1, arg9, 0, arg7, arg11);
        let v0 = 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::borrow_withdraw_cap(arg2);
        assert!(arg8 > 0, 30001);
        let v1 = 0x2::coin::from_balance<T0>(0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::cloud_wallet::quick_withdraw<T0>(v0, arg3, arg4, arg0, arg8, arg5, arg10), arg11);
        let v2 = 0x2::object::id<0x2::coin::Coin<T0>>(&v1);
        let v3 = SellAlpha{
            id          : v2,
            order_id    : arg7,
            withdraw_id : arg8,
        };
        (v1, 0x1e439c11a7e0c89e659ea628439012d6ca6e22ce3ecaad8942b88e4eab250f90::swap::before_swap<T0, T1>(arg5, arg6, v2), v3)
    }

    public fun credit_coin<T0>(arg0: &0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultConfig, arg1: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::only_operator(arg0, arg3);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::only_allow_version(arg0);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::credit_coin<T0>(arg1, arg2, arg3);
    }

    public fun emergency_withdraw<T0>(arg0: &0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultConfig, arg1: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultTokenHolder, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::only_admin(arg0, arg4);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::only_allow_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::emergency_withdraw<T0>(arg1, arg2), arg4), arg3);
    }

    public(friend) fun get_checksum<T0>(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(((arg1 / 1000) as u256))));
        0x2::hash::keccak256(&v0)
    }

    public fun rebalance_out<T0>(arg0: &0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultConfig, arg1: &mut 0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultTokenHolder, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::only_operator(arg0, arg4);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::only_allow_version(arg0);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::check_rebalance_to(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::rebalance_out<T0>(arg1, arg3), arg4), arg2);
        let v0 = RebalanceToCex{
            operator   : 0x2::tx_context::sender(arg4),
            amount     : arg3,
            to_address : arg2,
            token      : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RebalanceToCex>(v0);
    }

    public(friend) fun swap_check<T0>(arg0: &0x2::clock::Clock, arg1: &0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::VaultConfig, arg2: u64, arg3: u64, arg4: u256, arg5: &0x2::tx_context::TxContext) {
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::only_trusted_bot(arg1, arg5);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::when_not_paused(arg1);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::when_not_expired(arg0, arg2);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::check_trade_token<T0>(arg1, arg3);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::only_allow_version(arg1);
        0x1636f4b8dcdf00f869cefc55e52733590e2e1f4491ca460e6ba42aca7d39b2e2::vault_config::when_order_id_not_used(arg1, arg4);
    }

    // decompiled from Move bytecode v6
}

