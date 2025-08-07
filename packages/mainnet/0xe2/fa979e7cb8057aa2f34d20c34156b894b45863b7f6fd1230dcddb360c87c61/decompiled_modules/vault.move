module 0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        strategy_cap: 0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::StrategyOwnerCap<T0>,
        total_shares: u64,
        strategy_type: u8,
        management_fee_bps: u64,
        performance_fee_bps: u64,
        last_compound_time: u64,
        last_total_value: u64,
        manager: address,
        additional_fields: 0x2::bag::Bag,
    }

    struct VaultShare<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
    }

    struct VaultManagerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        strategy_type: u8,
        manager: address,
        management_fee_bps: u64,
        performance_fee_bps: u64,
    }

    struct Deposited has copy, drop {
        vault_id: address,
        user: address,
        deposit_amount: u64,
        shares_minted: u64,
        total_shares: u64,
        share_price: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: address,
        user: address,
        shares_burned: u64,
        withdraw_amount: u64,
        total_shares: u64,
        share_price: u64,
    }

    struct RewardsCompounded has copy, drop {
        vault_id: address,
        reward_token: 0x1::type_name::TypeName,
        reward_amount: u64,
        compounded_amount: u64,
        new_total_value: u64,
    }

    public fun calculate_share_value<T0>(arg0: &Vault<T0>, arg1: &VaultShare<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 3);
        if (arg0.total_shares == 0) {
            return 0
        };
        (((arg1.shares as u128) * (calculate_vault_value<T0>(arg0, arg2) as u128) / (arg0.total_shares as u128)) as u64)
    }

    fun calculate_vault_value<T0>(arg0: &Vault<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        0
    }

    public fun complete_cross_token_compound<T0, T1>(arg0: &mut Vault<T0>, arg1: &VaultManagerCap<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 4);
        let v0 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 > 0, 2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg3, 0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::inner_cap<T0>(&arg0.strategy_cap), arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg3, arg5, arg4, arg6), arg6);
        let v1 = RewardsCompounded{
            vault_id          : 0x2::object::id_address<Vault<T0>>(arg0),
            reward_token      : 0x1::type_name::get<T1>(),
            reward_amount     : 0,
            compounded_amount : v0,
            new_total_value   : calculate_vault_value<T0>(arg0, arg2),
        };
        0x2::event::emit<RewardsCompounded>(v1);
    }

    public fun compound_cross_token_rewards<T0, T1>(arg0: &mut Vault<T0>, arg1: &VaultManagerCap<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 4);
        arg0.last_compound_time = 0x2::clock::timestamp_ms(arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg2, 0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::inner_cap<T0>(&arg0.strategy_cap), arg6, arg3, arg4, arg5, arg7)
    }

    public fun compound_same_token_rewards<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards_and_deposit<T0, T1>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::inner_cap<T0>(&arg0.strategy_cap)), arg5, arg2, arg3, arg4, arg2, arg6);
        arg0.last_compound_time = 0x2::clock::timestamp_ms(arg5);
        let v0 = RewardsCompounded{
            vault_id          : 0x2::object::id_address<Vault<T0>>(arg0),
            reward_token      : 0x1::type_name::get<T1>(),
            reward_amount     : 0,
            compounded_amount : 0,
            new_total_value   : calculate_vault_value<T0>(arg0, arg1),
        };
        0x2::event::emit<RewardsCompounded>(v0);
    }

    public fun create_vault<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u8, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Vault<T0>, VaultManagerCap<T0>) {
        assert!(arg2 <= 1000, 5);
        assert!(arg3 <= 1000, 5);
        let v0 = Vault<T0>{
            id                  : 0x2::object::new(arg4),
            version             : 1,
            strategy_cap        : 0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::create_strategy_owner_cap<T0>(arg0, arg1, arg4),
            total_shares        : 0,
            strategy_type       : arg1,
            management_fee_bps  : arg2,
            performance_fee_bps : arg3,
            last_compound_time  : 0,
            last_total_value    : 0,
            manager             : 0x2::tx_context::sender(arg4),
            additional_fields   : 0x2::bag::new(arg4),
        };
        let v1 = VaultManagerCap<T0>{
            id       : 0x2::object::new(arg4),
            vault_id : 0x2::object::id<Vault<T0>>(&v0),
        };
        let v2 = VaultCreated{
            vault_id            : 0x2::object::id_address<Vault<T0>>(&v0),
            strategy_type       : arg1,
            manager             : 0x2::tx_context::sender(arg4),
            management_fee_bps  : arg2,
            performance_fee_bps : arg3,
        };
        0x2::event::emit<VaultCreated>(v2);
        (v0, v1)
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VaultShare<T0> {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 >= 1000, 2);
        let v1 = if (arg0.total_shares == 0) {
            v0
        } else {
            let v2 = calculate_vault_value<T0>(arg0, arg1);
            if (v2 == 0) {
                v0
            } else {
                (((v0 as u128) * (arg0.total_shares as u128) / (v2 as u128)) as u64)
            }
        };
        assert!(v1 > 0, 2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg2, 0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::inner_cap<T0>(&arg0.strategy_cap), arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg4, arg3, arg5), arg5);
        arg0.total_shares = arg0.total_shares + v1;
        let v3 = VaultShare<T0>{
            id       : 0x2::object::new(arg5),
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            shares   : v1,
        };
        let v4 = if (arg0.total_shares > v1) {
            calculate_vault_value<T0>(arg0, arg1) * 10000 / arg0.total_shares
        } else {
            10000
        };
        let v5 = Deposited{
            vault_id       : 0x2::object::id_address<Vault<T0>>(arg0),
            user           : 0x2::tx_context::sender(arg5),
            deposit_amount : v0,
            shares_minted  : v1,
            total_shares   : arg0.total_shares,
            share_price    : v4,
        };
        0x2::event::emit<Deposited>(v5);
        v3
    }

    public fun management_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.management_fee_bps
    }

    public fun manager<T0>(arg0: &Vault<T0>) : address {
        arg0.manager
    }

    public fun performance_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.performance_fee_bps
    }

    public fun share_amount<T0>(arg0: &VaultShare<T0>) : u64 {
        arg0.shares
    }

    public fun share_vault_id<T0>(arg0: &VaultShare<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun strategy_borrow<T0, T1>(arg0: &mut Vault<T0>, arg1: &VaultManagerCap<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg2, arg3, 0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::inner_cap<T0>(&arg0.strategy_cap), arg5, arg4, arg6)
    }

    public fun strategy_repay<T0, T1>(arg0: &mut Vault<T0>, arg1: &VaultManagerCap<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &mut 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::inner_cap<T0>(&arg0.strategy_cap)), arg5, arg4, arg6);
    }

    public fun strategy_type<T0>(arg0: &Vault<T0>) : u8 {
        arg0.strategy_type
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_shares
    }

    public fun vault_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        0x2::object::id<Vault<T0>>(arg0)
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0>, arg1: VaultShare<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 3);
        let VaultShare {
            id       : v0,
            vault_id : _,
            shares   : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v2 > 0, 7);
        assert!(arg0.total_shares >= v2, 7);
        let v3 = (((v2 as u128) * (calculate_vault_value<T0>(arg0, arg2) as u128) / (arg0.total_shares as u128)) as u64);
        assert!(v3 > 0, 2);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg3, 0xe2fa979e7cb8057aa2f34d20c34156b894b45863b7f6fd1230dcddb360c87c61::strategy_wrapper::inner_cap<T0>(&arg0.strategy_cap), arg4, v3, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5);
        arg0.total_shares = arg0.total_shares - v2;
        let v5 = if (arg0.total_shares > 0) {
            calculate_vault_value<T0>(arg0, arg2) * 10000 / arg0.total_shares
        } else {
            0
        };
        let v6 = Withdrawn{
            vault_id        : 0x2::object::id_address<Vault<T0>>(arg0),
            user            : 0x2::tx_context::sender(arg5),
            shares_burned   : v2,
            withdraw_amount : 0x2::coin::value<T1>(&v4),
            total_shares    : arg0.total_shares,
            share_price     : v5,
        };
        0x2::event::emit<Withdrawn>(v6);
        v4
    }

    // decompiled from Move bytecode v6
}

