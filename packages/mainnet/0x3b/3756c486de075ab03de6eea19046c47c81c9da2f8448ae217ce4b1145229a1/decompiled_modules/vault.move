module 0x3b3756c486de075ab03de6eea19046c47c81c9da2f8448ae217ce4b1145229a1::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        unlock_ms: u64,
        withdrawn: bool,
    }

    struct VaultLockedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        unlock_ms: u64,
        locked_at_ms: u64,
    }

    struct VaultToppedUpEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        contributor: address,
        amount: u64,
        new_balance: u64,
    }

    struct VaultExtendedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        old_unlock_ms: u64,
        new_unlock_ms: u64,
    }

    struct VaultWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        withdrawn_at_ms: u64,
    }

    public fun balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun extend_lock<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 60);
        assert!(!arg0.withdrawn, 34);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > v0, 20);
        assert!(arg1 - v0 <= 315360000000, 22);
        assert!(arg1 > arg0.unlock_ms, 31);
        arg0.unlock_ms = arg1;
        let v1 = VaultExtendedEvent<T0>{
            vault_id      : 0x2::object::uid_to_inner(&arg0.id),
            owner         : arg0.owner,
            old_unlock_ms : arg0.unlock_ms,
            new_unlock_ms : arg1,
        };
        0x2::event::emit<VaultExtendedEvent<T0>>(v1);
    }

    public fun is_unlocked<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 21);
        assert!(arg1 > v0, 20);
        assert!(arg1 - v0 <= 315360000000, 22);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = Vault<T0>{
            id        : 0x2::object::new(arg3),
            owner     : v2,
            balance   : 0x2::coin::into_balance<T0>(arg0),
            unlock_ms : arg1,
            withdrawn : false,
        };
        0x2::transfer::share_object<Vault<T0>>(v3);
        let v4 = VaultLockedEvent<T0>{
            vault_id     : 0x2::object::uid_to_inner(&v3.id),
            owner        : v2,
            amount       : v1,
            unlock_ms    : arg1,
            locked_at_ms : v0,
        };
        0x2::event::emit<VaultLockedEvent<T0>>(v4);
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun top_up<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 21);
        assert!(!arg0.withdrawn, 34);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.unlock_ms, 32);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = VaultToppedUpEvent<T0>{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            contributor : 0x2::tx_context::sender(arg3),
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<VaultToppedUpEvent<T0>>(v1);
    }

    public fun unlock_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.unlock_ms
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 60);
        assert!(!arg0.withdrawn, 34);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.unlock_ms, 30);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v1 > 0, 33);
        arg0.withdrawn = true;
        let v2 = VaultWithdrawnEvent<T0>{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            owner           : arg0.owner,
            amount          : v1,
            withdrawn_at_ms : v0,
        };
        0x2::event::emit<VaultWithdrawnEvent<T0>>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2)
    }

    public fun withdraw_and_transfer<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun withdrawn<T0>(arg0: &Vault<T0>) : bool {
        arg0.withdrawn
    }

    // decompiled from Move bytecode v7
}

