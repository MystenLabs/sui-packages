module 0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::tree_time_lock_vault {
    struct TimeLockVault<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        beneficiary: address,
        unlock_ms: u64,
        balance: 0x2::balance::Balance<T0>,
        total_locked: u64,
        total_withdrawn: u64,
    }

    struct TimeLockVaultCreated<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        beneficiary: address,
        unlock_ms: u64,
    }

    struct TokensLocked<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        locker: address,
        amount: u64,
        total_locked: u64,
        unlock_ms: u64,
    }

    struct TokensWithdrawn<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        remaining_balance: u64,
    }

    struct UnlockExtended<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        old_unlock_ms: u64,
        new_unlock_ms: u64,
    }

    public fun admin<T0>(arg0: &TimeLockVault<T0>) : address {
        arg0.admin
    }

    public fun beneficiary<T0>(arg0: &TimeLockVault<T0>) : address {
        arg0.beneficiary
    }

    entry fun create_time_lock_vault<T0>(arg0: address, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 2);
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = TimeLockVault<T0>{
            id              : 0x2::object::new(arg3),
            admin           : v0,
            beneficiary     : arg0,
            unlock_ms       : arg1,
            balance         : 0x2::balance::zero<T0>(),
            total_locked    : 0,
            total_withdrawn : 0,
        };
        let v2 = TimeLockVaultCreated<T0>{
            vault_id    : 0x2::object::id<TimeLockVault<T0>>(&v1),
            admin       : v0,
            beneficiary : arg0,
            unlock_ms   : arg1,
        };
        0x2::event::emit<TimeLockVaultCreated<T0>>(v2);
        0x2::transfer::share_object<TimeLockVault<T0>>(v1);
    }

    entry fun extend_unlock<T0>(arg0: &mut TimeLockVault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        assert!(arg1 > arg0.unlock_ms, 1);
        arg0.unlock_ms = arg1;
        let v0 = UnlockExtended<T0>{
            vault_id      : 0x2::object::id<TimeLockVault<T0>>(arg0),
            admin         : arg0.admin,
            old_unlock_ms : arg0.unlock_ms,
            new_unlock_ms : arg1,
        };
        0x2::event::emit<UnlockExtended<T0>>(v0);
    }

    public fun is_unlocked<T0>(arg0: &TimeLockVault<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms
    }

    entry fun lock_tokens<T0>(arg0: &mut TimeLockVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_locked = arg0.total_locked + v0;
        let v1 = TokensLocked<T0>{
            vault_id     : 0x2::object::id<TimeLockVault<T0>>(arg0),
            locker       : 0x2::tx_context::sender(arg2),
            amount       : v0,
            total_locked : arg0.total_locked,
            unlock_ms    : arg0.unlock_ms,
        };
        0x2::event::emit<TokensLocked<T0>>(v1);
    }

    public fun locked_balance<T0>(arg0: &TimeLockVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun total_locked<T0>(arg0: &TimeLockVault<T0>) : u64 {
        arg0.total_locked
    }

    public fun total_withdrawn<T0>(arg0: &TimeLockVault<T0>) : u64 {
        arg0.total_withdrawn
    }

    public fun unlock_ms<T0>(arg0: &TimeLockVault<T0>) : u64 {
        arg0.unlock_ms
    }

    public fun vault_id<T0>(arg0: &TimeLockVault<T0>) : 0x2::object::ID {
        0x2::object::id<TimeLockVault<T0>>(arg0)
    }

    entry fun withdraw_unlocked<T0>(arg0: &mut TimeLockVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.beneficiary, 5);
        assert!(is_unlocked<T0>(arg0, arg2), 6);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<T0>(&arg0.balance), 7);
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        let v0 = TokensWithdrawn<T0>{
            vault_id          : 0x2::object::id<TimeLockVault<T0>>(arg0),
            beneficiary       : arg0.beneficiary,
            amount            : arg1,
            remaining_balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<TokensWithdrawn<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg0.beneficiary);
    }

    // decompiled from Move bytecode v7
}

