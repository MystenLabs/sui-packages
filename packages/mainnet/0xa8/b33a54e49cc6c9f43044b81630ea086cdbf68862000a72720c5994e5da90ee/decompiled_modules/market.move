module 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market {
    struct MarketConfiguration has copy, drop, store {
        close_factor: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        close_factor_bypass_min_value: u64,
    }

    struct FlashLoan<phantom T0, phantom T1> {
        inner: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::ReserveFlashLoan<T0, T1>,
        fee: u64,
    }

    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        assets: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>,
        reserves: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>,
        ema_spot_tolerance: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>,
        emode_group_registry: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroupRegistry,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>,
        liquidity_miner: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::liquidity_miner::LiquidityMiner<T0>,
    }

    struct MarketConfigurationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CircuitBreakKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ADLRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LiquidationParams has drop {
        liquidation_ltv_threshold_override: 0x1::option::Option<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>,
        liquidation_incentive: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        liquidation_revenue_factor: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        close_factor: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        close_factor_bypass_min_value: u64,
    }

    public(friend) fun new<T0>(arg0: MarketConfiguration, arg1: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = Market<T0>{
            id                   : 0x2::object::new(arg1),
            version              : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::current_version::current_version(),
            assets               : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::new<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(arg1),
            reserves             : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::new<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg1),
            ema_spot_tolerance   : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::new<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(arg1),
            emode_group_registry : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::new_e_mode_registry(arg1),
            obligations          : 0x2::object_table::new<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(arg1),
            liquidity_miner      : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::liquidity_miner::new_liquidity_miner<T0>(arg1),
        };
        let v1 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::add<MarketConfigurationKey, MarketConfiguration>(&mut v0.id, v1, arg0);
        let v2 = CircuitBreakKey{dummy_field: false};
        0x2::dynamic_field::add<CircuitBreakKey, bool>(&mut v0.id, v2, false);
        let v3 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::add<ADLRegistryKey, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry>(&mut v0.id, v3, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::new_auto_deleverage_registry(arg1));
        v0
    }

    fun accrue_interest<T0, T1>(arg0: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::AssetConfig, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::InterestModel, arg3: u64) : &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0> {
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg0, 0x1::type_name::get<T1>());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::accrue_interest<T0>(v0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::repay_fee_rate(arg1), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::calc_interest(arg2, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::util_rate<T0>(v0)), arg3);
        v0
    }

    public(friend) fun adl_registry<T0>(arg0: &Market<T0>) : &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry {
        let v0 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<ADLRegistryKey, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry>(&arg0.id, v0)
    }

    public(friend) fun adl_registry_mut<T0>(arg0: &mut Market<T0>) : &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry {
        let v0 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry>(&mut arg0.id, v0)
    }

    public fun assert_emode_group_exists<T0>(arg0: &Market<T0>, arg1: u8) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::ensure_group_exists(&arg0.emode_group_registry, arg1);
    }

    public(friend) fun asset_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0> {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&arg0.assets, arg1)
    }

    public(friend) fun borrow_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoan<T0, T1>) {
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::flash_loan_paused<T0>(v0), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::flash_loan_paused_for_asset());
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::flash_loan_ongoing<T0>(v0), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::flash_loan_ongoing());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::flash_loan_triggered<T0>(v0);
        let v1 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>());
        let v2 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::int_mul(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::fee_rate(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::flash_loan(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, arg1), 0x1::type_name::get<T1>()))), arg2);
        assert!(v2 != 0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::reserve_flash_loan_fee_too_small());
        let (v3, v4) = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_flash_loan<T0, T1>(v1, arg2);
        let v5 = FlashLoan<T0, T1>{
            inner : v4,
            fee   : v2,
        };
        (0x2::coin::from_balance<T1>(v3, arg3), v5)
    }

    public(friend) fun borrow_liquidity_mining<T0>(arg0: &Market<T0>) : &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::liquidity_miner::LiquidityMiner<T0> {
        &arg0.liquidity_miner
    }

    public(friend) fun borrow_liquidity_mining_mut<T0>(arg0: &mut Market<T0>) : &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::liquidity_miner::LiquidityMiner<T0> {
        &mut arg0.liquidity_miner
    }

    public fun borrow_obligation<T0>(arg0: &Market<T0>, arg1: 0x2::object::ID) : &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    fun collaterals_usd_for_liquidation<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroup, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal) {
        let v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero();
        let v1 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero();
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::deposit_types<T0>(arg2);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::collateral(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(arg0, v3));
            if (!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::can_be_collateral(v4)) {
                continue
            };
            let v5 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::liquidation_factor(v4);
            let v6 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::value::coin_value(0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price(arg4, v3, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::get_oracle_base_token(arg0), arg5), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::exchange_rate<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg1, v3)), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::ctoken_amount_by_coin<T0>(arg2, v3))), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::decimals(arg3, v3));
            v1 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::add(v1, v6);
            v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::add(v0, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(v6, v5));
        };
        (v0, v1)
    }

    fun collaterals_usd_non_liquidation<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroup, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg4: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg6: &0x2::clock::Clock) : (0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal) {
        let v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero();
        let v1 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero();
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::deposit_types<T0>(arg3);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::collateral(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(arg0, v3));
            if (!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::can_be_collateral(v4)) {
                continue
            };
            let v5 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::collateral_factor(v4);
            let v6 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::value::coin_value(0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price_with_check(arg5, v3, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::get_oracle_base_token(arg0), arg6, *0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(arg2, v3)), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::exchange_rate<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg1, v3)), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::ctoken_amount_by_coin<T0>(arg3, v3))), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::decimals(arg4, v3));
            v1 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::add(v1, v6);
            v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::add(v0, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(v6, v5));
        };
        (v0, v1)
    }

    fun debts_value_usd_for_liquidation<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroup, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal) {
        let v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero();
        let v1 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero();
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt_types<T0>(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v5 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::value::coin_value(0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price(arg4, v4, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::get_oracle_base_token(arg0), arg5), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::debt::debt(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt<T0>(arg2, v4), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::borrow_index::value(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_index<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg1, v4)))), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::decimals(arg3, v4));
            v1 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::add(v1, v5);
            v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::add(v0, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(v5, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_weight(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(arg0, v4)))));
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    fun debts_value_usd_non_liquidation<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroup, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg4: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg6: &0x2::clock::Clock) : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal {
        let v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero();
        let v1 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt_types<T0>(arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::add(v0, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::value::coin_value(0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price_with_check(arg5, v3, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::get_oracle_base_token(arg0), arg6, *0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(arg2, v3)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::debt::debt(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt<T0>(arg3, v3), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::borrow_index::value(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_index<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg1, v3)))), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::decimals(arg4, v3)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_weight(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(arg0, v3)))));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun discharge_circuit_break<T0>(arg0: &mut Market<T0>) {
        let v0 = CircuitBreakKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<CircuitBreakKey, bool>(&mut arg0.id, v0) = false;
    }

    public fun emode_registry<T0>(arg0: &Market<T0>) : &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroupRegistry {
        &arg0.emode_group_registry
    }

    public(friend) fun emode_registry_mut<T0>(arg0: &mut Market<T0>) : &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroupRegistry {
        &mut arg0.emode_group_registry
    }

    fun ensure_liquidate_borrow_allowed<T0, T1>(arg0: &LiquidationParams, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroup, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg4: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg7: &0x2::clock::Clock) {
        let (v0, v1) = debts_value_usd_for_liquidation<T0>(arg2, arg3, arg1, arg4, arg6, arg7);
        let (v2, v3) = collaterals_usd_for_liquidation<T0>(arg2, arg3, arg1, arg4, arg6, arg7);
        if (0x1::option::is_some<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(&arg0.liquidation_ltv_threshold_override)) {
            assert!(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::gt(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::div(v0, v3), *0x1::option::borrow<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(&arg0.liquidation_ltv_threshold_override)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::liquidation_obligation_still_safe());
        } else {
            assert!(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::gt(v0, v2), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::liquidation_obligation_still_safe());
        };
        if (0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::le(v3, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(101, 100), v1))) {
            return
        };
        let v4 = 0x1::type_name::get<T1>();
        let v5 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::debt::unsafe_debt_amount(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt<T0>(arg1, v4));
        if (0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::ceil(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::value::coin_value(0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price(arg6, v4, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::get_oracle_base_token(arg2), arg7), v5, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::decimals(arg4, v4))) < arg0.close_factor_bypass_min_value) {
            return
        };
        assert!(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::le(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from(arg5), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(v5, arg0.close_factor)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::liquidation_close_factor_exceeded());
    }

    public(friend) fun ensure_version_matches<T0>(arg0: &Market<T0>) {
        assert!(arg0.version == 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::current_version::current_version(), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::version_mismatch());
    }

    public fun exchange_rate<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::exchange_rate<T0>(reserve_by_type<T0>(arg0, arg1))
    }

    public fun fee<T0, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        arg0.fee
    }

    public(friend) fun handle_borrow<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64) : (0x2::balance::Balance<T1>, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal) {
        assert!(arg2 > 0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::zero_debt_to_repay_error());
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::borrow_paused<T0>(v1), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::borrow_paused_for_asset());
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::min_borrow_amount(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::asset_config<T0>(v1));
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v3), 0x1::type_name::get<T1>());
        let v5 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::max_borrow_amount(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow(v4));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::limiter::add_outflow(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_mut_borrow_limiter(v4), arg6, arg2);
        let v6 = &mut arg0.reserves;
        refresh_obligation_borrow_interest<T0>(&arg0.assets, v6, v3, arg6);
        let v7 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::borrow_index::value(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_index<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&arg0.reserves, v0)));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::try_borrow_asset<T0, T1>(v3, arg2, v7);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v3, v2);
        assert!(is_obligation_safe<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v3)), &arg0.reserves, &arg0.ema_spot_tolerance, 0x2::object_table::borrow<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&arg0.obligations, arg1), arg3, arg4, arg5), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::obligation_not_safe_after_operation());
        let v8 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&mut arg0.reserves, v0);
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_limit_breached<T0>(v8, arg2, v5), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_borrow_limit_exceeded());
        (0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_amount<T0, T1>(v8, arg2), v7, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::debt::unsafe_debt_amount(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt<T0>(v3, v0)))
    }

    public(friend) fun handle_collateral_auto_deleverage<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let v0 = 0x1::type_name::get<T2>();
        let v1 = *0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::get_collateral_deleverage(adl_registry<T0>(arg0), v0);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v3 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::market_id<T0>(v2);
        assert!(&v3 == 0x2::object::uid_as_inner(&arg0.id), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::obligation_from_different_market());
        let v4 = &mut arg0.reserves;
        refresh_obligation_assets_interest<T0>(&arg0.assets, &arg0.emode_group_registry, v4, v2, arg6);
        let v5 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::collateral(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v2)), 0x1::type_name::get<T2>()));
        assert!(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::can_be_collateral(v5), 13906836867287875583);
        let v6 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::inner<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::DeleverageParams>(&v1);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::ensure_limit_breached(v6, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::cash_plus_borrows_minus_reserves<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&arg0.reserves, v0))));
        let v7 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::get_secs_since_activation<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::DeleverageParams>(&v1, arg5);
        let v8 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::some<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::liquidation_ltv(v6, v7)),
            liquidation_incentive              : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::min(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::liquidation_incentive(v6, v7), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::liquidation_incentive(v5)),
            liquidation_revenue_factor         : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero(),
            close_factor                       : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::close_factor(v6),
            close_factor_bypass_min_value      : market_config<T0>(arg0).close_factor_bypass_min_value,
        };
        let v9 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v2));
        let v10 = &mut arg0.reserves;
        let (v11, v12) = liquidation_inner<T0, T1, T2>(v9, v10, v2, &v8, arg2, arg3, arg4, arg5, arg7);
        let v13 = ADLRegistryKey{dummy_field: false};
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::try_stop_collateral_deleverage<T2>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry>(&mut arg0.id, v13), 0x1::type_name::get<T0>(), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::ceil(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::cash_plus_borrows_minus_reserves<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&mut arg0.reserves, v0))));
        (v11, v12)
    }

    public(friend) fun handle_debt_auto_deleverage<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::market_id<T0>(v1);
        assert!(&v2 == 0x2::object::uid_as_inner(&arg0.id), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::obligation_from_different_market());
        let v3 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::collateral(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v1)), 0x1::type_name::get<T2>()));
        assert!(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::can_be_collateral(v3), 13906836523690491903);
        let v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::liquidation_incentive(v3);
        let v5 = &mut arg0.reserves;
        refresh_obligation_assets_interest<T0>(&arg0.assets, &arg0.emode_group_registry, v5, v1, arg6);
        let v6 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v1);
        let v7 = ADLRegistryKey{dummy_field: false};
        let v8 = *0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::get_borrow_deleverage(0x2::dynamic_field::borrow<ADLRegistryKey, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry>(&arg0.id, v7), v0, v6);
        let v9 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::inner<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::DeleverageParams>(&v8);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::ensure_limit_breached(v9, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(*0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::debt<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&arg0.reserves, v0))));
        let v10 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::get_secs_since_activation<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::DeleverageParams>(&v8, arg5);
        let v11 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::some<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::liquidation_ltv(v9, v10)),
            liquidation_incentive              : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::min(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::liquidation_incentive(v9, v10), v4),
            liquidation_revenue_factor         : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero(),
            close_factor                       : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::close_factor(v9),
            close_factor_bypass_min_value      : market_config<T0>(arg0).close_factor_bypass_min_value,
        };
        let v12 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v1));
        let v13 = &mut arg0.reserves;
        let (v14, v15) = liquidation_inner<T0, T1, T2>(v12, v13, v1, &v11, arg2, arg3, arg4, arg5, arg7);
        let v16 = ADLRegistryKey{dummy_field: false};
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::try_stop_borrow_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry>(&mut arg0.id, v16), 0x1::type_name::get<T0>(), v6, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(*0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::debt<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&arg0.reserves, v0))));
        (v14, v15)
    }

    public(friend) fun handle_liquidation<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let MarketConfiguration {
            close_factor                  : v0,
            close_factor_bypass_min_value : v1,
        } = *market_config<T0>(arg0);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v3 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::market_id<T0>(v2);
        assert!(&v3 == 0x2::object::uid_as_inner(&arg0.id), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::obligation_from_different_market());
        let v4 = &mut arg0.reserves;
        refresh_obligation_assets_interest<T0>(&arg0.assets, &arg0.emode_group_registry, v4, v2, arg6);
        let v5 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::collateral(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v2)), 0x1::type_name::get<T2>()));
        assert!(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::can_be_collateral(v5), 13906836321827028991);
        let v6 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::none<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(),
            liquidation_incentive              : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::liquidation_incentive(v5),
            liquidation_revenue_factor         : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::liquidation_fee_rate(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::asset_config<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&arg0.assets, 0x1::type_name::get<T2>()))),
            close_factor                       : v0,
            close_factor_bypass_min_value      : v1,
        };
        let v7 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v2));
        let v8 = &mut arg0.reserves;
        liquidation_inner<T0, T1, T2>(v7, v8, v2, &v6, arg2, arg3, arg4, arg5, arg7)
    }

    public(friend) fun handle_mint<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::deposit_paused<T0>(v2), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::deposit_paused_for_asset());
        let v3 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::asset_config<T0>(v2);
        let v4 = &mut arg0.reserves;
        let v5 = accrue_interest<T0, T1>(v4, v3, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::interest_model<T0>(v2), arg3);
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::deposit_limit_breached<T0>(v5, v1, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::max_deposit_amount(v3)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_deposit_limit_exceeded());
        let v6 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::mint_ctokens<T0, T1>(v5, arg2);
        let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v8 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::market_id<T0>(v7);
        assert!(&v8 == 0x2::object::uid_as_inner(&arg0.id), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::obligation_from_different_market());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::deposit_ctoken<T0, T1>(v7, v6);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::limiter::reduce_outflow(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_mut_deposit_limiter(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v7), 0x1::type_name::get<T1>())), arg3, v1);
        (0x2::balance::value<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::ctoken::CToken<T0, T1>>(&v6), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::ctoken_amount_by_coin<T0>(v7, v0))
    }

    public(friend) fun handle_new_obligation<T0>(arg0: &mut Market<T0>, arg1: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>) {
        0x2::object_table::add<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&arg1), arg1);
    }

    public(friend) fun handle_repay<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&mut arg0.assets, v0);
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::min_borrow_amount(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::asset_config<T0>(v1));
        let v3 = &mut arg0.reserves;
        let v4 = accrue_interest<T0, T1>(v3, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::asset_config<T0>(v1), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::interest_model<T0>(v1), arg3);
        let v5 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v6 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::market_id<T0>(v5);
        assert!(&v6 == 0x2::object::uid_as_inner(&arg0.id), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::obligation_from_different_market());
        let v7 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::borrow_index::value(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_index<T0>(v4));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v5, v2);
        let v8 = if (0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::has_debt<T0>(v5, v0)) {
            0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::debt::unsafe_debt_amount(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt<T0>(v5, v0))
        } else {
            0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero()
        };
        let v9 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v5);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::limiter::reduce_outflow(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_mut_borrow_limiter(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_mut_emode(&mut arg0.emode_group_registry, v9, 0x1::type_name::get<T1>())), arg3, 0x2::coin::value<T1>(&arg2));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::repay_amount<T0, T1>(v4, arg2);
        let v10 = ADLRegistryKey{dummy_field: false};
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::try_stop_borrow_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry>(&mut arg0.id, v10), 0x1::type_name::get<T0>(), v9, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::ceil(*0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::debt<T0>(v4)));
        (0x2::coin::split<T1>(&mut arg2, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::repay_debt<T0, T1>(v5, 0x2::coin::value<T1>(&arg2), v7), arg4), v7, v8)
    }

    public(friend) fun handle_withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::withdraw_paused<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&arg0.assets, v0)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::withdraw_paused_for_asset());
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v2 = &mut arg0.reserves;
        refresh_obligation_borrow_interest<T0>(&arg0.assets, v2, v1, arg6);
        assert!(is_obligation_safe<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(&arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v1)), &arg0.reserves, &arg0.ema_spot_tolerance, v1, arg3, arg4, arg5), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::obligation_not_safe_after_operation());
        let v3 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&mut arg0.reserves, v0);
        let v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::burn_ctokens<T0, T1>(v3, 0x2::coin::from_balance<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::ctoken::CToken<T0, T1>>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::withdraw_ctokens<T0, T1>(v1, arg2), arg7));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::limiter::add_outflow(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_mut_deposit_limiter(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(v1), 0x1::type_name::get<T1>())), arg6, 0x2::balance::value<T1>(&v4));
        let v5 = ADLRegistryKey{dummy_field: false};
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::try_stop_collateral_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::adl::AutoDeleverageRegistry>(&mut arg0.id, v5), 0x1::type_name::get<T0>(), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::ceil(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::total_deposit_plus_interest<T0>(v3)));
        (0x2::coin::from_balance<T1>(v4, arg7), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::ctoken_amount_by_coin<T0>(v1, v0))
    }

    public(friend) fun has_circuit_break_triggered<T0>(arg0: &Market<T0>) : bool {
        let v0 = CircuitBreakKey{dummy_field: false};
        *0x2::dynamic_field::borrow<CircuitBreakKey, bool>(&arg0.id, v0)
    }

    fun is_obligation_safe<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroup, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>, arg3: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg4: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg6: &0x2::clock::Clock) : bool {
        let (v0, _) = collaterals_usd_non_liquidation<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::ge(v0, debts_value_usd_non_liquidation<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6))
    }

    public(friend) fun lending_default_emode_group() : u8 {
        0
    }

    fun liquidate_calculate_seize_ctokens<T0, T1>(arg0: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, arg1: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, arg2: u64, arg3: 0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::BaseToken, arg4: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from(arg2);
        let v1 = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::div(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::div(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::add(v0, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(v0, arg1)), 0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price(arg4, 0x1::type_name::get<T0>(), arg3, arg5)), 0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::user_oracle::get_price(arg4, 0x1::type_name::get<T1>(), arg3, arg5)), arg0);
        assert!(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::lt(v1, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from(18446744073709551615)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invariant_seize_tokens_crazy_big());
        0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(v1)
    }

    fun liquidation_inner<T0, T1, T2>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroup, arg1: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg3: &LiquidationParams, arg4: 0x2::coin::Coin<T1>, arg5: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        assert!(0x2::coin::value<T1>(&arg4) != 0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::liquidation_zero_repay());
        ensure_liquidate_borrow_allowed<T0, T1>(arg3, arg2, arg0, arg1, arg5, 0x2::coin::value<T1>(&arg4), arg6, arg7);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::unsafe_repay_debt_only<T0, T1>(arg2, 0x2::coin::value<T1>(&arg4));
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg1, 0x1::type_name::get<T2>());
        let v1 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::withdraw_ctokens<T0, T2>(arg2, liquidate_calculate_seize_ctokens<T1, T2>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::exchange_rate<T0>(v0), arg3.liquidation_incentive, 0x2::coin::value<T1>(&arg4), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::get_oracle_base_token(arg0), arg6, arg7));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::repay_amount<T0, T1>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg1, 0x1::type_name::get<T1>()), arg4);
        (0x2::coin::from_balance<T2>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::liquidate_ctokens<T0, T2>(v0, 0x2::coin::from_balance<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::ctoken::CToken<T0, T2>>(v1, arg8), arg3.liquidation_revenue_factor), arg8), 0x2::balance::value<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::ctoken::CToken<T0, T2>>(&v1))
    }

    public fun loan_amount<T0, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::amount<T0, T1>(&arg0.inner)
    }

    public(friend) fun market_asset_borrow_mut<T0, T1>(arg0: &mut Market<T0>) : &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0> {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>())
    }

    public(friend) fun market_config<T0>(arg0: &Market<T0>) : &MarketConfiguration {
        let v0 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::borrow<MarketConfigurationKey, MarketConfiguration>(&arg0.id, v0)
    }

    public(friend) fun new_market_configuration(arg0: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, arg1: u64) : MarketConfiguration {
        MarketConfiguration{
            close_factor                  : arg0,
            close_factor_bypass_min_value : arg1,
        }
    }

    public(friend) fun onboard_new_asset<T0, T1>(arg0: &mut Market<T0>, arg1: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::InterestModel, arg2: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::AssetConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::supports<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>, T1>(&arg0.assets), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::asset_already_onboarded());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::store<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>, T1>(&mut arg0.assets, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::new<T0>(arg1, arg2, arg4));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::store<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>, T1>(&mut arg0.reserves, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::new<T0, T1>(arg4, arg3));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::store<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, T1>(&mut arg0.ema_spot_tolerance, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(1000, 10000));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::liquidity_miner::support_coin<T0, T1>(&mut arg0.liquidity_miner, arg4);
    }

    fun refresh_obligation_assets_interest<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::EModeGroupRegistry, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg3: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg4: u64) {
        refresh_obligation_borrow_interest<T0>(arg0, arg2, arg3, arg4);
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::deposit_types<T0>(arg3);
        let v1 = 0;
        let v2 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode_group(arg1, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::emode_group<T0>(arg3));
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(arg0, v3);
            v1 = v1 + 1;
            if (!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::can_be_collateral(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::collateral(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::emode::borrow_emode(v2, v3)))) {
                continue
            };
            let v5 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg2, v3);
            0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::accrue_interest<T0>(v5, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::repay_fee_rate(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::asset_config<T0>(v4)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::calc_interest(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::interest_model<T0>(v4), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::util_rate<T0>(v5)), arg4);
        };
    }

    fun refresh_obligation_borrow_interest<T0>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>, arg1: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::GenericCoinTypeStorage<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::Obligation<T0>, arg3: u64) {
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::debt_types<T0>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(arg0, v2);
            let v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(arg1, v2);
            0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::accrue_interest<T0>(v4, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::repay_fee_rate(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::asset_config<T0>(v3)), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::calc_interest(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::interest_model<T0>(v3), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::util_rate<T0>(v4)), arg3);
            0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::accrue_interest<T0>(arg2, v2, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::borrow_index::value(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::borrow_index<T0>(v4)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun repay_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: FlashLoan<T0, T1>, arg3: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::referral::Referral, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::flash_loan_ongoing<T0>(v0), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::flash_loan_not_ongoing());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::flash_loan_finished<T0>(v0);
        let FlashLoan {
            inner : v1,
            fee   : v2,
        } = arg2;
        let v3 = v1;
        assert!(0x2::coin::value<T1>(&arg1) == 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::amount<T0, T1>(&v3) + v2, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::reserve_flash_loan_not_paid_enough());
        let v4 = 0x2::coin::split<T1>(&mut arg1, v2, arg5);
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            let v5 = v4;
            v4 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::referral::track_flash_loan_usage<T1>(arg3, v5, 0x1::option::extract<0x1::string::String>(&mut arg4), 0x2::tx_context::sender(arg5), arg5);
            assert!(0x2::coin::value<T1>(&v4) != 0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::reserve_flash_loan_fee_too_small());
        };
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::repay_flash_loan<T0, T1>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), v3, arg1, v4);
    }

    public(friend) fun reserve_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0> {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&arg0.reserves, arg1)
    }

    public(friend) fun set_ema_spot_tolerance<T0, T1>(arg0: &mut Market<T0>, arg1: u64) {
        assert!(arg1 < 10000, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invalid_params_error());
        *0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal>(&mut arg0.ema_spot_tolerance, 0x1::type_name::get<T1>()) = 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg1, 10000);
    }

    public(friend) fun supported_assets<T0>(arg0: &Market<T0>) : vector<0x1::type_name::TypeName> {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::keys<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::Asset<T0>>(&arg0.assets)
    }

    public(friend) fun take_revenue<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::take_revenue<T0, T1>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::generic_store::load_mut_by_type<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1), arg2)
    }

    public(friend) fun trigger_circuit_break<T0>(arg0: &mut Market<T0>) {
        let v0 = CircuitBreakKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<CircuitBreakKey, bool>(&mut arg0.id, v0) = true;
    }

    public(friend) fun update_market_config<T0>(arg0: &mut Market<T0>, arg1: MarketConfiguration) {
        let v0 = MarketConfigurationKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<MarketConfigurationKey, MarketConfiguration>(&mut arg0.id, v0) = arg1;
    }

    // decompiled from Move bytecode v6
}

