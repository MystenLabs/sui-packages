module 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking {
    struct Staking has key {
        id: 0x2::object::UID,
        version: u64,
        config: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::StakingConfig,
        sui_vault: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::Vault<0x2::sui::SUI>,
        claim_sui_vault: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::Vault<0x2::sui::SUI>,
        protocol_sui_vault: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::Vault<0x2::sui::SUI>,
        service_sui_vault: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::Vault<0x2::sui::SUI>,
        stsui_treasury_cap: 0x2::coin::TreasuryCap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        unstake_epochs: vector<EpochClaim>,
        total_staked: u64,
        total_unstaked: u64,
        total_rewards: u64,
        total_protocol_fees: u64,
        uncollected_protocol_fees: u64,
        stsui_supply: u64,
        unclaimed_sui_amount: u64,
        pause_stake: bool,
        pause_unstake: bool,
        validators: vector<address>,
        pools: 0x2::table::Table<address, PoolInfo>,
        user_selected_validator_bals: 0x2::vec_map::VecMap<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        rewards_last_updated_epoch: u64,
    }

    struct PoolInfo has store {
        staked_suis: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::TableQueue<0x3::staking_pool::StakedSui>,
        total_staked: u64,
        rewards: u64,
    }

    struct EpochClaim has store {
        epoch: u64,
        amount: u64,
        approved: bool,
    }

    struct UnstakeTicket has key {
        id: 0x2::object::UID,
        unstake_timestamp_ms: u64,
        st_amount: u64,
        sui_amount: u64,
        claim_epoch: u64,
        claim_timestamp_ms: u64,
    }

    struct UserStaked has copy, drop {
        owner: address,
        sui_amount: u64,
        st_amount: u64,
        validator: address,
    }

    struct UserInstantUnstaked has copy, drop {
        owner: address,
        sui_amount: u64,
        st_amount: u64,
    }

    struct UserNormalUnstaked has copy, drop {
        owner: address,
        epoch: u64,
        epoch_timestamp_ms: u64,
        unstake_timestamp_ms: u64,
        sui_amount: u64,
        st_amount: u64,
    }

    struct UserClaimed has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        sui_amount: u64,
    }

    struct SystemStaked has copy, drop {
        staked_sui_id: 0x2::object::ID,
        epoch: u64,
        sui_amount: u64,
        validator: address,
    }

    struct SystemUnstaked has copy, drop {
        epoch: u64,
        sui_amount: u64,
        approved_amount: u64,
    }

    struct PoolSystemUnstaked has copy, drop {
        validator: address,
        epoch: u64,
        sui_amount: u64,
        unstaked_all: bool,
    }

    struct SuiRewardsUpdated has copy, drop {
        old: u64,
        new: u64,
        fee: u64,
    }

    struct RewardsFeeCollected has copy, drop {
        owner: address,
        sui_amount: u64,
    }

    struct ServiceFeeCollected has copy, drop {
        owner: address,
        sui_amount: u64,
    }

    struct VersionUpdated has copy, drop {
        old: u64,
        new: u64,
    }

    struct ExchangeRateUpdated has copy, drop {
        old: u64,
        new: u64,
    }

    struct RewardsInjected has copy, drop {
        owner: address,
        sui_amount: u64,
    }

    struct ValidatorStakedInfo has store {
        validator: address,
        total_staked: u64,
        rewards: u64,
        staked_sui_count: u64,
    }

    struct ValidatorStakedInfoV2 has store {
        validator: address,
        total_staked: u64,
        rewards: u64,
        staked_sui_count: u64,
        pool_id: 0x2::object::ID,
        exchange_rates_unexisted_epoches: vector<u64>,
        stake_activation_epoches: vector<u64>,
    }

    struct UserSelectedStaking has drop {
        validator: address,
        amount: u64,
    }

    public fun assert_version(arg0: &Staking) {
        assert!(arg0.version <= 5, 1);
    }

    fun calculate_staked_sui_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::util::calculate_rewards(arg0, 0x3::staking_pool::pool_id(arg1), 0x3::staking_pool::staked_sui_amount(arg1), 0x3::staking_pool::stake_activation_epoch(arg1), arg2)
    }

    fun calculate_validator_pool_rewards_increase(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut PoolInfo, arg2: u64) : u64 {
        if (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<0x3::staking_pool::StakedSui>(&arg1.staked_suis) == 0) {
            return 0
        };
        let v0 = 0;
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<0x3::staking_pool::StakedSui>(&arg1.staked_suis);
        while (v1 < 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<0x3::staking_pool::StakedSui>(&arg1.staked_suis)) {
            v0 = v0 + calculate_staked_sui_rewards(arg0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<0x3::staking_pool::StakedSui>(&arg1.staked_suis, v1), arg2);
            v1 = v1 + 1;
        };
        let v2 = 0;
        if (v0 > arg1.rewards) {
            v2 = v0 - arg1.rewards;
            arg1.rewards = v0;
        };
        v2
    }

    public fun claim(arg0: &mut Staking, arg1: UnstakeTicket, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun claim_coin(arg0: &mut Staking, arg1: UnstakeTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 0
    }

    public fun claim_coin_v2(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: UnstakeTicket, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg1);
        assert!(!query_pause_claim(arg1), 17);
        let UnstakeTicket {
            id                   : v0,
            unstake_timestamp_ms : _,
            st_amount            : _,
            sui_amount           : v3,
            claim_epoch          : v4,
            claim_timestamp_ms   : v5,
        } = arg2;
        let v6 = v0;
        0x2::object::delete(v6);
        assert!(0x2::tx_context::epoch(arg3) >= v4, 6);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= v5, 6);
        let (v7, v8) = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::withdraw_max<0x2::sui::SUI>(&mut arg1.claim_sui_vault, v3);
        let v9 = v7;
        let v10 = withdraw_sui(arg0, arg1, v8, false, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut v9, v10);
        arg1.unclaimed_sui_amount = arg1.unclaimed_sui_amount - v3;
        let v11 = UserClaimed{
            id         : 0x2::object::uid_to_inner(&v6),
            owner      : 0x2::tx_context::sender(arg3),
            sui_amount : v3,
        };
        0x2::event::emit<UserClaimed>(v11);
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg3)
    }

    public fun claim_v2(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: UnstakeTicket, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_coin_v2(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun collect_rewards_fee(arg0: &mut Staking, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun collect_rewards_fee_v2(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::withdraw_max<0x2::sui::SUI>(&mut arg1.protocol_sui_vault, arg1.uncollected_protocol_fees);
        let v2 = v0;
        let v3 = withdraw_sui(arg0, arg1, v1, false, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut v2, v3);
        arg1.total_protocol_fees = arg1.total_protocol_fees + arg1.uncollected_protocol_fees;
        arg1.uncollected_protocol_fees = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3), arg2);
        let v4 = RewardsFeeCollected{
            owner      : arg2,
            sui_amount : 0x2::balance::value<0x2::sui::SUI>(&v2),
        };
        0x2::event::emit<RewardsFeeCollected>(v4);
    }

    public(friend) fun collect_service_fee(arg0: &mut Staking, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::vault_amount<0x2::sui::SUI>(&arg0.service_sui_vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::withdraw<0x2::sui::SUI>(&mut arg0.service_sui_vault, v0), arg2), arg1);
        let v1 = ServiceFeeCollected{
            owner      : arg1,
            sui_amount : v0,
        };
        0x2::event::emit<ServiceFeeCollected>(v1);
    }

    public fun destroy_ValidatorStakedInfoV2(arg0: ValidatorStakedInfoV2) {
        let ValidatorStakedInfoV2 {
            validator                        : _,
            total_staked                     : _,
            rewards                          : _,
            staked_sui_count                 : _,
            pool_id                          : _,
            exchange_rates_unexisted_epoches : _,
            stake_activation_epoches         : _,
        } = arg0;
    }

    public(friend) fun do_stake(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::sui_system::active_validator_addresses(arg1);
        let v1 = stake_user_selected_validators(arg0, arg1, &v0, arg3);
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::deposit<0x2::sui::SUI>(&mut arg0.sui_vault, v1);
        let v2 = 0x1::vector::length<address>(&arg2);
        let v3 = v2;
        assert!(v2 > 0, 3);
        let v4 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::get_validator_count(&arg0.config);
        if (v4 < v2) {
            v3 = v4;
        };
        let v5 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::vault_amount<0x2::sui::SUI>(&arg0.sui_vault);
        let v6 = v5 / 1000000000;
        if (v6 == 0) {
            return
        };
        if (v3 > v6) {
            v3 = v6;
        };
        let v7 = 0;
        while (v7 < v3) {
            let v8 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::withdraw<0x2::sui::SUI>(&mut arg0.sui_vault, v5 / v3);
            stake_to_validator(v8, arg0, arg1, *0x1::vector::borrow<address>(&arg2, v7), arg3);
            v7 = v7 + 1;
        };
    }

    public(friend) fun do_unstake_onchain_by_validator(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        unstake_inactive_validators(arg0, arg1, arg3);
    }

    fun do_validator_unstake(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::table::contains<address, PoolInfo>(&arg0.pools, arg3)) {
            return arg4
        };
        let v0 = 0;
        let v1 = 0x2::table::borrow_mut<address, PoolInfo>(&mut arg0.pools, arg3);
        while (arg4 > 0 && 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<0x3::staking_pool::StakedSui>(&v1.staked_suis) > 0) {
            let (v2, v3) = get_split_amount(arg1, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_front<0x3::staking_pool::StakedSui>(&v1.staked_suis), arg4, arg5);
            let v4 = if (v2 > 0) {
                0x3::staking_pool::split(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_front_mut<0x3::staking_pool::StakedSui>(&mut v1.staked_suis), v3, arg6)
            } else {
                0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::pop_front<0x3::staking_pool::StakedSui>(&mut v1.staked_suis)
            };
            let (v5, v6) = withdraw_staked_sui(arg1, v4, arg2, arg6);
            let v7 = v0 + v5;
            v0 = v7 + v6;
            if (v5 + v6 <= arg4) {
                let v8 = arg4 - v5;
                arg4 = v8 - v6;
            } else {
                arg4 = 0;
            };
            v1.total_staked = v1.total_staked - v5;
            if (v1.rewards >= v6) {
                v1.rewards = v1.rewards - v6;
                continue
            };
            v1.rewards = 0;
        };
        let v9 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::is_empty<0x3::staking_pool::StakedSui>(&v1.staked_suis);
        if (v9) {
            let PoolInfo {
                staked_suis  : v10,
                total_staked : _,
                rewards      : _,
            } = 0x2::table::remove<address, PoolInfo>(&mut arg0.pools, arg3);
            0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::destroy_empty<0x3::staking_pool::StakedSui>(v10);
            let (v13, v14) = 0x1::vector::index_of<address>(&arg0.validators, &arg3);
            if (v13) {
                0x1::vector::remove<address>(&mut arg0.validators, v14);
            };
        };
        if (arg4 != arg4) {
            let v15 = PoolSystemUnstaked{
                validator    : arg3,
                epoch        : arg5,
                sui_amount   : v0,
                unstaked_all : v9,
            };
            0x2::event::emit<PoolSystemUnstaked>(v15);
        };
        arg4
    }

    public fun get_all_current_validator_staked_info(arg0: &Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x2::tx_context::TxContext) : vector<ValidatorStakedInfo> {
        let v0 = 0x1::vector::empty<ValidatorStakedInfo>();
        let v1 = arg0.validators;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.validators)) {
            let v3 = *0x1::vector::borrow<address>(&v1, v2);
            v2 = v2 + 1;
            0x1::vector::push_back<ValidatorStakedInfo>(&mut v0, get_current_validator_staked_info(arg0, arg1, v3, arg2));
        };
        v0
    }

    public fun get_cached_validator_number(arg0: &Staking) : u64 {
        0x2::vec_map::size<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_selected_validator_bals)
    }

    public fun get_config_mut(arg0: &mut Staking) : &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::StakingConfig {
        assert_version(arg0);
        &mut arg0.config
    }

    public fun get_current_validator_staked_info(arg0: &Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: &0x2::tx_context::TxContext) : ValidatorStakedInfo {
        let v0 = 0x2::table::borrow<address, PoolInfo>(&arg0.pools, arg2);
        let v1 = ValidatorStakedInfo{
            validator        : arg2,
            total_staked     : 0,
            rewards          : 0,
            staked_sui_count : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<0x3::staking_pool::StakedSui>(&v0.staked_suis),
        };
        if (v1.staked_sui_count == 0) {
            return v1
        };
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<0x3::staking_pool::StakedSui>(&v0.staked_suis);
        while (v2 < 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<0x3::staking_pool::StakedSui>(&v0.staked_suis)) {
            let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<0x3::staking_pool::StakedSui>(&v0.staked_suis, v2);
            v1.total_staked = v1.total_staked + 0x3::staking_pool::staked_sui_amount(v3);
            v1.rewards = v1.rewards + calculate_staked_sui_rewards(arg1, v3, 0x2::tx_context::epoch(arg3));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_current_validator_staked_info_detail_single(arg0: &Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) : ValidatorStakedInfoV2 {
        let v0 = 0x2::table::borrow<address, PoolInfo>(&arg0.pools, arg2);
        let v1 = ValidatorStakedInfoV2{
            validator                        : arg2,
            total_staked                     : v0.total_staked,
            rewards                          : v0.rewards,
            staked_sui_count                 : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<0x3::staking_pool::StakedSui>(&v0.staked_suis),
            pool_id                          : 0x2::object::id<Staking>(arg0),
            exchange_rates_unexisted_epoches : vector[],
            stake_activation_epoches         : vector[],
        };
        if (v1.staked_sui_count == 0) {
            return v1
        };
        if (arg3) {
            v1.total_staked = 0;
            v1.rewards = 0;
        };
        let v2 = 0x2::vec_map::empty<u64, u64>();
        let v3 = 0x2::tx_context::epoch(arg4);
        let v4 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<0x3::staking_pool::StakedSui>(&v0.staked_suis);
        while (v4 < 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<0x3::staking_pool::StakedSui>(&v0.staked_suis)) {
            let v5 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<0x3::staking_pool::StakedSui>(&v0.staked_suis, v4);
            if (arg3) {
                v1.total_staked = v1.total_staked + 0x3::staking_pool::staked_sui_amount(v5);
                let v6 = calculate_staked_sui_rewards(arg1, v5, v3);
                v1.rewards = v1.rewards + v6;
            };
            let v7 = 0x3::staking_pool::stake_activation_epoch(v5);
            v1.pool_id = 0x3::staking_pool::pool_id(v5);
            let v8 = 0x3::sui_system::pool_exchange_rates(arg1, &v1.pool_id);
            if (!0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v8, v3)) {
                if (!0x2::vec_map::contains<u64, u64>(&v2, &v3)) {
                    0x1::vector::push_back<u64>(&mut v1.exchange_rates_unexisted_epoches, v3);
                    0x2::vec_map::insert<u64, u64>(&mut v2, v3, 0);
                };
            };
            if (!0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v8, v7)) {
                if (!0x2::vec_map::contains<u64, u64>(&v2, &v7)) {
                    0x1::vector::push_back<u64>(&mut v1.exchange_rates_unexisted_epoches, v7);
                    0x2::vec_map::insert<u64, u64>(&mut v2, v7, 0);
                };
            };
            0x1::vector::push_back<u64>(&mut v1.stake_activation_epoches, v7);
            v4 = v4 + 1;
        };
        v1
    }

    public fun get_current_validator_staked_info_detail_vector(arg0: &Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: bool, arg3: &0x2::tx_context::TxContext) : vector<ValidatorStakedInfoV2> {
        let v0 = 0x1::vector::empty<ValidatorStakedInfoV2>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.validators)) {
            let v2 = *0x1::vector::borrow<address>(&arg0.validators, v1);
            v1 = v1 + 1;
            0x1::vector::push_back<ValidatorStakedInfoV2>(&mut v0, get_current_validator_staked_info_detail_single(arg0, arg1, v2, arg2, arg3));
        };
        v0
    }

    public fun get_exchange_rate(arg0: &Staking) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.stsui_supply == 0) {
            return 1000000
        };
        (((v0 as u128) * (1000000 as u128) / (arg0.stsui_supply as u128)) as u64)
    }

    public fun get_protocol_sui_vault_amount(arg0: &Staking) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::vault_amount<0x2::sui::SUI>(&arg0.protocol_sui_vault)
    }

    public fun get_service_sui_vault_amount(arg0: &Staking) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::vault_amount<0x2::sui::SUI>(&arg0.service_sui_vault)
    }

    fun get_split_amount(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = 0x3::staking_pool::staked_sui_amount(arg1);
        let v1 = v0 + calculate_staked_sui_rewards(arg0, arg1, arg3);
        if (v1 <= arg2) {
            (0, v0)
        } else {
            let v4 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::util::mul_div(arg2, v0, v1) + 1;
            let v5 = v4;
            let v6 = if (v0 >= v4) {
                v0 - v4
            } else {
                v5 = v0;
                0
            };
            if (v5 >= 1000000000) {
                if (v6 >= 1000000000) {
                    (v6, v5)
                } else {
                    (0, v0)
                }
            } else if (v0 >= 2 * 1000000000) {
                (v0 - 1000000000, 1000000000)
            } else {
                (0, v0)
            }
        }
    }

    public fun get_staked_validator(arg0: &Staking, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.validators, &arg1)
    }

    public fun get_staked_validators(arg0: &Staking) : vector<address> {
        arg0.validators
    }

    public fun get_stsui_by_sui(arg0: &Staking, arg1: u64) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.stsui_supply == 0) {
            return arg1
        };
        (((arg0.stsui_supply as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    public fun get_stsui_supply(arg0: &Staking) : u64 {
        arg0.stsui_supply
    }

    public fun get_sui_by_stsui(arg0: &Staking, arg1: u64) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.stsui_supply == 0) {
            return arg1
        };
        (((v0 as u128) * (arg1 as u128) / (arg0.stsui_supply as u128)) as u64)
    }

    public fun get_sui_vault_amount(arg0: &Staking) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::vault_amount<0x2::sui::SUI>(&arg0.sui_vault)
    }

    public fun get_total_protocol_fees(arg0: &Staking) : u64 {
        arg0.total_protocol_fees
    }

    public fun get_total_rewards(arg0: &Staking) : u64 {
        arg0.total_rewards
    }

    public fun get_total_staked(arg0: &Staking) : u64 {
        arg0.total_staked
    }

    public fun get_total_sui(arg0: &Staking) : u64 {
        arg0.total_staked + arg0.total_rewards - arg0.total_protocol_fees - arg0.uncollected_protocol_fees - arg0.total_unstaked
    }

    public fun get_total_sui_cap(arg0: &Staking) : u64 {
        get_total_sui(arg0) + arg0.unclaimed_sui_amount
    }

    public fun get_total_unstaked(arg0: &Staking) : u64 {
        arg0.total_unstaked
    }

    public fun get_unclaimed_sui_amount(arg0: &Staking) : u64 {
        arg0.unclaimed_sui_amount
    }

    public fun get_uncollected_protocol_fees(arg0: &Staking) : u64 {
        arg0.uncollected_protocol_fees
    }

    public fun get_user_selected_staking(arg0: &mut Staking) : vector<UserSelectedStaking> {
        let v0 = 0x1::vector::empty<UserSelectedStaking>();
        let v1 = 0x2::vec_map::keys<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_selected_validator_bals);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x1::vector::borrow<address>(&v1, v2);
            let v4 = UserSelectedStaking{
                validator : *v3,
                amount    : 0x2::balance::value<0x2::sui::SUI>(0x2::vec_map::get<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_selected_validator_bals, v3)),
            };
            0x1::vector::push_back<UserSelectedStaking>(&mut v0, v4);
            v2 = v2 + 1;
        };
        v0
    }

    fun get_user_selected_validators(arg0: &mut Staking, arg1: &vector<address>) : (vector<address>, vector<0x2::balance::Balance<0x2::sui::SUI>>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::balance::Balance<0x2::sui::SUI>>();
        while (!0x2::vec_map::is_empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_selected_validator_bals)) {
            let (v3, v4) = 0x2::vec_map::pop<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_selected_validator_bals);
            let v5 = v4;
            if (is_active_validator(v3, arg1)) {
                if (0x2::balance::value<0x2::sui::SUI>(&v5) >= 1000000000) {
                    0x1::vector::push_back<address>(&mut v1, v3);
                    0x1::vector::push_back<0x2::balance::Balance<0x2::sui::SUI>>(&mut v2, v5);
                    continue
                };
                0x2::balance::join<0x2::sui::SUI>(&mut v0, v5);
                continue
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v5);
        };
        (v1, v2, v0)
    }

    public fun get_validator_staked_info(arg0: &Staking) : vector<ValidatorStakedInfo> {
        let v0 = 0x1::vector::empty<ValidatorStakedInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.validators)) {
            let v2 = *0x1::vector::borrow<address>(&arg0.validators, v1);
            v1 = v1 + 1;
            let v3 = 0x2::table::borrow<address, PoolInfo>(&arg0.pools, v2);
            let v4 = ValidatorStakedInfo{
                validator        : v2,
                total_staked     : v3.total_staked,
                rewards          : v3.rewards,
                staked_sui_count : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<0x3::staking_pool::StakedSui>(&v3.staked_suis),
            };
            0x1::vector::push_back<ValidatorStakedInfo>(&mut v0, v4);
        };
        v0
    }

    public fun get_version(arg0: &Staking) : u64 {
        arg0.version
    }

    public fun import_stake_sui_vec(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: vector<0x3::staking_pool::StakedSui>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        while (0x1::vector::length<0x3::staking_pool::StakedSui>(&arg2) > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x3::sui_system::request_withdraw_stake_non_entry(arg0, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut arg2), arg4));
        };
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(arg2);
        let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4);
        request_stake_coin(arg0, arg1, v1, arg3, arg4)
    }

    public(friend) fun initialize(arg0: 0x2::coin::TreasuryCap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Staking{
            id                           : 0x2::object::new(arg1),
            version                      : 5,
            config                       : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::new(0, 1000000, 0, 900000, 72000000, 10),
            sui_vault                    : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::new<0x2::sui::SUI>(arg1),
            claim_sui_vault              : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::new<0x2::sui::SUI>(arg1),
            protocol_sui_vault           : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::new<0x2::sui::SUI>(arg1),
            service_sui_vault            : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::new<0x2::sui::SUI>(arg1),
            stsui_treasury_cap           : arg0,
            unstake_epochs               : 0x1::vector::empty<EpochClaim>(),
            total_staked                 : 0,
            total_unstaked               : 0,
            total_rewards                : 0,
            total_protocol_fees          : 0,
            uncollected_protocol_fees    : 0,
            stsui_supply                 : 0,
            unclaimed_sui_amount         : 0,
            pause_stake                  : false,
            pause_unstake                : false,
            validators                   : 0x1::vector::empty<address>(),
            pools                        : 0x2::table::new<address, PoolInfo>(arg1),
            user_selected_validator_bals : 0x2::vec_map::empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(),
            rewards_last_updated_epoch   : 0,
        };
        0x2::transfer::share_object<Staking>(v0);
    }

    public fun inject_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 20);
        assert!(arg1.stsui_supply > 0, 1);
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::deposit<0x2::sui::SUI>(&mut arg1.sui_vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.total_rewards = arg1.total_rewards + v0;
        let v1 = RewardsInjected{
            owner      : 0x2::tx_context::sender(arg3),
            sui_amount : v0,
        };
        0x2::event::emit<RewardsInjected>(v1);
        let v2 = SuiRewardsUpdated{
            old : arg1.total_rewards,
            new : arg1.total_rewards,
            fee : 0,
        };
        0x2::event::emit<SuiRewardsUpdated>(v2);
        let v3 = ExchangeRateUpdated{
            old : get_exchange_rate(arg1),
            new : get_exchange_rate(arg1),
        };
        0x2::event::emit<ExchangeRateUpdated>(v3);
    }

    fun is_active_validator(arg0: address, arg1: &vector<address>) : bool {
        0x1::vector::contains<address>(arg1, &arg0)
    }

    public(friend) fun migrate(arg0: &mut Staking) {
        assert!(arg0.version < 5, 1);
        let v0 = VersionUpdated{
            old : arg0.version,
            new : 5,
        };
        0x2::event::emit<VersionUpdated>(v0);
        arg0.version = 5;
    }

    public fun query_pause_claim(arg0: &Staking) : bool {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg0.id, b"pause_claim_key")) {
            return *0x2::dynamic_field::borrow<vector<u8>, bool>(&arg0.id, b"pause_claim_key")
        };
        false
    }

    public fun request_stake_coin(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert_version(arg1);
        assert!(!arg1.pause_stake, 12);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 1000000000, 4);
        let v1 = get_stsui_by_sui(arg1, v0);
        assert!(v1 > 0, 5);
        let v2 = 0x2::coin::mint<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg1.stsui_treasury_cap, v1, arg4);
        let v3 = 0x3::sui_system::active_validator_addresses(arg0);
        if (arg3 == @0x0 || !is_active_validator(arg3, &v3)) {
            0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::deposit<0x2::sui::SUI>(&mut arg1.sui_vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        } else {
            save_user_selected_staking(arg1, arg2, arg3);
        };
        arg1.total_staked = arg1.total_staked + v0;
        arg1.stsui_supply = 0x2::coin::total_supply<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1.stsui_treasury_cap);
        let v4 = UserStaked{
            owner      : 0x2::tx_context::sender(arg4),
            sui_amount : v0,
            st_amount  : v1,
            validator  : arg3,
        };
        0x2::event::emit<UserStaked>(v4);
        v2
    }

    public fun request_unstake_delay(arg0: &mut Staking, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.pause_unstake, 13);
        let v0 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg2);
        let v1 = get_sui_by_stsui(arg0, v0);
        assert!(v0 > 0, 11);
        assert!(v1 <= get_total_sui(arg0) && v1 >= 1000000000, 8);
        let v2 = 0x2::tx_context::epoch(arg3);
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v4 = 0x2::clock::timestamp_ms(arg1);
        let v5 = 86400000;
        let v6 = v5;
        let v7 = v2 + 1;
        let v8 = v7;
        if (v4 > v3 + 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::get_withdraw_time_limit(&arg0.config)) {
            v8 = v7 + 1;
            v6 = v5 + 86400000;
        };
        let v9 = UnstakeTicket{
            id                   : 0x2::object::new(arg3),
            unstake_timestamp_ms : v4,
            st_amount            : v0,
            sui_amount           : v1,
            claim_epoch          : v8,
            claim_timestamp_ms   : v3 + v6,
        };
        let v10 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<UnstakeTicket>(v9, v10);
        0x2::coin::burn<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.stsui_treasury_cap, arg2);
        let v11 = UserNormalUnstaked{
            owner                : v10,
            epoch                : v2,
            epoch_timestamp_ms   : v3,
            unstake_timestamp_ms : v4,
            sui_amount           : v1,
            st_amount            : v0,
        };
        0x2::event::emit<UserNormalUnstaked>(v11);
        arg0.total_unstaked = arg0.total_unstaked + v1;
        arg0.stsui_supply = 0x2::coin::total_supply<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.stsui_treasury_cap);
        arg0.unclaimed_sui_amount = arg0.unclaimed_sui_amount + v1;
    }

    public fun request_unstake_instant(arg0: &mut Staking, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun request_unstake_instant_coin(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg1);
        assert!(!arg1.pause_unstake, 13);
        let v0 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg2);
        let v1 = get_sui_by_stsui(arg1, v0);
        assert!(v0 > 0, 11);
        assert!(v1 <= get_total_sui(arg1) && v1 >= 1000000000, 8);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = withdraw_sui(arg0, arg1, v1, true, arg3);
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::deposit<0x2::sui::SUI>(&mut arg1.service_sui_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v3, (((v1 as u128) * (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::get_service_fee(&arg1.config) as u128) / (10000000 as u128)) as u64)));
        0x2::coin::burn<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg1.stsui_treasury_cap, arg2);
        let v4 = UserInstantUnstaked{
            owner      : v2,
            sui_amount : v1,
            st_amount  : v0,
        };
        0x2::event::emit<UserInstantUnstaked>(v4);
        arg1.total_unstaked = arg1.total_unstaked + v1;
        arg1.stsui_supply = 0x2::coin::total_supply<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1.stsui_treasury_cap);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3)
    }

    public fun request_unstake_instant_v2(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = request_unstake_instant_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun save_user_selected_staking(arg0: &mut Staking, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address) {
        if (!0x2::vec_map::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_selected_validator_bals, &arg2)) {
            0x2::vec_map::insert<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_selected_validator_bals, arg2, 0x2::balance::zero<0x2::sui::SUI>());
        };
        0x2::balance::join<0x2::sui::SUI>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_selected_validator_bals, &arg2), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun sort_validators(arg0: &mut Staking, arg1: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg0.validators);
        assert!(0x1::vector::length<address>(&arg1) == v0, 18);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::contains<address>(&arg1, 0x1::vector::borrow<address>(&arg0.validators, v1)), 19);
            v1 = v1 + 1;
        };
        arg0.validators = arg1;
    }

    fun stake_to_validator(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: &mut Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, PoolInfo>(&arg1.pools, arg3)) {
            let v0 = PoolInfo{
                staked_suis  : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::empty<0x3::staking_pool::StakedSui>(arg4),
                total_staked : 0,
                rewards      : 0,
            };
            0x2::table::add<address, PoolInfo>(&mut arg1.pools, arg3, v0);
            0x1::vector::push_back<address>(&mut arg1.validators, arg3);
        };
        let v1 = 0x2::table::borrow_mut<address, PoolInfo>(&mut arg1.pools, arg3);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0);
        v1.total_staked = v1.total_staked + v2;
        let v3 = 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg4), arg3, arg4);
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::push_back<0x3::staking_pool::StakedSui>(&mut v1.staked_suis, v3);
        let v4 = SystemStaked{
            staked_sui_id : 0x2::object::id<0x3::staking_pool::StakedSui>(&v3),
            epoch         : 0x2::tx_context::epoch(arg4),
            sui_amount    : v2,
            validator     : arg3,
        };
        0x2::event::emit<SystemStaked>(v4);
    }

    fun stake_user_selected_validators(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &vector<address>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (v0, v1, v2) = get_user_selected_validators(arg0, arg2);
        let v3 = v1;
        let v4 = v0;
        while (0x1::vector::length<0x2::balance::Balance<0x2::sui::SUI>>(&v3) > 0) {
            stake_to_validator(0x1::vector::pop_back<0x2::balance::Balance<0x2::sui::SUI>>(&mut v3), arg0, arg1, 0x1::vector::pop_back<address>(&mut v4), arg3);
        };
        0x1::vector::destroy_empty<0x2::balance::Balance<0x2::sui::SUI>>(v3);
        v2
    }

    public fun ticket_claim_epoch(arg0: &UnstakeTicket) : u64 {
        arg0.claim_epoch
    }

    public fun ticket_claim_timestamp_ms(arg0: &UnstakeTicket) : u64 {
        arg0.claim_timestamp_ms
    }

    public fun ticket_st_amount(arg0: &UnstakeTicket) : u64 {
        arg0.st_amount
    }

    public fun ticket_sui_amount(arg0: &UnstakeTicket) : u64 {
        arg0.sui_amount
    }

    public fun ticket_unstake_timestamp_ms(arg0: &UnstakeTicket) : u64 {
        arg0.unstake_timestamp_ms
    }

    public(friend) fun toggle_claim(arg0: &mut Staking, arg1: bool) {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg0.id, b"pause_claim_key")) {
            0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"pause_claim_key", arg1);
        } else {
            *0x2::dynamic_field::borrow_mut<vector<u8>, bool>(&mut arg0.id, b"pause_claim_key") = arg1;
        };
    }

    public(friend) fun toggle_stake(arg0: &mut Staking, arg1: bool) {
        arg0.pause_stake = arg1;
    }

    public(friend) fun toggle_unstake(arg0: &mut Staking, arg1: bool) {
        arg0.pause_unstake = arg1;
    }

    public(friend) fun unstake_from_validator(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = &mut v1;
        do_validator_unstake(arg0, arg1, v2, arg2, arg3, v0, arg4);
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::deposit<0x2::sui::SUI>(&mut arg0.sui_vault, v1);
    }

    public(friend) fun unstake_inactive_validators(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::sui_system::active_validator_addresses(arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.validators)) {
            let v3 = *0x1::vector::borrow<address>(&arg0.validators, v2);
            if (!is_active_validator(v3, &v0)) {
                0x1::vector::push_back<address>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        if (0x1::vector::length<address>(&v1) > 0) {
            unstake_validator_pools(arg0, arg1, v1, arg2);
        };
    }

    public(friend) fun unstake_validator_pools(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = &mut v1;
            do_validator_unstake(arg0, arg1, v3, *0x1::vector::borrow<address>(&arg2, v2), 18446744073709551615, v0, arg3);
            v2 = v2 + 1;
        };
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::deposit<0x2::sui::SUI>(&mut arg0.sui_vault, v1);
    }

    public(friend) fun update_total_rewards_onchain(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::tx_context::epoch(arg2);
        if (arg0.rewards_last_updated_epoch >= v1) {
            return
        };
        let v2 = arg0.validators;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg0.validators)) {
            let v4 = *0x1::vector::borrow<address>(&v2, v3);
            v3 = v3 + 1;
            let v5 = 0x2::table::borrow_mut<address, PoolInfo>(&mut arg0.pools, v4);
            v0 = v0 + calculate_validator_pool_rewards_increase(arg1, v5, v1);
        };
        let v6 = (((v0 as u128) * (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::get_reward_fee(&arg0.config) as u128) / (10000000 as u128)) as u64);
        arg0.uncollected_protocol_fees = arg0.uncollected_protocol_fees + v6;
        arg0.total_rewards = arg0.total_rewards + v0;
        let v7 = SuiRewardsUpdated{
            old : arg0.total_rewards,
            new : arg0.total_rewards,
            fee : v6,
        };
        0x2::event::emit<SuiRewardsUpdated>(v7);
        let v8 = ExchangeRateUpdated{
            old : get_exchange_rate(arg0),
            new : get_exchange_rate(arg0),
        };
        0x2::event::emit<ExchangeRateUpdated>(v8);
        arg0.rewards_last_updated_epoch = v1;
    }

    public(friend) fun update_validator_rewards(arg0: &mut Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, PoolInfo>(&arg0.pools, arg2)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, PoolInfo>(&mut arg0.pools, arg2);
        let v1 = 0 + calculate_validator_pool_rewards_increase(arg1, v0, 0x2::tx_context::epoch(arg3));
        let v2 = (((v1 as u128) * (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::get_reward_fee(&arg0.config) as u128) / (10000000 as u128)) as u64);
        arg0.uncollected_protocol_fees = arg0.uncollected_protocol_fees + v2;
        arg0.total_rewards = arg0.total_rewards + v1;
        let v3 = SuiRewardsUpdated{
            old : arg0.total_rewards,
            new : arg0.total_rewards,
            fee : v2,
        };
        0x2::event::emit<SuiRewardsUpdated>(v3);
        let v4 = ExchangeRateUpdated{
            old : get_exchange_rate(arg0),
            new : get_exchange_rate(arg0),
        };
        0x2::event::emit<ExchangeRateUpdated>(v4);
    }

    fun withdraw_staked_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x3::staking_pool::staked_sui_amount(&arg1);
        let v1 = calculate_staked_sui_rewards(arg0, &arg1, 0x2::tx_context::epoch(arg3));
        let v2 = 0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v2) == v0 + v1, 2);
        0x2::balance::join<0x2::sui::SUI>(arg2, v2);
        (v0, v1)
    }

    fun withdraw_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut Staking, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (v0, v1) = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::withdraw_max<0x2::sui::SUI>(&mut arg1.sui_vault, arg2);
        let v2 = v0;
        arg2 = v1;
        if (arg3) {
            let v3 = 0x2::vec_map::keys<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.user_selected_validator_bals);
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(&v3) && arg2 > 0) {
                let v5 = *0x1::vector::borrow<address>(&v3, v4);
                let v6 = 0x2::vec_map::get_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.user_selected_validator_bals, &v5);
                let v7 = 0x2::balance::value<0x2::sui::SUI>(v6);
                if (v7 > 0) {
                    if (v7 >= arg2) {
                        0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::balance::split<0x2::sui::SUI>(v6, arg2));
                        arg2 = 0;
                    } else {
                        arg2 = arg2 - v7;
                        0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::balance::withdraw_all<0x2::sui::SUI>(v6));
                    };
                };
                v4 = v4 + 1;
            };
        };
        if (arg2 > 0) {
            let v8 = 0x2::balance::zero<0x2::sui::SUI>();
            let v9 = 0x2::tx_context::epoch(arg4);
            let v10 = arg1.validators;
            let v11 = 0;
            while (v11 < 0x1::vector::length<address>(&v10) && arg2 > 0) {
                let v12 = &mut v8;
                arg2 = do_validator_unstake(arg1, arg0, v12, *0x1::vector::borrow<address>(&v10, v11), arg2, v9, arg4);
                v11 = v11 + 1;
            };
            assert!(arg2 == 0, 16);
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::balance::split<0x2::sui::SUI>(&mut v8, arg2));
            0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::vault::deposit<0x2::sui::SUI>(&mut arg1.sui_vault, v8);
        };
        v2
    }

    // decompiled from Move bytecode v6
}

