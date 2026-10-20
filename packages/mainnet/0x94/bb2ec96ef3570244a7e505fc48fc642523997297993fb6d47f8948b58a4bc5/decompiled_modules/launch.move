module 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::launch {
    struct EconomyLaunched has copy, drop {
        config_id: 0x2::object::ID,
        fee_vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        burn_vault_id: 0x2::object::ID,
        escrow_registry_id: 0x2::object::ID,
        genesis_ms: u64,
        epoch_length_ms: u64,
    }

    public fun launch<T0>(arg0: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyRegistry, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyAdminCap, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) {
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::new<T0>(arg0, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
        let v1 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::new<T0>(arg0);
        let v2 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::new_pool<T0>(arg0);
        let v3 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::new<T0>(arg0);
        let v4 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::new_registry<T0>(arg0);
        let v5 = EconomyLaunched{
            config_id          : 0x2::object::id<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>>(&v0),
            fee_vault_id       : 0x2::object::id<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::FeeVault<T0>>(&v1),
            pool_id            : 0x2::object::id<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::RewardsPool<T0>>(&v2),
            burn_vault_id      : 0x2::object::id<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::BurnVault<T0>>(&v3),
            escrow_registry_id : 0x2::object::id<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::EscrowRegistry<T0>>(&v4),
            genesis_ms         : arg2,
            epoch_length_ms    : arg3,
        };
        0x2::event::emit<EconomyLaunched>(v5);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::share<T0>(v0);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::share<T0>(v1);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::share_pool<T0>(v2);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::share<T0>(v3);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::share_registry<T0>(v4);
    }

    // decompiled from Move bytecode v7
}

