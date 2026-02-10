module 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::event {
    struct ConfigCreated has copy, drop {
        sender: address,
        id: address,
        market_id: u64,
    }

    struct AssetConfigCreated has copy, drop {
        sender: address,
        config_id: address,
        asset_id: address,
        market_id: u64,
    }

    struct FlashLoan has copy, drop {
        sender: address,
        asset: address,
        amount: u64,
        market_id: u64,
    }

    struct FlashRepay has copy, drop {
        sender: address,
        asset: address,
        amount: u64,
        fee_to_supplier: u64,
        fee_to_treasury: u64,
        market_id: u64,
    }

    struct RewardFundCreated has copy, drop {
        sender: address,
        reward_fund_id: address,
        coin_type: 0x1::ascii::String,
        market_id: u64,
    }

    struct RewardFundDeposited has copy, drop {
        sender: address,
        reward_fund_id: address,
        amount: u64,
        market_id: u64,
    }

    struct RewardFundWithdrawn has copy, drop {
        sender: address,
        reward_fund_id: address,
        amount: u64,
        market_id: u64,
    }

    struct IncentiveCreated has copy, drop {
        sender: address,
        incentive_id: address,
        market_id: u64,
    }

    struct AssetPoolCreated has copy, drop {
        sender: address,
        asset_id: u8,
        asset_coin_type: 0x1::ascii::String,
        pool_id: address,
        market_id: u64,
    }

    struct RuleCreated has copy, drop {
        sender: address,
        pool: 0x1::ascii::String,
        rule_id: address,
        option: u8,
        reward_coin_type: 0x1::ascii::String,
        market_id: u64,
    }

    struct BorrowFeeRateUpdated has copy, drop {
        sender: address,
        rate: u64,
        market_id: u64,
    }

    struct BorrowFeeWithdrawn has copy, drop {
        sender: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        market_id: u64,
    }

    struct RewardStateUpdated has copy, drop {
        sender: address,
        rule_id: address,
        enable: bool,
        market_id: u64,
    }

    struct MaxRewardRateUpdated has copy, drop {
        rule_id: address,
        max_total_supply: u64,
        duration_ms: u64,
        market_id: u64,
    }

    struct RewardRateUpdated has copy, drop {
        sender: address,
        pool: 0x1::ascii::String,
        rule_id: address,
        rate: u256,
        total_supply: u64,
        duration_ms: u64,
        timestamp: u64,
        market_id: u64,
    }

    struct RewardClaimed has copy, drop {
        user: address,
        total_claimed: u64,
        coin_type: 0x1::ascii::String,
        rule_ids: vector<address>,
        rule_indices: vector<u256>,
        market_id: u64,
    }

    struct AssetBorrowFeeRateUpdated has copy, drop {
        sender: address,
        asset_id: u8,
        user: address,
        rate: u64,
        market_id: u64,
    }

    struct AssetBorrowFeeRateRemoved has copy, drop {
        sender: address,
        asset_id: u8,
        user: address,
        market_id: u64,
    }

    struct BorrowFeeDeposited has copy, drop {
        sender: address,
        coin_type: 0x1::ascii::String,
        fee: u64,
        market_id: u64,
    }

    struct DepositEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
        market_id: u64,
    }

    struct DepositOnBehalfOfEvent has copy, drop {
        reserve: u8,
        sender: address,
        user: address,
        amount: u64,
        market_id: u64,
    }

    struct WithdrawEvent has copy, drop {
        reserve: u8,
        sender: address,
        to: address,
        amount: u64,
        market_id: u64,
    }

    struct BorrowEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
        market_id: u64,
    }

    struct RepayEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
        market_id: u64,
    }

    struct RepayOnBehalfOfEvent has copy, drop {
        reserve: u8,
        sender: address,
        user: address,
        amount: u64,
        market_id: u64,
    }

    struct LiquidationCallEvent has copy, drop {
        reserve: u8,
        sender: address,
        liquidate_user: address,
        liquidate_amount: u64,
        market_id: u64,
    }

    struct LiquidationEvent has copy, drop {
        sender: address,
        user: address,
        collateral_asset: u8,
        collateral_price: u256,
        collateral_amount: u64,
        treasury: u64,
        debt_asset: u8,
        debt_price: u256,
        debt_amount: u64,
        market_id: u64,
    }

    struct StateUpdated has copy, drop {
        user: address,
        asset: u8,
        user_supply_balance: u256,
        user_borrow_balance: u256,
        new_supply_index: u256,
        new_borrow_index: u256,
        market_id: u64,
    }

    struct FundUpdated has copy, drop {
        original_sui_amount: u64,
        current_sui_amount: u64,
        vsui_balance_amount: u64,
        target_sui_amount: u64,
        manager_id: address,
    }

    struct StakingTreasuryWithdrawn has copy, drop {
        taken_vsui_balance_amount: u64,
        equal_sui_balance_amount: u64,
        manager_id: address,
    }

    struct PoolCreate has copy, drop {
        creator: address,
        coin_type: 0x1::ascii::String,
        pool_id: address,
        market_id: u64,
    }

    struct PoolBalanceRegister has copy, drop {
        sender: address,
        amount: u64,
        new_amount: u64,
        pool: 0x1::ascii::String,
        market_id: u64,
    }

    struct PoolDeposit has copy, drop {
        sender: address,
        amount: u64,
        pool: 0x1::ascii::String,
        market_id: u64,
    }

    struct PoolWithdraw has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        pool: 0x1::ascii::String,
        market_id: u64,
    }

    struct PoolWithdrawReserve has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        before: u64,
        after: u64,
        pool: 0x1::ascii::String,
        poolId: address,
        market_id: u64,
    }

    struct StorageConfiguratorSetting has copy, drop {
        sender: address,
        configurator: address,
        value: bool,
        market_id: u64,
    }

    struct Paused has copy, drop {
        paused: bool,
        market_id: u64,
    }

    struct WithdrawTreasuryEvent has copy, drop {
        sender: address,
        recipient: address,
        asset: u8,
        amount: u256,
        poolId: address,
        before: u256,
        after: u256,
        index: u256,
        market_id: u64,
    }

    struct LiquidatorSet has copy, drop {
        liquidator: address,
        user: address,
        is_liquidatable: bool,
        market_id: u64,
    }

    struct ProtectedUserSet has copy, drop {
        user: address,
        is_protected: bool,
        market_id: u64,
    }

    struct EmodePairCreated has copy, drop {
        emode_id: u64,
        assetA: u8,
        assetB: u8,
        market_id: u64,
    }

    struct EmodeParamSet has copy, drop {
        emode_id: u64,
        asset: u8,
        value: u256,
        param_type: 0x1::ascii::String,
        market_id: u64,
    }

    struct EmodeActiveSet has copy, drop {
        emode_id: u64,
        is_active: bool,
        market_id: u64,
    }

    struct EmodeUserStateChanged has copy, drop {
        user: address,
        emode_id: u64,
        is_entered: bool,
        market_id: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: u64,
    }

    struct BorrowWeightSet has copy, drop {
        asset: u8,
        weight: u64,
        market_id: u64,
    }

    struct BorrowWeightRemoved has copy, drop {
        asset: u8,
        market_id: u64,
    }

    struct StorageParamsUpdated has copy, drop {
        asset: u8,
        param_type: 0x1::ascii::String,
        value: u256,
        market_id: u64,
    }

    public(friend) fun emit_asset_borrow_fee_rate_removed(arg0: address, arg1: u8, arg2: address, arg3: u64) {
        let v0 = AssetBorrowFeeRateRemoved{
            sender    : arg0,
            asset_id  : arg1,
            user      : arg2,
            market_id : arg3,
        };
        0x2::event::emit<AssetBorrowFeeRateRemoved>(v0);
    }

    public(friend) fun emit_asset_borrow_fee_rate_updated(arg0: address, arg1: u8, arg2: address, arg3: u64, arg4: u64) {
        let v0 = AssetBorrowFeeRateUpdated{
            sender    : arg0,
            asset_id  : arg1,
            user      : arg2,
            rate      : arg3,
            market_id : arg4,
        };
        0x2::event::emit<AssetBorrowFeeRateUpdated>(v0);
    }

    public(friend) fun emit_asset_config_created(arg0: address, arg1: address, arg2: address, arg3: u64) {
        let v0 = AssetConfigCreated{
            sender    : arg0,
            config_id : arg1,
            asset_id  : arg2,
            market_id : arg3,
        };
        0x2::event::emit<AssetConfigCreated>(v0);
    }

    public(friend) fun emit_asset_pool_created(arg0: address, arg1: u8, arg2: 0x1::ascii::String, arg3: address, arg4: u64) {
        let v0 = AssetPoolCreated{
            sender          : arg0,
            asset_id        : arg1,
            asset_coin_type : arg2,
            pool_id         : arg3,
            market_id       : arg4,
        };
        0x2::event::emit<AssetPoolCreated>(v0);
    }

    public(friend) fun emit_borrow_event(arg0: u8, arg1: address, arg2: u64, arg3: u64) {
        let v0 = BorrowEvent{
            reserve   : arg0,
            sender    : arg1,
            amount    : arg2,
            market_id : arg3,
        };
        0x2::event::emit<BorrowEvent>(v0);
    }

    public(friend) fun emit_borrow_fee_deposited(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = BorrowFeeDeposited{
            sender    : arg0,
            coin_type : arg1,
            fee       : arg2,
            market_id : arg3,
        };
        0x2::event::emit<BorrowFeeDeposited>(v0);
    }

    public(friend) fun emit_borrow_fee_rate_updated(arg0: address, arg1: u64, arg2: u64) {
        let v0 = BorrowFeeRateUpdated{
            sender    : arg0,
            rate      : arg1,
            market_id : arg2,
        };
        0x2::event::emit<BorrowFeeRateUpdated>(v0);
    }

    public(friend) fun emit_borrow_fee_withdrawn(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = BorrowFeeWithdrawn{
            sender    : arg0,
            coin_type : arg1,
            amount    : arg2,
            market_id : arg3,
        };
        0x2::event::emit<BorrowFeeWithdrawn>(v0);
    }

    public(friend) fun emit_borrow_weight_removed(arg0: u8, arg1: u64) {
        let v0 = BorrowWeightRemoved{
            asset     : arg0,
            market_id : arg1,
        };
        0x2::event::emit<BorrowWeightRemoved>(v0);
    }

    public(friend) fun emit_borrow_weight_set(arg0: u8, arg1: u64, arg2: u64) {
        let v0 = BorrowWeightSet{
            asset     : arg0,
            weight    : arg1,
            market_id : arg2,
        };
        0x2::event::emit<BorrowWeightSet>(v0);
    }

    public(friend) fun emit_config_created(arg0: address, arg1: address, arg2: u64) {
        let v0 = ConfigCreated{
            sender    : arg0,
            id        : arg1,
            market_id : arg2,
        };
        0x2::event::emit<ConfigCreated>(v0);
    }

    public(friend) fun emit_deposit_event(arg0: u8, arg1: address, arg2: u64, arg3: u64) {
        let v0 = DepositEvent{
            reserve   : arg0,
            sender    : arg1,
            amount    : arg2,
            market_id : arg3,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_deposit_on_behalf_of_event(arg0: u8, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = DepositOnBehalfOfEvent{
            reserve   : arg0,
            sender    : arg1,
            user      : arg2,
            amount    : arg3,
            market_id : arg4,
        };
        0x2::event::emit<DepositOnBehalfOfEvent>(v0);
    }

    public(friend) fun emit_emode_active_set(arg0: u64, arg1: bool, arg2: u64) {
        let v0 = EmodeActiveSet{
            emode_id  : arg0,
            is_active : arg1,
            market_id : arg2,
        };
        0x2::event::emit<EmodeActiveSet>(v0);
    }

    public(friend) fun emit_emode_pair_created(arg0: u64, arg1: u8, arg2: u8, arg3: u64) {
        let v0 = EmodePairCreated{
            emode_id  : arg0,
            assetA    : arg1,
            assetB    : arg2,
            market_id : arg3,
        };
        0x2::event::emit<EmodePairCreated>(v0);
    }

    public(friend) fun emit_emode_param_set(arg0: u64, arg1: u8, arg2: u256, arg3: 0x1::ascii::String, arg4: u64) {
        let v0 = EmodeParamSet{
            emode_id   : arg0,
            asset      : arg1,
            value      : arg2,
            param_type : arg3,
            market_id  : arg4,
        };
        0x2::event::emit<EmodeParamSet>(v0);
    }

    public(friend) fun emit_emode_user_state_changed(arg0: address, arg1: u64, arg2: bool, arg3: u64) {
        let v0 = EmodeUserStateChanged{
            user       : arg0,
            emode_id   : arg1,
            is_entered : arg2,
            market_id  : arg3,
        };
        0x2::event::emit<EmodeUserStateChanged>(v0);
    }

    public(friend) fun emit_flash_loan(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = FlashLoan{
            sender    : arg0,
            asset     : arg1,
            amount    : arg2,
            market_id : arg3,
        };
        0x2::event::emit<FlashLoan>(v0);
    }

    public(friend) fun emit_flash_repay(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = FlashRepay{
            sender          : arg0,
            asset           : arg1,
            amount          : arg2,
            fee_to_supplier : arg3,
            fee_to_treasury : arg4,
            market_id       : arg5,
        };
        0x2::event::emit<FlashRepay>(v0);
    }

    public(friend) fun emit_fund_updated(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: address) {
        let v0 = FundUpdated{
            original_sui_amount : arg0,
            current_sui_amount  : arg1,
            vsui_balance_amount : arg2,
            target_sui_amount   : arg3,
            manager_id          : arg4,
        };
        0x2::event::emit<FundUpdated>(v0);
    }

    public(friend) fun emit_incentive_created(arg0: address, arg1: address, arg2: u64) {
        let v0 = IncentiveCreated{
            sender       : arg0,
            incentive_id : arg1,
            market_id    : arg2,
        };
        0x2::event::emit<IncentiveCreated>(v0);
    }

    public(friend) fun emit_liquidation_call_event(arg0: u8, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = LiquidationCallEvent{
            reserve          : arg0,
            sender           : arg1,
            liquidate_user   : arg2,
            liquidate_amount : arg3,
            market_id        : arg4,
        };
        0x2::event::emit<LiquidationCallEvent>(v0);
    }

    public(friend) fun emit_liquidation_event(arg0: address, arg1: address, arg2: u8, arg3: u256, arg4: u64, arg5: u64, arg6: u8, arg7: u256, arg8: u64, arg9: u64) {
        let v0 = LiquidationEvent{
            sender            : arg0,
            user              : arg1,
            collateral_asset  : arg2,
            collateral_price  : arg3,
            collateral_amount : arg4,
            treasury          : arg5,
            debt_asset        : arg6,
            debt_price        : arg7,
            debt_amount       : arg8,
            market_id         : arg9,
        };
        0x2::event::emit<LiquidationEvent>(v0);
    }

    public(friend) fun emit_liquidator_set(arg0: address, arg1: address, arg2: bool, arg3: u64) {
        let v0 = LiquidatorSet{
            liquidator      : arg0,
            user            : arg1,
            is_liquidatable : arg2,
            market_id       : arg3,
        };
        0x2::event::emit<LiquidatorSet>(v0);
    }

    public(friend) fun emit_market_created(arg0: u64) {
        let v0 = MarketCreated{market_id: arg0};
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_max_reward_rate_updated(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = MaxRewardRateUpdated{
            rule_id          : arg0,
            max_total_supply : arg1,
            duration_ms      : arg2,
            market_id        : arg3,
        };
        0x2::event::emit<MaxRewardRateUpdated>(v0);
    }

    public(friend) fun emit_paused(arg0: bool, arg1: u64) {
        let v0 = Paused{
            paused    : arg0,
            market_id : arg1,
        };
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_pool_balance_register(arg0: address, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: u64) {
        let v0 = PoolBalanceRegister{
            sender     : arg0,
            amount     : arg1,
            new_amount : arg2,
            pool       : arg3,
            market_id  : arg4,
        };
        0x2::event::emit<PoolBalanceRegister>(v0);
    }

    public(friend) fun emit_pool_create(arg0: address, arg1: 0x1::ascii::String, arg2: address, arg3: u64) {
        let v0 = PoolCreate{
            creator   : arg0,
            coin_type : arg1,
            pool_id   : arg2,
            market_id : arg3,
        };
        0x2::event::emit<PoolCreate>(v0);
    }

    public(friend) fun emit_pool_deposit(arg0: address, arg1: u64, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = PoolDeposit{
            sender    : arg0,
            amount    : arg1,
            pool      : arg2,
            market_id : arg3,
        };
        0x2::event::emit<PoolDeposit>(v0);
    }

    public(friend) fun emit_pool_withdraw(arg0: address, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: u64) {
        let v0 = PoolWithdraw{
            sender    : arg0,
            recipient : arg1,
            amount    : arg2,
            pool      : arg3,
            market_id : arg4,
        };
        0x2::event::emit<PoolWithdraw>(v0);
    }

    public(friend) fun emit_pool_withdraw_reserve(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::ascii::String, arg6: address, arg7: u64) {
        let v0 = PoolWithdrawReserve{
            sender    : arg0,
            recipient : arg1,
            amount    : arg2,
            before    : arg3,
            after     : arg4,
            pool      : arg5,
            poolId    : arg6,
            market_id : arg7,
        };
        0x2::event::emit<PoolWithdrawReserve>(v0);
    }

    public(friend) fun emit_protected_user_set(arg0: address, arg1: bool, arg2: u64) {
        let v0 = ProtectedUserSet{
            user         : arg0,
            is_protected : arg1,
            market_id    : arg2,
        };
        0x2::event::emit<ProtectedUserSet>(v0);
    }

    public(friend) fun emit_repay_event(arg0: u8, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RepayEvent{
            reserve   : arg0,
            sender    : arg1,
            amount    : arg2,
            market_id : arg3,
        };
        0x2::event::emit<RepayEvent>(v0);
    }

    public(friend) fun emit_repay_on_behalf_of_event(arg0: u8, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = RepayOnBehalfOfEvent{
            reserve   : arg0,
            sender    : arg1,
            user      : arg2,
            amount    : arg3,
            market_id : arg4,
        };
        0x2::event::emit<RepayOnBehalfOfEvent>(v0);
    }

    public(friend) fun emit_reward_claimed(arg0: address, arg1: u64, arg2: 0x1::ascii::String, arg3: vector<address>, arg4: vector<u256>, arg5: u64) {
        let v0 = RewardClaimed{
            user          : arg0,
            total_claimed : arg1,
            coin_type     : arg2,
            rule_ids      : arg3,
            rule_indices  : arg4,
            market_id     : arg5,
        };
        0x2::event::emit<RewardClaimed>(v0);
    }

    public(friend) fun emit_reward_fund_created(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = RewardFundCreated{
            sender         : arg0,
            reward_fund_id : arg1,
            coin_type      : arg2,
            market_id      : arg3,
        };
        0x2::event::emit<RewardFundCreated>(v0);
    }

    public(friend) fun emit_reward_fund_deposited(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RewardFundDeposited{
            sender         : arg0,
            reward_fund_id : arg1,
            amount         : arg2,
            market_id      : arg3,
        };
        0x2::event::emit<RewardFundDeposited>(v0);
    }

    public(friend) fun emit_reward_fund_withdrawn(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RewardFundWithdrawn{
            sender         : arg0,
            reward_fund_id : arg1,
            amount         : arg2,
            market_id      : arg3,
        };
        0x2::event::emit<RewardFundWithdrawn>(v0);
    }

    public(friend) fun emit_reward_rate_updated(arg0: address, arg1: 0x1::ascii::String, arg2: address, arg3: u256, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = RewardRateUpdated{
            sender       : arg0,
            pool         : arg1,
            rule_id      : arg2,
            rate         : arg3,
            total_supply : arg4,
            duration_ms  : arg5,
            timestamp    : arg6,
            market_id    : arg7,
        };
        0x2::event::emit<RewardRateUpdated>(v0);
    }

    public(friend) fun emit_reward_state_updated(arg0: address, arg1: address, arg2: bool, arg3: u64) {
        let v0 = RewardStateUpdated{
            sender    : arg0,
            rule_id   : arg1,
            enable    : arg2,
            market_id : arg3,
        };
        0x2::event::emit<RewardStateUpdated>(v0);
    }

    public(friend) fun emit_rule_created(arg0: address, arg1: 0x1::ascii::String, arg2: address, arg3: u8, arg4: 0x1::ascii::String, arg5: u64) {
        let v0 = RuleCreated{
            sender           : arg0,
            pool             : arg1,
            rule_id          : arg2,
            option           : arg3,
            reward_coin_type : arg4,
            market_id        : arg5,
        };
        0x2::event::emit<RuleCreated>(v0);
    }

    public(friend) fun emit_staking_treasury_withdrawn(arg0: u64, arg1: u64, arg2: address) {
        let v0 = StakingTreasuryWithdrawn{
            taken_vsui_balance_amount : arg0,
            equal_sui_balance_amount  : arg1,
            manager_id                : arg2,
        };
        0x2::event::emit<StakingTreasuryWithdrawn>(v0);
    }

    public(friend) fun emit_state_updated(arg0: address, arg1: u8, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u64) {
        let v0 = StateUpdated{
            user                : arg0,
            asset               : arg1,
            user_supply_balance : arg2,
            user_borrow_balance : arg3,
            new_supply_index    : arg4,
            new_borrow_index    : arg5,
            market_id           : arg6,
        };
        0x2::event::emit<StateUpdated>(v0);
    }

    public(friend) fun emit_storage_configurator_setting(arg0: address, arg1: address, arg2: bool, arg3: u64) {
        let v0 = StorageConfiguratorSetting{
            sender       : arg0,
            configurator : arg1,
            value        : arg2,
            market_id    : arg3,
        };
        0x2::event::emit<StorageConfiguratorSetting>(v0);
    }

    public(friend) fun emit_storage_params_updated(arg0: u8, arg1: 0x1::ascii::String, arg2: u256, arg3: u64) {
        let v0 = StorageParamsUpdated{
            asset      : arg0,
            param_type : arg1,
            value      : arg2,
            market_id  : arg3,
        };
        0x2::event::emit<StorageParamsUpdated>(v0);
    }

    public(friend) fun emit_withdraw_event(arg0: u8, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = WithdrawEvent{
            reserve   : arg0,
            sender    : arg1,
            to        : arg2,
            amount    : arg3,
            market_id : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public(friend) fun emit_withdraw_treasury_event(arg0: address, arg1: address, arg2: u8, arg3: u256, arg4: address, arg5: u256, arg6: u256, arg7: u256, arg8: u64) {
        let v0 = WithdrawTreasuryEvent{
            sender    : arg0,
            recipient : arg1,
            asset     : arg2,
            amount    : arg3,
            poolId    : arg4,
            before    : arg5,
            after     : arg6,
            index     : arg7,
            market_id : arg8,
        };
        0x2::event::emit<WithdrawTreasuryEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

