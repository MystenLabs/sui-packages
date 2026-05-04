module 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::lock_coin_v2 {
    struct LockedCoinV2<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        locked_start_time: u64,
        locked_until_time: u64,
    }

    struct LockCoinV2Event has copy, drop {
        type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        locked_until_time: u64,
    }

    struct UnlockCoinV2Event has copy, drop {
        type: 0x1::type_name::TypeName,
        amount: u64,
        locked_coin: 0x2::object::ID,
        locked_until_time: u64,
    }

    public fun value<T0>(arg0: &LockedCoinV2<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun destroy_for_cancel<T0>(arg0: LockedCoinV2<T0>) : (0x2::balance::Balance<T0>, 0x2::object::ID) {
        let LockedCoinV2 {
            id                : v0,
            balance           : v1,
            locked_start_time : _,
            locked_until_time : _,
        } = arg0;
        let v4 = v0;
        0x2::object::delete(v4);
        (v1, 0x2::object::uid_to_inner(&v4))
    }

    public(friend) fun lock_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg2 > arg1, 0);
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = LockCoinV2Event{
            type              : 0x1::type_name::with_defining_ids<T0>(),
            amount            : 0x2::balance::value<T0>(&v0),
            recipient         : arg3,
            locked_until_time : arg2,
        };
        0x2::event::emit<LockCoinV2Event>(v1);
        new_from_balance<T0>(v0, arg1, arg2, arg3, arg4)
    }

    public fun lock_time<T0>(arg0: &LockedCoinV2<T0>) : u64 {
        arg0.locked_until_time
    }

    fun new_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg4);
        let v1 = LockedCoinV2<T0>{
            id                : v0,
            balance           : arg0,
            locked_start_time : arg1,
            locked_until_time : arg2,
        };
        0x2::transfer::transfer<LockedCoinV2<T0>>(v1, arg3);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun unlock_coin<T0>(arg0: LockedCoinV2<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let LockedCoinV2 {
            id                : v0,
            balance           : v1,
            locked_start_time : _,
            locked_until_time : v3,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        assert!(v3 <= 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::utils::now_timestamp(arg1), 1);
        let v6 = 0x2::object::uid_to_inner(&v5);
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg2), 0x2::tx_context::sender(arg2));
        let v7 = UnlockCoinV2Event{
            type              : 0x1::type_name::with_defining_ids<T0>(),
            amount            : 0x2::balance::value<T0>(&v4),
            locked_coin       : v6,
            locked_until_time : v3,
        };
        0x2::event::emit<UnlockCoinV2Event>(v7);
        v6
    }

    // decompiled from Move bytecode v7
}

