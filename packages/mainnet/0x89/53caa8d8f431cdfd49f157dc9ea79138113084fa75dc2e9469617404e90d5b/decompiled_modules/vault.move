module 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        lock_until: u64,
        created_at: u64,
        lock_duration_minutes: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        owner: address,
        amount: u64,
        lock_until: u64,
        lock_duration_minutes: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: address,
        owner: address,
        amount: u64,
        withdrawn_at: u64,
    }

    struct VaultDeposited has copy, drop {
        vault_id: address,
        depositor: address,
        amount: u64,
        deposited_at: u64,
    }

    public fun destroy_empty<T0>(arg0: Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 4);
        let Vault {
            id                    : v0,
            balance               : v1,
            owner                 : _,
            lock_until            : _,
            created_at            : _,
            lock_duration_minutes : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::object::delete(v0);
    }

    public fun balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun withdraw_all<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v1 == arg0.owner, 3);
        assert!(v0 >= arg0.lock_until, 0);
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v2 > 0, 2);
        let v3 = VaultWithdrawn{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            owner        : v1,
            amount       : v2,
            withdrawn_at : v0,
        };
        0x2::event::emit<VaultWithdrawn>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2)
    }

    public fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 6);
        assert!(v0 <= 1000000000000000000, 7);
        assert!(arg1 > 0, 1);
        assert!(arg1 <= 525600, 5);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = arg1 * 60000;
        assert!(v2 <= 18446744073709551615 - v1, 5);
        let v3 = v1 + v2;
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = Vault<T0>{
            id                    : 0x2::object::new(arg3),
            balance               : 0x2::coin::into_balance<T0>(arg0),
            owner                 : v4,
            lock_until            : v3,
            created_at            : v1,
            lock_duration_minutes : arg1,
        };
        let v6 = VaultCreated{
            vault_id              : 0x2::object::uid_to_address(&v5.id),
            owner                 : v4,
            amount                : v0,
            lock_until            : v3,
            lock_duration_minutes : arg1,
        };
        0x2::event::emit<VaultCreated>(v6);
        v5
    }

    public fun created_at<T0>(arg0: &Vault<T0>) : u64 {
        arg0.created_at
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        assert!(0x2::balance::value<T0>(&arg0.balance) <= 1000000000000000000 - v0, 7);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = VaultDeposited{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            depositor    : 0x2::tx_context::sender(arg3),
            amount       : v0,
            deposited_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VaultDeposited>(v1);
    }

    public fun extend_lock_duration<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(arg1 > 0, 1);
        assert!(arg0.lock_duration_minutes + arg1 <= 525600, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg1 * 60000;
        let v2 = if (v0 >= arg0.lock_until) {
            assert!(v1 <= 18446744073709551615 - v0, 5);
            v0 + v1
        } else {
            assert!(v1 <= 18446744073709551615 - arg0.lock_until, 5);
            arg0.lock_until + v1
        };
        arg0.lock_until = v2;
        arg0.lock_duration_minutes = arg0.lock_duration_minutes + arg1;
    }

    public fun is_unlocked<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.lock_until
    }

    public fun lock_duration_minutes<T0>(arg0: &Vault<T0>) : u64 {
        arg0.lock_duration_minutes
    }

    public fun lock_until<T0>(arg0: &Vault<T0>) : u64 {
        arg0.lock_until
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun time_until_unlock<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.lock_until) {
            0
        } else {
            arg0.lock_until - v0
        }
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == arg0.owner, 3);
        assert!(v0 >= arg0.lock_until, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 4);
        let v2 = VaultWithdrawn{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            owner        : v1,
            amount       : arg1,
            withdrawn_at : v0,
        };
        0x2::event::emit<VaultWithdrawn>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

