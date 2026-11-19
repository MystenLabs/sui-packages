module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::balance_migration {
    struct UnderlyingBalanceMigratedEvent has copy, drop {
        market: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CollateralBalanceMigratedEvent has copy, drop {
        obligation: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        executor: address,
    }

    fun assert_balance_migration_authority(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::balance_migration_authority_registry_key();
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg0);
        assert!(0x2::dynamic_field::exists_<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::BalanceMigrationAuthorityRegistryKey>(v1, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unauthorized_balance_migration_error());
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::BalanceMigrationAuthorityRegistryKey, 0x2::vec_set::VecSet<address>>(v1, v0), &v2), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unauthorized_balance_migration_error());
    }

    public fun migrate_collateral_balance<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg0);
        assert_balance_migration_authority(arg1, arg3);
        let v0 = CollateralBalanceMigratedEvent{
            obligation : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2),
            coin_type  : 0x1::type_name::get<T0>(),
            amount     : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::migrate_collateral_balance<T0>(arg2, arg3),
            executor   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CollateralBalanceMigratedEvent>(v0);
    }

    public fun migrate_underlying_balance<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::app::AdminCap, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg1);
        let v0 = UnderlyingBalanceMigratedEvent{
            market    : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg2),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::migrate_underlying_balance<T0>(arg2, arg3),
        };
        0x2::event::emit<UnderlyingBalanceMigratedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

