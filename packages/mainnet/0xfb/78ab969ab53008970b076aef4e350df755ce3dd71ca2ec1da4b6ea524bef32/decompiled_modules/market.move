module 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market {
    struct MarketConfiguration has copy, drop, store {
        close_factor: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal,
        close_factor_bypass_min_value: u64,
    }

    struct FlashLoan<phantom T0, phantom T1> {
        inner: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::ReserveFlashLoan<T0, T1>,
        fee: u64,
    }

    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        assets: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>,
        reserves: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>,
        ema_spot_tolerance: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>,
        emode_group_registry: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroupRegistry,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>,
        liquidity_miner: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::liquidity_miner::LiquidityMiner<T0>,
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
        liquidation_ltv_threshold_override: 0x1::option::Option<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>,
        liquidation_incentive: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal,
        liquidation_revenue_factor: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal,
        close_factor: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal,
        close_factor_bypass_min_value: u64,
    }

    public(friend) fun new<T0>(arg0: MarketConfiguration, arg1: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = Market<T0>{
            id                   : 0x2::object::new(arg1),
            version              : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::current_version::current_version(),
            assets               : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::new<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(arg1),
            reserves             : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::new<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg1),
            ema_spot_tolerance   : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::new<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(arg1),
            emode_group_registry : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::new_e_mode_registry(arg1),
            obligations          : 0x2::object_table::new<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(arg1),
            liquidity_miner      : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::liquidity_miner::new_liquidity_miner<T0>(arg1),
        };
        let v1 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::add<MarketConfigurationKey, MarketConfiguration>(&mut v0.id, v1, arg0);
        let v2 = CircuitBreakKey{dummy_field: false};
        0x2::dynamic_field::add<CircuitBreakKey, bool>(&mut v0.id, v2, false);
        let v3 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::add<ADLRegistryKey, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry>(&mut v0.id, v3, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::new_auto_deleverage_registry(arg1));
        v0
    }

    fun try_stop_borrow_deleverage<T0, T1>(arg0: &mut 0x2::object::UID, arg1: u8, arg2: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg3: 0x1::type_name::TypeName) {
        let v0 = ADLRegistryKey{dummy_field: false};
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::try_stop_borrow_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry>(arg0, v0), 0x1::type_name::get<T0>(), arg1, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::floor(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_amount(arg2, arg3)));
    }

    fun try_stop_collateral_deleverage<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg2: 0x1::type_name::TypeName) {
        let v0 = ADLRegistryKey{dummy_field: false};
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::try_stop_collateral_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry>(arg0, v0), 0x1::type_name::get<T0>(), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::ceil(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::cash_plus_borrows_minus_reserves<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg1, arg2))));
    }

    fun accrue_interest<T0>(arg0: 0x1::type_name::TypeName, arg1: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg2: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::AssetConfig, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::interest::InterestModel, arg4: u64) : &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0> {
        let v0 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg1, arg0);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::accrue_interest<T0>(v0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::repay_fee_rate(arg2), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::interest::calc_interest(arg3, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::util_rate<T0>(v0)), arg4);
        v0
    }

    public(friend) fun adl_registry<T0>(arg0: &Market<T0>) : &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry {
        let v0 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<ADLRegistryKey, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry>(&arg0.id, v0)
    }

    public(friend) fun adl_registry_mut<T0>(arg0: &mut Market<T0>) : &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry {
        let v0 = ADLRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry>(&mut arg0.id, v0)
    }

    public fun assert_emode_group_exists<T0>(arg0: &Market<T0>, arg1: u8) {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::ensure_group_exists(&arg0.emode_group_registry, arg1);
    }

    public(friend) fun asset_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0> {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&arg0.assets, arg1)
    }

    public(friend) fun borrow_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoan<T0, T1>) {
        let v0 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::flash_loan_paused<T0>(v0), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::flash_loan_paused_for_asset());
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::flash_loan_ongoing<T0>(v0), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::flash_loan_ongoing());
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::flash_loan_triggered<T0>(v0);
        let v1 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>());
        let v2 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::int_mul(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::fee_rate(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::flash_loan(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_group(&arg0.emode_group_registry, arg1), 0x1::type_name::get<T1>()))), arg2);
        assert!(v2 != 0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::reserve_flash_loan_fee_too_small());
        let (v3, v4) = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::borrow_flash_loan<T0, T1>(v1, arg2);
        let v5 = FlashLoan<T0, T1>{
            inner : v4,
            fee   : v2,
        };
        (0x2::coin::from_balance<T1>(v3, arg3), v5)
    }

    public(friend) fun borrow_liquidity_mining<T0>(arg0: &Market<T0>) : &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::liquidity_miner::LiquidityMiner<T0> {
        &arg0.liquidity_miner
    }

    public(friend) fun borrow_liquidity_mining_mut<T0>(arg0: &mut Market<T0>) : &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::liquidity_miner::LiquidityMiner<T0> {
        &mut arg0.liquidity_miner
    }

    public fun borrow_obligation<T0>(arg0: &Market<T0>, arg1: 0x2::object::ID) : &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    fun collaterals_usd_for_liquidation<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg2: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal) {
        let v0 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero();
        let v1 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero();
        let v2 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::deposit_types<T0>(arg2);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::collateral(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(arg0, v3));
            if (!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::can_be_collateral(v4)) {
                continue
            };
            let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::liquidation_factor(v4);
            let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::value::coin_value(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::user_oracle::get_price(arg4, v3, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::get_oracle_base_token(arg0), arg5), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::exchange_rate<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg1, v3)), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::ctoken_amount_by_coin<T0>(arg2, v3))), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::decimals(arg3, v3));
            v1 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::add(v1, v6);
            v0 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::add(v0, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(v6, v5));
        };
        (v0, v1)
    }

    fun collaterals_usd_non_liquidation<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg2: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg4: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg6: &0x2::clock::Clock) : (0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal) {
        let v0 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero();
        let v1 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero();
        let v2 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::deposit_types<T0>(arg3);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::collateral(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(arg0, v3));
            if (!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::can_be_collateral(v4)) {
                continue
            };
            let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::collateral_factor(v4);
            let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::value::coin_value(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::user_oracle::get_price_with_check(arg5, v3, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::get_oracle_base_token(arg0), arg6, *0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(arg2, v3)), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::exchange_rate<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg1, v3)), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::ctoken_amount_by_coin<T0>(arg3, v3))), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::decimals(arg4, v3));
            v1 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::add(v1, v6);
            v0 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::add(v0, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(v6, v5));
        };
        (v0, v1)
    }

    fun debts_value_usd_for_liquidation<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg2: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal) {
        let v0 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero();
        let v1 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero();
        let v2 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt_types<T0>(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::value::coin_value(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::user_oracle::get_price(arg4, v4, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::get_oracle_base_token(arg0), arg5), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::debt(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(arg2, v4), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::borrow_index::value(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::borrow_index<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg1, v4)))), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::decimals(arg3, v4));
            v1 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::add(v1, v5);
            v0 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::add(v0, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(v5, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_weight(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(arg0, v4)))));
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    fun debts_value_usd_non_liquidation<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg2: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg4: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg6: &0x2::clock::Clock) : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal {
        let v0 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero();
        let v1 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt_types<T0>(arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            v0 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::add(v0, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::value::coin_value(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::user_oracle::get_price_with_check(arg5, v3, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::get_oracle_base_token(arg0), arg6, *0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(arg2, v3)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::debt(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(arg3, v3), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::borrow_index::value(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::borrow_index<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg1, v3)))), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::decimals(arg4, v3)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_weight(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(arg0, v3)))));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun discharge_circuit_break<T0>(arg0: &mut Market<T0>) {
        let v0 = CircuitBreakKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<CircuitBreakKey, bool>(&mut arg0.id, v0);
        assert!(*v1, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::not_under_circuit_break());
        *v1 = false;
    }

    public fun emode_registry<T0>(arg0: &Market<T0>) : &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroupRegistry {
        &arg0.emode_group_registry
    }

    public(friend) fun emode_registry_mut<T0>(arg0: &mut Market<T0>) : &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroupRegistry {
        &mut arg0.emode_group_registry
    }

    fun ensure_liquidate_borrow_allowed<T0, T1>(arg0: &LiquidationParams, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg2: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg4: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg7: &0x2::clock::Clock) {
        let (v0, v1) = debts_value_usd_for_liquidation<T0>(arg2, arg3, arg1, arg4, arg6, arg7);
        let (v2, v3) = collaterals_usd_for_liquidation<T0>(arg2, arg3, arg1, arg4, arg6, arg7);
        if (0x1::option::is_some<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(&arg0.liquidation_ltv_threshold_override)) {
            assert!(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::gt(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::div(v0, v3), *0x1::option::borrow<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(&arg0.liquidation_ltv_threshold_override)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::liquidation_obligation_still_safe());
        } else {
            assert!(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::gt(v0, v2), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::liquidation_obligation_still_safe());
        };
        if (0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::le(v3, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(101, 100), v1))) {
            return
        };
        let v4 = 0x1::type_name::get<T1>();
        let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::unsafe_debt_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(arg1, v4));
        if (0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::ceil(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::value::coin_value(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::user_oracle::get_price(arg6, v4, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::get_oracle_base_token(arg2), arg7), v5, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::decimals(arg4, v4))) <= arg0.close_factor_bypass_min_value) {
            return
        };
        assert!(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::le(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from(arg5), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(v5, arg0.close_factor)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::liquidation_close_factor_exceeded());
    }

    public(friend) fun ensure_version_matches<T0>(arg0: &Market<T0>) {
        assert!(arg0.version == 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::current_version::current_version(), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::version_mismatch());
    }

    public fun exchange_rate<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::exchange_rate<T0>(reserve_by_type<T0>(arg0, arg1))
    }

    public fun fee<T0, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        arg0.fee
    }

    public(friend) fun handle_borrow<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64) : (0x2::balance::Balance<T1>, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal) {
        assert!(arg2 != 0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::no_zero_amount());
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::borrow_paused<T0>(v1), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::borrow_paused_for_asset());
        let v2 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::min_borrow_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v1));
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v4 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::market_id<T0>(v3);
        assert!(&v4 == 0x2::object::uid_as_inner(&arg0.id), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_from_different_market());
        let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v3), 0x1::type_name::get<T1>());
        let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::max_borrow_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow(v5));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::limiter::add_outflow(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_mut_borrow_limiter(v5), arg6, arg2);
        let v7 = if (!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::has_debt<T0>(v3, v0)) {
            0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero()
        } else {
            0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::unsafe_debt_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(v3, v0))
        };
        let v8 = &mut arg0.reserves;
        refresh_obligation_borrow_interest_with_new_borrow<T0>(v0, &arg0.assets, v8, v3, arg6);
        let v9 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::borrow_index::value(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::borrow_index<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&arg0.reserves, v0)));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::try_borrow_asset<T0, T1>(v3, arg2, v9);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v3, v2);
        let v10 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::unsafe_debt_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(v3, v0));
        let v11 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v3));
        assert!(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::le(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::update_asset_borrow(v11, v0, v7, v10), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from(v6)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::emode_borrow_limit_exceeded());
        assert!(is_obligation_safe<T0>(v11, &arg0.reserves, &arg0.ema_spot_tolerance, 0x2::object_table::borrow<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&arg0.obligations, arg1), arg3, arg4, arg5), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_not_safe_after_operation());
        (0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::borrow_amount<T0, T1>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&mut arg0.reserves, v0), arg2), v9, v10)
    }

    public(friend) fun handle_collateral_auto_deleverage<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x1::type_name::get<T2>();
        let v1 = *0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::get_collateral_deleverage(adl_registry<T0>(arg0), v0);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v3 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::market_id<T0>(v2);
        assert!(&v3 == 0x2::object::uid_as_inner(&arg0.id), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_from_different_market());
        let v4 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v2));
        let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::collateral(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(v4, v0));
        assert!(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::can_be_collateral(v5), 13906836927417417727);
        let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, v0);
        let v7 = &mut arg0.reserves;
        accrue_interest<T0>(v0, v7, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v6), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::interest_model<T0>(v6), arg6);
        let v8 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::inner<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::DeleverageParams>(&v1);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::ensure_limit_breached(v8, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::floor(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::cash_plus_borrows_minus_reserves<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&arg0.reserves, v0))));
        let v9 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::get_secs_since_activation<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::DeleverageParams>(&v1, arg5);
        let v10 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::some<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::liquidation_ltv(v8, v9)),
            liquidation_incentive              : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::min(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::liquidation_incentive(v8, v9), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::liquidation_incentive(v5)),
            liquidation_revenue_factor         : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero(),
            close_factor                       : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::close_factor(v8),
            close_factor_bypass_min_value      : market_config<T0>(arg0).close_factor_bypass_min_value,
        };
        let v11 = &mut arg0.id;
        let v12 = &mut arg0.reserves;
        liquidation_inner<T0, T1, T2>(v11, &arg0.assets, v4, v12, v2, &v10, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun handle_debt_auto_deleverage<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T2>();
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v3 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::market_id<T0>(v2);
        assert!(&v3 == 0x2::object::uid_as_inner(&arg0.id), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_from_different_market());
        let v4 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v2);
        let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v2));
        let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::collateral(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(v5, v1));
        assert!(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::can_be_collateral(v6), 13906836618179772415);
        let v7 = ADLRegistryKey{dummy_field: false};
        let v8 = *0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::get_borrow_deleverage(0x2::dynamic_field::borrow<ADLRegistryKey, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry>(&arg0.id, v7), v0, v4);
        let v9 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, v1);
        let v10 = &mut arg0.reserves;
        accrue_interest<T0>(v1, v10, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v9), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::interest_model<T0>(v9), arg6);
        let v11 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::inner<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::DeleverageParams>(&v8);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::ensure_limit_breached(v11, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::floor(*0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::debt<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&arg0.reserves, v0))));
        let v12 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::get_secs_since_activation<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::DeleverageParams>(&v8, arg5);
        let v13 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::some<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::liquidation_ltv(v11, v12)),
            liquidation_incentive              : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::min(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::liquidation_incentive(v11, v12), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::liquidation_incentive(v6)),
            liquidation_revenue_factor         : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero(),
            close_factor                       : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::close_factor(v11),
            close_factor_bypass_min_value      : market_config<T0>(arg0).close_factor_bypass_min_value,
        };
        let v14 = &mut arg0.id;
        let v15 = &mut arg0.reserves;
        liquidation_inner<T0, T1, T2>(v14, &arg0.assets, v5, v15, v2, &v13, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun handle_liquidation<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, u64) {
        let MarketConfiguration {
            close_factor                  : v0,
            close_factor_bypass_min_value : v1,
        } = *market_config<T0>(arg0);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v3 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::market_id<T0>(v2);
        assert!(&v3 == 0x2::object::uid_as_inner(&arg0.id), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_from_different_market());
        let v4 = 0x1::type_name::get<T2>();
        let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v2));
        let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::collateral(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(v5, v4));
        assert!(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::can_be_collateral(v6), 13906836390546505727);
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::liquidation_paused<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, v4)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::liquidation_paused_for_asset());
        let v7 = LiquidationParams{
            liquidation_ltv_threshold_override : 0x1::option::none<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(),
            liquidation_incentive              : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::liquidation_incentive(v6),
            liquidation_revenue_factor         : 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::liquidation_fee_rate(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&arg0.assets, 0x1::type_name::get<T2>()))),
            close_factor                       : v0,
            close_factor_bypass_min_value      : v1,
        };
        let v8 = &mut arg0.id;
        let v9 = &mut arg0.reserves;
        liquidation_inner<T0, T1, T2>(v8, &arg0.assets, v5, v9, v2, &v7, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun handle_mint<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64) : (u64, u64) {
        assert!(0x2::coin::value<T1>(&arg2) != 0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::no_zero_amount());
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::deposit_paused<T0>(v2), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::deposit_paused_for_asset());
        let v3 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v2);
        let v4 = &mut arg0.reserves;
        let v5 = accrue_interest<T0>(v0, v4, v3, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::interest_model<T0>(v2), arg3);
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::deposit_limit_breached<T0>(v5, v1, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::max_deposit_amount(v3)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::market_deposit_limit_exceeded());
        let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::mint_ctokens<T0, T1>(v5, arg2);
        let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v8 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::market_id<T0>(v7);
        assert!(&v8 == 0x2::object::uid_as_inner(&arg0.id), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_from_different_market());
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::deposit_ctoken<T0, T1>(v7, v6);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::limiter::reduce_outflow(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_mut_deposit_limiter(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v7), 0x1::type_name::get<T1>())), arg3, v1);
        (0x2::balance::value<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::ctoken::CToken<T0, T1>>(&v6), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::ctoken_amount_by_coin<T0>(v7, v0))
    }

    public(friend) fun handle_new_obligation<T0>(arg0: &mut Market<T0>, arg1: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>) {
        0x2::object_table::add<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&arg1), arg1);
    }

    public(friend) fun handle_repay<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal) {
        assert!(0x2::coin::value<T1>(&arg2) != 0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::no_zero_amount());
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, v0);
        let v2 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::min_borrow_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v1));
        let v3 = &mut arg0.reserves;
        let v4 = accrue_interest<T0>(v0, v3, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v1), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::interest_model<T0>(v1), arg3);
        let v5 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::market_id<T0>(v5);
        assert!(&v6 == 0x2::object::uid_as_inner(&arg0.id), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_from_different_market());
        let v7 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::unsafe_debt_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(v5, v0));
        let v8 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::borrow_index::value(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::borrow_index<T0>(v4));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v5, v2);
        let v9 = if (0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::has_debt<T0>(v5, v0)) {
            0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::unsafe_debt_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(v5, v0))
        } else {
            0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero()
        };
        let v10 = 0x2::coin::split<T1>(&mut arg2, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::repay_debt<T0, T1>(v5, 0x2::coin::value<T1>(&arg2), v8), arg4);
        let v11 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v5);
        let v12 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, v11);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::limiter::reduce_outflow(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_mut_borrow_limiter(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_mut(v12, v0)), arg3, 0x2::coin::value<T1>(&arg2));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::repay_amount<T0, T1>(v4, arg2);
        let v13 = ADLRegistryKey{dummy_field: false};
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::try_stop_borrow_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry>(&mut arg0.id, v13), 0x1::type_name::get<T0>(), v11, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::ceil(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::update_asset_borrow(v12, v0, v7, v9)));
        (v10, v8, v9)
    }

    public(friend) fun handle_withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        assert!(arg2 != 0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::no_zero_amount());
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::withdraw_paused<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&arg0.assets, v0)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::withdraw_paused_for_asset());
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v2 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::market_id<T0>(v1);
        assert!(&v2 == 0x2::object::uid_as_inner(&arg0.id), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_from_different_market());
        let v3 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_group_mut(&mut arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v1));
        let v4 = &mut arg0.reserves;
        refresh_obligation_assets_interest<T0>(&arg0.assets, v3, v4, v1, arg6);
        assert!(is_obligation_safe<T0>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode_group(&arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v1)), &arg0.reserves, &arg0.ema_spot_tolerance, v1, arg3, arg4, arg5), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::obligation_not_safe_after_operation());
        let v5 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&mut arg0.reserves, v0);
        let v6 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::burn_ctokens<T0, T1>(v5, 0x2::coin::from_balance<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::ctoken::CToken<T0, T1>>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::withdraw_ctokens<T0, T1>(v1, arg2), arg7));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::limiter::add_outflow(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_mut_deposit_limiter(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(v1), 0x1::type_name::get<T1>())), arg6, 0x2::balance::value<T1>(&v6));
        let v7 = ADLRegistryKey{dummy_field: false};
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::try_stop_collateral_deleverage<T1>(0x2::dynamic_field::borrow_mut<ADLRegistryKey, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::adl::AutoDeleverageRegistry>(&mut arg0.id, v7), 0x1::type_name::get<T0>(), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::ceil(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::total_deposit_plus_interest<T0>(v5)));
        (0x2::coin::from_balance<T1>(v6, arg7), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::ctoken_amount_by_coin<T0>(v1, v0))
    }

    public(friend) fun has_circuit_break_triggered<T0>(arg0: &Market<T0>) : bool {
        let v0 = CircuitBreakKey{dummy_field: false};
        *0x2::dynamic_field::borrow<CircuitBreakKey, bool>(&arg0.id, v0)
    }

    fun is_obligation_safe<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg2: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>, arg3: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg4: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg6: &0x2::clock::Clock) : bool {
        let (v0, _) = collaterals_usd_non_liquidation<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::ge(v0, debts_value_usd_non_liquidation<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6))
    }

    public(friend) fun lending_default_emode_group() : u8 {
        0
    }

    fun liquidate_calculate_seize_ctokens<T0, T1>(arg0: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, arg1: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, arg2: u64, arg3: 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::BaseToken, arg4: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg5: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from(arg2);
        let v3 = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::div(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul_u64(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::div(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::div_u64(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::add(v2, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul(v2, arg1)), 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::user_oracle::get_spot_price(arg4, v0, arg3, arg6)), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::u64::pow10_u64(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::decimals(arg5, v0))), 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::user_oracle::get_spot_price(arg4, v1, arg3, arg6)), 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::u64::pow10_u64(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::decimals(arg5, v1))), arg0);
        assert!(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::lt(v3, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from(18446744073709551615)), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::invariant_seize_tokens_crazy_big());
        0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::floor(v3)
    }

    fun liquidation_inner<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg3: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg4: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg5: &LiquidationParams, arg6: 0x2::coin::Coin<T1>, arg7: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, u64) {
        assert!(0x2::coin::value<T1>(&arg6) != 0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::liquidation_zero_repay());
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::unsafe_debt_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(arg4, v0));
        refresh_obligation_assets_interest<T0>(arg1, arg2, arg3, arg4, arg10);
        ensure_liquidate_borrow_allowed<T0, T1>(arg5, arg4, arg2, arg3, arg7, 0x2::coin::value<T1>(&arg6), arg8, arg9);
        let v2 = 0x2::coin::split<T1>(&mut arg6, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::unsafe_repay_debt_only<T0, T1>(arg4, 0x2::coin::value<T1>(&arg6)), arg11);
        let v3 = if (!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::has_debt<T0>(arg4, v0)) {
            0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::zero()
        } else {
            0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::debt::unsafe_debt_amount(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt<T0>(arg4, v0))
        };
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::update_asset_borrow(arg2, v0, v1, v3);
        let v4 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg3, 0x1::type_name::get<T2>());
        let v5 = liquidate_calculate_seize_ctokens<T1, T2>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::exchange_rate<T0>(v4), arg5.liquidation_incentive, 0x2::coin::value<T1>(&arg6), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::get_oracle_base_token(arg2), arg8, arg7, arg9);
        let v6 = v5;
        let v7 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::ctoken_amount_by_coin<T0>(arg4, 0x1::type_name::get<T2>());
        if (v7 < v5) {
            0x2::coin::join<T1>(&mut v2, 0x2::coin::split<T1>(&mut arg6, 0x2::coin::value<T1>(&arg6) - 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::ceil(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::mul_u64(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(v7, v5), 0x2::coin::value<T1>(&arg6))), arg11));
            v6 = v7;
        };
        let v8 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::withdraw_ctokens<T0, T2>(arg4, v6);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::repay_amount<T0, T1>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(arg3, v0), arg6);
        try_stop_borrow_deleverage<T0, T1>(arg0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::emode_group<T0>(arg4), arg2, v0);
        try_stop_collateral_deleverage<T0, T2>(arg0, arg3, 0x1::type_name::get<T2>());
        (0x2::coin::from_balance<T2>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::liquidate_ctokens<T0, T2>(v4, 0x2::coin::from_balance<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::ctoken::CToken<T0, T2>>(v8, arg11), arg5.liquidation_revenue_factor), arg11), v2, 0x2::balance::value<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::ctoken::CToken<T0, T2>>(&v8))
    }

    public fun loan_amount<T0, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::amount<T0, T1>(&arg0.inner)
    }

    public(friend) fun market_asset_borrow_mut<T0, T1>(arg0: &mut Market<T0>) : &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0> {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>())
    }

    public(friend) fun market_config<T0>(arg0: &Market<T0>) : &MarketConfiguration {
        let v0 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::borrow<MarketConfigurationKey, MarketConfiguration>(&arg0.id, v0)
    }

    public(friend) fun new_market_configuration(arg0: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, arg1: u64) : MarketConfiguration {
        MarketConfiguration{
            close_factor                  : arg0,
            close_factor_bypass_min_value : arg1,
        }
    }

    public(friend) fun onboard_new_asset<T0, T1>(arg0: &mut Market<T0>, arg1: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::interest::InterestModel, arg2: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::AssetConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::supports<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>, T1>(&arg0.assets), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::asset_already_onboarded());
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::store<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>, T1>(&mut arg0.assets, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::new<T0>(arg1, arg2, arg4));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::store<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>, T1>(&mut arg0.reserves, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::new<T0, T1>(arg4, arg3));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::store<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal, T1>(&mut arg0.ema_spot_tolerance, 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(1000, 10000));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::liquidity_miner::support_coin<T0, T1>(&mut arg0.liquidity_miner, arg4);
    }

    fun refresh_obligation_assets_interest<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::EModeGroup, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg3: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg4: u64) {
        refresh_obligation_borrow_interest<T0>(arg0, arg2, arg3, arg4);
        let v0 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::deposit_types<T0>(arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(arg0, v2);
            v1 = v1 + 1;
            if (!0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::can_be_collateral(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::collateral(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::emode::borrow_emode(arg1, v2)))) {
                continue
            };
            accrue_interest<T0>(v2, arg2, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v3), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::interest_model<T0>(v3), arg4);
        };
    }

    fun refresh_obligation_borrow_interest<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>, arg1: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg3: u64) {
        let v0 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::debt_types<T0>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(arg0, v2);
            0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::accrue_interest<T0>(arg2, v2, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::borrow_index::value(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::borrow_index<T0>(accrue_interest<T0>(v2, arg1, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v3), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::interest_model<T0>(v3), arg3))));
            v1 = v1 + 1;
        };
    }

    fun refresh_obligation_borrow_interest_with_new_borrow<T0>(arg0: 0x1::type_name::TypeName, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::GenericCoinTypeStorage<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>, arg3: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::Obligation<T0>, arg4: u64) {
        refresh_obligation_borrow_interest<T0>(arg1, arg2, arg3, arg4);
        if (0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::obligation::has_debt<T0>(arg3, arg0)) {
            return
        };
        let v0 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(arg1, arg0);
        accrue_interest<T0>(arg0, arg2, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::asset_config<T0>(v0), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::interest_model<T0>(v0), arg4);
    }

    public(friend) fun repay_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: FlashLoan<T0, T1>, arg3: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::referral::Referral, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::flash_loan_ongoing<T0>(v0), 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::flash_loan_not_ongoing());
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::flash_loan_finished<T0>(v0);
        let FlashLoan {
            inner : v1,
            fee   : v2,
        } = arg2;
        let v3 = v1;
        assert!(0x2::coin::value<T1>(&arg1) == 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::amount<T0, T1>(&v3) + v2, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::reserve_flash_loan_not_paid_enough());
        let v4 = 0x2::coin::split<T1>(&mut arg1, v2, arg5);
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            let v5 = v4;
            v4 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::referral::track_flash_loan_usage<T1>(arg3, v5, 0x1::option::extract<0x1::string::String>(&mut arg4), 0x2::tx_context::sender(arg5), arg5);
            assert!(0x2::coin::value<T1>(&v4) != 0, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::reserve_flash_loan_fee_too_small());
        };
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::repay_flash_loan<T0, T1>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), v3, arg1, v4);
    }

    public(friend) fun reserve_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0> {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&arg0.reserves, arg1)
    }

    public(friend) fun set_ema_spot_tolerance<T0, T1>(arg0: &mut Market<T0>, arg1: u64) {
        assert!(arg1 < 10000, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::invalid_params_error());
        *0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal>(&mut arg0.ema_spot_tolerance, 0x1::type_name::get<T1>()) = 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(arg1, 10000);
    }

    public(friend) fun supported_assets<T0>(arg0: &Market<T0>) : vector<0x1::type_name::TypeName> {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::keys<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::asset::Asset<T0>>(&arg0.assets)
    }

    public(friend) fun take_revenue<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::take_revenue<T0, T1>(0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::generic_store::load_mut_by_type<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1), arg2)
    }

    public(friend) fun trigger_circuit_break<T0>(arg0: &mut Market<T0>) {
        let v0 = CircuitBreakKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<CircuitBreakKey, bool>(&mut arg0.id, v0);
        assert!(!*v1, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::error::already_under_circuit_break());
        *v1 = true;
    }

    public(friend) fun update_market_config<T0>(arg0: &mut Market<T0>, arg1: MarketConfiguration) {
        let v0 = MarketConfigurationKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<MarketConfigurationKey, MarketConfiguration>(&mut arg0.id, v0) = arg1;
    }

    // decompiled from Move bytecode v6
}

