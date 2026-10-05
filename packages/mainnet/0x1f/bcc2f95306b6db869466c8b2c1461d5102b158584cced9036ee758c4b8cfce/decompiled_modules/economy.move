module 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::economy {
    struct Setup has store, key {
        id: 0x2::object::UID,
    }

    struct Economy has key {
        id: 0x2::object::UID,
        token: 0x1::ascii::String,
        currency: 0x2::object::ID,
        staking_pool: 0x2::object::ID,
        combat_pot: 0x2::object::ID,
        community_pool: 0x2::object::ID,
        started_ms: u64,
    }

    struct Funded<phantom T0> has copy, drop {
        economy: 0x2::object::ID,
        currency: 0x2::object::ID,
        staking_pool: 0x2::object::ID,
        combat_pot: 0x2::object::ID,
        community_pool: 0x2::object::ID,
        started_ms: u64,
    }

    public fun assert_combat_pot<T0>(arg0: &Economy, arg1: &0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::combat_rewards::CombatPot<T0>) {
        assert_token<T0>(arg0);
        assert!(arg0.combat_pot == 0x2::object::id<0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::combat_rewards::CombatPot<T0>>(arg1), 1);
    }

    public fun assert_currency<T0>(arg0: &Economy, arg1: &0x2::coin_registry::Currency<T0>) {
        assert_token<T0>(arg0);
        assert!(arg0.currency == 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1), 1);
    }

    public fun assert_token<T0>(arg0: &Economy) {
        assert!(!0x1::ascii::is_empty(&arg0.token) && arg0.token == 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Setup{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Setup>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Economy>(unfunded(arg0));
    }

    public fun is_funded(arg0: &Economy) : bool {
        !0x1::ascii::is_empty(&arg0.token)
    }

    public fun setup<T0, T1: drop>(arg0: Setup, arg1: &mut Economy, arg2: &0x2::package::UpgradeCap, arg3: &0x2::coin_registry::Currency<T0>, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::is_empty(&arg1.token), 4);
        let v0 = 0x1::type_name::with_original_ids<Setup>();
        let v1 = if (0x2::package::version(arg2) == 1) {
            if (0x2::package::upgrade_policy(arg2) == 0x2::package::compatible_policy()) {
                let v2 = 0x2::package::upgrade_package(arg2);
                0x2::address::to_ascii_string(0x2::object::id_to_address(&v2)) == 0x1::type_name::address_string(&v0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        assert!(0x2::coin_registry::decimals<T0>(arg3) == 9 && 0x2::coin_registry::is_supply_burn_only<T0>(arg3), 1);
        assert!(0x2::coin::value<T0>(&arg4) == 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::reserve_tokens(), 2);
        assert!(arg5 != @0x0 && arg5 == 0x2::tx_context::sender(arg7), 3);
        let Setup { id: v3 } = arg0;
        0x2::object::delete(v3);
        let v4 = 0x2::coin::into_balance<T0>(arg4);
        let v5 = 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::staking::create<T0>(0x2::balance::split<T0>(&mut v4, 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::staking_tokens()), arg7);
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::staking::activate<T0>(&mut v5, arg6);
        let v6 = 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::combat_rewards::create<T0, T1>(0x2::balance::split<T0>(&mut v4, 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::combat_tokens()), arg6, arg7);
        let v7 = 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::community::create<T0>(0x2::balance::withdraw_all<T0>(&mut v4), arg5, arg6, arg7);
        0x2::balance::destroy_zero<T0>(v4);
        arg1.token = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        arg1.currency = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg3);
        arg1.staking_pool = 0x2::object::id<0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::staking::StakingPool<T0>>(&v5);
        arg1.combat_pot = 0x2::object::id<0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::combat_rewards::CombatPot<T0>>(&v6);
        arg1.community_pool = 0x2::object::id<0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::community::CommunityPool<T0>>(&v7);
        arg1.started_ms = 0x2::clock::timestamp_ms(arg6);
        let v8 = Funded<T0>{
            economy        : 0x2::object::id<Economy>(arg1),
            currency       : arg1.currency,
            staking_pool   : arg1.staking_pool,
            combat_pot     : arg1.combat_pot,
            community_pool : arg1.community_pool,
            started_ms     : arg1.started_ms,
        };
        0x2::event::emit<Funded<T0>>(v8);
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::staking::share<T0>(v5);
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::combat_rewards::share<T0>(v6);
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::community::share<T0>(v7);
    }

    fun unfunded(arg0: &mut 0x2::tx_context::TxContext) : Economy {
        Economy{
            id             : 0x2::object::new(arg0),
            token          : 0x1::ascii::string(b""),
            currency       : 0x2::object::id_from_address(@0x0),
            staking_pool   : 0x2::object::id_from_address(@0x0),
            combat_pot     : 0x2::object::id_from_address(@0x0),
            community_pool : 0x2::object::id_from_address(@0x0),
            started_ms     : 0,
        }
    }

    // decompiled from Move bytecode v7
}

