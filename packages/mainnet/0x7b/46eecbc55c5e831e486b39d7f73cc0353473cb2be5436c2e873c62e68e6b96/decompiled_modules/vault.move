module 0x7b46eecbc55c5e831e486b39d7f73cc0353473cb2be5436c2e873c62e68e6b96::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        amount: u64,
        vault_id: 0x2::object::ID,
    }

    struct DepositEventWithThreshold<phantom T0> has copy, drop {
        amount_deposited: u64,
        amount_threshold: u64,
        vault_id: 0x2::object::ID,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        amount: u64,
        vault_id: 0x2::object::ID,
    }

    public fun balance_of<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun deposit_coin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public fun deposit_coin_with_event<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v0 = DepositEvent<T0>{
            amount   : 0x2::coin::value<T0>(&arg1),
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::event::emit<DepositEvent<T0>>(v0);
    }

    public fun deposit_coin_with_threshold<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public fun deposit_coin_with_threshold_and_event<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 2);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v1 = DepositEventWithThreshold<T0>{
            amount_deposited : v0,
            amount_threshold : arg2,
            vault_id         : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::event::emit<DepositEventWithThreshold<T0>>(v1);
    }

    public fun new_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun set_admin<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public fun withdraw_balance<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun withdraw_balance_with_event<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let v0 = WithdrawEvent<T0>{
            amount   : arg1,
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2)
    }

    public fun withdraw_coin_with_event<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let v0 = WithdrawEvent<T0>{
            amount   : arg1,
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
        0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

