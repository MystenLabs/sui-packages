module 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault {
    struct DSuiVault has key {
        id: 0x2::object::UID,
        dsui_kraft_cap: 0x2::coin::TreasuryCap<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>,
        config_params: ConfigParams,
        whitelisted_validators: vector<address>,
        validator_pools: 0x2::linked_table::LinkedTable<address, ValidatorPool>,
        selected_validator_mapping: 0x2::linked_table::LinkedTable<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        sui_to_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        hive_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        unstaked_sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        unstake_epochs: 0x2::linked_table::LinkedTable<u64, RequestsForEpoch>,
        total_sui_supply: u64,
        dsui_supply: u64,
        sui_to_unstake: u64,
        uncollected_protocol_fees: u64,
        last_refresh_epoch: u64,
        sui_claimable_per_dsui: u128,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct UnstakeRequest has store, key {
        id: 0x2::object::UID,
        dsui_amount: u64,
        sui_amount: u64,
        requested_at_epoch: u64,
    }

    struct ConfigParams has store {
        pause_stake: bool,
        protocol_fee_percent: u64,
        redeem_fee_bps: u64,
        unstake_delay_epoches: u64,
        treasury_percent: u64,
    }

    struct ValidatorPool has store {
        staking_pool_id: 0x2::object::ID,
        validator_address: address,
        active_stake: 0x1::option::Option<0x3::staking_pool::FungibleStakedSui>,
        inactive_stake: 0x1::option::Option<0x3::staking_pool::StakedSui>,
        exchange_rate: 0x3::staking_pool::PoolTokenExchangeRate,
        total_sui_amount: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct RequestsForEpoch has store {
        amount: u64,
        approved: bool,
    }

    struct ValidatorListUpdated has copy, drop {
        validator_list: vector<address>,
        to_add: bool,
    }

    struct DegenSUIFeeStructureUpdated has copy, drop {
        protocol_fee_percent: u64,
        treasury_percent: u64,
        redeem_fee_bps: u64,
        unstake_delay_epoches: u64,
    }

    struct EmergencyPauseUpdate has copy, drop {
        pause_stake: bool,
    }

    struct StakeSuiRequest has copy, drop {
        staker: address,
        sui_to_stake: u64,
        dsui_krafted: u64,
        sui_claimable_per_dsui: u128,
        cur_epoch: u64,
    }

    struct UserUnstakedInstantly has copy, drop {
        owner: address,
        sui_withdrawn: u64,
        dsui_burnt: u64,
        redemption_fees: u64,
        sui_claimable_per_dsui: u128,
        cur_epoch: u64,
    }

    struct UserUnstakeRequest has copy, drop {
        owner: address,
        unstake_epoch: u64,
        sui_to_claim: u64,
        dsui_burnt: u64,
        sui_claimable_per_dsui: u128,
        cur_epoch: u64,
    }

    struct UserClaimedSui has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        sui_withdrawn: u64,
        net_sui_withdrawn: u64,
        redemption_fees: u64,
        sui_claimable_per_dsui: u128,
        cur_epoch: u64,
    }

    struct RequestsForEpochDestroyed has copy, drop {
        epoch: u64,
    }

    struct StakeWithSelectedValidatorRequestProcessed has copy, drop {
        validator_addr: address,
        sui_to_stake_amt: u64,
        cur_epoch: u64,
    }

    struct StakeOperationProcessed has copy, drop {
        validator_addr: address,
        sui_to_stake_amt: u64,
        cur_epoch: u64,
    }

    struct StakeSuiRequestsProcessed has copy, drop {
        cur_epoch: u64,
        total_sui_staked: u64,
        sui_to_unstaked_for_requests: u64,
        protocol_fee_collected: u64,
        sui_claimable_per_dsui: u128,
    }

    struct TotalRewardsUpdated has copy, drop {
        cur_epoch: u64,
        old_sui_supply: u64,
        new_sui_supply: u64,
        dsui_supply: u64,
        fees_charged: u64,
    }

    struct ValidatorPoolDestroyed has copy, drop {
        validator_address: address,
    }

    struct LsdFeeCollected has copy, drop {
        collected_fees_amt: u64,
        treasury_fees: u64,
        sui_for_buyback: u64,
    }

    public fun admin_emergency_pause_update(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DeployerCap, arg1: &mut DSuiVault, arg2: bool) {
        assert!(arg1.version == 0, 9002);
        arg1.config_params.pause_stake = arg2;
        let v0 = EmergencyPauseUpdate{pause_stake: arg1.config_params.pause_stake};
        0x2::event::emit<EmergencyPauseUpdate>(v0);
    }

    public entry fun claim_collected_lsd_fee(arg0: &mut DSuiVault, arg1: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg2: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9002);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.hive_fee_vault);
        let v1 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u128((v0 as u128), (arg0.config_params.treasury_percent as u128), (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::constants::percent_precision() as u128));
        if (v1 > 0) {
            0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::add_to_treasury(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.hive_fee_vault, v1));
        };
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg2, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.hive_fee_vault));
        let v2 = LsdFeeCollected{
            collected_fees_amt : v0,
            treasury_fees      : v1,
            sui_for_buyback    : 0x2::balance::value<0x2::sui::SUI>(&arg0.hive_fee_vault),
        };
        0x2::event::emit<LsdFeeCollected>(v2);
    }

    fun claim_unstake_epoch(arg0: &mut DSuiVault, arg1: u64, arg2: u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, RequestsForEpoch>(&mut arg0.unstake_epochs, arg1);
        assert!(v0.approved, 9007);
        v0.amount = v0.amount - arg2;
        if (v0.amount == 0) {
            let (_, _) = destroy_unstake_epoch(arg1, 0x2::linked_table::remove<u64, RequestsForEpoch>(&mut arg0.unstake_epochs, arg1));
        };
    }

    public fun claim_unstaked_sui(arg0: &mut DSuiVault, arg1: UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.version == 0, 9002);
        assert!(!arg0.config_params.pause_stake, 9003);
        let (v0, _, v2, v3) = destroy_ticket(arg1);
        assert!(v3 + arg0.config_params.unstake_delay_epoches <= 0x2::tx_context::epoch(arg2), 9008);
        claim_unstake_epoch(arg0, v3, v2);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.unstaked_sui_reserve, v2);
        let v5 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(v2, arg0.config_params.redeem_fee_bps, 10000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.hive_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v5));
        let v6 = UserClaimedSui{
            id                     : v0,
            owner                  : 0x2::tx_context::sender(arg2),
            sui_withdrawn          : v2,
            net_sui_withdrawn      : 0x2::balance::value<0x2::sui::SUI>(&v4),
            redemption_fees        : v5,
            sui_claimable_per_dsui : get_sui_claimable_per_dsui(arg0),
            cur_epoch              : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<UserClaimedSui>(v6);
        v4
    }

    fun destroy_ticket(arg0: UnstakeRequest) : (0x2::object::ID, u64, u64, u64) {
        let UnstakeRequest {
            id                 : v0,
            dsui_amount        : v1,
            sui_amount         : v2,
            requested_at_epoch : v3,
        } = arg0;
        let v4 = v0;
        0x2::object::delete(v4);
        (0x2::object::uid_to_inner(&v4), v1, v2, v3)
    }

    fun destroy_unstake_epoch(arg0: u64, arg1: RequestsForEpoch) : (u64, bool) {
        let RequestsForEpoch {
            amount   : v0,
            approved : v1,
        } = arg1;
        let v2 = RequestsForEpochDestroyed{epoch: arg0};
        0x2::event::emit<RequestsForEpochDestroyed>(v2);
        (v0, v1)
    }

    fun destroy_validator_pool(arg0: &mut DSuiVault, arg1: address) {
        let ValidatorPool {
            staking_pool_id   : _,
            validator_address : _,
            active_stake      : v2,
            inactive_stake    : v3,
            exchange_rate     : _,
            total_sui_amount  : _,
            extra_fields      : v6,
        } = 0x2::linked_table::remove<address, ValidatorPool>(&mut arg0.validator_pools, arg1);
        0x1::option::destroy_none<0x3::staking_pool::FungibleStakedSui>(v2);
        0x1::option::destroy_none<0x3::staking_pool::StakedSui>(v3);
        0x2::bag::destroy_empty(v6);
        let v7 = ValidatorPoolDestroyed{validator_address: arg1};
        0x2::event::emit<ValidatorPoolDestroyed>(v7);
    }

    public fun emergency_pause_update(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: &mut DSuiVault, arg2: bool) {
        assert!(arg1.version == 0, 9002);
        arg1.config_params.pause_stake = arg2;
        let v0 = EmergencyPauseUpdate{pause_stake: arg1.config_params.pause_stake};
        0x2::event::emit<EmergencyPauseUpdate>(v0);
    }

    fun extract_from_active_stake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut ValidatorPool, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x3::sui_system::redeem_fungible_staked_sui(arg0, 0x1::option::extract<0x3::staking_pool::FungibleStakedSui>(&mut arg1.active_stake), arg2)
    }

    fun extract_inactive_stake(arg0: &mut ValidatorPool) : 0x3::staking_pool::StakedSui {
        0x1::option::extract<0x3::staking_pool::StakedSui>(&mut arg0.inactive_stake)
    }

    public fun get_dsui_by_sui(arg0: &DSuiVault, arg1: u64) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.dsui_supply == 0) {
            return arg1
        };
        (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg1 as u256), (arg0.dsui_supply as u256), (v0 as u256)) as u64)
    }

    fun get_latest_exchange_rate(arg0: &0x2::object::ID, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x1::option::Option<0x3::staking_pool::PoolTokenExchangeRate> {
        let v0 = 0x3::sui_system::pool_exchange_rates(arg1, arg0);
        let v1 = 0x2::tx_context::epoch(arg3);
        while (v1 > arg2) {
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, v1)) {
                return 0x1::option::some<0x3::staking_pool::PoolTokenExchangeRate>(*0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, v1))
            };
            v1 = v1 - 1;
        };
        0x1::option::none<0x3::staking_pool::PoolTokenExchangeRate>()
    }

    fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        let v0 = 0x3::staking_pool::sui_amount(arg0);
        let v1 = 0x3::staking_pool::pool_token_amount(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v0 as u256), (arg1 as u256), (v1 as u256)) as u64)
    }

    public fun get_sui_by_dsui(arg0: &DSuiVault, arg1: u64) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.dsui_supply == 0) {
            return arg1
        };
        (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v0 as u256), (arg1 as u256), (arg0.dsui_supply as u256)) as u64)
    }

    public fun get_sui_claimable_per_dsui(arg0: &DSuiVault) : u128 {
        let v0 = get_total_sui(arg0);
        let v1 = arg0.dsui_supply;
        if (v0 == 0 || v1 == 0) {
            return (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::constants::lsd_exchange_rate_precision() as u128)
        };
        (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v0 as u256), (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::constants::lsd_exchange_rate_precision() as u256), (v1 as u256)) as u128)
    }

    public fun get_total_sui(arg0: &DSuiVault) : u64 {
        let v0 = *0x2::linked_table::front<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping);
        let v1 = 0;
        while (0x1::option::is_some<address>(&v0)) {
            let v2 = *0x1::option::borrow<address>(&v0);
            v1 = v1 + 0x2::balance::value<0x2::sui::SUI>(0x2::linked_table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, v2));
            v0 = *0x2::linked_table::next<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, v2);
        };
        let v3 = arg0.total_sui_supply + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_to_stake) + v1;
        let v4 = arg0.uncollected_protocol_fees + arg0.sui_to_unstake;
        if (v3 < v4) {
            0
        } else {
            v3 - v4
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_dsui_vault(arg0: 0x2::coin::TreasuryCap<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigParams{
            pause_stake           : false,
            protocol_fee_percent  : 1000,
            redeem_fee_bps        : 1,
            unstake_delay_epoches : 0,
            treasury_percent      : 10,
        };
        let v1 = DSuiVault{
            id                         : 0x2::object::new(arg1),
            dsui_kraft_cap             : arg0,
            config_params              : v0,
            whitelisted_validators     : 0x1::vector::empty<address>(),
            validator_pools            : 0x2::linked_table::new<address, ValidatorPool>(arg1),
            selected_validator_mapping : 0x2::linked_table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg1),
            sui_to_stake               : 0x2::balance::zero<0x2::sui::SUI>(),
            hive_fee_vault             : 0x2::balance::zero<0x2::sui::SUI>(),
            unstaked_sui_reserve       : 0x2::balance::zero<0x2::sui::SUI>(),
            unstake_epochs             : 0x2::linked_table::new<u64, RequestsForEpoch>(arg1),
            total_sui_supply           : 0,
            dsui_supply                : 0,
            sui_to_unstake             : 0,
            uncollected_protocol_fees  : 0,
            last_refresh_epoch         : 0x2::tx_context::epoch(arg1),
            sui_claimable_per_dsui     : (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::constants::lsd_exchange_rate_precision() as u128),
            bag                        : 0x2::bag::new(arg1),
            version                    : 0,
        };
        0x2::transfer::share_object<DSuiVault>(v1);
    }

    fun is_empty(arg0: &ValidatorPool) : bool {
        0x1::option::is_none<0x3::staking_pool::FungibleStakedSui>(&arg0.active_stake) && 0x1::option::is_none<0x3::staking_pool::StakedSui>(&arg0.inactive_stake) && arg0.total_sui_amount == 0
    }

    fun join_fungible_staked_sui_to_validator(arg0: &mut DSuiVault, arg1: address, arg2: 0x3::staking_pool::FungibleStakedSui) {
        let v0 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg0.validator_pools, arg1);
        if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            0x3::staking_pool::join_fungible_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::FungibleStakedSui>(&mut v0.active_stake), arg2);
        } else {
            0x1::option::fill<0x3::staking_pool::FungibleStakedSui>(&mut v0.active_stake, arg2);
        };
        refresh_validator_info(arg0, arg1);
    }

    public fun migrate(arg0: &mut DSuiVault) {
        assert!(arg0.version < 0, 9002);
        arg0.version = 0;
    }

    public fun process_stake_sui_requests(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9002);
        assert!(!arg1.config_params.pause_stake, 9003);
        let v0 = 0x2::tx_context::epoch(arg2);
        update_accrued_rewards(arg1, arg0, arg2);
        let v1 = 0x3::sui_system::active_validator_addresses(arg0);
        let (v2, v3) = stake_user_selected_validators(arg0, arg1, v1, arg2);
        let v4 = v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v3);
        let (v5, v6) = process_unstaking_requests(arg1, arg2);
        let v7 = v5 + v6;
        let v8 = 0x2::balance::zero<0x2::sui::SUI>();
        let v9 = if (v7 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v8, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v7));
            0
        } else {
            let v9 = v7 - 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake);
            0x2::balance::join<0x2::sui::SUI>(&mut v8, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_to_stake));
            v9
        };
        if (v9 > 0) {
            let v10 = unstake_sui_from_validators(arg1, arg0, v9, arg2);
            0x2::balance::join<0x2::sui::SUI>(&mut v8, v10);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v8, v5));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v8, v6));
        arg1.uncollected_protocol_fees = 0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v8);
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) > 0x1::vector::length<address>(&arg1.whitelisted_validators) * 1000000000) {
            let v11 = 0;
            let v12 = 0;
            while (v12 < 0x1::vector::length<address>(&arg1.whitelisted_validators)) {
                let v13 = *0x1::vector::borrow<address>(&arg1.whitelisted_validators, v12);
                if (0x1::vector::contains<address>(&v1, &v13)) {
                    v11 = v11 + 1;
                };
                v12 = v12 + 1;
            };
            assert!(v11 > 0, 9009);
            let v14 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) / v11;
            if (v14 > 1000000000) {
                let v15 = 0;
                while (v15 < 0x1::vector::length<address>(&arg1.whitelisted_validators) - 1) {
                    let v16 = *0x1::vector::borrow<address>(&arg1.whitelisted_validators, v15);
                    if (0x1::vector::contains<address>(&v1, &v16)) {
                        let v17 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v14);
                        v4 = v4 + v14;
                        stake_with_validator(arg0, arg1, v16, v17, arg2);
                    };
                    v15 = v15 + 1;
                };
                let v18 = *0x1::vector::borrow<address>(&arg1.whitelisted_validators, v15);
                if (0x1::vector::contains<address>(&v1, &v18)) {
                    let v19 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_to_stake);
                    v4 = v4 + 0x2::balance::value<0x2::sui::SUI>(&v19);
                    stake_with_validator(arg0, arg1, v18, v19, arg2);
                };
            };
        };
        arg1.sui_claimable_per_dsui = get_sui_claimable_per_dsui(arg1);
        let v20 = StakeSuiRequestsProcessed{
            cur_epoch                    : v0,
            total_sui_staked             : v4,
            sui_to_unstaked_for_requests : v5,
            protocol_fee_collected       : v6,
            sui_claimable_per_dsui       : get_sui_claimable_per_dsui(arg1),
        };
        0x2::event::emit<StakeSuiRequestsProcessed>(v20);
    }

    fun process_unstaking_requests(arg0: &mut DSuiVault, arg1: &0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0;
        let v1 = *0x2::linked_table::front<u64, RequestsForEpoch>(&arg0.unstake_epochs);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::extract<u64>(&mut v1);
            let v3 = 0x2::linked_table::borrow_mut<u64, RequestsForEpoch>(&mut arg0.unstake_epochs, v2);
            if (0x2::tx_context::epoch(arg1) >= v2 + arg0.config_params.unstake_delay_epoches && !v3.approved) {
                v0 = v0 + v3.amount;
                v3.approved = true;
                arg0.sui_to_unstake = arg0.sui_to_unstake - v3.amount;
            };
            v1 = *0x2::linked_table::next<u64, RequestsForEpoch>(&arg0.unstake_epochs, v2);
        };
        (v0, arg0.uncollected_protocol_fees)
    }

    public fun query_all_selected_validator_mapping(arg0: &DSuiVault, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<0x2::sui::SUI>(0x2::linked_table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, *v5)));
            v3 = *0x2::linked_table::next<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping))
    }

    public fun query_dsui_vault_config(arg0: &DSuiVault) : (bool, u64, u64, u64, u64) {
        (arg0.config_params.pause_stake, arg0.config_params.protocol_fee_percent, arg0.config_params.redeem_fee_bps, arg0.config_params.unstake_delay_epoches, arg0.config_params.treasury_percent)
    }

    public fun query_request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg1.version == 0, 9002);
        assert!(!arg1.config_params.pause_stake, 9003);
        update_accrued_rewards(arg1, arg0, arg3);
        let v0 = get_sui_by_dsui(arg1, arg2);
        assert!(arg1.config_params.unstake_delay_epoches > 0, 9015);
        assert!(v0 > 0 && v0 <= get_total_sui(arg1), 9006);
        (v0, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(v0, arg1.config_params.redeem_fee_bps, 10000))
    }

    public fun query_request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg1.version == 0, 9002);
        assert!(!arg1.config_params.pause_stake, 9003);
        update_accrued_rewards(arg1, arg0, arg3);
        let v0 = get_sui_by_dsui(arg1, arg2);
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) < v0) {
            assert!(arg1.config_params.unstake_delay_epoches == 0, 9014);
        };
        (v0, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(v0, arg1.config_params.redeem_fee_bps, 10000))
    }

    public fun query_selected_validator_mapping(arg0: &DSuiVault, arg1: address) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0x2::linked_table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, arg1))
    }

    public fun query_stake_sui_request(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.version == 0, 9002);
        assert!(!arg1.config_params.pause_stake, 9003);
        update_accrued_rewards(arg1, arg0, arg3);
        get_dsui_by_sui(arg1, arg2)
    }

    public fun query_unstake_request(arg0: &UnstakeRequest) : (u64, u64, u64) {
        (arg0.dsui_amount, arg0.sui_amount, arg0.requested_at_epoch)
    }

    public fun query_unstake_request_claim_epoch(arg0: &DSuiVault, arg1: &UnstakeRequest) : u64 {
        arg1.requested_at_epoch + arg0.config_params.unstake_delay_epoches
    }

    public fun query_unstake_request_for_epoch(arg0: &DSuiVault, arg1: u64) : (u64, bool) {
        let v0 = 0x2::linked_table::borrow<u64, RequestsForEpoch>(&arg0.unstake_epochs, arg1);
        (v0.amount, v0.approved)
    }

    public fun query_unstake_request_for_epochs(arg0: &DSuiVault, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<u64>, vector<bool>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<bool>();
        let v3 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, RequestsForEpoch>(&arg0.unstake_epochs)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<u64>(&v4) && v5 < arg2) {
            let v6 = 0x1::option::borrow<u64>(&v4);
            let v7 = 0x2::linked_table::borrow<u64, RequestsForEpoch>(&arg0.unstake_epochs, *v6);
            0x1::vector::push_back<u64>(&mut v0, *v6);
            0x1::vector::push_back<u64>(&mut v1, v7.amount);
            0x1::vector::push_back<bool>(&mut v2, v7.approved);
            v4 = *0x2::linked_table::next<u64, RequestsForEpoch>(&arg0.unstake_epochs, *v6);
            v5 = v5 + 1;
        };
        (v0, v1, v2, 0x2::linked_table::length<u64, RequestsForEpoch>(&arg0.unstake_epochs))
    }

    public fun query_validator_pool(arg0: &DSuiVault, arg1: address) : (0x2::object::ID, address, u64, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<address, ValidatorPool>(&arg0.validator_pools, arg1);
        let v1 = 0;
        let v2 = 0;
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) {
            v1 = 0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v0.inactive_stake));
            v2 = 0x3::staking_pool::stake_activation_epoch(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v0.inactive_stake));
        };
        let v3 = 0;
        let v4 = 0;
        if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            let v5 = 0x3::staking_pool::fungible_staked_sui_value(0x1::option::borrow<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake));
            v3 = v5;
            v4 = get_sui_amount(&v0.exchange_rate, v5);
        };
        (v0.staking_pool_id, v0.validator_address, v1, v2, v3, v4, v0.total_sui_amount)
    }

    public fun query_validator_pools(arg0: &DSuiVault, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<0x2::object::ID>, vector<address>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, ValidatorPool>(&arg0.validator_pools)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<address>(&v8) && v9 < arg2) {
            let v10 = 0x1::option::borrow<address>(&v8);
            let (v11, v12, v13, v14, v15, v16, v17) = query_validator_pool(arg0, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v11);
            0x1::vector::push_back<address>(&mut v1, v12);
            0x1::vector::push_back<u64>(&mut v2, v13);
            0x1::vector::push_back<u64>(&mut v3, v14);
            0x1::vector::push_back<u64>(&mut v4, v15);
            0x1::vector::push_back<u64>(&mut v5, v16);
            0x1::vector::push_back<u64>(&mut v6, v17);
            v8 = *0x2::linked_table::next<address, ValidatorPool>(&arg0.validator_pools, *v10);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<address, ValidatorPool>(&arg0.validator_pools))
    }

    public fun query_vault_overview(arg0: &DSuiVault) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u128) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_to_stake), 0x2::balance::value<0x2::sui::SUI>(&arg0.hive_fee_vault), 0x2::balance::value<0x2::sui::SUI>(&arg0.unstaked_sui_reserve), 0x2::linked_table::length<address, ValidatorPool>(&arg0.validator_pools), 0x2::linked_table::length<u64, RequestsForEpoch>(&arg0.unstake_epochs), arg0.total_sui_supply, arg0.dsui_supply, arg0.sui_to_unstake, arg0.uncollected_protocol_fees, arg0.last_refresh_epoch, arg0.sui_claimable_per_dsui)
    }

    public fun query_whitelisted_validators(arg0: &DSuiVault) : vector<address> {
        arg0.whitelisted_validators
    }

    fun refresh_validator_info(arg0: &mut DSuiVault, arg1: address) {
        let v0 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg0.validator_pools, arg1);
        arg0.total_sui_supply = arg0.total_sui_supply - v0.total_sui_amount;
        let v1 = 0;
        let v2 = v1;
        if (0x1::option::is_some<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            v2 = v1 + get_sui_amount(&v0.exchange_rate, 0x3::staking_pool::fungible_staked_sui_value(0x1::option::borrow<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)));
        };
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) {
            v2 = v2 + 0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v0.inactive_stake));
        };
        v0.total_sui_amount = v2;
        arg0.total_sui_supply = arg0.total_sui_supply + v2;
    }

    fun refresh_validator_pools(arg0: &mut DSuiVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (arg0.last_refresh_epoch == v0) {
            return false
        };
        let v1 = 0x3::sui_system::active_validator_addresses(arg1);
        let v2 = *0x2::linked_table::front<address, ValidatorPool>(&arg0.validator_pools);
        while (0x1::option::is_some<address>(&v2)) {
            let v3 = *0x1::option::borrow<address>(&v2);
            if (!0x1::vector::contains<address>(&v1, &v3)) {
                let v4 = unstake_sui_from_validator(arg0, arg1, v3, 10000000000000000000, arg2);
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_to_stake, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.unstaked_sui_reserve, v4));
            };
            if (is_empty(0x2::linked_table::borrow<address, ValidatorPool>(&arg0.validator_pools, v3))) {
                v2 = *0x2::linked_table::next<address, ValidatorPool>(&arg0.validator_pools, v3);
                destroy_validator_pool(arg0, v3);
                continue
            };
            let v5 = get_latest_exchange_rate(&0x2::linked_table::borrow<address, ValidatorPool>(&arg0.validator_pools, v3).staking_pool_id, arg1, arg0.last_refresh_epoch, arg2);
            if (0x1::option::is_some<0x3::staking_pool::PoolTokenExchangeRate>(&v5)) {
                0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg0.validator_pools, v3).exchange_rate = *0x1::option::borrow<0x3::staking_pool::PoolTokenExchangeRate>(&v5);
            };
            refresh_validator_info(arg0, v3);
            if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&0x2::linked_table::borrow<address, ValidatorPool>(&arg0.validator_pools, v3).inactive_stake)) {
                let v6 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg0.validator_pools, v3);
                if (v0 >= 0x3::staking_pool::stake_activation_epoch(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v6.inactive_stake))) {
                    join_fungible_staked_sui_to_validator(arg0, v3, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, extract_inactive_stake(v6), arg2));
                };
            };
            v2 = *0x2::linked_table::next<address, ValidatorPool>(&arg0.validator_pools, v3);
        };
        arg0.last_refresh_epoch = v0;
        true
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>, arg3: &mut 0x2::tx_context::TxContext) : UnstakeRequest {
        assert!(arg1.version == 0, 9002);
        assert!(!arg1.config_params.pause_stake, 9003);
        let v0 = 0x2::tx_context::epoch(arg3);
        update_accrued_rewards(arg1, arg0, arg3);
        let v1 = get_sui_by_dsui(arg1, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&arg2));
        assert!(v1 > 0 && v1 <= get_total_sui(arg1), 9006);
        assert!(arg1.config_params.unstake_delay_epoches > 0, 9015);
        if (0x2::linked_table::contains<u64, RequestsForEpoch>(&arg1.unstake_epochs, v0)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, RequestsForEpoch>(&mut arg1.unstake_epochs, v0);
            v2.amount = v2.amount + v1;
        } else {
            let v3 = RequestsForEpoch{
                amount   : v1,
                approved : false,
            };
            0x2::linked_table::push_back<u64, RequestsForEpoch>(&mut arg1.unstake_epochs, v0, v3);
        };
        let v4 = UnstakeRequest{
            id                 : 0x2::object::new(arg3),
            dsui_amount        : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&arg2),
            sui_amount         : v1,
            requested_at_epoch : v0,
        };
        0x2::coin::burn<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&mut arg1.dsui_kraft_cap, 0x2::coin::from_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(arg2, arg3));
        arg1.dsui_supply = 0x2::coin::total_supply<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&arg1.dsui_kraft_cap);
        arg1.sui_to_unstake = arg1.sui_to_unstake + v1;
        let v5 = get_sui_claimable_per_dsui(arg1);
        arg1.sui_claimable_per_dsui = v5;
        let v6 = UserUnstakeRequest{
            owner                  : 0x2::tx_context::sender(arg3),
            unstake_epoch          : v4.requested_at_epoch + arg1.config_params.unstake_delay_epoches,
            sui_to_claim           : v1,
            dsui_burnt             : v4.dsui_amount,
            sui_claimable_per_dsui : v5,
            cur_epoch              : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UserUnstakeRequest>(v6);
        v4
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg1.version == 0, 9002);
        assert!(!arg1.config_params.pause_stake, 9003);
        update_accrued_rewards(arg1, arg0, arg3);
        let v0 = get_sui_by_dsui(arg1, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&arg2));
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) > v0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v0));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_to_stake));
        };
        let v2 = v0 - 0x2::balance::value<0x2::sui::SUI>(&v1);
        if (v2 > 0) {
            assert!(arg1.config_params.unstake_delay_epoches == 0, 9014);
            let v3 = unstake_sui_from_validators(arg1, arg0, v2, arg3);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v3);
        };
        let v4 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(v0, arg1.config_params.redeem_fee_bps, 10000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v4));
        0x2::coin::burn<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&mut arg1.dsui_kraft_cap, 0x2::coin::from_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(arg2, arg3));
        arg1.dsui_supply = 0x2::coin::total_supply<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&arg1.dsui_kraft_cap);
        let v5 = get_sui_claimable_per_dsui(arg1);
        arg1.sui_claimable_per_dsui = v5;
        let v6 = UserUnstakedInstantly{
            owner                  : 0x2::tx_context::sender(arg3),
            sui_withdrawn          : v0,
            dsui_burnt             : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&arg2),
            redemption_fees        : v4,
            sui_claimable_per_dsui : v5,
            cur_epoch              : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UserUnstakedInstantly>(v6);
        v1
    }

    fun sort_vals_in_decreasing_order(arg0: &DSuiVault) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = *0x2::linked_table::front<address, ValidatorPool>(&arg0.validator_pools);
        while (0x1::option::is_some<address>(&v2)) {
            let v3 = *0x1::option::borrow<address>(&v2);
            0x1::vector::push_back<address>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, 0x2::linked_table::borrow<address, ValidatorPool>(&arg0.validator_pools, v3).total_sui_amount);
            v2 = *0x2::linked_table::next<address, ValidatorPool>(&arg0.validator_pools, v3);
        };
        let v4 = 0x1::vector::length<address>(&v0);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = v5 + 1;
            while (v6 < v4) {
                if (*0x1::vector::borrow<u64>(&v1, v6) > *0x1::vector::borrow<u64>(&v1, v5)) {
                    0x1::vector::swap<u64>(&mut v1, v5, v6);
                    0x1::vector::swap<address>(&mut v0, v5, v6);
                };
                v6 = v6 + 1;
            };
            v5 = v5 + 1;
        };
        v0
    }

    fun split_from_active_stake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut ValidatorPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x3::sui_system::redeem_fungible_staked_sui(arg0, 0x3::staking_pool::split_fungible_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::FungibleStakedSui>(&mut arg1.active_stake), arg2, arg3), arg3)
    }

    fun split_from_inactive_stake(arg0: &mut ValidatorPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        0x3::staking_pool::split(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut arg0.inactive_stake), arg1, arg2)
    }

    public fun stake_sui_request(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI> {
        assert!(arg1.version == 0, 9002);
        assert!(!arg1.config_params.pause_stake, 9003);
        update_accrued_rewards(arg1, arg0, arg4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = get_dsui_by_sui(arg1, v0);
        let v2 = 0x3::sui_system::active_validator_addresses(arg0);
        if (0x1::option::is_some<address>(&arg3)) {
            assert!(0x1::vector::contains<address>(&v2, 0x1::option::borrow<address>(&arg3)), 9012);
            let v3 = *0x1::option::borrow<address>(&arg3);
            let v4 = 0;
            if (!0x2::linked_table::contains<address, ValidatorPool>(&arg1.validator_pools, v3)) {
                v4 = 1;
            };
            assert!(0x2::linked_table::length<address, ValidatorPool>(&arg1.validator_pools) + v4 <= 75, 9013);
            if (0x2::linked_table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.selected_validator_mapping, v3)) {
                0x2::balance::join<0x2::sui::SUI>(0x2::linked_table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, v3), arg2);
            } else {
                0x2::linked_table::push_back<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, v3, arg2);
            };
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, arg2);
        };
        arg1.dsui_supply = 0x2::coin::total_supply<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&arg1.dsui_kraft_cap);
        let v5 = get_sui_claimable_per_dsui(arg1);
        arg1.sui_claimable_per_dsui = v5;
        let v6 = StakeSuiRequest{
            staker                 : 0x2::tx_context::sender(arg4),
            sui_to_stake           : v0,
            dsui_krafted           : v1,
            sui_claimable_per_dsui : v5,
            cur_epoch              : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<StakeSuiRequest>(v6);
        0x2::coin::mint_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&mut arg1.dsui_kraft_cap, v1)
    }

    fun stake_user_selected_validators(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        let v2 = *0x2::linked_table::front<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.selected_validator_mapping);
        while (0x1::option::is_some<address>(&v2)) {
            let v3 = *0x1::option::borrow<address>(&v2);
            let v4 = 0x2::linked_table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, v3);
            let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
            v2 = *0x2::linked_table::front<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.selected_validator_mapping);
            if (v5 >= 1000000000 && 0x1::vector::contains<address>(&arg2, &v3)) {
                v1 = v1 + v5;
                stake_with_validator(arg0, arg1, v3, v4, arg3);
                let v6 = StakeWithSelectedValidatorRequestProcessed{
                    validator_addr   : v3,
                    sui_to_stake_amt : v5,
                    cur_epoch        : 0x2::tx_context::epoch(arg3),
                };
                0x2::event::emit<StakeWithSelectedValidatorRequestProcessed>(v6);
                continue
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v4);
        };
        (v1, v0)
    }

    fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = 0x3::sui_system::request_add_stake_non_entry(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), arg2, arg4);
        if (!0x2::linked_table::contains<address, ValidatorPool>(&arg1.validator_pools, arg2)) {
            let v3 = 0x3::staking_pool::pool_id(&v2);
            let v4 = ValidatorPool{
                staking_pool_id   : v3,
                validator_address : arg2,
                active_stake      : 0x1::option::none<0x3::staking_pool::FungibleStakedSui>(),
                inactive_stake    : 0x1::option::none<0x3::staking_pool::StakedSui>(),
                exchange_rate     : *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(0x3::sui_system::pool_exchange_rates(arg0, &v3), v1),
                total_sui_amount  : 0,
                extra_fields      : 0x2::bag::new(arg4),
            };
            0x2::linked_table::push_back<address, ValidatorPool>(&mut arg1.validator_pools, arg2, v4);
        };
        let v5 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg1.validator_pools, arg2);
        v5.total_sui_amount = v5.total_sui_amount + v0;
        arg1.total_sui_supply = arg1.total_sui_supply + v0;
        if (0x3::staking_pool::stake_activation_epoch(&v2) <= v1) {
            join_fungible_staked_sui_to_validator(arg1, arg2, 0x3::sui_system::convert_to_fungible_staked_sui(arg0, v2, arg4));
        } else if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v5.inactive_stake)) {
            0x3::staking_pool::join_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut v5.inactive_stake), v2);
        } else {
            0x1::option::fill<0x3::staking_pool::StakedSui>(&mut v5.inactive_stake, v2);
        };
        refresh_validator_info(arg1, arg2);
        let v6 = StakeOperationProcessed{
            validator_addr   : arg2,
            sui_to_stake_amt : v0,
            cur_epoch        : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<StakeOperationProcessed>(v6);
    }

    fun unstake_from_active_stake(arg0: &mut DSuiVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg0.validator_pools, arg2);
        if (0x1::option::is_none<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake)) {
            return 0
        };
        let v1 = 0x3::staking_pool::fungible_staked_sui_value(0x1::option::borrow<0x3::staking_pool::FungibleStakedSui>(&v0.active_stake));
        let v2 = get_sui_amount(&v0.exchange_rate, v1);
        let v3 = if (v2 <= arg3) {
            extract_from_active_stake(arg1, v0, arg4)
        } else {
            split_from_active_stake(arg1, v0, ((((arg3 as u128) * (v1 as u128) + (v2 as u128) - 1) / (v2 as u128)) as u64), arg4)
        };
        let v4 = v3;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        if (v5 > v0.total_sui_amount) {
            v0.total_sui_amount = 0;
        } else {
            v0.total_sui_amount = v0.total_sui_amount - v5;
        };
        if (v5 > arg0.total_sui_supply) {
            arg0.total_sui_supply = 0;
        } else {
            arg0.total_sui_supply = arg0.total_sui_supply - v5;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.unstaked_sui_reserve, v4);
        v5
    }

    fun unstake_from_inactive_stake(arg0: &mut DSuiVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg0.validator_pools, arg2);
        if (0x1::option::is_none<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) {
            return 0
        };
        let v1 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::max_u64(arg3, 1000000000);
        let v2 = if (0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v0.inactive_stake)) < v1 + 1000000000) {
            extract_inactive_stake(v0)
        } else {
            split_from_inactive_stake(v0, v1, arg4)
        };
        let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v2, arg4);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        if (v4 > v0.total_sui_amount) {
            v0.total_sui_amount = 0;
        } else {
            v0.total_sui_amount = v0.total_sui_amount - v4;
        };
        if (v4 > arg0.total_sui_supply) {
            arg0.total_sui_supply = 0;
        } else {
            arg0.total_sui_supply = arg0.total_sui_supply - v4;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.unstaked_sui_reserve, v3);
        v4
    }

    fun unstake_sui_from_validator(arg0: &mut DSuiVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        refresh_validator_info(arg0, arg2);
        let v0 = unstake_from_inactive_stake(arg0, arg1, arg2, arg3, arg4);
        let v1 = v0;
        if (arg3 > v0) {
            v1 = v0 + unstake_from_active_stake(arg0, arg1, arg2, arg3 - v0, arg4);
        };
        v1
    }

    fun unstake_sui_from_validators(arg0: &mut DSuiVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = sort_vals_in_decreasing_order(arg0);
        let v1 = 0x1::vector::length<address>(&v0);
        let v2 = 0;
        while (v2 < v1 && 0x2::balance::value<0x2::sui::SUI>(&arg0.unstaked_sui_reserve) < arg2) {
            let v3 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg0.unstaked_sui_reserve) + 1;
            unstake_from_inactive_stake(arg0, arg1, *0x1::vector::borrow<address>(&v0, v2), v3, arg3);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v1 && 0x2::balance::value<0x2::sui::SUI>(&arg0.unstaked_sui_reserve) < arg2) {
            let v4 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg0.unstaked_sui_reserve) + 1;
            unstake_from_active_stake(arg0, arg1, *0x1::vector::borrow<address>(&v0, v2), v4, arg3);
            v2 = v2 + 1;
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.unstaked_sui_reserve) >= arg2, 9004);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.unstaked_sui_reserve, arg2)
    }

    public entry fun update_accrued_rewards(arg0: &mut DSuiVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9002);
        let v0 = arg0.total_sui_supply;
        if (refresh_validator_pools(arg0, arg1, arg2)) {
            let v1 = arg0.total_sui_supply;
            let v2 = 0;
            if (v1 > v0) {
                v2 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((v1 - v0) as u256), (arg0.config_params.protocol_fee_percent as u256), (10000 as u256)) as u64);
            };
            arg0.uncollected_protocol_fees = arg0.uncollected_protocol_fees + v2;
            arg0.sui_claimable_per_dsui = get_sui_claimable_per_dsui(arg0);
            let v3 = TotalRewardsUpdated{
                cur_epoch      : 0x2::tx_context::epoch(arg2),
                old_sui_supply : v0,
                new_sui_supply : v1,
                dsui_supply    : arg0.dsui_supply,
                fees_charged   : v2,
            };
            0x2::event::emit<TotalRewardsUpdated>(v3);
        };
    }

    public fun update_dsui_fee_config(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: &mut DSuiVault, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg1.version == 0, 9002);
        if (arg2 > 0 && arg2 < 2500) {
            arg1.config_params.protocol_fee_percent = arg2;
        };
        if (arg4 > 0 && arg4 < 50) {
            arg1.config_params.treasury_percent = arg4;
        };
        if (arg3 > 0 && arg3 < 10) {
            arg1.config_params.redeem_fee_bps = arg3;
        };
        if (arg5 >= 0) {
            arg1.config_params.unstake_delay_epoches = arg5;
        };
        let v0 = DegenSUIFeeStructureUpdated{
            protocol_fee_percent  : arg1.config_params.protocol_fee_percent,
            treasury_percent      : arg1.config_params.treasury_percent,
            redeem_fee_bps        : arg1.config_params.redeem_fee_bps,
            unstake_delay_epoches : arg1.config_params.unstake_delay_epoches,
        };
        0x2::event::emit<DegenSUIFeeStructureUpdated>(v0);
    }

    public fun update_validator_list(arg0: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut DSuiVault, arg3: vector<address>, arg4: bool) {
        assert!(arg2.version == 0, 9002);
        let v0 = 0x3::sui_system::active_validator_addresses(arg1);
        if (arg4) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg3)) {
                let v2 = *0x1::vector::borrow<address>(&arg3, v1);
                if (0x1::vector::contains<address>(&v0, &v2) && !0x1::vector::contains<address>(&arg2.whitelisted_validators, &v2)) {
                    0x1::vector::push_back<address>(&mut arg2.whitelisted_validators, v2);
                };
                v1 = v1 + 1;
            };
        };
        if (!arg4) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(&arg3)) {
                let v4 = *0x1::vector::borrow<address>(&arg3, v3);
                let (v5, v6) = 0x1::vector::index_of<address>(&arg2.whitelisted_validators, &v4);
                if (v5) {
                    0x1::vector::remove<address>(&mut arg2.whitelisted_validators, v6);
                };
                v3 = v3 + 1;
            };
        };
        assert!(0x1::vector::length<address>(&arg2.whitelisted_validators) <= 50, 9009);
        let v7 = ValidatorListUpdated{
            validator_list : arg3,
            to_add         : arg4,
        };
        0x2::event::emit<ValidatorListUpdated>(v7);
    }

    // decompiled from Move bytecode v6
}

