module 0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::pool {
    struct Pool has store, key {
        id: 0x2::object::UID,
        balanceA: u64,
        balanceB: u64,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id       : 0x2::object::new(arg0),
            balanceA : 0,
            balanceB : 0,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    fun add_a(arg0: &mut Pool, arg1: u64, arg2: &mut 0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::Tracker) {
        arg0.balanceA = arg0.balanceA + arg1;
        0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::deposit(arg2, arg1);
    }

    fun add_b(arg0: &mut Pool, arg1: u64, arg2: &mut 0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::Tracker) {
        arg0.balanceB = arg0.balanceB + arg1;
        0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::deposit(arg2, arg1);
    }

    public fun add_liquidity(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: &mut 0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::Tracker, arg4: &mut 0x2::clock::Clock) {
        add_a(arg0, arg1, arg3);
        add_b(arg0, arg2, arg3);
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOL>(arg0, arg1);
        0x2::transfer::public_share_object<0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::Tracker>(0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::new(arg1));
    }

    fun remove_a(arg0: &mut Pool, arg1: u64, arg2: &mut 0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::Tracker) {
        arg0.balanceA = arg0.balanceA - arg1;
        0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::withdraw(arg2, arg1);
    }

    fun remove_b(arg0: &mut Pool, arg1: u64, arg2: &mut 0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::Tracker) {
        arg0.balanceB = arg0.balanceB - arg1;
        0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::withdraw(arg2, arg1);
    }

    public fun remove_liquidity(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: &mut 0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker::Tracker, arg4: &mut 0x2::clock::Clock) {
        remove_a(arg0, arg1, arg3);
        remove_b(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

