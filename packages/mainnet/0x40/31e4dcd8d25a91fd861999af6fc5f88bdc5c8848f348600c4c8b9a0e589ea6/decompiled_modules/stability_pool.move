module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool {
    struct Pool has store, key {
        id: 0x2::object::UID,
        current_index: u256,
        current_scale: u64,
    }

    struct Collateral<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_collateral_balance: 0x2::balance::Balance<T0>,
        scale_to_collateral: 0x2::table::Table<u64, u256>,
    }

    struct Yield has store, key {
        id: 0x2::object::UID,
        active_yield_balance: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
        yield_gain_pending: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
        scale_to_yield: 0x2::table::Table<u64, u256>,
    }

    struct Staker<phantom T0> has key {
        id: 0x2::object::UID,
        stability_pool_id: 0x2::object::ID,
        balance: u256,
        snapshot_pool_index: u256,
        snapshot_collateral_index: u256,
        snapshot_yield_index: u256,
        pending_collateral_rewards: 0x2::balance::Balance<T0>,
        snapshot_scale: u64,
    }

    struct StabilityPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        vault_registry_id: 0x2::object::ID,
        total_dori_balance: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
        pool: Pool,
        collateral: Collateral<T0>,
        yield: Yield,
        stakers_table: 0x2::table::Table<address, 0x2::object::ID>,
    }

    public fun assert_vault_registry_id<T0>(arg0: &StabilityPool<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.vault_registry_id == arg1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EVaultRegistryIdMismatch());
    }

    public fun assert_version<T0>(arg0: &StabilityPool<T0>) {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
    }

    public entry fun claim_all_collateral_rewards<T0>(arg0: &mut Staker<T0>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg2);
        assert_vault_registry_id<T0>(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg2));
        assert!(arg0.stability_pool_id == 0x2::object::id<StabilityPool<T0>>(arg1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStabilityPoolIdMismatch());
        assert!(arg0.balance == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStakerBalanceNotEmpty());
        stability_pool_mint_and_distribute_interest<T0>(arg2, arg1, arg3, arg4, arg5);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_collateral_rewards), arg5);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_claim_all_rewards_event(0x2::tx_context::sender(arg5), 0x2::object::id<Staker<T0>>(arg0), 0x2::coin::value<T0>(&v0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun claim_all_collateral_rewards_v2<T0>(arg0: &mut Staker<T0>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg5: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_all_collateral_rewards_v3<T0>(arg0: &mut Staker<T0>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg2);
        assert_vault_registry_id<T0>(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg2));
        assert!(arg0.stability_pool_id == 0x2::object::id<StabilityPool<T0>>(arg1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStabilityPoolIdMismatch());
        assert!(arg0.balance == 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStakerBalanceNotEmpty());
        stability_pool_mint_and_distribute_interest_v3<T0>(arg2, arg1, arg3, arg4, arg5, arg6);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_collateral_rewards), arg6);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_claim_all_rewards_event(0x2::tx_context::sender(arg6), 0x2::object::id<Staker<T0>>(arg0), 0x2::coin::value<T0>(&v0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
    }

    public(friend) fun create_stability_pool<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id            : 0x2::object::new(arg1),
            current_index : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::INDEX_PRECISION(),
            current_scale : 0,
        };
        let v1 = Collateral<T0>{
            id                       : 0x2::object::new(arg1),
            total_collateral_balance : 0x2::balance::zero<T0>(),
            scale_to_collateral      : 0x2::table::new<u64, u256>(arg1),
        };
        0x2::table::add<u64, u256>(&mut v1.scale_to_collateral, 0, 0);
        let v2 = Yield{
            id                   : 0x2::object::new(arg1),
            active_yield_balance : 0x2::balance::zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(),
            yield_gain_pending   : 0x2::balance::zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(),
            scale_to_yield       : 0x2::table::new<u64, u256>(arg1),
        };
        0x2::table::add<u64, u256>(&mut v2.scale_to_yield, 0, 0);
        let v3 = StabilityPool<T0>{
            id                 : 0x2::object::new(arg1),
            version            : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(),
            vault_registry_id  : arg0,
            total_dori_balance : 0x2::balance::zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(),
            pool               : v0,
            collateral         : v1,
            yield              : v2,
            stakers_table      : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<StabilityPool<T0>>(v3);
    }

    fun distribute_interest_and_get_global_indexes<T0>(arg0: &mut StabilityPool<T0>, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u256, u256) {
        stability_pool_mint_and_distribute_interest<T0>(arg1, arg0, arg2, arg3, arg4);
        let v0 = if (0x2::table::contains<u64, u256>(&arg0.yield.scale_to_yield, arg0.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg0.yield.scale_to_yield, arg0.pool.current_scale)
        } else {
            let v1 = 0;
            &v1
        };
        let v2 = if (0x2::table::contains<u64, u256>(&arg0.collateral.scale_to_collateral, arg0.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg0.collateral.scale_to_collateral, arg0.pool.current_scale)
        } else {
            let v3 = 0;
            &v3
        };
        (*v0, *v2)
    }

    fun distribute_interest_and_get_global_indexes_v2<T0>(arg0: &mut StabilityPool<T0>, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg4: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u256, u256) {
        stability_pool_mint_and_distribute_interest_v2<T0>(arg1, arg0, arg2, arg3, arg4, arg5, arg6);
        let v0 = if (0x2::table::contains<u64, u256>(&arg0.yield.scale_to_yield, arg0.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg0.yield.scale_to_yield, arg0.pool.current_scale)
        } else {
            let v1 = 0;
            &v1
        };
        let v2 = if (0x2::table::contains<u64, u256>(&arg0.collateral.scale_to_collateral, arg0.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg0.collateral.scale_to_collateral, arg0.pool.current_scale)
        } else {
            let v3 = 0;
            &v3
        };
        (*v0, *v2)
    }

    fun distribute_interest_and_get_global_indexes_v3<T0>(arg0: &mut StabilityPool<T0>, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u256, u256) {
        stability_pool_mint_and_distribute_interest_v3<T0>(arg1, arg0, arg2, arg3, arg4, arg5);
        let v0 = if (0x2::table::contains<u64, u256>(&arg0.yield.scale_to_yield, arg0.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg0.yield.scale_to_yield, arg0.pool.current_scale)
        } else {
            let v1 = 0;
            &v1
        };
        let v2 = if (0x2::table::contains<u64, u256>(&arg0.collateral.scale_to_collateral, arg0.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg0.collateral.scale_to_collateral, arg0.pool.current_scale)
        } else {
            let v3 = 0;
            &v3
        };
        (*v0, *v2)
    }

    fun distribute_yield_savings(arg0: u64, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg0 > 0) {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::distribute_yield(arg2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_return_coin(arg1, arg0, arg4), arg3);
        };
    }

    public fun get_collateral_staking_rewards<T0>(arg0: &Staker<T0>, arg1: &StabilityPool<T0>) : u64 {
        if (arg0.balance == 0) {
            return 0
        };
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(*0x2::table::borrow<u64, u256>(&arg1.collateral.scale_to_collateral, arg0.snapshot_scale)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.snapshot_collateral_index));
        let v1 = 1;
        while (v1 <= 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::SCALE_SPAN()) {
            if (0x2::table::contains<u64, u256>(&arg1.collateral.scale_to_collateral, arg0.snapshot_scale + v1)) {
                v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(v0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(*0x2::table::borrow<u64, u256>(&arg1.collateral.scale_to_collateral, arg0.snapshot_scale + v1)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::pow(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from((0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::SCALE_FACTOR() as u64)), v1)));
            };
            v1 = v1 + 1;
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.balance), v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.snapshot_pool_index)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::balance::value<T0>(&arg1.collateral.total_collateral_balance))))
    }

    public fun get_dori_staking_rewards<T0>(arg0: &Staker<T0>, arg1: &StabilityPool<T0>) : u64 {
        if (arg0.balance == 0) {
            return 0
        };
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from(0);
        let v1 = 1;
        while (v1 <= 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::SCALE_SPAN()) {
            if (0x2::table::contains<u64, u256>(&arg1.yield.scale_to_yield, arg0.snapshot_scale + v1)) {
                v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(v0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(*0x2::table::borrow<u64, u256>(&arg1.yield.scale_to_yield, arg0.snapshot_scale + v1)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::pow(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from((0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::SCALE_FACTOR() as u64)), v1)));
            };
            v1 = v1 + 1;
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.balance), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(*0x2::table::borrow<u64, u256>(&arg1.yield.scale_to_yield, arg0.snapshot_scale)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.snapshot_yield_index)), v0)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.snapshot_pool_index)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1.yield.active_yield_balance))))
    }

    public fun get_staker_balance_decimal<T0>(arg0: &Staker<T0>, arg1: &StabilityPool<T0>) : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal {
        let v0 = arg1.pool.current_scale - arg0.snapshot_scale;
        if (v0 > 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::MAX_SCALE_FACTOR_EXPONENT()) {
            return 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from(0)
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.balance), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg1.pool.current_index), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.snapshot_pool_index))), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::pow(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from((0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::SCALE_FACTOR() as u64)), v0))
    }

    public fun get_total_dori_balance<T0>(arg0: &StabilityPool<T0>) : u64 {
        0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.total_dori_balance)
    }

    public(friend) fun init_staker_display<T0>(arg0: 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::package::Publisher, 0x2::display::Display<Staker<T0>>) {
        intern_init_staker_display<T0>(arg0, arg1)
    }

    fun intern_init_staker_display<T0>(arg0: 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::package::Publisher, 0x2::display::Display<Staker<T0>>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Staker"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"With Staker, you can track your staked DORI balance and view your pending collateral rewards in the stability pool."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/dori-staking-512x512.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/dori-staking-256x256.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weiss.finance/staker/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weiss.finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Weiss Finance"));
        let v4 = 0x2::display::new_with_fields<Staker<T0>>(&arg0, v0, v2, arg1);
        0x2::display::update_version<Staker<T0>>(&mut v4);
        (arg0, v4)
    }

    entry fun migrate<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut StabilityPool<T0>) {
        assert!(arg1.version < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENotUpgrade());
        arg1.version = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION();
    }

    public entry fun new_stake<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg2);
        assert_vault_registry_id<T0>(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg2));
        assert!(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        let (v0, v1) = distribute_interest_and_get_global_indexes<T0>(arg1, arg2, arg3, arg4, arg5);
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0));
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.stakers_table, 0x2::tx_context::sender(arg5)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStakerAlreadyExist());
        let v3 = Staker<T0>{
            id                         : 0x2::object::new(arg5),
            stability_pool_id          : 0x2::object::id<StabilityPool<T0>>(arg1),
            balance                    : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v2),
            snapshot_pool_index        : arg1.pool.current_index,
            snapshot_collateral_index  : v1,
            snapshot_yield_index       : v0,
            pending_collateral_rewards : 0x2::balance::zero<T0>(),
            snapshot_scale             : arg1.pool.current_scale,
        };
        let v4 = 0x2::object::id<Staker<T0>>(&v3);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.stakers_table, 0x2::tx_context::sender(arg5), v4);
        0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg1.total_dori_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0));
        0x2::transfer::transfer<Staker<T0>>(v3, 0x2::tx_context::sender(arg5));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_new_stake_event(0x2::object::uid_to_inner(&arg1.id), arg1.vault_registry_id, 0x2::tx_context::sender(arg5), v4, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v2), arg1.pool.current_index, v1, v0, arg1.pool.current_scale, 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1.total_dori_balance));
    }

    public entry fun new_stake_v2<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg5: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun new_stake_v3<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg2);
        assert_vault_registry_id<T0>(arg1, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg2));
        assert!(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        let (v0, v1) = distribute_interest_and_get_global_indexes_v3<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0));
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.stakers_table, 0x2::tx_context::sender(arg6)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStakerAlreadyExist());
        let v3 = Staker<T0>{
            id                         : 0x2::object::new(arg6),
            stability_pool_id          : 0x2::object::id<StabilityPool<T0>>(arg1),
            balance                    : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v2),
            snapshot_pool_index        : arg1.pool.current_index,
            snapshot_collateral_index  : v1,
            snapshot_yield_index       : v0,
            pending_collateral_rewards : 0x2::balance::zero<T0>(),
            snapshot_scale             : arg1.pool.current_scale,
        };
        let v4 = 0x2::object::id<Staker<T0>>(&v3);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.stakers_table, 0x2::tx_context::sender(arg6), v4);
        0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg1.total_dori_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0));
        0x2::transfer::transfer<Staker<T0>>(v3, 0x2::tx_context::sender(arg6));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_new_stake_event(0x2::object::uid_to_inner(&arg1.id), arg1.vault_registry_id, 0x2::tx_context::sender(arg6), v4, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v2), arg1.pool.current_index, v1, v0, arg1.pool.current_scale, 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1.total_dori_balance));
    }

    public(friend) fun offset<T0>(arg0: u256, arg1: 0x2::coin::Coin<T0>, arg2: &mut StabilityPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0);
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::coin::value<T0>(&arg1));
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2.total_dori_balance));
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg2.pool.current_index), v1), v2);
        if (0x2::table::contains<u64, u256>(&arg2.collateral.scale_to_collateral, arg2.pool.current_scale)) {
            let v4 = 0x2::table::borrow_mut<u64, u256>(&mut arg2.collateral.scale_to_collateral, arg2.pool.current_scale);
            *v4 = *v4 + 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v3);
        } else {
            0x2::table::add<u64, u256>(&mut arg2.collateral.scale_to_collateral, arg2.pool.current_scale, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v3));
        };
        let v5 = arg2.pool.current_index * 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v2, v0));
        let v6 = v5;
        let v7 = v5 / 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v2);
        let v8 = v7;
        assert!(v7 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        while (v8 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::INDEX_PRECISION() / 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::SCALE_FACTOR()) {
            v6 = v6 * 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::SCALE_FACTOR();
            v8 = v6 / 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v2);
            arg2.pool.current_scale = arg2.pool.current_scale + 1;
        };
        arg2.pool.current_index = v8;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::burn_dori_coin(arg3, 0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0))), arg4));
        0x2::balance::join<T0>(&mut arg2.collateral.total_collateral_balance, 0x2::coin::into_balance<T0>(arg1));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_stability_pool_offset_event(0x2::object::uid_to_inner(&arg2.id), arg2.vault_registry_id, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v1), arg2.pool.current_index, arg2.pool.current_scale, 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2.total_dori_balance), 0x2::balance::value<T0>(&arg2.collateral.total_collateral_balance), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v3), 0x2::coin::value<T0>(&arg1));
    }

    public(friend) fun stability_pool_mint_and_distribute_interest<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry_interest_and_return<T0>(arg0, arg3);
        if (v0 > 0) {
            trigger_dori_yield_distribution<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_return_coin(arg2, v0, arg4), arg1);
        };
        v0
    }

    fun stability_pool_mint_and_distribute_interest_v2<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg4: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    fun stability_pool_mint_and_distribute_interest_v3<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg1: &mut StabilityPool<T0>, arg2: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::update_vault_registry_interest_and_return<T0>(arg0, arg4);
        if (v0 > 0) {
            let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::get_savings_fee_bps<T0>(arg0)));
            distribute_yield_savings(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v1), arg2, arg3, arg4, arg5);
            trigger_dori_yield_distribution<T0>(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::mint_dori_and_return_coin(arg2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v0), v1)), arg5), arg1);
        };
        v0
    }

    public fun trigger_dori_yield_distribution<T0>(arg0: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg1: &mut StabilityPool<T0>) {
        assert_version<T0>(arg1);
        let v0 = 0;
        if (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1.total_dori_balance) < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::MIN_YIELD_DEPOSIT()) {
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg1.yield.yield_gain_pending, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0));
        } else {
            let v1 = 0x2::balance::withdraw_all<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg1.yield.yield_gain_pending);
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg1.yield.active_yield_balance, v1);
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg1.yield.active_yield_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg0));
            let v2 = arg1.pool.current_index * 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&v1)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0)))) / 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1.total_dori_balance)));
            if (0x2::table::contains<u64, u256>(&arg1.yield.scale_to_yield, arg1.pool.current_scale)) {
                let v3 = 0x2::table::borrow_mut<u64, u256>(&mut arg1.yield.scale_to_yield, arg1.pool.current_scale);
                *v3 = *v3 + v2;
                v0 = *v3;
            } else {
                0x2::table::add<u64, u256>(&mut arg1.yield.scale_to_yield, arg1.pool.current_scale, v2);
                v0 = v2;
            };
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_stability_pool_yield_distribution_event(0x2::object::uid_to_inner(&arg1.id), arg1.vault_registry_id, 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1.yield.yield_gain_pending), 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1.yield.active_yield_balance), v0, 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0));
    }

    public entry fun unstake<T0>(arg0: &mut Staker<T0>, arg1: u64, arg2: &mut StabilityPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg3);
        assert_vault_registry_id<T0>(arg2, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3));
        assert!(arg0.stability_pool_id == 0x2::object::id<StabilityPool<T0>>(arg2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStabilityPoolIdMismatch());
        assert!(arg0.balance > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStakerBalanceEmpty());
        stability_pool_mint_and_distribute_interest<T0>(arg3, arg2, arg4, arg5, arg7);
        let v0 = if (0x2::table::contains<u64, u256>(&arg2.yield.scale_to_yield, arg2.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg2.yield.scale_to_yield, arg2.pool.current_scale)
        } else {
            let v1 = 0;
            &v1
        };
        let v2 = if (0x2::table::contains<u64, u256>(&arg2.collateral.scale_to_collateral, arg2.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg2.collateral.scale_to_collateral, arg2.pool.current_scale)
        } else {
            let v3 = 0;
            &v3
        };
        let v4 = get_dori_staking_rewards<T0>(arg0, arg2);
        let v5 = get_collateral_staking_rewards<T0>(arg0, arg2);
        let v6 = get_staker_balance_decimal<T0>(arg0, arg2);
        let v7 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(v6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg1));
        0x2::balance::join<T0>(&mut arg0.pending_collateral_rewards, 0x2::balance::split<T0>(&mut arg2.collateral.total_collateral_balance, v5));
        if (arg6) {
            let v8 = 0x2::balance::zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>();
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v8, 0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.yield.active_yield_balance, v4));
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v8, 0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v7)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v8, arg7), 0x2::tx_context::sender(arg7));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_collateral_rewards), arg7), 0x2::tx_context::sender(arg7));
            arg0.balance = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v6, v7));
        } else {
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.yield.active_yield_balance, v4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v7)), arg7), 0x2::tx_context::sender(arg7));
            arg0.balance = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v6, v7), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v4)));
        };
        arg0.snapshot_pool_index = arg2.pool.current_index;
        arg0.snapshot_collateral_index = *v2;
        arg0.snapshot_yield_index = *v0;
        arg0.snapshot_scale = arg2.pool.current_scale;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_unstake_event(0x2::object::uid_to_inner(&arg2.id), arg2.vault_registry_id, 0x2::tx_context::sender(arg7), 0x2::object::id<Staker<T0>>(arg0), arg6, v5, 0x2::balance::value<T0>(&arg0.pending_collateral_rewards), v4, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v7), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.balance)), arg2.pool.current_index, *v2, *v0, arg2.pool.current_scale, 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2.total_dori_balance));
        assert!(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2.total_dori_balance) >= 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::MIN_YIELD_DEPOSIT(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ERequireOneDoriMinAmountToLeaveInSP());
    }

    public entry fun unstake_v2<T0>(arg0: &mut Staker<T0>, arg1: u64, arg2: &mut StabilityPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg5: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg6: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg7: &0x2::clock::Clock, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun unstake_v3<T0>(arg0: &mut Staker<T0>, arg1: u64, arg2: &mut StabilityPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg6: &0x2::clock::Clock, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg3);
        assert_vault_registry_id<T0>(arg2, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3));
        assert!(arg0.stability_pool_id == 0x2::object::id<StabilityPool<T0>>(arg2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStabilityPoolIdMismatch());
        assert!(arg0.balance > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStakerBalanceEmpty());
        stability_pool_mint_and_distribute_interest_v3<T0>(arg3, arg2, arg4, arg5, arg6, arg8);
        let v0 = if (0x2::table::contains<u64, u256>(&arg2.yield.scale_to_yield, arg2.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg2.yield.scale_to_yield, arg2.pool.current_scale)
        } else {
            let v1 = 0;
            &v1
        };
        let v2 = if (0x2::table::contains<u64, u256>(&arg2.collateral.scale_to_collateral, arg2.pool.current_scale)) {
            0x2::table::borrow<u64, u256>(&arg2.collateral.scale_to_collateral, arg2.pool.current_scale)
        } else {
            let v3 = 0;
            &v3
        };
        let v4 = get_dori_staking_rewards<T0>(arg0, arg2);
        let v5 = get_collateral_staking_rewards<T0>(arg0, arg2);
        let v6 = get_staker_balance_decimal<T0>(arg0, arg2);
        let v7 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(v6, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg1));
        0x2::balance::join<T0>(&mut arg0.pending_collateral_rewards, 0x2::balance::split<T0>(&mut arg2.collateral.total_collateral_balance, v5));
        if (arg7) {
            let v8 = 0x2::balance::zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>();
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v8, 0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.yield.active_yield_balance, v4));
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut v8, 0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v7)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(v8, arg8), 0x2::tx_context::sender(arg8));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_collateral_rewards), arg8), 0x2::tx_context::sender(arg8));
            arg0.balance = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v6, v7));
        } else {
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.yield.active_yield_balance, v4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v7)), arg8), 0x2::tx_context::sender(arg8));
            arg0.balance = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v6, v7), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v4)));
        };
        arg0.snapshot_pool_index = arg2.pool.current_index;
        arg0.snapshot_collateral_index = *v2;
        arg0.snapshot_yield_index = *v0;
        arg0.snapshot_scale = arg2.pool.current_scale;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_unstake_event(0x2::object::uid_to_inner(&arg2.id), arg2.vault_registry_id, 0x2::tx_context::sender(arg8), 0x2::object::id<Staker<T0>>(arg0), arg7, v5, 0x2::balance::value<T0>(&arg0.pending_collateral_rewards), v4, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v7), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.balance)), arg2.pool.current_index, *v2, *v0, arg2.pool.current_scale, 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2.total_dori_balance));
        assert!(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2.total_dori_balance) >= 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::MIN_YIELD_DEPOSIT(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ERequireOneDoriMinAmountToLeaveInSP());
    }

    public entry fun update_stake<T0>(arg0: &mut Staker<T0>, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut StabilityPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg3);
        assert_vault_registry_id<T0>(arg2, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3));
        assert!(arg0.stability_pool_id == 0x2::object::id<StabilityPool<T0>>(arg2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStabilityPoolIdMismatch());
        assert!(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        let (v0, v1) = distribute_interest_and_get_global_indexes<T0>(arg2, arg3, arg4, arg5, arg7);
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1));
        let v3 = get_dori_staking_rewards<T0>(arg0, arg2);
        let v4 = get_collateral_staking_rewards<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.pending_collateral_rewards, 0x2::balance::split<T0>(&mut arg2.collateral.total_collateral_balance, v4));
        if (arg6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.yield.active_yield_balance, v3), arg7), 0x2::tx_context::sender(arg7));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_collateral_rewards), arg7), 0x2::tx_context::sender(arg7));
            arg0.balance = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(get_staker_balance_decimal<T0>(arg0, arg2), v2));
        } else {
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.yield.active_yield_balance, v3));
            arg0.balance = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(get_staker_balance_decimal<T0>(arg0, arg2), v2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v3)));
        };
        arg0.snapshot_pool_index = arg2.pool.current_index;
        arg0.snapshot_collateral_index = v1;
        arg0.snapshot_yield_index = v0;
        arg0.snapshot_scale = arg2.pool.current_scale;
        0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_update_stake_event(0x2::object::uid_to_inner(&arg2.id), arg2.vault_registry_id, 0x2::tx_context::sender(arg7), 0x2::object::id<Staker<T0>>(arg0), arg6, v4, 0x2::balance::value<T0>(&arg0.pending_collateral_rewards), v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.balance)), arg2.pool.current_index, v1, v0, arg2.pool.current_scale, 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2.total_dori_balance));
    }

    public entry fun update_stake_v2<T0>(arg0: &mut Staker<T0>, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut StabilityPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg5: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx::Farm, arg6: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg7: &0x2::clock::Clock, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_stake_v3<T0>(arg0: &mut Staker<T0>, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut StabilityPool<T0>, arg3: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>, arg4: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg5: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::SavingsVault, arg6: &0x2::clock::Clock, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::assert_version<T0>(arg3);
        assert_vault_registry_id<T0>(arg2, 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::VaultRegistry<T0>>(arg3));
        assert!(arg0.stability_pool_id == 0x2::object::id<StabilityPool<T0>>(arg2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EStabilityPoolIdMismatch());
        assert!(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1) > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        let (v0, v1) = distribute_interest_and_get_global_indexes_v3<T0>(arg2, arg3, arg4, arg5, arg6, arg8);
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1));
        let v3 = get_dori_staking_rewards<T0>(arg0, arg2);
        let v4 = get_collateral_staking_rewards<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.pending_collateral_rewards, 0x2::balance::split<T0>(&mut arg2.collateral.total_collateral_balance, v4));
        if (arg7) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>>(0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.yield.active_yield_balance, v3), arg8), 0x2::tx_context::sender(arg8));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_collateral_rewards), arg8), 0x2::tx_context::sender(arg8));
            arg0.balance = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(get_staker_balance_decimal<T0>(arg0, arg2), v2));
        } else {
            0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.yield.active_yield_balance, v3));
            arg0.balance = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(get_staker_balance_decimal<T0>(arg0, arg2), v2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(v3)));
        };
        arg0.snapshot_pool_index = arg2.pool.current_index;
        arg0.snapshot_collateral_index = v1;
        arg0.snapshot_yield_index = v0;
        arg0.snapshot_scale = arg2.pool.current_scale;
        0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg2.total_dori_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_update_stake_event(0x2::object::uid_to_inner(&arg2.id), arg2.vault_registry_id, 0x2::tx_context::sender(arg8), 0x2::object::id<Staker<T0>>(arg0), arg7, v4, 0x2::balance::value<T0>(&arg0.pending_collateral_rewards), v3, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(v2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0.balance)), arg2.pool.current_index, v1, v0, arg2.pool.current_scale, 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg2.total_dori_balance));
    }

    // decompiled from Move bytecode v6
}

