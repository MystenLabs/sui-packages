module 0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::satlayer_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        staking_cap: u64,
        is_paused: bool,
        caps_enabled: bool,
        balance: 0x2::balance::Balance<T0>,
        min_deposit_amount: u64,
        withdrawal_cooldown: u64,
        withdraw_info: 0x2::table::Table<address, WithdrawInfo>,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
    }

    struct WithdrawInfo has drop, store {
        withdrawal_requests: u64,
        withdraw_amount: u64,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        actual_amount: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        sender: address,
        amount: u64,
    }

    struct WithdrawalRequest<phantom T0> has copy, drop {
        sender: address,
        amount: u64,
        receipt_token_burned: u64,
        withdrawal_timestamp: u64,
    }

    struct SetStakingCapEvent<phantom T0> has copy, drop {
        admin: address,
        vault: 0x2::object::ID,
        new_cap: u64,
    }

    struct CapsEnabledEvent<phantom T0> has copy, drop {
        admin: address,
        vault: 0x2::object::ID,
        enabled: bool,
    }

    struct ToggleVaultEvent<phantom T0> has copy, drop {
        admin: address,
        vault: 0x2::object::ID,
        status: bool,
    }

    struct UpdateWithdrawalTimeEvent<phantom T0> has copy, drop {
        admin: address,
        vault: 0x2::object::ID,
        new_cooldown_time: u64,
    }

    struct InitializeVaultEvent<phantom T0, phantom T1> has copy, drop {
        admin: address,
        vault: 0x2::object::ID,
        input_coin_type: 0x1::type_name::TypeName,
        receipt_coin_type: 0x1::type_name::TypeName,
        staking_cap: u64,
        min_deposit_amount: u64,
        withdrawal_cooldown: u64,
    }

    public fun deposit_for<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::validate_version(arg2, 1);
        assert!(!arg0.is_paused, 3);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 5);
        if (arg0.caps_enabled) {
            assert!(0x2::coin::value<T0>(&arg1) >= arg0.min_deposit_amount, 9);
            if (0x2::balance::value<T0>(&arg0.balance) + 0x2::coin::value<T0>(&arg1) > arg0.staking_cap) {
                abort 4
            };
        };
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = DepositEvent<T1>{
            sender        : 0x2::tx_context::sender(arg3),
            coin_type     : 0x1::type_name::get<T1>(),
            actual_amount : v0,
        };
        0x2::event::emit<DepositEvent<T1>>(v1);
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, v0, arg3)
    }

    public fun get_staking_cap<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.staking_cap
    }

    public fun get_total_vault_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_user_withdraw_info<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::table::borrow<address, WithdrawInfo>(&arg0.withdraw_info, 0x2::tx_context::sender(arg1));
        (v0.withdrawal_requests, v0.withdraw_amount)
    }

    public fun get_vault_is_paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun get_withdrawal_cooldown_time<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.withdrawal_cooldown
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_vault<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::validate_version(arg5, 1);
        assert!(0x2::coin::total_supply<T1>(&arg1) == 0, 7);
        assert!(arg4 >= 604800000 && arg4 <= 1209600000, 8);
        let v0 = Vault<T0, T1>{
            id                  : 0x2::object::new(arg6),
            staking_cap         : arg2,
            is_paused           : true,
            caps_enabled        : true,
            balance             : 0x2::balance::zero<T0>(),
            min_deposit_amount  : arg3,
            withdrawal_cooldown : arg4,
            withdraw_info       : 0x2::table::new<address, WithdrawInfo>(arg6),
            treasury_cap        : arg1,
        };
        let v1 = InitializeVaultEvent<T0, T1>{
            admin               : 0x2::tx_context::sender(arg6),
            vault               : 0x2::object::id<Vault<T0, T1>>(&v0),
            input_coin_type     : 0x1::type_name::get<T0>(),
            receipt_coin_type   : 0x1::type_name::get<T1>(),
            staking_cap         : arg2,
            min_deposit_amount  : arg3,
            withdrawal_cooldown : arg4,
        };
        0x2::event::emit<InitializeVaultEvent<T0, T1>>(v1);
        0x2::transfer::public_share_object<Vault<T0, T1>>(v0);
    }

    public fun queue_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::validate_version(arg3, 1);
        assert!(!arg0.is_paused, 3);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 6);
        if (!0x2::table::contains<address, WithdrawInfo>(&arg0.withdraw_info, 0x2::tx_context::sender(arg4))) {
            let v0 = WithdrawInfo{
                withdrawal_requests : 0x2::clock::timestamp_ms(arg2) + arg0.withdrawal_cooldown,
                withdraw_amount     : 0x2::coin::value<T1>(&arg1),
            };
            0x2::table::add<address, WithdrawInfo>(&mut arg0.withdraw_info, 0x2::tx_context::sender(arg4), v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, WithdrawInfo>(&mut arg0.withdraw_info, 0x2::tx_context::sender(arg4));
            v1.withdrawal_requests = 0x2::clock::timestamp_ms(arg2) + arg0.withdrawal_cooldown;
            v1.withdraw_amount = v1.withdraw_amount + 0x2::coin::value<T1>(&arg1);
        };
        let v2 = WithdrawalRequest<T1>{
            sender               : 0x2::tx_context::sender(arg4),
            amount               : 0x2::coin::value<T1>(&arg1),
            receipt_token_burned : 0x2::coin::value<T1>(&arg1),
            withdrawal_timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawalRequest<T1>>(v2);
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, arg1);
    }

    public fun set_caps_enabled<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: bool, arg3: &0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::validate_version(arg3, 1);
        assert!(arg1.caps_enabled != arg2, 2);
        arg1.caps_enabled = arg2;
        let v0 = CapsEnabledEvent<T1>{
            admin   : 0x2::tx_context::sender(arg4),
            vault   : 0x2::object::id<Vault<T0, T1>>(arg1),
            enabled : arg2,
        };
        0x2::event::emit<CapsEnabledEvent<T1>>(v0);
    }

    public fun set_staking_cap<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::validate_version(arg3, 1);
        assert!(arg1.staking_cap != arg2, 2);
        arg1.staking_cap = arg2;
        let v0 = SetStakingCapEvent<T1>{
            admin   : 0x2::tx_context::sender(arg4),
            vault   : 0x2::object::id<Vault<T0, T1>>(arg1),
            new_cap : arg2,
        };
        0x2::event::emit<SetStakingCapEvent<T1>>(v0);
    }

    public fun toggle_vault_pause<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: bool, arg3: &0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::validate_version(arg3, 1);
        assert!(arg1.is_paused != arg2, 2);
        arg1.is_paused = arg2;
        let v0 = ToggleVaultEvent<T1>{
            admin  : 0x2::tx_context::sender(arg4),
            vault  : 0x2::object::id<Vault<T0, T1>>(arg1),
            status : arg2,
        };
        0x2::event::emit<ToggleVaultEvent<T1>>(v0);
    }

    public fun update_withdrawal_time<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::validate_version(arg3, 1);
        assert!(arg2 > arg1.withdrawal_cooldown && arg2 <= 1209600000, 10);
        arg1.withdrawal_cooldown = arg2;
        let v0 = UpdateWithdrawalTimeEvent<T1>{
            admin             : 0x2::tx_context::sender(arg4),
            vault             : 0x2::object::id<Vault<T0, T1>>(arg1),
            new_cooldown_time : arg2,
        };
        0x2::event::emit<UpdateWithdrawalTimeEvent<T1>>(v0);
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version::validate_version(arg2, 1);
        assert!(!arg0.is_paused, 3);
        assert!(0x2::table::contains<address, WithdrawInfo>(&arg0.withdraw_info, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x2::table::borrow<address, WithdrawInfo>(&arg0.withdraw_info, 0x2::tx_context::sender(arg3)).withdrawal_requests, 1);
        let v0 = 0x2::table::remove<address, WithdrawInfo>(&mut arg0.withdraw_info, 0x2::tx_context::sender(arg3));
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0.withdraw_amount), arg3);
        let v2 = WithdrawEvent<T1>{
            sender : 0x2::tx_context::sender(arg3),
            amount : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<WithdrawEvent<T1>>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

