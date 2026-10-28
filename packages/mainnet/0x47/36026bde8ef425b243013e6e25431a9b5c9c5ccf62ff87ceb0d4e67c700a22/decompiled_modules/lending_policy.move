module 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::lending_policy {
    struct LendingPolicy<phantom T0> has drop, store {
        pool: 0x2::object::ID,
        asset: u8,
        allow_borrow: bool,
        per_action: u64,
        daily: u64,
        min_health_factor: u256,
        meter: 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::meter::Meter,
    }

    struct Lent has copy, drop {
        controller: 0x2::object::ID,
        pool: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        action: u8,
        amount: u64,
    }

    public fun borrow() : u8 {
        2
    }

    public fun allow_borrow<T0>(arg0: &LendingPolicy<T0>) : bool {
        arg0.allow_borrow
    }

    public fun asset<T0>(arg0: &LendingPolicy<T0>) : u8 {
        arg0.asset
    }

    public(friend) fun authorize<T0>(arg0: &mut LendingPolicy<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg0.pool == arg2 && arg0.asset == arg3, 0);
        assert!(arg4 != 2 || arg0.allow_borrow, 1);
        assert!(arg5 > 0, 2);
        assert!(arg5 <= arg0.per_action, 3);
        0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::meter::charge(&mut arg0.meter, arg5, arg0.daily, arg6);
        let v0 = Lent{
            controller : arg1,
            pool       : arg2,
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            action     : arg4,
            amount     : arg5,
        };
        0x2::event::emit<Lent>(v0);
    }

    public fun daily<T0>(arg0: &LendingPolicy<T0>) : u64 {
        arg0.daily
    }

    public fun min_health_factor<T0>(arg0: &LendingPolicy<T0>) : u256 {
        arg0.min_health_factor
    }

    public fun new<T0>(arg0: 0x2::object::ID, arg1: u8, arg2: bool, arg3: u64, arg4: u64, arg5: u256, arg6: &0x2::clock::Clock) : LendingPolicy<T0> {
        assert!(arg3 > 0 && arg4 >= arg3, 4);
        LendingPolicy<T0>{
            pool              : arg0,
            asset             : arg1,
            allow_borrow      : arg2,
            per_action        : arg3,
            daily             : arg4,
            min_health_factor : arg5,
            meter             : 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::meter::new(arg6),
        }
    }

    public fun per_action<T0>(arg0: &LendingPolicy<T0>) : u64 {
        arg0.per_action
    }

    public fun pool<T0>(arg0: &LendingPolicy<T0>) : 0x2::object::ID {
        arg0.pool
    }

    public fun repay() : u8 {
        3
    }

    public fun supply() : u8 {
        0
    }

    public fun used_today<T0>(arg0: &LendingPolicy<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::meter::used_today(&arg0.meter, arg1)
    }

    public fun withdraw() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

