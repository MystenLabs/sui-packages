module 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking {
    struct LIQUID_STAKING has drop {
        dummy_field: bool,
    }

    struct LiquidStakingInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        lst_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        fee_config: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::cell::Cell<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig>,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        accrued_spread_fees: u64,
        storage: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::Storage,
        version: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::Version,
        extra_fields: 0x2::bag::Bag,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct CreateEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        liquid_staking_info_id: 0x2::object::ID,
    }

    struct MintEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        sui_amount_in: u64,
        lst_amount_out: u64,
        fee_amount: u64,
    }

    struct RedeemEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        lst_amount_in: u64,
        sui_amount_out: u64,
        fee_amount: u64,
    }

    struct DecreaseValidatorStakeEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        staking_pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct IncreaseValidatorStakeEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        staking_pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct CollectFeesEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EpochChangedEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        old_sui_supply: u64,
        new_sui_supply: u64,
        lst_supply: u64,
        spread_fee: u64,
    }

    public fun mint<T0: drop>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        refresh<T0>(arg0, arg1, arg3);
        let v0 = (total_sui_supply<T0>(arg0) as u128);
        let v1 = (total_lst_supply<T0>(arg0) as u128);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v3 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::calculate_mint_fee(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::cell::get<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig>(&arg0.fee_config), 0x2::balance::value<0x2::sui::SUI>(&v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
        let v4 = sui_amount_to_lst_amount<T0>(arg0, 0x2::balance::value<0x2::sui::SUI>(&v2));
        assert!(v4 > 0, 5);
        let v5 = MintEvent{
            typename       : 0x1::type_name::get<T0>(),
            sui_amount_in  : 0x2::balance::value<0x2::sui::SUI>(&v2),
            lst_amount_out : v4,
            fee_amount     : v3,
        };
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::events::emit_event<MintEvent>(v5);
        let v6 = 0x2::coin::mint<T0>(&mut arg0.lst_treasury_cap, v4, arg3);
        assert!((0x2::coin::value<T0>(&v6) as u128) * v0 <= (0x2::balance::value<0x2::sui::SUI>(&v2) as u128) * v1 || v0 > 0 && v1 == 0, 1);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::join_to_sui_pool(&mut arg0.storage, v2);
        v6
    }

    public fun fees<T0>(arg0: &LiquidStakingInfo<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees) + arg0.accrued_spread_fees
    }

    public fun change_validator_priority<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &AdminCap<T0>, arg2: u64, arg3: u64) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::change_validator_priority(&mut arg0.storage, arg2, arg3);
    }

    public fun collect_fees<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &AdminCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        refresh<T0>(arg0, arg1, arg3);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::split_n_sui(&mut arg0.storage, arg1, arg0.accrued_spread_fees, arg3);
        arg0.accrued_spread_fees = arg0.accrued_spread_fees - 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fees);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, v0);
        let v2 = CollectFeesEvent{
            typename : 0x1::type_name::get<T0>(),
            amount   : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::events::emit_event<CollectFeesEvent>(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3)
    }

    public fun create_lst<T0: drop>(arg0: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : (AdminCap<T0>, LiquidStakingInfo<T0>) {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::new(arg2);
        create_lst_with_storage<T0>(arg0, arg1, v0, arg2)
    }

    public fun create_lst_with_stake<T0: drop>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig, arg2: 0x2::coin::TreasuryCap<T0>, arg3: vector<0x3::staking_pool::FungibleStakedSui>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (AdminCap<T0>, LiquidStakingInfo<T0>) {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::new(arg5);
        while (!0x1::vector::is_empty<0x3::staking_pool::FungibleStakedSui>(&arg3)) {
            0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::join_fungible_stake(&mut v0, arg0, 0x1::vector::pop_back<0x3::staking_pool::FungibleStakedSui>(&mut arg3), arg5);
        };
        0x1::vector::destroy_empty<0x3::staking_pool::FungibleStakedSui>(arg3);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::join_to_sui_pool(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        assert!(0x2::coin::total_supply<T0>(&arg2) > 0 && 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::total_sui_supply(&v0) > 0, 0);
        let v1 = (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::total_sui_supply(&v0) as u128);
        let v2 = (0x2::coin::total_supply<T0>(&arg2) as u128);
        assert!(v1 >= v2 && v1 <= 2 * v2, 0);
        create_lst_with_storage<T0>(arg1, arg2, v0, arg5)
    }

    fun create_lst_with_storage<T0: drop>(arg0: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::Storage, arg3: &mut 0x2::tx_context::TxContext) : (AdminCap<T0>, LiquidStakingInfo<T0>) {
        let v0 = 0x2::object::new(arg3);
        let v1 = CreateEvent{
            typename               : 0x1::type_name::get<T0>(),
            liquid_staking_info_id : 0x2::object::uid_to_inner(&v0),
        };
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::events::emit_event<CreateEvent>(v1);
        let v2 = AdminCap<T0>{id: 0x2::object::new(arg3)};
        let v3 = LiquidStakingInfo<T0>{
            id                  : v0,
            lst_treasury_cap    : arg1,
            fee_config          : 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::cell::new<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig>(arg0),
            fees                : 0x2::balance::zero<0x2::sui::SUI>(),
            accrued_spread_fees : 0,
            storage             : arg2,
            version             : 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::new(1),
            extra_fields        : 0x2::bag::new(arg3),
        };
        (v2, v3)
    }

    public fun storage<T0>(arg0: &LiquidStakingInfo<T0>) : &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::Storage {
        &arg0.storage
    }

    public fun decrease_validator_stake<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &AdminCap<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        refresh<T0>(arg0, arg2, arg5);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::find_validator_index_by_address(&arg0.storage, arg3);
        assert!(v0 < 0x1::vector::length<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::ValidatorInfo>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::validators(&arg0.storage)), 3);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::unstake_approx_n_sui_from_validator(&mut arg0.storage, arg2, v0, arg4, arg5);
        let v2 = DecreaseValidatorStakeEvent{
            typename        : 0x1::type_name::get<T0>(),
            staking_pool_id : 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::staking_pool_id(0x1::vector::borrow<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::ValidatorInfo>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::validators(&arg0.storage), v0)),
            amount          : v1,
        };
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::events::emit_event<DecreaseValidatorStakeEvent>(v2);
        v1
    }

    public fun fee_config<T0>(arg0: &LiquidStakingInfo<T0>) : &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::cell::get<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig>(&arg0.fee_config)
    }

    public fun increase_validator_stake<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &AdminCap<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        refresh<T0>(arg0, arg2, arg5);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::split_up_to_n_sui_from_sui_pool(&mut arg0.storage, arg4);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) < 1000000000) {
            0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::join_to_sui_pool(&mut arg0.storage, v0);
            return 0
        };
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), arg3, arg5);
        let v2 = IncreaseValidatorStakeEvent{
            typename        : 0x1::type_name::get<T0>(),
            staking_pool_id : 0x3::staking_pool::pool_id(&v1),
            amount          : 0x3::staking_pool::staked_sui_amount(&v1),
        };
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::events::emit_event<IncreaseValidatorStakeEvent>(v2);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::join_stake(&mut arg0.storage, arg2, v1, arg5);
        0x3::staking_pool::staked_sui_amount(&v1)
    }

    fun init(arg0: LIQUID_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LIQUID_STAKING>(arg0, arg1);
    }

    fun lst_amount_to_sui_amount<T0>(arg0: &LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = total_lst_supply<T0>(arg0);
        assert!(v0 > 0, 4);
        (((total_sui_supply<T0>(arg0) as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    public fun redeem<T0: drop>(arg0: &mut LiquidStakingInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        refresh<T0>(arg0, arg2, arg3);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::split_n_sui(&mut arg0.storage, arg2, lst_amount_to_sui_amount<T0>(arg0, 0x2::coin::value<T0>(&arg1)), arg3);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::calculate_redeem_fee(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::cell::get<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig>(&arg0.fee_config), 0x2::balance::value<0x2::sui::SUI>(&v0));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v0, (v1 as u64)));
        let v2 = RedeemEvent{
            typename       : 0x1::type_name::get<T0>(),
            lst_amount_in  : 0x2::coin::value<T0>(&arg1),
            sui_amount_out : 0x2::balance::value<0x2::sui::SUI>(&v0),
            fee_amount     : v1,
        };
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::events::emit_event<RedeemEvent>(v2);
        assert!((0x2::balance::value<0x2::sui::SUI>(&v0) as u128) * (total_lst_supply<T0>(arg0) as u128) <= (0x2::coin::value<T0>(&arg1) as u128) * (total_sui_supply<T0>(arg0) as u128), 2);
        0x2::coin::burn<T0>(&mut arg0.lst_treasury_cap, arg1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3)
    }

    public fun refresh<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = total_sui_supply<T0>(arg0);
        if (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::refresh(&mut arg0.storage, arg1, arg2)) {
            let v1 = total_sui_supply<T0>(arg0);
            let v2 = if (v1 > v0) {
                ((((v1 - v0) as u128) * (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::spread_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::cell::get<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig>(&arg0.fee_config)) as u128) / 10000) as u64)
            } else {
                0
            };
            arg0.accrued_spread_fees = arg0.accrued_spread_fees + v2;
            let v3 = EpochChangedEvent{
                typename       : 0x1::type_name::get<T0>(),
                old_sui_supply : v0,
                new_sui_supply : v1,
                lst_supply     : total_lst_supply<T0>(arg0),
                spread_fee     : v2,
            };
            0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::events::emit_event<EpochChangedEvent>(v3);
            return true
        };
        false
    }

    fun sui_amount_to_lst_amount<T0>(arg0: &LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = total_sui_supply<T0>(arg0);
        let v1 = total_lst_supply<T0>(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (((v1 as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    public fun total_lst_supply<T0>(arg0: &LiquidStakingInfo<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lst_treasury_cap)
    }

    public fun total_sui_supply<T0>(arg0: &LiquidStakingInfo<T0>) : u64 {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::storage::total_sui_supply(&arg0.storage) - arg0.accrued_spread_fees
    }

    public fun update_fees<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &AdminCap<T0>, arg2: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::version::assert_version_and_upgrade(&mut arg0.version, 1);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::destroy(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::cell::set<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::FeeConfig>(&mut arg0.fee_config, arg2));
    }

    // decompiled from Move bytecode v6
}

