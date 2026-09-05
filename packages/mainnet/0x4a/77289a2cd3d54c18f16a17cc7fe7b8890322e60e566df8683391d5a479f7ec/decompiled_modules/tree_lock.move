module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::tree_lock {
    struct TreeLock<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        funds: 0x2::balance::Balance<T0>,
        locked_at_ms: u64,
        unlock_at_ms: u64,
    }

    struct TreeLocked has copy, drop {
        lock_id: address,
        owner: address,
        amount_raw: u64,
        locked_at_ms: u64,
        unlock_at_ms: u64,
    }

    struct TreeUnlocked has copy, drop {
        lock_id: address,
        owner: address,
        amount_raw: u64,
    }

    public fun amount_raw<T0>(arg0: &TreeLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public entry fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= 1000000000000, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_tree_lock_below_minimum());
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 <= 18446744073709551615 - 2592000000, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_tree_lock_overflow());
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = TreeLock<T0>{
            id           : 0x2::object::new(arg2),
            owner        : v2,
            funds        : 0x2::coin::into_balance<T0>(arg0),
            locked_at_ms : v1,
            unlock_at_ms : v1 + 2592000000,
        };
        0x2::transfer::transfer<TreeLock<T0>>(v3, v2);
        let v4 = TreeLocked{
            lock_id      : 0x2::object::uid_to_address(&v3.id),
            owner        : v2,
            amount_raw   : v0,
            locked_at_ms : v1,
            unlock_at_ms : v3.unlock_at_ms,
        };
        0x2::event::emit<TreeLocked>(v4);
    }

    public fun lock_period_ms() : u64 {
        2592000000
    }

    public fun locked_at_ms<T0>(arg0: &TreeLock<T0>) : u64 {
        arg0.locked_at_ms
    }

    public fun minimum_tree_raw() : u64 {
        1000000000000
    }

    public fun owner<T0>(arg0: &TreeLock<T0>) : address {
        arg0.owner
    }

    public entry fun unlock<T0>(arg0: TreeLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let TreeLock {
            id           : v0,
            owner        : v1,
            funds        : v2,
            locked_at_ms : _,
            unlock_at_ms : v4,
        } = arg0;
        let v5 = v2;
        let v6 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_tree_lock_wrong_owner());
        assert!(0x2::clock::timestamp_ms(arg1) >= v4, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_tree_lock_still_locked());
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v1);
        let v7 = TreeUnlocked{
            lock_id    : 0x2::object::uid_to_address(&v6),
            owner      : v1,
            amount_raw : 0x2::balance::value<T0>(&v5),
        };
        0x2::event::emit<TreeUnlocked>(v7);
    }

    public fun unlock_at_ms<T0>(arg0: &TreeLock<T0>) : u64 {
        arg0.unlock_at_ms
    }

    // decompiled from Move bytecode v7
}

