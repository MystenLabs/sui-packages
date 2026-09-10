module 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::offering {
    struct Offering has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        minimum: u64,
        maximum: u64,
        started_ms: 0x1::option::Option<u64>,
        duration_ms: u64,
        treasury: address,
        liquidity: address,
        deposits: 0x2::balance::Balance<0x2::sui::SUI>,
        sale_tokens: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
        liquidity_tokens: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
        total_deposited: u64,
        accepted: u64,
        settled: bool,
        community_tokens: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
        settled_ms: u64,
        combat_pot: 0x2::object::ID,
        combat_tokens: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
    }

    struct Contribution has key {
        id: 0x2::object::UID,
        offering: 0x2::object::ID,
        amount: u64,
    }

    struct CommunityClaimed has copy, drop {
        offering: 0x2::object::ID,
        amount: u64,
    }

    public fun accepted(arg0: &Offering) : u64 {
        arg0.accepted
    }

    public fun add_contribution(arg0: &mut Offering, arg1: &mut Contribution, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock) {
        assert!(arg1.offering == 0x2::object::id<Offering>(arg0), 2);
        arg1.amount = arg1.amount + deposit(arg0, arg2, arg3);
    }

    public fun authorize_combat<T0: drop>(arg0: &Offering, arg1: &mut 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::CombatPot, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 7);
        assert!(arg0.combat_pot == 0x2::object::id<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::CombatPot>(arg1), 6);
        0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::authorize<T0>(arg1);
    }

    public fun boss_bounty<T0: drop>(arg0: &Offering, arg1: &mut 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::CombatPot, arg2: T0, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        assert!(arg0.combat_pot == 0x2::object::id<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::CombatPot>(arg1), 6);
        if (!arg0.settled) {
            return 0x2::balance::zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>()
        };
        0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::take<T0>(arg1, arg2, arg3, arg4, arg0.settled_ms, arg5, arg6)
    }

    public fun claim(arg0: &mut Offering, arg1: &mut 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking::StakingPool, arg2: Contribution, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg2.offering == 0x2::object::id<Offering>(arg0), 2);
        assert!(arg0.pool == 0x2::object::id<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking::StakingPool>(arg1), 6);
        assert!(0x2::clock::timestamp_ms(arg3) >= closes_ms(arg0), 5);
        if (!arg0.settled && arg0.total_deposited >= arg0.minimum) {
            settle(arg0, arg1, arg3, arg4);
        };
        let Contribution {
            id       : v0,
            offering : _,
            amount   : v2,
        } = arg2;
        0x2::object::delete(v0);
        let (v3, v4) = entitlement(arg0, v2);
        (0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.sale_tokens, v3), arg4), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.deposits, v4), arg4))
    }

    public fun claim_community(arg0: &mut Offering, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 7);
        let v0 = community_claimable(arg0, arg1);
        assert!(v0 > 0, 8);
        let v1 = CommunityClaimed{
            offering : 0x2::object::id<Offering>(arg0),
            amount   : v0,
        };
        0x2::event::emit<CommunityClaimed>(v1);
        0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.community_tokens, v0), arg2)
    }

    public fun closes_ms(arg0: &Offering) : u64 {
        timestamp(arg0, (arg0.duration_ms as u128))
    }

    public fun combat_pot(arg0: &Offering) : 0x2::object::ID {
        arg0.combat_pot
    }

    public fun combat_remaining(arg0: &Offering) : u64 {
        0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.combat_tokens)
    }

    public fun community_claimable(arg0: &Offering, arg1: &0x2::clock::Clock) : u64 {
        if (!arg0.settled) {
            return 0
        };
        (((110000000000000 as u128) * (0x1::u64::min(0x2::clock::timestamp_ms(arg1) - arg0.settled_ms, 157680000000) as u128) / (157680000000 as u128)) as u64) - 110000000000000 - 0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.community_tokens)
    }

    public fun community_remaining(arg0: &Offering) : u64 {
        0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.community_tokens)
    }

    public fun contribute(arg0: &mut Offering, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new_contribution(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<Contribution>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun contribution_amount(arg0: &Contribution) : u64 {
        arg0.amount
    }

    public fun contribution_offering(arg0: &Contribution) : 0x2::object::ID {
        arg0.offering
    }

    fun deposit(arg0: &mut Offering, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock) : u64 {
        assert!(started(arg0) && 0x2::clock::timestamp_ms(arg2) < closes_ms(arg0), 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 3);
        arg0.total_deposited = arg0.total_deposited + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.deposits, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        v0
    }

    public fun deposits(arg0: &Offering) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.deposits)
    }

    public fun duration_ms(arg0: &Offering) : u64 {
        arg0.duration_ms
    }

    fun entitlement(arg0: &Offering, arg1: u64) : (u64, u64) {
        if (arg0.settled) {
            let v2 = (arg0.total_deposited as u128);
            ((((arg1 as u128) * (400000000000000 as u128) / v2) as u64), (((arg1 as u128) * ((arg0.total_deposited - arg0.accepted) as u128) / v2) as u64))
        } else {
            (0, arg1)
        }
    }

    public fun liquidity(arg0: &Offering) : address {
        arg0.liquidity
    }

    public fun liquidity_tokens(arg0: &Offering) : u64 {
        0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.liquidity_tokens)
    }

    public fun maximum(arg0: &Offering) : u64 {
        arg0.maximum
    }

    public fun minimum(arg0: &Offering) : u64 {
        arg0.minimum
    }

    fun new_contribution(arg0: &mut Offering, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Contribution {
        let v0 = deposit(arg0, arg1, arg2);
        Contribution{
            id       : 0x2::object::new(arg3),
            offering : 0x2::object::id<Offering>(arg0),
            amount   : v0,
        }
    }

    public fun opens_ms(arg0: &Offering) : u64 {
        timestamp(arg0, 0)
    }

    public fun pool(arg0: &Offering) : 0x2::object::ID {
        arg0.pool
    }

    public fun sale_tokens(arg0: &Offering) : u64 {
        0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.sale_tokens)
    }

    public fun seed_combat(arg0: &mut Offering, arg1: &mut 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::CombatPot, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 7);
        assert!(arg0.combat_pot == 0x2::object::id<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::CombatPot>(arg1), 6);
        assert!(0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.combat_tokens) > 0, 10);
        0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::fund_balance(arg1, 0x2::balance::withdraw_all<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.combat_tokens));
    }

    public fun settle(arg0: &mut Offering, arg1: &mut 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking::StakingPool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool == 0x2::object::id<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking::StakingPool>(arg1), 6);
        if (arg0.settled) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(started(arg0) && v0 >= closes_ms(arg0), 4);
        assert!(arg0.total_deposited >= arg0.minimum, 4);
        let v1 = 0x1::u64::min(arg0.total_deposited, arg0.maximum);
        let v2 = (((v1 as u128) * 40 / 100) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.deposits, v2), arg3), arg0.liquidity);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.deposits, v1 - v2), arg3), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>>(0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::withdraw_all<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.liquidity_tokens), arg3), arg0.liquidity);
        0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking::activate(arg1, arg2);
        arg0.accepted = v1;
        arg0.settled_ms = v0;
        arg0.settled = true;
    }

    public fun settled(arg0: &Offering) : bool {
        arg0.settled
    }

    public fun settled_ms(arg0: &Offering) : u64 {
        arg0.settled_ms
    }

    public fun setup(arg0: 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::Genesis, arg1: 0x2::package::UpgradeCap, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_original_ids<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>();
        let v1 = if (0x2::package::version(&arg1) == 1) {
            let v2 = 0x2::package::upgrade_package(&arg1);
            0x2::address::to_ascii_string(0x2::object::id_to_address(&v2)) == 0x1::type_name::address_string(&v0)
        } else {
            false
        };
        assert!(v1, 9);
        assert!(arg2 > 0 && arg3 >= arg2, 0);
        assert!(arg4 > 0, 0);
        let v3 = if (arg5 != @0x0) {
            if (arg6 != @0x0) {
                if (arg7 != @0x0) {
                    arg8 != @0x0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 0);
        0x2::package::make_immutable(arg1);
        let (v4, v5) = 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::consume(arg0);
        let v6 = v4;
        let v7 = 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking::create(0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut v6, 200000000000000), arg9);
        let v8 = 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::create(arg9);
        let v9 = Offering{
            id               : 0x2::object::new(arg9),
            pool             : 0x2::object::id<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking::StakingPool>(&v7),
            minimum          : arg2,
            maximum          : arg3,
            started_ms       : 0x1::option::none<u64>(),
            duration_ms      : arg4,
            treasury         : arg5,
            liquidity        : arg6,
            deposits         : 0x2::balance::zero<0x2::sui::SUI>(),
            sale_tokens      : 0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut v6, 400000000000000),
            liquidity_tokens : 0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut v6, 160000000000000),
            total_deposited  : 0,
            accepted         : 0,
            settled          : false,
            community_tokens : 0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut v6, 110000000000000),
            settled_ms       : 0,
            combat_pot       : 0x2::object::id<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::CombatPot>(&v8),
            combat_tokens    : 0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut v6, 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::initial_tokens()),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>>(0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut v6, 30000000000000), arg9), arg7);
        0x2::balance::destroy_zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(v6);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>>(v5, arg8);
        0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking::share(v7);
        0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::share(v8);
        0x2::transfer::share_object<Offering>(v9);
    }

    public fun start(arg0: &mut Offering, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 7);
        assert!(0x1::option::is_none<u64>(&arg0.started_ms), 11);
        assert!((0x2::clock::timestamp_ms(arg1) as u128) + (arg0.duration_ms as u128) <= 18446744073709551615, 0);
        0x1::option::fill<u64>(&mut arg0.started_ms, 0x2::clock::timestamp_ms(arg1));
    }

    public fun started(arg0: &Offering) : bool {
        0x1::option::is_some<u64>(&arg0.started_ms)
    }

    fun timestamp(arg0: &Offering, arg1: u128) : u64 {
        if (0x1::option::is_none<u64>(&arg0.started_ms)) {
            0
        } else {
            (((*0x1::option::borrow<u64>(&arg0.started_ms) as u128) + arg1) as u64)
        }
    }

    public fun total_deposited(arg0: &Offering) : u64 {
        arg0.total_deposited
    }

    public fun treasury(arg0: &Offering) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

