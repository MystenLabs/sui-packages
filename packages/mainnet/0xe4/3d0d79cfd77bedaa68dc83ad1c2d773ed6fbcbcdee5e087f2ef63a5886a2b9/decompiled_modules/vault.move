module 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        liquid: 0x2::balance::Balance<T0>,
        savings_position: 0x1::option::Option<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>,
        venue_id: 0x2::object::ID,
        per_tx_cap: u64,
        daily_cap: u64,
        daily_spent: u64,
        last_reset_epoch: u64,
        agent_nonce: u64,
        payout_address: address,
        allowlist: 0x2::vec_set::VecSet<address>,
        outflow_per_tx_cap: u64,
        outflow_daily_cap: u64,
        outflow_daily_spent: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        nonce: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        to: address,
        liquid_after: u64,
        by_agent: bool,
    }

    struct SendEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        to: address,
        liquid_after: u64,
        by_agent: bool,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        liquid_after: u64,
    }

    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        direction: u8,
        amount: u64,
        liquid_after: u64,
        savings_value_after: u64,
        epoch: u64,
    }

    public fun add_payee<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: address) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 6);
        0x2::vec_set::insert<address>(&mut arg1.allowlist, arg2);
    }

    public fun agent_cap_nonce(arg0: &AgentCap) : u64 {
        arg0.nonce
    }

    public fun agent_nonce<T0>(arg0: &Vault<T0>) : u64 {
        arg0.agent_nonce
    }

    public fun agent_send<T0>(arg0: &AgentCap, arg1: &mut Vault<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 0);
        assert!(arg0.nonce == arg1.agent_nonce, 0);
        assert!(0x2::vec_set::contains<address>(&arg1.allowlist, &arg3), 8);
        let v0 = 0x2::tx_context::epoch(arg4);
        if (v0 > arg1.last_reset_epoch) {
            arg1.daily_spent = 0;
            arg1.outflow_daily_spent = 0;
            arg1.last_reset_epoch = v0;
        };
        assert!(arg2 <= arg1.outflow_per_tx_cap, 9);
        assert!(arg1.outflow_daily_spent + arg2 <= arg1.outflow_daily_cap, 10);
        assert!(0x2::balance::value<T0>(&arg1.liquid) >= arg2, 3);
        arg1.outflow_daily_spent = arg1.outflow_daily_spent + arg2;
        let v1 = SendEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            amount       : arg2,
            to           : arg3,
            liquid_after : 0x2::balance::value<T0>(&arg1.liquid),
            by_agent     : true,
        };
        0x2::event::emit<SendEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.liquid, arg2), arg4), arg3);
    }

    public fun agent_withdraw_to_owner<T0>(arg0: &AgentCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 0);
        assert!(arg0.nonce == arg1.agent_nonce, 0);
        let v0 = 0x2::tx_context::epoch(arg3);
        if (v0 > arg1.last_reset_epoch) {
            arg1.daily_spent = 0;
            arg1.outflow_daily_spent = 0;
            arg1.last_reset_epoch = v0;
        };
        assert!(arg2 <= arg1.outflow_per_tx_cap, 9);
        assert!(arg1.outflow_daily_spent + arg2 <= arg1.outflow_daily_cap, 10);
        assert!(0x2::balance::value<T0>(&arg1.liquid) >= arg2, 3);
        arg1.outflow_daily_spent = arg1.outflow_daily_spent + arg2;
        let v1 = arg1.payout_address;
        let v2 = WithdrawEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            amount       : arg2,
            to           : v1,
            liquid_after : 0x2::balance::value<T0>(&arg1.liquid),
            by_agent     : true,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.liquid, arg2), arg3), v1);
    }

    public fun create_vault<T0, T1>(arg0: &0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = 0x2::object::new(arg6);
        let v1 = Vault<T1>{
            id                  : v0,
            liquid              : 0x2::balance::zero<T1>(),
            savings_position    : 0x1::option::none<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(),
            venue_id            : 0x2::object::id<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>>(arg0),
            per_tx_cap          : arg2,
            daily_cap           : arg3,
            daily_spent         : 0,
            last_reset_epoch    : 0x2::tx_context::epoch(arg6),
            agent_nonce         : 0,
            payout_address      : arg1,
            allowlist           : 0x2::vec_set::empty<address>(),
            outflow_per_tx_cap  : arg4,
            outflow_daily_cap   : arg5,
            outflow_daily_spent : 0,
        };
        0x2::transfer::share_object<Vault<T1>>(v1);
        OwnerCap{
            id       : 0x2::object::new(arg6),
            vault_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    public fun daily_cap<T0>(arg0: &Vault<T0>) : u64 {
        arg0.daily_cap
    }

    public fun daily_spent<T0>(arg0: &Vault<T0>) : u64 {
        arg0.daily_spent
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.liquid, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            amount       : 0x2::coin::value<T0>(&arg1),
            liquid_after : 0x2::balance::value<T0>(&arg0.liquid),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun has_savings_position<T0>(arg0: &Vault<T0>) : bool {
        0x1::option::is_some<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg0.savings_position)
    }

    public fun is_allowlisted<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.allowlist, &arg1)
    }

    public fun issue_agent_cap<T0>(arg0: &OwnerCap, arg1: &Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : AgentCap {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 6);
        AgentCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0>>(arg1),
            nonce    : arg1.agent_nonce,
        }
    }

    public fun liquid_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liquid)
    }

    public fun outflow_daily_cap<T0>(arg0: &Vault<T0>) : u64 {
        arg0.outflow_daily_cap
    }

    public fun outflow_daily_spent<T0>(arg0: &Vault<T0>) : u64 {
        arg0.outflow_daily_spent
    }

    public fun outflow_per_tx_cap<T0>(arg0: &Vault<T0>) : u64 {
        arg0.outflow_per_tx_cap
    }

    public fun owner_rebalance<T0, T1>(arg0: &OwnerCap, arg1: &mut Vault<T1>, arg2: &mut 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T1>>(arg1), 6);
        assert!(0x2::object::id<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>>(arg2) == arg1.venue_id, 7);
        let (v0, v1) = if (arg5 == 0) {
            assert!(0x2::balance::value<T1>(&arg1.liquid) >= arg6, 3);
            if (0x1::option::is_none<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position)) {
                0x1::option::fill<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position, 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::deposit<T0, T1>(arg3, arg2, arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.liquid, arg6), arg7), arg7));
            } else {
                0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::extend_position<T0, T1>(arg3, arg2, arg4, 0x1::option::borrow_mut<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.liquid, arg6), arg7), arg7);
            };
            (arg6, 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::current_value<T0, T1>(arg3, arg2, 0x1::option::borrow<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position)))
        } else {
            assert!(arg5 == 1, 5);
            assert!(0x1::option::is_some<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position), 4);
            let v2 = 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::withdraw<T0, T1>(arg3, arg2, arg4, 0x1::option::borrow_mut<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position), arg6, arg7);
            0x2::balance::join<T1>(&mut arg1.liquid, 0x2::coin::into_balance<T1>(v2));
            let v1 = if (0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::position_principal(0x1::option::borrow<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position)) == 0) {
                0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::destroy_zero_position(0x1::option::extract<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position));
                0
            } else {
                0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::current_value<T0, T1>(arg3, arg2, 0x1::option::borrow<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position))
            };
            (0x2::coin::value<T1>(&v2), v1)
        };
        let v3 = RebalanceEvent{
            vault_id            : 0x2::object::id<Vault<T1>>(arg1),
            direction           : arg5,
            amount              : v0,
            liquid_after        : 0x2::balance::value<T1>(&arg1.liquid),
            savings_value_after : v1,
            epoch               : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<RebalanceEvent>(v3);
    }

    public fun owner_send<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 6);
        assert!(0x2::balance::value<T0>(&arg1.liquid) >= arg2, 3);
        let v0 = SendEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            amount       : arg2,
            to           : arg3,
            liquid_after : 0x2::balance::value<T0>(&arg1.liquid),
            by_agent     : false,
        };
        0x2::event::emit<SendEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.liquid, arg2), arg4), arg3);
    }

    public fun payout_address<T0>(arg0: &Vault<T0>) : address {
        arg0.payout_address
    }

    public fun per_tx_cap<T0>(arg0: &Vault<T0>) : u64 {
        arg0.per_tx_cap
    }

    public fun rebalance<T0, T1>(arg0: &AgentCap, arg1: &mut Vault<T1>, arg2: &mut 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T1>>(arg1), 0);
        assert!(arg0.nonce == arg1.agent_nonce, 0);
        assert!(0x2::object::id<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>>(arg2) == arg1.venue_id, 7);
        assert!(arg6 <= arg1.per_tx_cap, 1);
        let v0 = 0x2::tx_context::epoch(arg7);
        if (v0 > arg1.last_reset_epoch) {
            arg1.daily_spent = 0;
            arg1.outflow_daily_spent = 0;
            arg1.last_reset_epoch = v0;
        };
        assert!(arg1.daily_spent + arg6 <= arg1.daily_cap, 2);
        let (v1, v2) = if (arg5 == 0) {
            assert!(0x2::balance::value<T1>(&arg1.liquid) >= arg6, 3);
            if (0x1::option::is_none<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position)) {
                0x1::option::fill<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position, 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::deposit<T0, T1>(arg3, arg2, arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.liquid, arg6), arg7), arg7));
            } else {
                0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::extend_position<T0, T1>(arg3, arg2, arg4, 0x1::option::borrow_mut<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.liquid, arg6), arg7), arg7);
            };
            (arg6, 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::current_value<T0, T1>(arg3, arg2, 0x1::option::borrow<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position)))
        } else {
            assert!(arg5 == 1, 5);
            assert!(0x1::option::is_some<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position), 4);
            let v3 = 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::withdraw<T0, T1>(arg3, arg2, arg4, 0x1::option::borrow_mut<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position), arg6, arg7);
            0x2::balance::join<T1>(&mut arg1.liquid, 0x2::coin::into_balance<T1>(v3));
            let v2 = if (0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::position_principal(0x1::option::borrow<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position)) == 0) {
                0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::destroy_zero_position(0x1::option::extract<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position));
                0
            } else {
                0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::current_value<T0, T1>(arg3, arg2, 0x1::option::borrow<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position))
            };
            (0x2::coin::value<T1>(&v3), v2)
        };
        arg1.daily_spent = arg1.daily_spent + arg6;
        let v4 = RebalanceEvent{
            vault_id            : 0x2::object::id<Vault<T1>>(arg1),
            direction           : arg5,
            amount              : v1,
            liquid_after        : 0x2::balance::value<T1>(&arg1.liquid),
            savings_value_after : v2,
            epoch               : v0,
        };
        0x2::event::emit<RebalanceEvent>(v4);
    }

    public fun redeem_position<T0, T1>(arg0: &OwnerCap, arg1: &mut Vault<T1>, arg2: &mut 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T1>>(arg1), 6);
        assert!(0x2::object::id<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>>(arg2) == arg1.venue_id, 7);
        if (0x1::option::is_none<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg1.savings_position)) {
            return
        };
        let v0 = 0x1::option::extract<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&mut arg1.savings_position);
        let v1 = 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::withdraw_all<T0, T1>(arg3, arg2, arg4, &mut v0, arg5);
        0x2::balance::join<T1>(&mut arg1.liquid, 0x2::coin::into_balance<T1>(v1));
        0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::destroy_zero_position(v0);
        let v2 = RebalanceEvent{
            vault_id            : 0x2::object::id<Vault<T1>>(arg1),
            direction           : 1,
            amount              : 0x2::coin::value<T1>(&v1),
            liquid_after        : 0x2::balance::value<T1>(&arg1.liquid),
            savings_value_after : 0,
            epoch               : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<RebalanceEvent>(v2);
    }

    public fun remove_payee<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: address) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 6);
        0x2::vec_set::remove<address>(&mut arg1.allowlist, &arg2);
    }

    public fun revoke<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 6);
        arg1.agent_nonce = arg1.agent_nonce + 1;
    }

    public fun savings_balance<T0, T1>(arg0: &Vault<T1>, arg1: &0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::YieldVenue<T0, T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        if (0x1::option::is_none<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg0.savings_position)) {
            return 0
        };
        0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::current_value<T0, T1>(arg2, arg1, 0x1::option::borrow<0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::yield_venue::Position>(&arg0.savings_position))
    }

    public fun set_outflow_caps<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: u64, arg3: u64) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 6);
        arg1.outflow_per_tx_cap = arg2;
        arg1.outflow_daily_cap = arg3;
    }

    public fun set_payout_address<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: address) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 6);
        arg1.payout_address = arg2;
    }

    public fun withdraw<T0>(arg0: &OwnerCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 6);
        let v0 = WithdrawEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            amount       : arg2,
            to           : 0x2::tx_context::sender(arg3),
            liquid_after : 0x2::balance::value<T0>(&arg1.liquid),
            by_agent     : false,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.liquid, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

