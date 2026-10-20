module 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn {
    struct BurnVault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<T0>,
        total_burned: u64,
    }

    struct Burned has copy, drop {
        vault_id: 0x2::object::ID,
        source: u8,
        amount: u64,
        total_burned: u64,
    }

    public fun burn<T0>(arg0: &mut BurnVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13906834410566582273);
        burn_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0);
    }

    public fun balance_value<T0>(arg0: &BurnVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun burn_balance<T0>(arg0: &mut BurnVault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u8) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        arg0.total_burned = arg0.total_burned + v0;
        let v1 = Burned{
            vault_id     : 0x2::object::id<BurnVault<T0>>(arg0),
            source       : arg2,
            amount       : v0,
            total_burned : arg0.total_burned,
        };
        0x2::event::emit<Burned>(v1);
    }

    public(friend) fun new<T0>(arg0: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyRegistry) : BurnVault<T0> {
        BurnVault<T0>{
            id           : 0x2::derived_object::claim<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::InstanceKey<T0>>(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::uid_mut(arg0), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::instance_key<T0>(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::kind_burn_vault())),
            version      : 1,
            balance      : 0x2::balance::zero<T0>(),
            total_burned : 0,
        }
    }

    public(friend) fun share<T0>(arg0: BurnVault<T0>) {
        0x2::transfer::share_object<BurnVault<T0>>(arg0);
    }

    public fun source_buyback() : u8 {
        1
    }

    public fun source_direct() : u8 {
        0
    }

    public fun source_penalty() : u8 {
        2
    }

    public fun total_burned<T0>(arg0: &BurnVault<T0>) : u64 {
        arg0.total_burned
    }

    public fun version<T0>(arg0: &BurnVault<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

