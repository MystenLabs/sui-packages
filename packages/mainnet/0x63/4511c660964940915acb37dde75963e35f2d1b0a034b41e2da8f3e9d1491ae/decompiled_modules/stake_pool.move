module 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::stake_pool {
    struct STAKE_POOL has drop {
        dummy_field: bool,
    }

    struct StakePool has store, key {
        id: 0x2::object::UID,
        fee_config: 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::FeeConfig,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        boosted_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        boosted_reward_amount: u64,
        accrued_reward_fees: u64,
        validator_pool: 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::ValidatorPool,
        manage: 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::Manage,
        extra_fields: 0x2::bag::Bag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeEventExt has copy, drop {
        sui_amount_in: u64,
        lst_amount_out: u64,
        fee_amount: u64,
    }

    struct UnstakeEventExt has copy, drop {
        lst_amount_in: u64,
        sui_amount_out: u64,
        fee_amount: u64,
        redistribution_amount: u64,
    }

    struct EpochChangedEvent has copy, drop {
        old_sui_supply: u64,
        new_sui_supply: u64,
        boosted_reward_amount: u64,
        lst_supply: u64,
        reward_fee: u64,
    }

    struct DelegateStakeEvent has copy, drop {
        v_address: address,
        sui_amount_in: u64,
        lst_amount_out: u64,
    }

    struct MintOperatorCapEvent has copy, drop {
        recipient: address,
    }

    struct CollectFeesEvent has copy, drop {
        amount: u64,
    }

    struct DepositBoostedBalanceEvent has copy, drop {
        before_balance: u64,
        after_balance: u64,
    }

    struct RebalanceEvent has copy, drop {
        is_epoch_rolled_over: bool,
        sender: address,
    }

    struct BoostedRewardAmountUpdateEvent has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    struct FeeUpdateEvent has copy, drop {
        field: 0x1::ascii::String,
        old_value: u64,
        new_value: u64,
    }

    struct ValidatorWeightsUpdateEvent has copy, drop {
        validator_weights: 0x2::vec_map::VecMap<address, u64>,
    }

    struct SetPausedEvent has copy, drop {
        paused: bool,
    }

    public fun fee_config(arg0: &StakePool) : &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::FeeConfig {
        &arg0.fee_config
    }

    public fun migrate_version(arg0: &mut StakePool, arg1: &AdminCap) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::migrate_version(&mut arg0.manage);
    }

    public fun set_paused(arg0: &mut StakePool, arg1: &AdminCap, arg2: bool) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::set_paused(&mut arg0.manage, arg2);
        let v0 = SetPausedEvent{paused: arg2};
        0x2::event::emit<SetPausedEvent>(v0);
    }

    public fun accrued_reward_fees(arg0: &StakePool) : u64 {
        arg0.accrued_reward_fees
    }

    public fun boosted_balance(arg0: &StakePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.boosted_balance)
    }

    public fun collect_fees(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        refresh(arg0, arg1, arg2, arg4);
        let v0 = 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::split_n_sui(&mut arg0.validator_pool, arg2, arg0.accrued_reward_fees, arg4);
        arg0.accrued_reward_fees = arg0.accrued_reward_fees - 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fees);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, v0);
        let v2 = CollectFeesEvent{amount: 0x2::balance::value<0x2::sui::SUI>(&v1)};
        0x2::event::emit<CollectFeesEvent>(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4)
    }

    fun create_lst_with_validator_pool(arg0: 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::ValidatorPool, arg1: &mut 0x2::tx_context::TxContext) : (AdminCap, StakePool) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = StakePool{
            id                    : 0x2::object::new(arg1),
            fee_config            : 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::new(arg1),
            fees                  : 0x2::balance::zero<0x2::sui::SUI>(),
            boosted_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            boosted_reward_amount : 0,
            accrued_reward_fees   : 0,
            validator_pool        : arg0,
            manage                : 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::new(),
            extra_fields          : 0x2::bag::new(arg1),
        };
        (v0, v1)
    }

    public fun validator_pool(arg0: &StakePool) : &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::ValidatorPool {
        &arg0.validator_pool
    }

    public(friend) fun create_stake_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::new(arg0);
        let (v1, v2) = create_lst_with_validator_pool(v0, arg0);
        0x2::transfer::public_transfer<StakePool>(v2, 0x2::tx_context::sender(arg0));
        let v3 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v3, 0x2::tx_context::sender(arg0));
        let v4 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v4, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun delegate_stake(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT> {
        let v0 = stake(arg0, arg1, arg2, arg3, arg5);
        let v1 = DelegateStakeEvent{
            v_address      : arg4,
            sui_amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            lst_amount_out : 0x2::coin::value<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>(&v0),
        };
        0x2::event::emit<DelegateStakeEvent>(v1);
        v0
    }

    public entry fun delegate_stake_entry(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = delegate_stake(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun deposit_boosted_balance(arg0: &mut StakePool, arg1: &OperatorCap, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.boosted_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
        let v0 = DepositBoostedBalanceEvent{
            before_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.boosted_balance),
            after_balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.boosted_balance),
        };
        0x2::event::emit<DepositBoostedBalanceEvent>(v0);
    }

    public fun get_amount_out(arg0: &StakePool, arg1: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: u64, arg3: bool) : u64 {
        if (arg3) {
            sui_amount_to_lst_amount(arg0, arg1, arg2 - 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::calculate_stake_fee(&arg0.fee_config, arg2))
        } else {
            lst_amount_to_sui_amount(arg0, arg1, arg2 - 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::calculate_unstake_fee(&arg0.fee_config, arg2))
        }
    }

    public fun get_ratio(arg0: &StakePool, arg1: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>) : u64 {
        if (total_sui_supply(arg0) == 0 || 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::get_total_supply_value(arg1) == 0) {
            return 0
        };
        sui_amount_to_lst_amount(arg0, arg1, 1000000000)
    }

    public fun get_ratio_reverse(arg0: &StakePool, arg1: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>) : u64 {
        if (total_sui_supply(arg0) == 0 || 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::get_total_supply_value(arg1) == 0) {
            return 0
        };
        lst_amount_to_sui_amount(arg0, arg1, 1000000000)
    }

    fun init(arg0: STAKE_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<STAKE_POOL>(arg0, arg1);
        create_stake_pool(arg1);
    }

    public(friend) fun join_to_sui_pool(arg0: &mut StakePool, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::join_to_sui_pool(&mut arg0.validator_pool, arg1);
    }

    public fun lst_amount_to_sui_amount(arg0: &StakePool, arg1: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: u64) : u64 {
        let v0 = 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::get_total_supply_value(arg1);
        assert!(v0 > 0, 30002);
        (((total_sui_supply(arg0) as u128) * (arg2 as u128) / (v0 as u128)) as u64)
    }

    public fun migrate_cert(arg0: &mut StakePool, arg1: &AdminCap, arg2: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::migrate_version(&mut arg0.manage);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::migrate(arg2);
    }

    public fun mint_operator_cap(arg0: &mut StakePool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = OperatorCap{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<OperatorCap>(v0, arg2);
        let v1 = MintOperatorCapEvent{recipient: arg2};
        0x2::event::emit<MintOperatorCapEvent>(v1);
    }

    public fun publish_ratio(arg0: &StakePool, arg1: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>) {
    }

    public fun rebalance(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_not_paused(&arg0.manage);
        let v0 = refresh(arg0, arg1, arg2, arg3);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::rebalance(&mut arg0.validator_pool, 0x1::option::none<0x2::vec_map::VecMap<address, u64>>(), arg2, arg3);
        let v1 = RebalanceEvent{
            is_epoch_rolled_over : v0,
            sender               : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RebalanceEvent>(v1);
    }

    public fun refresh(arg0: &mut StakePool, arg1: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : bool {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_not_paused(&arg0.manage);
        let v0 = total_sui_supply(arg0);
        if (0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::refresh(&mut arg0.validator_pool, arg2, arg3)) {
            let v1 = total_sui_supply(arg0);
            let v2 = if (v1 > v0) {
                ((((v1 - v0) as u128) * (0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::reward_fee_bps(&arg0.fee_config) as u128) / (10000 as u128)) as u64)
            } else {
                0
            };
            arg0.accrued_reward_fees = arg0.accrued_reward_fees + v2;
            let v3 = if (v1 > v0) {
                let v4 = 0x1::u64::min(0x1::u64::min(arg0.boosted_reward_amount, v1 - v0), 0x2::balance::value<0x2::sui::SUI>(&arg0.boosted_balance));
                let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.boosted_balance, v4);
                join_to_sui_pool(arg0, v5);
                v4
            } else {
                0
            };
            let v6 = EpochChangedEvent{
                old_sui_supply        : v0,
                new_sui_supply        : v1,
                boosted_reward_amount : v3,
                lst_supply            : total_lst_supply(arg1),
                reward_fee            : v2,
            };
            0x2::event::emit<EpochChangedEvent>(v6);
            return true
        };
        false
    }

    public fun set_validator_weights(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &OperatorCap, arg4: 0x2::vec_map::VecMap<address, u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        refresh(arg0, arg1, arg2, arg5);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::set_validator_weights(&mut arg0.validator_pool, arg4, arg2, arg5);
        let v0 = ValidatorWeightsUpdateEvent{validator_weights: arg4};
        0x2::event::emit<ValidatorWeightsUpdateEvent>(v0);
    }

    public fun stake(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT> {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_not_paused(&arg0.manage);
        refresh(arg0, arg1, arg2, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 100000000, 30003);
        let v0 = (total_sui_supply(arg0) as u128);
        let v1 = (total_lst_supply(arg1) as u128);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v3 = 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::calculate_stake_fee(&arg0.fee_config, 0x2::balance::value<0x2::sui::SUI>(&v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
        let v4 = sui_amount_to_lst_amount(arg0, arg1, 0x2::balance::value<0x2::sui::SUI>(&v2));
        assert!(v4 > 0, 30000);
        let v5 = StakeEventExt{
            sui_amount_in  : 0x2::balance::value<0x2::sui::SUI>(&v2),
            lst_amount_out : v4,
            fee_amount     : v3,
        };
        0x2::event::emit<StakeEventExt>(v5);
        let v6 = 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::mint(arg1, v4, arg4);
        assert!((0x2::coin::value<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>(&v6) as u128) * v0 <= (0x2::balance::value<0x2::sui::SUI>(&v2) as u128) * v1 || v0 > 0 && v1 == 0, 30001);
        join_to_sui_pool(arg0, v2);
        v6
    }

    public entry fun stake_entry(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = stake(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun sui_amount_to_lst_amount(arg0: &StakePool, arg1: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: u64) : u64 {
        let v0 = total_sui_supply(arg0);
        let v1 = 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::get_total_supply_value(arg1);
        if (v0 == 0 || v1 == 0) {
            return arg2
        };
        (((v1 as u128) * (arg2 as u128) / (v0 as u128)) as u64)
    }

    public fun total_fees(arg0: &StakePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees) + arg0.accrued_reward_fees
    }

    public fun total_lst_supply(arg0: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>) : u64 {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::get_total_supply_value(arg0)
    }

    public fun total_sui_supply(arg0: &StakePool) : u64 {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::total_sui_supply(&arg0.validator_pool) - arg0.accrued_reward_fees
    }

    public fun unstake(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_not_paused(&arg0.manage);
        refresh(arg0, arg1, arg2, arg4);
        let v0 = (total_sui_supply(arg0) as u128);
        let v1 = lst_amount_to_sui_amount(arg0, arg1, 0x2::coin::value<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>(&arg3));
        assert!(v1 >= 100000000, 30003);
        let v2 = 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::validator_pool::split_n_sui(&mut arg0.validator_pool, arg2, v1, arg4);
        let v3 = 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::calculate_unstake_fee(&arg0.fee_config, 0x2::balance::value<0x2::sui::SUI>(&v2));
        let v4 = if (total_lst_supply(arg1) == 0x2::coin::value<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>(&arg3)) {
            0
        } else {
            0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::calculate_unstake_fee_redistribution(&arg0.fee_config, v3)
        };
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut v2, (v3 as u64));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, v5);
        join_to_sui_pool(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v4));
        let v6 = UnstakeEventExt{
            lst_amount_in         : 0x2::coin::value<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>(&arg3),
            sui_amount_out        : 0x2::balance::value<0x2::sui::SUI>(&v2),
            fee_amount            : v3 - v4,
            redistribution_amount : v4,
        };
        0x2::event::emit<UnstakeEventExt>(v6);
        assert!((0x2::balance::value<0x2::sui::SUI>(&v2) as u128) * (total_lst_supply(arg1) as u128) <= (0x2::coin::value<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>(&arg3) as u128) * v0, 30001);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::burn_coin(arg1, arg3);
        0x2::coin::from_balance<0x2::sui::SUI>(v2, arg4)
    }

    public entry fun unstake_entry(arg0: &mut StakePool, arg1: &mut 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = unstake(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun update_boosted_reward_amount(arg0: &mut StakePool, arg1: &AdminCap, arg2: u64) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = BoostedRewardAmountUpdateEvent{
            old_value : arg0.boosted_reward_amount,
            new_value : arg2,
        };
        0x2::event::emit<BoostedRewardAmountUpdateEvent>(v0);
        arg0.boosted_reward_amount = arg2;
    }

    public fun update_reward_fee(arg0: &mut StakePool, arg1: &AdminCap, arg2: u64) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = FeeUpdateEvent{
            field     : 0x1::ascii::string(b"reward_fee_bps"),
            old_value : 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::reward_fee_bps(&arg0.fee_config),
            new_value : arg2,
        };
        0x2::event::emit<FeeUpdateEvent>(v0);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::set_reward_fee_bps(&mut arg0.fee_config, arg2);
    }

    public fun update_stake_fee(arg0: &mut StakePool, arg1: &AdminCap, arg2: u64) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = FeeUpdateEvent{
            field     : 0x1::ascii::string(b"stake_fee_bps"),
            old_value : 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::stake_fee_bps(&arg0.fee_config),
            new_value : arg2,
        };
        0x2::event::emit<FeeUpdateEvent>(v0);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::set_stake_fee_bps(&mut arg0.fee_config, arg2);
    }

    public fun update_unstake_fee(arg0: &mut StakePool, arg1: &AdminCap, arg2: u64) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = FeeUpdateEvent{
            field     : 0x1::ascii::string(b"unstake_fee_bps"),
            old_value : 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::unstake_fee_bps(&arg0.fee_config),
            new_value : arg2,
        };
        0x2::event::emit<FeeUpdateEvent>(v0);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::set_unstake_fee_bps(&mut arg0.fee_config, arg2);
    }

    public fun update_unstake_fee_redistribution(arg0: &mut StakePool, arg1: &AdminCap, arg2: u64) {
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::manage::check_version(&arg0.manage);
        let v0 = FeeUpdateEvent{
            field     : 0x1::ascii::string(b"unstake_fee_redistribution_bps"),
            old_value : 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::unstake_fee_redistribution_bps(&arg0.fee_config),
            new_value : arg2,
        };
        0x2::event::emit<FeeUpdateEvent>(v0);
        0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::fee_config::set_unstake_fee_redistribution_bps(&mut arg0.fee_config, arg2);
    }

    // decompiled from Move bytecode v6
}

