module 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault {
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
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
    }

    struct SellAlpha {
        id: 0x2::object::ID,
        order_id: u256,
        withdraw_id: u256,
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
    }

    public fun after_buy<T0>(arg0: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultConfig, arg1: &0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletConfig, arg2: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder, arg3: 0x2::coin::Coin<T0>, arg4: 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::Swapping, arg5: BuyAlpha, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let BuyAlpha {
            id                : v0,
            order_id          : v1,
            account_id        : v2,
            checksum          : v3,
            from_coin_type    : v4,
            total_from_amount : v5,
        } = arg5;
        let v6 = 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::after_swap<T0>(arg3, arg4);
        assert!(v0 == 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::get_swapping_id(&arg4), 50002);
        let v7 = 0x2::coin::value<T0>(&v6);
        let v8 = 0x2::object::id<0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder>(arg2);
        let v9 = BuyToAlphaEvent{
            order_id     : v1,
            from_token   : v4,
            from_amount  : v5,
            to_token     : 0x1::type_name::get<T0>(),
            to_amount    : v7,
            account_id   : v2,
            cloud_wallet : 0x2::object::id_to_address(&v8),
        };
        0x2::event::emit<BuyToAlphaEvent>(v9);
        0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet::deposit<T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v6), v1, v2, v3, arg6);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::mark_order_id_used(arg0, v1);
        v7
    }

    public fun after_sell<T0>(arg0: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultTokenHolder, arg1: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder, arg2: 0x2::coin::Coin<T0>, arg3: 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::Swapping, arg4: SellAlpha, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let SellAlpha {
            id                : v0,
            order_id          : v1,
            withdraw_id       : v2,
            from_coin_type    : v3,
            total_from_amount : v4,
        } = arg4;
        let v5 = 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::after_swap<T0>(arg2, arg3);
        assert!(v0 == 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::get_swapping_id(&arg3), 50002);
        let v6 = 0x2::coin::value<T0>(&v5);
        let v7 = 0x2::object::id<0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder>(arg1);
        let v8 = SellToSelfFromAlpha{
            order_id     : v1,
            from_token   : v3,
            from_amount  : v4,
            to_token     : 0x1::type_name::get<T0>(),
            to_amount    : v6,
            withdraw_id  : v2,
            cloud_wallet : 0x2::object::id_to_address(&v7),
        };
        0x2::event::emit<SellToSelfFromAlpha>(v8);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::deposit_token_from_vault<T0>(arg0, v5);
        v6
    }

    public fun before_buy<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultConfig, arg2: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultTokenHolder, arg3: u64, arg4: u64, arg5: u256, arg6: u256, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::Swapping, BuyAlpha) {
        swap_check<T0>(arg0, arg1, arg7, arg3, arg5, arg8);
        let v0 = 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::before_swap<T0, T1>(arg3, arg4, arg8);
        let v1 = BuyAlpha{
            id                : 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::get_swapping_id(&v0),
            order_id          : arg5,
            account_id        : arg6,
            checksum          : get_checksum<T0>(arg3, arg7),
            from_coin_type    : 0x1::type_name::get<T0>(),
            total_from_amount : arg3,
        };
        (0x2::coin::from_balance<T0>(0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::get_token_to_vault<T0>(arg2, arg3), arg8), v0, v1)
    }

    public fun before_sell<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultConfig, arg2: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultTokenHolder, arg3: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder, arg5: u64, arg6: u64, arg7: u256, arg8: u256, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::Swapping, SellAlpha) {
        swap_check<T1>(arg0, arg1, arg9, 0, arg7, arg11);
        let v0 = 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::borrow_withdraw_cap(arg2);
        assert!(arg8 > 0, 50001);
        let v1 = 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::before_swap<T0, T1>(arg5, arg6, arg11);
        let v2 = SellAlpha{
            id                : 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap::get_swapping_id(&v1),
            order_id          : arg7,
            withdraw_id       : arg8,
            from_coin_type    : 0x1::type_name::get<T0>(),
            total_from_amount : arg5,
        };
        (0x2::coin::from_balance<T0>(0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet::quick_withdraw<T0>(v0, arg3, arg4, arg0, arg8, arg5, arg10), arg11), v1, v2)
    }

    public fun credit_coin<T0>(arg0: &0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultConfig, arg1: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::only_operator(arg0, arg3);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::only_allow_version(arg0);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::credit_coin<T0>(arg1, arg2, arg3);
    }

    public fun emergency_withdraw<T0>(arg0: &0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultConfig, arg1: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultTokenHolder, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::only_admin(arg0, arg4);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::only_allow_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::emergency_withdraw<T0>(arg1, arg2), arg4), arg3);
    }

    public(friend) fun get_checksum<T0>(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(((arg1 / 1000) as u256))));
        0x2::hash::keccak256(&v0)
    }

    public fun rebalance_out<T0>(arg0: &0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultConfig, arg1: &mut 0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultTokenHolder, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::only_operator(arg0, arg4);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::only_allow_version(arg0);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::check_rebalance_to(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::rebalance_out<T0>(arg1, arg3), arg4), arg2);
        let v0 = RebalanceToCex{
            operator   : 0x2::tx_context::sender(arg4),
            amount     : arg3,
            to_address : arg2,
            token      : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RebalanceToCex>(v0);
    }

    public(friend) fun swap_check<T0>(arg0: &0x2::clock::Clock, arg1: &0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::VaultConfig, arg2: u64, arg3: u64, arg4: u256, arg5: &0x2::tx_context::TxContext) {
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::only_trusted_bot(arg1, arg5);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::when_not_paused(arg1);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::when_not_expired(arg0, arg2);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::check_trade_token<T0>(arg1, arg3);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::only_allow_version(arg1);
        0xbfabeb3e25ca8b12ce738b70f4ff4428e7309193aab597a8ab4ae2e4ab6e6f2a::vault_config::when_order_id_not_used(arg1, arg4);
    }

    // decompiled from Move bytecode v6
}

