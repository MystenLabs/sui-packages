module 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking {
    struct LIQUID_STAKING has drop {
        dummy_field: bool,
    }

    struct LiquidStakingInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        lst_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        fee_config: 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::Cell<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        accrued_spread_fees: u64,
        storage: 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::Storage,
        flash_stake_lst: u64,
        collection_fee_cap_id: 0x2::object::ID,
        is_paused: bool,
        version: 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::version::Version,
        extra_fields: 0x2::bag::Bag,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionFeeCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct FlashStake<phantom T0> {
        sui_amount: u64,
        lst_amount: u64,
        fee: u64,
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

    struct FlashStakeEvent has copy, drop {
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
        fee_distributed: u64,
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

    struct ALPHA has drop {
        dummy_field: bool,
    }

    public fun mint<T0: drop>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = is_paused<T0>(arg0);
        assert!(!v0, 6);
        refresh_no_entry<T0>(arg0, arg1, arg3);
        let v1 = (total_sui_supply<T0>(arg0) as u128);
        let v2 = (total_lst_supply<T0>(arg0) as u128);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v4 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::calculate_mint_fee(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::get<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&arg0.fee_config), 0x2::balance::value<0x2::sui::SUI>(&v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v4));
        let v5 = sui_amount_to_lst_amount<T0>(arg0, 0x2::balance::value<0x2::sui::SUI>(&v3));
        assert!(v5 > 0, 4);
        let v6 = MintEvent{
            typename       : 0x1::type_name::get<T0>(),
            sui_amount_in  : 0x2::balance::value<0x2::sui::SUI>(&v3),
            lst_amount_out : v5,
            fee_amount     : v4,
        };
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::events::emit_event<MintEvent>(v6);
        let v7 = 0x2::coin::mint<T0>(&mut arg0.lst_treasury_cap, v5, arg3);
        assert!((0x2::coin::value<T0>(&v7) as u128) * v1 <= (0x2::balance::value<0x2::sui::SUI>(&v3) as u128) * v2 || v1 > 0 && v2 == 0, 1);
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::join_to_sui_pool(&mut arg0.storage, v3);
        v7
    }

    public fun fees<T0>(arg0: &LiquidStakingInfo<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees) + arg0.accrued_spread_fees
    }

    public fun collect_fees<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &CollectionFeeCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.collection_fee_cap_id == 0x2::object::id<CollectionFeeCap<T0>>(arg2), 5);
        refresh_no_entry<T0>(arg0, arg1, arg3);
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::split_n_sui(&mut arg0.storage, arg1, arg0.accrued_spread_fees, arg3);
        arg0.accrued_spread_fees = arg0.accrued_spread_fees - 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fees);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, v0);
        let v2 = CollectFeesEvent{
            typename : 0x1::type_name::get<T0>(),
            amount   : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::events::emit_event<CollectFeesEvent>(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3)
    }

    public fun create_lst<T0: drop>(arg0: 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : (AdminCap<T0>, CollectionFeeCap<T0>, LiquidStakingInfo<T0>) {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0);
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::new(arg2);
        create_lst_with_storage<T0>(arg0, arg1, v0, arg2)
    }

    fun create_lst_with_storage<T0: drop>(arg0: 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::Storage, arg3: &mut 0x2::tx_context::TxContext) : (AdminCap<T0>, CollectionFeeCap<T0>, LiquidStakingInfo<T0>) {
        let v0 = 0x2::object::new(arg3);
        let v1 = CreateEvent{
            typename               : 0x1::type_name::get<T0>(),
            liquid_staking_info_id : 0x2::object::uid_to_inner(&v0),
        };
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::events::emit_event<CreateEvent>(v1);
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::emit_fee_change_event<T0>(&arg0);
        let v2 = CollectionFeeCap<T0>{id: 0x2::object::new(arg3)};
        let v3 = AdminCap<T0>{id: 0x2::object::new(arg3)};
        let v4 = LiquidStakingInfo<T0>{
            id                    : v0,
            lst_treasury_cap      : arg1,
            fee_config            : 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::new<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(arg0),
            fees                  : 0x2::balance::zero<0x2::sui::SUI>(),
            accrued_spread_fees   : 0,
            storage               : arg2,
            flash_stake_lst       : 0,
            collection_fee_cap_id : 0x2::object::id<CollectionFeeCap<T0>>(&v2),
            is_paused             : false,
            version               : 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::version::new(2),
            extra_fields          : 0x2::bag::new(arg3),
        };
        (v3, v2, v4)
    }

    public(friend) fun storage<T0>(arg0: &LiquidStakingInfo<T0>) : &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::Storage {
        &arg0.storage
    }

    public fun fee_config<T0>(arg0: &LiquidStakingInfo<T0>) : &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig {
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::get<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&arg0.fee_config)
    }

    public fun flash_stake_conclude<T0: drop>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: FlashStake<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_paused<T0>(arg0), 7);
        let FlashStake {
            sui_amount : v0,
            lst_amount : v1,
            fee        : v2,
        } = arg3;
        refresh_no_entry<T0>(arg0, arg1, arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg2)) >= v0 + v2, 9223373303870128127);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v2));
        flash_stake_supply_reduce<T0>(arg0, v1);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut v3, v0);
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::join_to_sui_pool(&mut arg0.storage, v4);
        let v5 = FlashStakeEvent{
            typename       : 0x1::type_name::get<T0>(),
            sui_amount_in  : 0x2::balance::value<0x2::sui::SUI>(&v4),
            lst_amount_out : v1,
            fee_amount     : v2,
        };
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::events::emit_event<FlashStakeEvent>(v5);
        un_pause_no_entry<T0>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4)
    }

    public fun flash_stake_start<T0: drop>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashStake<T0>) {
        let v0 = is_paused<T0>(arg0);
        assert!(!v0, 6);
        refresh_no_entry<T0>(arg0, arg1, arg3);
        let v1 = lst_amount_to_sui_amount_round_up<T0>(arg0, arg2);
        let v2 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::calculate_flash_stake_fee(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::get<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&arg0.fee_config), v1);
        let v3 = 0x2::coin::mint<T0>(&mut arg0.lst_treasury_cap, arg2, arg3);
        flash_stake_supply_add<T0>(arg0, arg2);
        pause_no_entry<T0>(arg0);
        let v4 = FlashStake<T0>{
            sui_amount : v1,
            lst_amount : arg2,
            fee        : v2,
        };
        (v3, v4)
    }

    fun flash_stake_supply<T0>(arg0: &LiquidStakingInfo<T0>) : u64 {
        arg0.flash_stake_lst
    }

    fun flash_stake_supply_add<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: u64) {
        arg0.flash_stake_lst = arg0.flash_stake_lst + arg1;
    }

    fun flash_stake_supply_reduce<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: u64) {
        arg0.flash_stake_lst = arg0.flash_stake_lst - arg1;
    }

    public fun generate_new_collection_cap<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &AdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : CollectionFeeCap<T0> {
        let v0 = CollectionFeeCap<T0>{id: 0x2::object::new(arg2)};
        arg0.collection_fee_cap_id = 0x2::object::id<CollectionFeeCap<T0>>(&v0);
        v0
    }

    fun init(arg0: LIQUID_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LIQUID_STAKING>(arg0, arg1);
    }

    public fun is_paused<T0>(arg0: &mut LiquidStakingInfo<T0>) : bool {
        arg0.is_paused
    }

    fun lst_amount_to_sui_amount<T0>(arg0: &LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = total_lst_supply<T0>(arg0);
        assert!(v0 > 0, 3);
        (((total_sui_supply<T0>(arg0) as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    fun lst_amount_to_sui_amount_round_up<T0>(arg0: &LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = total_lst_supply<T0>(arg0);
        assert!(v0 > 0, 3);
        ((((total_sui_supply<T0>(arg0) as u128) * (arg1 as u128) + (v0 as u128) - 1) / (v0 as u128)) as u64)
    }

    public fun lst_to_sui_redemption_price<T0>(arg0: &LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = lst_amount_to_sui_amount<T0>(arg0, arg1);
        v0 - 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::calculate_redeem_fee(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::get<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&arg0.fee_config), v0)
    }

    fun pause_no_entry<T0>(arg0: &mut LiquidStakingInfo<T0>) {
        arg0.is_paused = true;
    }

    public fun redeem<T0: drop>(arg0: &mut LiquidStakingInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = is_paused<T0>(arg0);
        assert!(!v0, 6);
        refresh_no_entry<T0>(arg0, arg2, arg3);
        let v1 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::split_n_sui(&mut arg0.storage, arg2, lst_amount_to_sui_amount<T0>(arg0, 0x2::coin::value<T0>(&arg1)), arg3);
        let v2 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::calculate_redeem_fee(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::get<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&arg0.fee_config), 0x2::balance::value<0x2::sui::SUI>(&v1));
        let v3 = if (total_lst_supply<T0>(arg0) == 0x2::coin::value<T0>(&arg1)) {
            0
        } else {
            0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::calculate_distribution_component_fee(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::get<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&arg0.fee_config), v2)
        };
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v1, (v4 as u64)));
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::join_to_sui_pool(&mut arg0.storage, 0x2::balance::split<0x2::sui::SUI>(&mut v1, (v3 as u64)));
        let v5 = RedeemEvent{
            typename        : 0x1::type_name::get<T0>(),
            lst_amount_in   : 0x2::coin::value<T0>(&arg1),
            sui_amount_out  : 0x2::balance::value<0x2::sui::SUI>(&v1),
            fee_amount      : v4,
            fee_distributed : v3,
        };
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::events::emit_event<RedeemEvent>(v5);
        assert!((0x2::balance::value<0x2::sui::SUI>(&v1) as u128) * (total_lst_supply<T0>(arg0) as u128) <= (0x2::coin::value<T0>(&arg1) as u128) * (total_sui_supply<T0>(arg0) as u128), 2);
        0x2::coin::burn<T0>(&mut arg0.lst_treasury_cap, arg1);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3)
    }

    public entry fun refresh<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        refresh_no_entry<T0>(arg0, arg1, arg2);
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::stake_pending_sui<T0>(&mut arg0.storage, arg1, arg2);
    }

    public(friend) fun refresh_no_entry<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::version::assert_version_and_upgrade(&mut arg0.version, 2);
        let v0 = total_sui_supply<T0>(arg0);
        if (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::refresh<T0>(&mut arg0.storage, arg1, arg2)) {
            let v1 = total_sui_supply<T0>(arg0);
            let v2 = if (v1 > v0) {
                ((((v1 - v0) as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::spread_fee_bps(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::get<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&arg0.fee_config)) as u128) / 10000) as u64)
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
            0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::events::emit_event<EpochChangedEvent>(v3);
            return true
        };
        false
    }

    public fun set_validator_addresses_and_weights<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: 0x2::vec_map::VecMap<address, u64>, arg2: &AdminCap<T0>) {
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::set_validator_addresses_and_weights(&mut arg0.storage, arg1);
    }

    fun sui_amount_to_lst_amount<T0>(arg0: &LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = total_sui_supply<T0>(arg0);
        let v1 = total_lst_supply<T0>(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (((v1 as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    public fun sui_to_lst_mint_price<T0>(arg0: &LiquidStakingInfo<T0>, arg1: u64) : u64 {
        sui_amount_to_lst_amount<T0>(arg0, arg1 - 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::calculate_mint_fee(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::get<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&arg0.fee_config), arg1))
    }

    public fun total_lst_supply<T0>(arg0: &LiquidStakingInfo<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lst_treasury_cap) - flash_stake_supply<T0>(arg0)
    }

    public fun total_sui_supply<T0>(arg0: &LiquidStakingInfo<T0>) : u64 {
        if (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::total_sui_supply(&arg0.storage) > arg0.accrued_spread_fees) {
            0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::storage::total_sui_supply(&arg0.storage) - arg0.accrued_spread_fees
        } else {
            0
        }
    }

    fun un_pause_no_entry<T0>(arg0: &mut LiquidStakingInfo<T0>) {
        arg0.is_paused = false;
    }

    public fun update_fees<T0>(arg0: &mut LiquidStakingInfo<T0>, arg1: &AdminCap<T0>, arg2: 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig) {
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::version::assert_version_and_upgrade(&mut arg0.version, 2);
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::emit_fee_change_event<T0>(&arg2);
        0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::destroy(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::cell::set<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::FeeConfig>(&mut arg0.fee_config, arg2));
    }

    // decompiled from Move bytecode v6
}

