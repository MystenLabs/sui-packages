module 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        version: u64,
        reserves: vector<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>,
        usdj: u64,
        usdj_supply: 0x2::balance::Supply<USDJ>,
        staker: Staker,
    }

    struct Staker has store {
        validator_infos: vector<ValidatorInfo>,
        total_staked_sui_amount: u64,
        max_available_stake_ratio: u64,
        reward_sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ValidatorInfo has store {
        staking_pool_id: 0x2::object::ID,
        validator_address: address,
        staked_sui: 0x1::option::Option<0x3::staking_pool::StakedSui>,
        staked_sui_amount: u64,
    }

    struct USDJ has drop {
        dummy_field: bool,
    }

    struct BuyUSDJEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        usdj_amount: u64,
        coin_amount: u64,
    }

    struct SellUSDJEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        usdj_amount: u64,
        coin_amount: u64,
    }

    struct SettleEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        isIn: bool,
    }

    struct StakeSuiEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct UnstakeSuiEvent has copy, drop {
        sender: address,
        amount: u64,
        reward_amount: u64,
    }

    struct ClaimRewardSuiEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    public fun set_pause_status(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::AdminCap, arg1: &mut Vault, arg2: u64, arg3: bool) {
        assert!(arg1.version == 1, 1);
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::set_pause_status(0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg1.reserves, arg2), arg3);
    }

    public fun add_reserve<T0>(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::AdminCap, arg1: &mut Vault, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        assert!(reserve_array_index<T0>(arg1) == 0x1::vector::length<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&arg1.reserves), 2);
        0x1::vector::push_back<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg1.reserves, 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::create_reserve<T0>(0x1::vector::length<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&arg1.reserves), 0x2::coin::get_decimals<T0>(arg2), arg3, arg4, arg5));
    }

    public fun admin_settle<T0>(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::HandlerCap, arg1: &mut Vault, arg2: &mut 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::recharge::Recharge<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        if (arg5) {
            0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::receive_token<T0>(0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg1.reserves, arg3), 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::recharge::withdraw<T0>(arg2, arg4, true), true);
        } else {
            0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::recharge::deposit<T0>(arg2, 0x2::coin::from_balance<T0>(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::back_token<T0>(0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg1.reserves, arg3), arg4, true), arg6), @0x0, true, arg6);
        };
        let v0 = SettleEvent{
            sender    : 0x2::tx_context::sender(arg6),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : arg4,
            isIn      : arg5,
        };
        0x2::event::emit<SettleEvent>(v0);
    }

    public(friend) fun buy_usdj<T0>(arg0: &mut Vault, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<USDJ> {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg0.reserves, arg1);
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::assert_pause(v1);
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::assert_price_is_fresh(v1, arg3);
        let v2 = 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::floor(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(1000000), 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::token_amount_to_usd_lower_bound(v1, 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(v0))));
        arg0.usdj = arg0.usdj + v2;
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::receive_token<T0>(v1, 0x2::coin::into_balance<T0>(arg2), true);
        let v3 = BuyUSDJEvent{
            coin_type   : 0x1::type_name::get<T0>(),
            usdj_amount : v2,
            coin_amount : v0,
        };
        0x2::event::emit<BuyUSDJEvent>(v3);
        0x2::balance::increase_supply<USDJ>(&mut arg0.usdj_supply, v2)
    }

    public fun change_reserve_price_feed<T0>(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::AdminCap, arg1: &mut Vault, arg2: u64, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        assert!(arg1.version == 1, 1);
        let v0 = 0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg1.reserves, arg2);
        assert!(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::coin_type(v0) == 0x1::type_name::get<T0>(), 3);
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::change_price_feed(v0, arg3, arg4);
    }

    public fun claim_reward_sui(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::StakeHandlerCap, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.version == 1, 1);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.staker.reward_sui), arg2);
        let v1 = ClaimRewardSuiEvent{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&v0)),
        };
        0x2::event::emit<ClaimRewardSuiEvent>(v1);
        v0
    }

    public(friend) fun decrease_stake(arg0: &mut Staker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        let v0 = find_validator_index_by_address(arg0, arg2);
        assert!(v0 < 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos), 6);
        let v1 = if (0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, v0).staked_sui)) < arg3 + 1000000000) {
            take_from_staked_sui(arg0, v0)
        } else {
            split_from_staked_sui(arg0, v0, arg3, arg4)
        };
        let v2 = v1;
        let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v2, arg4);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3) - 0x3::staking_pool::staked_sui_amount(&v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v4));
        (v3, v4)
    }

    public(friend) fun find_validator_index_by_address(arg0: &Staker, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos)) {
            if (0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v0).validator_address == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public fun get_aum(arg0: &Vault, arg1: bool, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0);
        while (v0 < 0x1::vector::length<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&arg0.reserves)) {
            let v2 = 0x1::vector::borrow<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&arg0.reserves, v0);
            0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::assert_price_is_fresh(v2, arg2);
            let v3 = if (arg1) {
                0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::token_amount_to_usd_upper_bound(v2, 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::available_amount(v2)))
            } else {
                0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::token_amount_to_usd_lower_bound(v2, 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::available_amount(v2)))
            };
            v1 = 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::add(v1, v3);
            v0 = v0 + 1;
        };
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::floor(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(1000000), v1))
    }

    fun get_or_add_validator_index_by_staking_pool_id_mut(arg0: &mut Staker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID) : u64 {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<ValidatorInfo>(&arg0.validator_infos)) {
            if (0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v1).staking_pool_id == arg2) {
                return v1
            };
            0x1::vector::push_back<address>(&mut v0, 0x1::vector::borrow<ValidatorInfo>(&arg0.validator_infos, v1).validator_address);
            v1 = v1 + 1;
        };
        let v2 = 0x3::sui_system::validator_address_by_pool_id(arg1, &arg2);
        assert!(!0x1::vector::contains<address>(&v0, &v2), 4);
        let v3 = 0x3::sui_system::active_validator_addresses(arg1);
        assert!(0x1::vector::contains<address>(&v3, &v2), 5);
        let v4 = ValidatorInfo{
            staking_pool_id   : arg2,
            validator_address : v2,
            staked_sui        : 0x1::option::none<0x3::staking_pool::StakedSui>(),
            staked_sui_amount : 0,
        };
        0x1::vector::push_back<ValidatorInfo>(&mut arg0.validator_infos, v4);
        v1
    }

    public(friend) fun increase_usdj(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<USDJ> {
        assert!(arg0.version == 1, 1);
        arg0.usdj = arg0.usdj + arg1;
        0x2::balance::increase_supply<USDJ>(&mut arg0.usdj_supply, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = USDJ{dummy_field: false};
        let v1 = Staker{
            validator_infos           : 0x1::vector::empty<ValidatorInfo>(),
            total_staked_sui_amount   : 0,
            max_available_stake_ratio : 0,
            reward_sui                : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = Vault{
            id          : 0x2::object::new(arg0),
            version     : 1,
            reserves    : 0x1::vector::empty<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(),
            usdj        : 0,
            usdj_supply : 0x2::balance::create_supply<USDJ>(v0),
            staker      : v1,
        };
        0x2::transfer::share_object<Vault>(v2);
    }

    public(friend) fun join_stake(arg0: &mut Staker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x3::staking_pool::StakedSui) : u64 {
        let v0 = get_or_add_validator_index_by_staking_pool_id_mut(arg0, arg1, 0x3::staking_pool::pool_id(&arg2));
        let v1 = 0x3::staking_pool::staked_sui_amount(&arg2);
        let v2 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, v0);
        arg0.total_staked_sui_amount = arg0.total_staked_sui_amount + v1;
        v2.staked_sui_amount = v2.staked_sui_amount + v1;
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v2.staked_sui)) {
            0x3::staking_pool::join_staked_sui(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut v2.staked_sui), arg2);
        } else {
            0x1::option::fill<0x3::staking_pool::StakedSui>(&mut v2.staked_sui, arg2);
        };
        v1
    }

    public fun max_available_stake_ratio(arg0: &Staker) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from_bps(arg0.max_available_stake_ratio)
    }

    entry fun migrate(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::AdminCap, arg1: &mut Vault) {
        assert!(arg1.version <= 1 - 1, 1);
        arg1.version = 1;
    }

    public fun refresh_reserve_price(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(arg0.version == 1, 1);
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::update_price(0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg0.reserves, arg1), arg2, arg3);
    }

    fun refresh_validator_info(arg0: &mut Staker, arg1: u64) {
        let v0 = 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1);
        arg0.total_staked_sui_amount = arg0.total_staked_sui_amount - v0.staked_sui_amount;
        let v1 = 0;
        if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v0.staked_sui)) {
            v1 = 0x3::staking_pool::staked_sui_amount(0x1::option::borrow<0x3::staking_pool::StakedSui>(&v0.staked_sui));
        };
        v0.staked_sui_amount = v1;
        arg0.total_staked_sui_amount = arg0.total_staked_sui_amount + v1;
    }

    fun reserve_array_index<T0>(arg0: &Vault) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&arg0.reserves)) {
            if (0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::coin_type(0x1::vector::borrow<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&arg0.reserves, v0)) == 0x1::type_name::get<T0>()) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public fun reserves(arg0: &Vault) : &vector<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve> {
        &arg0.reserves
    }

    public(friend) fun sell_usdj<T0>(arg0: &mut Vault, arg1: u64, arg2: 0x2::coin::Coin<USDJ>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert!(arg0.version == 1, 1);
        let v0 = 0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg0.reserves, arg1);
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::assert_pause(v0);
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::assert_price_is_fresh(v0, arg3);
        let v1 = 0x2::coin::value<USDJ>(&arg2);
        arg0.usdj = arg0.usdj - v1;
        0x2::balance::decrease_supply<USDJ>(&mut arg0.usdj_supply, 0x2::coin::into_balance<USDJ>(arg2));
        let v2 = 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::back_token<T0>(v0, 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::floor(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::usd_to_token_amount_lower_bound(v0, 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::div(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(v1), 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(1000000)))), true);
        let v3 = SellUSDJEvent{
            coin_type   : 0x1::type_name::get<T0>(),
            usdj_amount : v1,
            coin_amount : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<SellUSDJEvent>(v3);
        v2
    }

    public fun set_max_available_stake_ratio(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::AdminCap, arg1: &mut Vault, arg2: u64) {
        assert!(arg1.version == 1, 1);
        arg1.staker.max_available_stake_ratio = arg2;
    }

    fun split_from_staked_sui(arg0: &mut Staker, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        let v0 = 0x3::staking_pool::split(0x1::option::borrow_mut<0x3::staking_pool::StakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1).staked_sui), arg2, arg3);
        refresh_validator_info(arg0, arg1);
        v0
    }

    public fun stake_sui(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::StakeHandlerCap, arg1: &mut Vault, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.version == 1, 1);
        let v0 = 0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg1.reserves, arg3);
        assert!(arg5 + arg1.staker.total_staked_sui_amount <= 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::ceil(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(max_available_stake_ratio(&arg1.staker), 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::available_amount(v0)))), 7);
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::back_token<0x2::sui::SUI>(v0, arg5, false), arg6), arg4, arg6);
        let v2 = &mut arg1.staker;
        let v3 = join_stake(v2, arg2, v1);
        let v4 = StakeSuiEvent{
            sender : 0x2::tx_context::sender(arg6),
            amount : v3,
        };
        0x2::event::emit<StakeSuiEvent>(v4);
        v3
    }

    public fun staker(arg0: &Vault) : &Staker {
        &arg0.staker
    }

    fun take_from_staked_sui(arg0: &mut Staker, arg1: u64) : 0x3::staking_pool::StakedSui {
        let v0 = 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut 0x1::vector::borrow_mut<ValidatorInfo>(&mut arg0.validator_infos, arg1).staked_sui);
        refresh_validator_info(arg0, arg1);
        v0
    }

    public fun unstake_sui(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::StakeHandlerCap, arg1: &mut Vault, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg1.version == 1, 1);
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = &mut arg1.staker;
        let (v1, v2) = decrease_stake(v0, arg2, arg4, arg5, arg6);
        let v3 = v1;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::receive_token<0x2::sui::SUI>(0x1::vector::borrow_mut<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve::Reserve>(&mut arg1.reserves, arg3), v3, false);
        let v5 = UnstakeSuiEvent{
            sender        : 0x2::tx_context::sender(arg6),
            amount        : v4,
            reward_amount : v2,
        };
        0x2::event::emit<UnstakeSuiEvent>(v5);
        (v4, v2)
    }

    // decompiled from Move bytecode v6
}

