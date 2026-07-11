module 0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::ve {
    struct VeLock has store, key {
        id: 0x2::object::UID,
        owner: address,
        locked: 0x2::balance::Balance<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>,
        amount: u64,
        end_ms: u64,
    }

    struct LockCreated has copy, drop {
        owner: address,
        amount: u64,
        end_ms: u64,
    }

    struct LockWithdrawn has copy, drop {
        owner: address,
        amount: u64,
    }

    public fun amount(arg0: &VeLock) : u64 {
        arg0.amount
    }

    public fun create_lock(arg0: 0x2::coin::Coin<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : VeLock {
        assert!(arg1 > 0, 0);
        assert!(arg1 <= 63072000000, 1);
        let v0 = 0x2::coin::value<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2) + arg1;
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = LockCreated{
            owner  : v2,
            amount : v0,
            end_ms : v1,
        };
        0x2::event::emit<LockCreated>(v3);
        VeLock{
            id     : 0x2::object::new(arg3),
            owner  : v2,
            locked : 0x2::coin::into_balance<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(arg0),
            amount : v0,
            end_ms : v1,
        }
    }

    public fun end_ms(arg0: &VeLock) : u64 {
        arg0.end_ms
    }

    public fun extend(arg0: &mut VeLock, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 <= 63072000000, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2) + arg1;
        assert!(v0 > arg0.end_ms, 4);
        arg0.end_ms = v0;
    }

    public fun increase_amount(arg0: &mut VeLock, arg1: 0x2::coin::Coin<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_ms, 3);
        arg0.amount = arg0.amount + 0x2::coin::value<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(&arg1);
        0x2::balance::join<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(&mut arg0.locked, 0x2::coin::into_balance<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(arg1));
    }

    public fun max_lock_ms() : u64 {
        63072000000
    }

    public fun voting_power(arg0: &VeLock, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_ms) {
            return 0
        };
        (((arg0.amount as u128) * ((arg0.end_ms - v0) as u128) / (63072000000 as u128)) as u64)
    }

    public fun withdraw(arg0: VeLock, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER> {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_ms, 2);
        let VeLock {
            id     : v0,
            owner  : v1,
            locked : v2,
            amount : v3,
            end_ms : _,
        } = arg0;
        let v5 = LockWithdrawn{
            owner  : v1,
            amount : v3,
        };
        0x2::event::emit<LockWithdrawn>(v5);
        0x2::object::delete(v0);
        0x2::coin::from_balance<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(v2, arg2)
    }

    // decompiled from Move bytecode v7
}

