module 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market {
    struct MarketConfiguration has copy, drop, store {
        close_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        close_factor_bypass_min_value: u64,
    }

    struct FlashLoan<phantom T0, phantom T1> {
        inner: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::ReserveFlashLoan<T0, T1>,
        fee: u64,
    }

    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
        assets: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>,
        reserves: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>,
        ema_spot_tolerance: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>,
        emode_group_registry: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroupRegistry,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>,
        liquidity_miner: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidity_miner::LiquidityMiner<T0>,
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
        liquidation_ltv_threshold_override: 0x1::option::Option<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>,
        liquidation_incentive: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_revenue_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        close_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        close_factor_bypass_min_value: u64,
    }

    public(friend) fun new<T0>(arg0: MarketConfiguration, arg1: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = Market<T0>{
            id                   : 0x2::object::new(arg1),
            assets               : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::new<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(arg1),
            reserves             : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::new<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg1),
            ema_spot_tolerance   : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::new<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(arg1),
            emode_group_registry : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::new_e_mode_registry(arg1),
            obligations          : 0x2::object_table::new<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(arg1),
            liquidity_miner      : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidity_miner::new_liquidity_miner<T0>(arg1),
        };
        let v1 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::add<MarketConfigurationKey, MarketConfiguration>(&mut v0.id, v1, arg0);
        let v2 = CircuitBreakKey{dummy_field: false};
        0x2::dynamic_field::add<CircuitBreakKey, bool>(&mut v0.id, v2, false);
        let v3 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::add<ADLRegistryKey, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry>(&mut v0.id, v3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::new_auto_deleverage_registry(arg1));
        v0
    }

    fun try_stop_borrow_deleverage<T0, T1>(arg0: &mut 0x2::object::UID, arg1: u8, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg3: 0x1::type_name::TypeName) {
        let v0 = ADLRegistryKey{dummy_field: false};
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::try_stop_borrow_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry>(arg0, v0), 0x1::type_name::with_defining_ids<T0>(), arg1, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_amount(arg2, arg3)));
    }

    fun try_stop_collateral_deleverage<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg2: 0x1::type_name::TypeName) {
        let v0 = ADLRegistryKey{dummy_field: false};
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::try_stop_collateral_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry>(arg0, v0), 0x1::type_name::with_defining_ids<T0>(), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ceil(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::cash_plus_borrows_minus_reserves<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg1, arg2))));
    }

    fun accrue_interest<T0>(arg0: 0x1::type_name::TypeName, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::AssetConfig, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::interest::InterestModel, arg4: u64) : &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0> {
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg1, arg0);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::accrue_interest<T0>(v0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::repay_fee_rate(arg2), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::interest::calc_interest(arg3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::util_rate<T0>(v0)), arg4);
        v0
    }

    public(friend) fun adl_registry<T0>(arg0: &Market<T0>) : &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry {
        let v0 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<ADLRegistryKey, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry>(&arg0.id, v0)
    }

    public(friend) fun adl_registry_mut<T0>(arg0: &mut Market<T0>) : &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry {
        let v0 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry>(&mut arg0.id, v0)
    }

    public fun assert_emode_group_exists<T0>(arg0: &Market<T0>, arg1: u8) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::ensure_group_exists(&arg0.emode_group_registry, arg1);
    }

    public(friend) fun asset_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0> {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&arg0.assets, arg1)
    }

    public(friend) fun borrow_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoan<T0, T1>) {
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::with_defining_ids<T1>());
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::flash_loan_paused<T0>(v0), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::flash_loan_paused_for_asset());
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::flash_loan_ongoing<T0>(v0), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::flash_loan_ongoing());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::flash_loan_triggered<T0>(v0);
        let v1 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::with_defining_ids<T1>());
        let v2 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::int_mul(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::fee_rate(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::flash_loan(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group(&arg0.emode_group_registry, arg1), 0x1::type_name::with_defining_ids<T1>()))), arg2);
        assert!(v2 != 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::reserve_flash_loan_fee_too_small());
        let (v3, v4) = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::borrow_flash_loan<T0, T1>(v1, arg2);
        let v5 = FlashLoan<T0, T1>{
            inner : v4,
            fee   : v2,
        };
        (0x2::coin::from_balance<T1>(v3, arg3), v5)
    }

    public(friend) fun borrow_liquidity_mining<T0>(arg0: &Market<T0>) : &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidity_miner::LiquidityMiner<T0> {
        &arg0.liquidity_miner
    }

    public(friend) fun borrow_liquidity_mining_mut<T0>(arg0: &mut Market<T0>) : &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidity_miner::LiquidityMiner<T0> {
        &mut arg0.liquidity_miner
    }

    public fun borrow_obligation<T0>(arg0: &Market<T0>, arg1: 0x2::object::ID) : &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    fun collaterals_usd_for_liquidation<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        let v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero();
        let v1 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero();
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::deposit_types<T0>(arg2);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::collateral(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(arg0, v3));
            if (!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::can_be_collateral(v4)) {
                continue
            };
            let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::liquidation_factor(v4);
            let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::value::coin_value(0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_price(arg4, v3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::get_oracle_base_token(arg0), arg5), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::exchange_rate<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg1, v3)), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ctoken_amount_by_coin<T0>(arg2, v3))), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg3, v3));
            v1 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(v1, v6);
            v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(v0, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(v6, v5));
        };
        (v0, v1)
    }

    fun collaterals_usd_non_liquidation<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg4: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg6: &0x2::clock::Clock) : (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        let v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero();
        let v1 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero();
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::deposit_types<T0>(arg3);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::collateral(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(arg0, v3));
            if (!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::can_be_collateral(v4)) {
                continue
            };
            let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::collateral_factor(v4);
            let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::value::coin_value(0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_price_with_check(arg5, v3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::get_oracle_base_token(arg0), arg6, *0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(arg2, v3)), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::exchange_rate<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg1, v3)), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ctoken_amount_by_coin<T0>(arg3, v3))), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg4, v3));
            v1 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(v1, v6);
            v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(v0, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(v6, v5));
        };
        (v0, v1)
    }

    fun debts_value_usd_for_liquidation<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        let v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero();
        let v1 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero();
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt_types<T0>(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::value::coin_value(0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_price(arg4, v4, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::get_oracle_base_token(arg0), arg5), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::debt(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(arg2, v4), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::borrow_index::value(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::borrow_index<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg1, v4)))), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg3, v4));
            v1 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(v1, v5);
            v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(v0, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(v5, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_weight(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(arg0, v4)))));
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    fun debts_value_usd_non_liquidation<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg4: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg6: &0x2::clock::Clock) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        let v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero();
        let v1 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt_types<T0>(arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(v0, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::value::coin_value(0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_price_with_check(arg5, v3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::get_oracle_base_token(arg0), arg6, *0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(arg2, v3)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::debt(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(arg3, v3), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::borrow_index::value(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::borrow_index<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg1, v3)))), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg4, v3)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_weight(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(arg0, v3)))));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun discharge_circuit_break<T0>(arg0: &mut Market<T0>) {
        let v0 = CircuitBreakKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<CircuitBreakKey, bool>(&mut arg0.id, v0);
        assert!(*v1, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::not_under_circuit_break());
        *v1 = false;
    }

    public fun emode_registry<T0>(arg0: &Market<T0>) : &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroupRegistry {
        &arg0.emode_group_registry
    }

    public(friend) fun emode_registry_mut<T0>(arg0: &mut Market<T0>) : &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroupRegistry {
        &mut arg0.emode_group_registry
    }

    fun ensure_liquidate_borrow_allowed<T0, T1>(arg0: &LiquidationParams, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg4: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg7: &0x2::clock::Clock) {
        let (v0, v1) = debts_value_usd_for_liquidation<T0>(arg2, arg3, arg1, arg4, arg6, arg7);
        let (v2, v3) = collaterals_usd_for_liquidation<T0>(arg2, arg3, arg1, arg4, arg6, arg7);
        if (0x1::option::is_some<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(&arg0.liquidation_ltv_threshold_override)) {
            assert!(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::gt(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(v0, v3), *0x1::option::borrow<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(&arg0.liquidation_ltv_threshold_override)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::liquidation_obligation_still_safe());
        } else {
            assert!(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::gt(v0, v2), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::liquidation_obligation_still_safe());
        };
        if (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::le(v3, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from_quotient(101, 100), v1))) {
            return
        };
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::unsafe_debt_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(arg1, v4));
        if (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ceil(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::value::coin_value(0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_price(arg6, v4, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::get_oracle_base_token(arg2), arg7), v5, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg4, v4))) <= arg0.close_factor_bypass_min_value) {
            return
        };
        assert!(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::le(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(arg5), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(v5, arg0.close_factor)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::liquidation_close_factor_exceeded());
    }

    public fun exchange_rate<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::exchange_rate<T0>(reserve_by_type<T0>(arg0, arg1))
    }

    public fun fee<T0, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        arg0.fee
    }

    public(friend) fun handle_borrow<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64) : (0x2::balance::Balance<T1>, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        assert!(arg2 != 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::no_zero_amount());
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::borrow_paused<T0>(v1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::borrow_paused_for_asset());
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v1);
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v4 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::market_id<T0>(v3);
        assert!(&v4 == 0x2::object::uid_as_inner(&arg0.id), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_from_different_market());
        let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v3), 0x1::type_name::with_defining_ids<T1>());
        let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::max_borrow_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow(v5));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::add_outflow(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_mut_borrow_limiter(v5), arg6, arg2);
        let v7 = if (!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::has_debt<T0>(v3, v0)) {
            0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero()
        } else {
            0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::unsafe_debt_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(v3, v0))
        };
        let v8 = &mut arg0.reserves;
        refresh_obligation_borrow_interest_with_new_borrow<T0>(v0, &arg0.assets, v8, v3, arg6);
        let v9 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::borrow_index::value(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::borrow_index<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&arg0.reserves, v0)));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::try_borrow_asset<T0, T1>(v3, arg2, v9);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::min_borrow_amount(v2));
        let v10 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::unsafe_debt_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(v3, v0));
        let v11 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v3));
        assert!(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::le(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::update_asset_borrow(v11, v0, v7, v10), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(v6)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::emode_borrow_limit_exceeded());
        assert!(is_obligation_safe<T0>(v11, &arg0.reserves, &arg0.ema_spot_tolerance, 0x2::object_table::borrow<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&arg0.obligations, arg1), arg3, arg4, arg5), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_not_safe_after_operation());
        let v12 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&mut arg0.reserves, v0);
        assert!(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ceil(*0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::debt<T0>(v12)) <= 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::max_borrow_amount(v2), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::market_borrow_limit_exceeded());
        (0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::borrow_amount<T0, T1>(v12, arg2), v9, v10)
    }

    public(friend) fun handle_collateral_auto_deleverage<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = *0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::get_collateral_deleverage(adl_registry<T0>(arg0), v0);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v3 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::market_id<T0>(v2);
        assert!(&v3 == 0x2::object::uid_as_inner(&arg0.id), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_from_different_market());
        let v4 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v2));
        let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::collateral(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(v4, v0));
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::can_be_collateral(v5), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::asset_not_collateral());
        let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, v0);
        let v7 = &mut arg0.reserves;
        accrue_interest<T0>(v0, v7, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v6), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::interest_model<T0>(v6), arg6);
        let v8 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::inner<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::DeleverageParams>(&v1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::ensure_limit_breached(v8, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::cash_plus_borrows_minus_reserves<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&arg0.reserves, v0))));
        let v9 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::get_secs_since_activation<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::DeleverageParams>(&v1, arg5);
        let v10 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::some<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::liquidation_ltv(v8, v9)),
            liquidation_incentive              : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::min(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::liquidation_incentive(v8, v9), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::liquidation_incentive(v5)),
            liquidation_revenue_factor         : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero(),
            close_factor                       : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::close_factor(v8),
            close_factor_bypass_min_value      : market_config<T0>(arg0).close_factor_bypass_min_value,
        };
        let v11 = &mut arg0.id;
        let v12 = &mut arg0.reserves;
        liquidation_inner<T0, T1, T2>(v11, &arg0.assets, v4, v12, v2, &v10, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun handle_debt_auto_deleverage<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::market_id<T0>(v1);
        assert!(&v2 == 0x2::object::uid_as_inner(&arg0.id), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_from_different_market());
        let v3 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v1);
        let v4 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v1));
        let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::collateral(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(v4, 0x1::type_name::with_defining_ids<T2>()));
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::can_be_collateral(v5), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::asset_not_collateral());
        let v6 = ADLRegistryKey{dummy_field: false};
        let v7 = *0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::get_borrow_deleverage(0x2::dynamic_field::borrow<ADLRegistryKey, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry>(&arg0.id, v6), v0, v3);
        let v8 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, v0);
        let v9 = &mut arg0.reserves;
        accrue_interest<T0>(v0, v9, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v8), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::interest_model<T0>(v8), arg6);
        let v10 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::inner<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::DeleverageParams>(&v7);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::ensure_limit_breached(v10, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(*0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::debt<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&arg0.reserves, v0))));
        let v11 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::get_secs_since_activation<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::DeleverageParams>(&v7, arg5);
        let v12 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::some<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::liquidation_ltv(v10, v11)),
            liquidation_incentive              : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::min(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::liquidation_incentive(v10, v11), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::liquidation_incentive(v5)),
            liquidation_revenue_factor         : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero(),
            close_factor                       : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::close_factor(v10),
            close_factor_bypass_min_value      : market_config<T0>(arg0).close_factor_bypass_min_value,
        };
        let v13 = &mut arg0.id;
        let v14 = &mut arg0.reserves;
        liquidation_inner<T0, T1, T2>(v13, &arg0.assets, v4, v14, v1, &v12, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun handle_liquidation<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, u64) {
        let MarketConfiguration {
            close_factor                  : v0,
            close_factor_bypass_min_value : v1,
        } = *market_config<T0>(arg0);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v3 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::market_id<T0>(v2);
        assert!(&v3 == 0x2::object::uid_as_inner(&arg0.id), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_from_different_market());
        let v4 = 0x1::type_name::with_defining_ids<T2>();
        let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v2));
        let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::collateral(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(v5, v4));
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::can_be_collateral(v6), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::asset_not_collateral());
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::liquidation_paused<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, v4)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::liquidation_paused_for_asset());
        let v7 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::none<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(),
            liquidation_incentive              : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::liquidation_incentive(v6),
            liquidation_revenue_factor         : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::liquidation_fee_rate(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&arg0.assets, 0x1::type_name::with_defining_ids<T2>()))),
            close_factor                       : v0,
            close_factor_bypass_min_value      : v1,
        };
        let v8 = &mut arg0.id;
        let v9 = &mut arg0.reserves;
        liquidation_inner<T0, T1, T2>(v8, &arg0.assets, v5, v9, v2, &v7, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun handle_mint<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64) : (u64, u64) {
        assert!(0x2::coin::value<T1>(&arg2) != 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::no_zero_amount());
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::deposit_paused<T0>(v2), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::deposit_paused_for_asset());
        let v3 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v2);
        let v4 = &mut arg0.reserves;
        let v5 = accrue_interest<T0>(v0, v4, v3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::interest_model<T0>(v2), arg3);
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::deposit_limit_breached<T0>(v5, v1, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::max_deposit_amount(v3)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::market_deposit_limit_exceeded());
        let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::mint_ctokens<T0, T1>(v5, arg2);
        let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v8 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::market_id<T0>(v7);
        assert!(&v8 == 0x2::object::uid_as_inner(&arg0.id), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_from_different_market());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::deposit_ctoken<T0, T1>(v7, v6);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::reduce_outflow(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_mut_deposit_limiter(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v7), 0x1::type_name::with_defining_ids<T1>())), arg3, v1);
        (0x2::balance::value<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::ctoken::CToken<T0, T1>>(&v6), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ctoken_amount_by_coin<T0>(v7, v0))
    }

    public(friend) fun handle_new_obligation<T0>(arg0: &mut Market<T0>, arg1: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>) {
        0x2::object_table::add<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&arg1), arg1);
    }

    public(friend) fun handle_repay<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        assert!(0x2::coin::value<T1>(&arg2) != 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::no_zero_amount());
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, v0);
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::min_borrow_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v1));
        let v3 = &mut arg0.reserves;
        let v4 = accrue_interest<T0>(v0, v3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::interest_model<T0>(v1), arg3);
        let v5 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::market_id<T0>(v5);
        assert!(&v6 == 0x2::object::uid_as_inner(&arg0.id), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_from_different_market());
        let v7 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::unsafe_debt_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(v5, v0));
        let v8 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::borrow_index::value(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::borrow_index<T0>(v4));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v5, v2);
        let v9 = if (0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::has_debt<T0>(v5, v0)) {
            0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::unsafe_debt_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(v5, v0))
        } else {
            0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero()
        };
        let v10 = 0x2::coin::split<T1>(&mut arg2, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::repay_debt<T0, T1>(v5, 0x2::coin::value<T1>(&arg2), v8), arg4);
        let v11 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v5);
        let v12 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, v11);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::reduce_outflow(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_mut_borrow_limiter(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_mut(v12, v0)), arg3, 0x2::coin::value<T1>(&arg2));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::repay_amount<T0, T1>(v4, arg2);
        let v13 = ADLRegistryKey{dummy_field: false};
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::try_stop_borrow_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry>(&mut arg0.id, v13), 0x1::type_name::with_defining_ids<T0>(), v11, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ceil(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::update_asset_borrow(v12, v0, v7, v9)));
        (v10, v8, v9)
    }

    public(friend) fun handle_withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        assert!(arg2 != 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::no_zero_amount());
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::withdraw_paused<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&arg0.assets, v0)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::withdraw_paused_for_asset());
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::market_id<T0>(v1);
        assert!(&v2 == 0x2::object::uid_as_inner(&arg0.id), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_from_different_market());
        let v3 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v1));
        let v4 = &mut arg0.reserves;
        refresh_obligation_assets_interest<T0>(&arg0.assets, v3, v4, v1, arg6);
        assert!(is_obligation_safe<T0>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode_group(&arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v1)), &arg0.reserves, &arg0.ema_spot_tolerance, v1, arg3, arg4, arg5), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::obligation_not_safe_after_operation());
        let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&mut arg0.reserves, v0);
        let v6 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::burn_ctokens<T0, T1>(v5, 0x2::coin::from_balance<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::ctoken::CToken<T0, T1>>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::withdraw_ctokens<T0, T1>(v1, arg2), arg7));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::add_outflow(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_mut_deposit_limiter(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(v1), 0x1::type_name::with_defining_ids<T1>())), arg6, 0x2::balance::value<T1>(&v6));
        let v7 = ADLRegistryKey{dummy_field: false};
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::try_stop_collateral_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::adl::AutoDeleverageRegistry>(&mut arg0.id, v7), 0x1::type_name::with_defining_ids<T0>(), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ceil(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::total_deposit_plus_interest<T0>(v5)));
        (0x2::coin::from_balance<T1>(v6, arg7), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ctoken_amount_by_coin<T0>(v1, v0))
    }

    public(friend) fun has_circuit_break_triggered<T0>(arg0: &Market<T0>) : bool {
        let v0 = CircuitBreakKey{dummy_field: false};
        *0x2::dynamic_field::borrow<CircuitBreakKey, bool>(&arg0.id, v0)
    }

    fun is_obligation_safe<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg4: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg6: &0x2::clock::Clock) : bool {
        let (v0, _) = collaterals_usd_non_liquidation<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ge(v0, debts_value_usd_non_liquidation<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6))
    }

    public(friend) fun lending_default_emode_group() : u8 {
        0
    }

    fun liquidate_calculate_seize_ctokens<T0, T1>(arg0: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg2: u64, arg3: 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::BaseToken, arg4: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg5: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(arg2);
        let v3 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(v2, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(v2, arg1)), 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_spot_price(arg4, v0, arg3, arg6)), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::u64::pow10_u64(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg5, v0))), 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_spot_price(arg4, v1, arg3, arg6)), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::u64::pow10_u64(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg5, v1))), arg0);
        assert!(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::lt(v3, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(18446744073709551615)), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::invariant_seize_tokens_crazy_big());
        0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(v3)
    }

    fun liquidation_inner<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg3: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg4: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg5: &LiquidationParams, arg6: 0x2::coin::Coin<T1>, arg7: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, u64) {
        assert!(0x2::coin::value<T1>(&arg6) != 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::liquidation_zero_repay());
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::unsafe_debt_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(arg4, v0));
        refresh_obligation_assets_interest<T0>(arg1, arg2, arg3, arg4, arg10);
        ensure_liquidate_borrow_allowed<T0, T1>(arg5, arg4, arg2, arg3, arg7, 0x2::coin::value<T1>(&arg6), arg8, arg9);
        let v2 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ceil(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::unsafe_debt_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(arg4, v0)));
        let v3 = if (v2 < 0x2::coin::value<T1>(&arg6)) {
            0x2::coin::split<T1>(&mut arg6, 0x2::coin::value<T1>(&arg6) - v2, arg11)
        } else {
            0x2::coin::zero<T1>(arg11)
        };
        let v4 = v3;
        let v5 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg3, 0x1::type_name::with_defining_ids<T2>());
        let v6 = liquidate_calculate_seize_ctokens<T1, T2>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::exchange_rate<T0>(v5), arg5.liquidation_incentive, 0x2::coin::value<T1>(&arg6), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::get_oracle_base_token(arg2), arg8, arg7, arg9);
        let v7 = v6;
        let v8 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::ctoken_amount_by_coin<T0>(arg4, 0x1::type_name::with_defining_ids<T2>());
        if (v8 < v6) {
            0x2::coin::join<T1>(&mut v4, 0x2::coin::split<T1>(&mut arg6, 0x2::coin::value<T1>(&arg6) - 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ceil(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from_quotient(v8, v6), 0x2::coin::value<T1>(&arg6))), arg11));
            v7 = v8;
        };
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::unsafe_repay_debt_only<T0, T1>(arg4, 0x2::coin::value<T1>(&arg6));
        let v9 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::withdraw_ctokens<T0, T2>(arg4, v7);
        let v10 = if (!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::has_debt<T0>(arg4, v0)) {
            0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero()
        } else {
            0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::debt::unsafe_debt_amount(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt<T0>(arg4, v0))
        };
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::update_asset_borrow(arg2, v0, v1, v10);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::repay_amount<T0, T1>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(arg3, v0), arg6);
        try_stop_borrow_deleverage<T0, T1>(arg0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::emode_group<T0>(arg4), arg2, v0);
        try_stop_collateral_deleverage<T0, T2>(arg0, arg3, 0x1::type_name::with_defining_ids<T2>());
        (0x2::coin::from_balance<T2>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::liquidate_ctokens<T0, T2>(v5, 0x2::coin::from_balance<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::ctoken::CToken<T0, T2>>(v9, arg11), arg5.liquidation_revenue_factor), arg11), v4, 0x2::balance::value<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::ctoken::CToken<T0, T2>>(&v9))
    }

    public fun loan_amount<T0, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::amount<T0, T1>(&arg0.inner)
    }

    public(friend) fun market_asset_borrow_mut<T0, T1>(arg0: &mut Market<T0>) : &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0> {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::with_defining_ids<T1>())
    }

    public(friend) fun market_config<T0>(arg0: &Market<T0>) : &MarketConfiguration {
        let v0 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::borrow<MarketConfigurationKey, MarketConfiguration>(&arg0.id, v0)
    }

    public(friend) fun new_market_configuration(arg0: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg1: u64) : MarketConfiguration {
        MarketConfiguration{
            close_factor                  : arg0,
            close_factor_bypass_min_value : arg1,
        }
    }

    public(friend) fun onboard_new_asset<T0, T1>(arg0: &mut Market<T0>, arg1: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::interest::InterestModel, arg2: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::AssetConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::supports<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>, T1>(&arg0.assets), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::asset_already_onboarded());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::store<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>, T1>(&mut arg0.assets, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::new<T0>(arg1, arg2, arg4));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::store<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>, T1>(&mut arg0.reserves, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::new<T0, T1>(arg4, arg3));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::store<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, T1>(&mut arg0.ema_spot_tolerance, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from_quotient(1000, 10000));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidity_miner::support_coin<T0, T1>(&mut arg0.liquidity_miner, arg4);
    }

    fun refresh_obligation_assets_interest<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::EModeGroup, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg3: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg4: u64) {
        refresh_obligation_borrow_interest<T0>(arg0, arg2, arg3, arg4);
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::deposit_types<T0>(arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(arg0, v2);
            v1 = v1 + 1;
            if (!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::can_be_collateral(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::collateral(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::borrow_emode(arg1, v2)))) {
                continue
            };
            accrue_interest<T0>(v2, arg2, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v3), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::interest_model<T0>(v3), arg4);
        };
    }

    fun refresh_obligation_borrow_interest<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg3: u64) {
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::debt_types<T0>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(arg0, v2);
            0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::accrue_interest<T0>(arg2, v2, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::borrow_index::value(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::borrow_index<T0>(accrue_interest<T0>(v2, arg1, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v3), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::interest_model<T0>(v3), arg3))));
            v1 = v1 + 1;
        };
    }

    fun refresh_obligation_borrow_interest_with_new_borrow<T0>(arg0: 0x1::type_name::TypeName, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::GenericCoinTypeStorage<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>, arg3: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::Obligation<T0>, arg4: u64) {
        refresh_obligation_borrow_interest<T0>(arg1, arg2, arg3, arg4);
        if (0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::obligation::has_debt<T0>(arg3, arg0)) {
            return
        };
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(arg1, arg0);
        accrue_interest<T0>(arg0, arg2, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::asset_config<T0>(v0), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::interest_model<T0>(v0), arg4);
    }

    public(friend) fun repay_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: FlashLoan<T0, T1>, arg3: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::referral::Referral, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::with_defining_ids<T1>());
        assert!(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::flash_loan_ongoing<T0>(v0), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::flash_loan_not_ongoing());
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::flash_loan_finished<T0>(v0);
        let FlashLoan {
            inner : v1,
            fee   : v2,
        } = arg2;
        let v3 = v1;
        assert!(0x2::coin::value<T1>(&arg1) == 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::amount<T0, T1>(&v3) + v2, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::reserve_flash_loan_not_paid_enough());
        let v4 = 0x2::coin::split<T1>(&mut arg1, v2, arg5);
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            let v5 = v4;
            v4 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::referral::track_flash_loan_usage<T1>(arg3, v5, 0x1::option::extract<0x1::string::String>(&mut arg4), 0x2::tx_context::sender(arg5), arg5);
            assert!(0x2::coin::value<T1>(&v4) != 0, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::reserve_flash_loan_fee_too_small());
        };
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::repay_flash_loan<T0, T1>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::with_defining_ids<T1>()), v3, arg1, v4);
    }

    public(friend) fun reserve_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0> {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&arg0.reserves, arg1)
    }

    public(friend) fun set_ema_spot_tolerance<T0, T1>(arg0: &mut Market<T0>, arg1: u64) {
        assert!(arg1 < 10000, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::invalid_params_error());
        *0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal>(&mut arg0.ema_spot_tolerance, 0x1::type_name::with_defining_ids<T1>()) = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from_quotient(arg1, 10000);
    }

    public(friend) fun supported_assets<T0>(arg0: &Market<T0>) : vector<0x1::type_name::TypeName> {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::keys<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset::Asset<T0>>(&arg0.assets)
    }

    public(friend) fun take_revenue<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::take_revenue<T0, T1>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::generic_store::load_mut_by_type<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::with_defining_ids<T1>()), arg1), arg2)
    }

    public(friend) fun trigger_circuit_break<T0>(arg0: &mut Market<T0>) {
        let v0 = CircuitBreakKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<CircuitBreakKey, bool>(&mut arg0.id, v0);
        assert!(!*v1, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::already_under_circuit_break());
        *v1 = true;
    }

    public(friend) fun update_market_config<T0>(arg0: &mut Market<T0>, arg1: MarketConfiguration) {
        let v0 = MarketConfigurationKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<MarketConfigurationKey, MarketConfiguration>(&mut arg0.id, v0) = arg1;
    }

    // decompiled from Move bytecode v6
}

