module 0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::external_rewards {
    struct TokenVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct DistributeStakingPoolEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        staking_pool_id: 0x2::object::ID,
        setter: address,
    }

    struct DistributeCollateralVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        collateral_pool_id: 0x2::object::ID,
        setter: address,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct TokenVaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        creator: address,
    }

    public fun add_token_support<T0>(arg0: &0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenVault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<TokenVault<T0>>(v0);
        let v1 = TokenVaultCreatedEvent{
            vault_id  : 0x2::object::id<TokenVault<T0>>(&v0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            creator   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenVaultCreatedEvent>(v1);
    }

    public entry fun deposit<T0>(arg0: &mut TokenVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositEvent{
            vault_id  : 0x2::object::id<TokenVault<T0>>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun distribute_rewards_collateral_vault<T0>(arg0: &0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::admin::AdminCap, arg1: &mut TokenVault<T0>, arg2: u64, arg3: &mut 0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::collateral_vault_rewards::RewardPool<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            let v0 = DistributeCollateralVaultEvent{
                vault_id           : 0x2::object::id<TokenVault<T0>>(arg1),
                coin_type          : 0x1::type_name::with_defining_ids<T0>(),
                amount             : arg2,
                collateral_pool_id : 0x2::object::id<0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::collateral_vault_rewards::RewardPool<T0>>(arg3),
                setter             : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<DistributeCollateralVaultEvent>(v0);
            0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::collateral_vault_rewards::deposit_reward_funds<T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg4);
        };
    }

    public fun distribute_rewards_staking_pool<T0>(arg0: &0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::admin::AdminCap, arg1: &mut TokenVault<T0>, arg2: u64, arg3: &mut 0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::staking_pool_rewards::RewardPool<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            let v0 = DistributeStakingPoolEvent{
                vault_id        : 0x2::object::id<TokenVault<T0>>(arg1),
                coin_type       : 0x1::type_name::with_defining_ids<T0>(),
                amount          : arg2,
                staking_pool_id : 0x2::object::id<0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::staking_pool_rewards::RewardPool<T0>>(arg3),
                setter          : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<DistributeStakingPoolEvent>(v0);
            0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::staking_pool_rewards::deposit_reward_funds<T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg4);
        };
    }

    public fun emergency_withdraw<T0>(arg0: &0xf7b2f7d0360fb41616fc9e47c2930fc27c81e18ea1cd8ae901ef754f870cecec::admin::AdminCap, arg1: &mut TokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        if (v0 > 0) {
            let v1 = EmergencyWithdrawEvent{
                vault_id  : 0x2::object::id<TokenVault<T0>>(arg1),
                coin_type : 0x1::type_name::with_defining_ids<T0>(),
                amount    : v0,
                recipient : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<EmergencyWithdrawEvent>(v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun get_vault_balance<T0>(arg0: &TokenVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    // decompiled from Move bytecode v6
}

