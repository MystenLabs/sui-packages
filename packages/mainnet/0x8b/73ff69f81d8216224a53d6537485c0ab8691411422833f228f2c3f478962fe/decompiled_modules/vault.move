module 0x8b73ff69f81d8216224a53d6537485c0ab8691411422833f228f2c3f478962fe::vault {
    struct ActivityEntry has copy, drop, store {
        kind: u8,
        actor: address,
        amount: u64,
        timestamp_ms: u64,
        aux: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        unlock_ms: u64,
        locked_at_ms: u64,
        withdrawn: bool,
        activity: vector<ActivityEntry>,
    }

    struct VaultMembership<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
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
        topped_up_at_ms: u64,
    }

    struct VaultExtendedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        old_unlock_ms: u64,
        new_unlock_ms: u64,
        extended_at_ms: u64,
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

    public fun activity_actor(arg0: &ActivityEntry) : address {
        arg0.actor
    }

    public fun activity_amount(arg0: &ActivityEntry) : u64 {
        arg0.amount
    }

    public fun activity_at<T0>(arg0: &Vault<T0>, arg1: u64) : &ActivityEntry {
        0x1::vector::borrow<ActivityEntry>(&arg0.activity, arg1)
    }

    public fun activity_aux(arg0: &ActivityEntry) : u64 {
        arg0.aux
    }

    public fun activity_kind(arg0: &ActivityEntry) : u8 {
        arg0.kind
    }

    public fun activity_len<T0>(arg0: &Vault<T0>) : u64 {
        0x1::vector::length<ActivityEntry>(&arg0.activity)
    }

    public fun activity_max() : u64 {
        100
    }

    public fun activity_timestamp_ms(arg0: &ActivityEntry) : u64 {
        arg0.timestamp_ms
    }

    public fun extend_lock<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 60);
        assert!(!arg0.withdrawn, 34);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > v0, 20);
        assert!(arg1 - v0 <= 315360000000, 22);
        assert!(arg1 > arg0.unlock_ms, 31);
        let v1 = arg0.unlock_ms;
        arg0.unlock_ms = arg1;
        let v2 = ActivityEntry{
            kind         : 2,
            actor        : arg0.owner,
            amount       : 0,
            timestamp_ms : v0,
            aux          : v1,
        };
        push_activity<T0>(arg0, v2);
        let v3 = VaultExtendedEvent<T0>{
            vault_id       : 0x2::object::uid_to_inner(&arg0.id),
            owner          : arg0.owner,
            old_unlock_ms  : v1,
            new_unlock_ms  : arg1,
            extended_at_ms : v0,
        };
        0x2::event::emit<VaultExtendedEvent<T0>>(v3);
    }

    public fun is_unlocked<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 21);
        assert!(v1 >= 1000000, 23);
        assert!(arg1 > v0, 20);
        assert!(arg1 - v0 <= 315360000000, 22);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x1::vector::empty<ActivityEntry>();
        let v4 = ActivityEntry{
            kind         : 0,
            actor        : v2,
            amount       : v1,
            timestamp_ms : v0,
            aux          : arg1,
        };
        0x1::vector::push_back<ActivityEntry>(&mut v3, v4);
        let v5 = Vault<T0>{
            id           : 0x2::object::new(arg3),
            owner        : v2,
            balance      : 0x2::coin::into_balance<T0>(arg0),
            unlock_ms    : arg1,
            locked_at_ms : v0,
            withdrawn    : false,
            activity     : v3,
        };
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        let v7 = VaultMembership<T0>{
            id       : 0x2::object::new(arg3),
            vault_id : v6,
        };
        0x2::transfer::transfer<VaultMembership<T0>>(v7, v2);
        0x2::transfer::share_object<Vault<T0>>(v5);
        let v8 = VaultLockedEvent<T0>{
            vault_id     : v6,
            owner        : v2,
            amount       : v1,
            unlock_ms    : arg1,
            locked_at_ms : v0,
        };
        0x2::event::emit<VaultLockedEvent<T0>>(v8);
    }

    public fun locked_at_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.locked_at_ms
    }

    public fun min_amount() : u64 {
        1000000
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    fun push_activity<T0>(arg0: &mut Vault<T0>, arg1: ActivityEntry) {
        if (0x1::vector::length<ActivityEntry>(&arg0.activity) >= 100) {
            0x1::vector::remove<ActivityEntry>(&mut arg0.activity, 0);
        };
        0x1::vector::push_back<ActivityEntry>(&mut arg0.activity, arg1);
    }

    public fun top_up<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 21);
        assert!(v0 >= 1000000, 23);
        assert!(!arg0.withdrawn, 34);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 < arg0.unlock_ms, 32);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = ActivityEntry{
            kind         : 1,
            actor        : v3,
            amount       : v0,
            timestamp_ms : v1,
            aux          : 0,
        };
        push_activity<T0>(arg0, v4);
        let v5 = VaultToppedUpEvent<T0>{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            contributor     : v3,
            amount          : v0,
            new_balance     : v2,
            topped_up_at_ms : v1,
        };
        0x2::event::emit<VaultToppedUpEvent<T0>>(v5);
    }

    public fun unlock_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.unlock_ms
    }

    public fun vault_id_of<T0>(arg0: &VaultMembership<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 60);
        assert!(!arg0.withdrawn, 34);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.unlock_ms, 30);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v1 > 0, 33);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2);
        arg0.withdrawn = true;
        let v3 = ActivityEntry{
            kind         : 3,
            actor        : arg0.owner,
            amount       : v1,
            timestamp_ms : v0,
            aux          : 0,
        };
        push_activity<T0>(arg0, v3);
        let v4 = VaultWithdrawnEvent<T0>{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            owner           : arg0.owner,
            amount          : v1,
            withdrawn_at_ms : v0,
        };
        0x2::event::emit<VaultWithdrawnEvent<T0>>(v4);
        v2
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

