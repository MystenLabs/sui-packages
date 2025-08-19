module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market {
    struct MarketConfiguration has copy, drop, store {
        close_factor: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
    }

    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        assets: 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>,
        reserves: 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>,
        limiters: 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::wit_table::WitTable<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::Limiters, 0x1::type_name::TypeName, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::Limiter>,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>,
    }

    struct MarketConfigurationKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: MarketConfiguration, arg1: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = Market<T0>{
            id          : 0x2::object::new(arg1),
            version     : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::current_version::current_version(),
            assets      : 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::new<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(arg1),
            reserves    : 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::new<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(arg1),
            limiters    : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::init_table(arg1),
            obligations : 0x2::object_table::new<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(arg1),
        };
        let v1 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::add<MarketConfigurationKey, MarketConfiguration>(&mut v0.id, v1, arg0);
        v0
    }

    public(friend) fun change_operation_status<T0, T1>(arg0: &mut Market<T0>, arg1: u8, arg2: bool) {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::change_operation_status<T0>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1, arg2);
    }

    public(friend) fun update_interest_model<T0, T1>(arg0: &mut Market<T0>, arg1: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::interest::InterestModel) {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::update_interest_model<T0>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1);
    }

    fun accrue_interest<T0, T1>(arg0: &mut 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>, arg1: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::BorrowConfig, arg2: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::interest::InterestModel, arg3: u64) : &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0> {
        let v0 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(arg0, 0x1::type_name::get<T1>());
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::accrue_interest<T0>(v0, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::repay_fee_rate(arg1), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::interest::calc_interest(arg2, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::util_rate<T0>(v0)), arg3);
        v0
    }

    public fun asset_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0> {
        0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&arg0.assets, arg1)
    }

    public(friend) fun borrow_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>) {
        let v0 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_paused<T0>(v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::borrow_disabled());
        assert!(!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::flash_loan_ongoing<T0>(v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::flash_loan_ongoing());
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::flash_loan_triggered<T0>(v0);
        let (v1, v2) = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_flash_loan<T0, T1>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::flash_loan_fee_rate(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_setting<T0>(v0)));
        (0x2::coin::from_balance<T1>(v1, arg2), v2)
    }

    public fun borrow_obligation<T0>(arg0: &Market<T0>, arg1: 0x2::object::ID) : &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    fun borrow_obligation_mut<T0>(arg0: &mut Market<T0>, arg1: 0x2::object::ID) : &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0> {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v1 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::market_id<T0>(v0);
        assert!(&v1 == 0x2::object::uid_as_inner(&arg0.id), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::obligation_from_different_market());
        v0
    }

    public fun calculate_collaterals_usd<T0>(arg0: &0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>, arg1: &0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>, arg2: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>, arg3: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg5: &0x2::clock::Clock) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        let v0 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::zero();
        let v1 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::deposit_types<T0>(arg2);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v1)) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            let v3 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(arg0, v2);
            if (!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::can_be_collateral<T0>(v3)) {
                continue
            };
            v0 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::add(v0, 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::usd_value(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg4, v2, arg5), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::exchange_rate<T0>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(arg1, v2)), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::ctoken_amount_by_coin<T0>(arg2, v2))), 0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::decimals(arg3, v2)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::collateral_factor(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::collateral_setting<T0>(v3))));
        };
        v0
    }

    public fun debts_value_usd<T0>(arg0: &0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>, arg1: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>, arg2: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        let v0 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::zero();
        let v1 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::debt_types<T0>(arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            v0 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::add(v0, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::usd_value(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg3, v3, arg4), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::debt::debt(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::debt<T0>(arg1, v3), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow_index::value(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_index<T0>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(arg0, v3)))), 0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::decimals(arg2, v3)));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun enable_asset_collateral<T0, T1>(arg0: &mut Market<T0>, arg1: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Collateral) {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::enable_as_collateral<T0>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1);
    }

    fun ensure_liquidate_borrow_allowed<T0, T1>(arg0: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>, arg1: &0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>, arg2: &0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>, arg3: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg4: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg7: &0x2::clock::Clock) {
        assert!(!is_obligation_safe<T0>(arg1, arg2, arg0, arg4, arg6, arg7), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::liquidation_obligation_still_safe());
        assert!(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::le(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from(arg5), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::debt::unsafe_debt_amount(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::debt<T0>(arg0, 0x1::type_name::get<T1>())), arg3)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::liquidation_close_factor_exceeded());
    }

    public(friend) fun handle_borrow<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64) : 0x2::balance::Balance<T1> {
        handle_outflow<T0, T1>(arg0, arg2, arg6);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_paused<T0>(v1), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::borrow_disabled());
        let v2 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_setting<T0>(v1);
        let v3 = &mut arg0.reserves;
        assert!(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::ge_u64(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::try_borrow_asset<T0, T1>(0x2::object_table::borrow_mut<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&mut arg0.obligations, arg1), arg2, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow_index::value(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_index<T0>(accrue_interest<T0, T1>(v3, v2, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::interest_model<T0>(v1), arg6)))), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::min_borrow_amount(v2)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::obligation_borrow_below_min());
        assert!(is_obligation_safe<T0>(&arg0.assets, &arg0.reserves, 0x2::object_table::borrow<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&arg0.obligations, arg1), arg3, arg4, arg5), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::obligation_not_safe_after_operation());
        let v4 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(&mut arg0.reserves, v0);
        assert!(!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_limit_breached<T0>(v4, arg2, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::max_borrow_amount(v2)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::market_borrow_limit_exceeded());
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_amount<T0, T1>(v4, arg2)
    }

    public(friend) fun handle_liquidation<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<T1>(&arg2) != 0, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::liquidation_zero_repay());
        assert!(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::can_be_collateral<T0>(asset_by_type<T0>(arg0, 0x1::type_name::get<T2>())), 13906836119963566079);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v1 = &mut arg0.reserves;
        refresh_for_liquidation<T0>(&arg0.assets, v1, v0, arg6);
        ensure_liquidate_borrow_allowed<T0, T1>(v0, &arg0.assets, &arg0.reserves, market_config<T0>(arg0).close_factor, arg3, 0x2::coin::value<T1>(&arg2), arg4, arg5);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::unsafe_repay_debt_only<T0, T1>(v0, 0x2::coin::value<T1>(&arg2));
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::reduce_outflow(&mut arg0.limiters, 0x1::type_name::get<T1>(), arg6, 0x2::coin::value<T1>(&arg2));
        let v2 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T2>());
        let v3 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::collateral_setting<T0>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T2>()));
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::repay_amount<T0, T1>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg2);
        0x2::coin::from_balance<T2>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::liquidate_ctokens<T0, T2>(v2, 0x2::coin::from_balance<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::ctoken::CToken<T0, T2>>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::withdraw_ctokens<T0, T2>(v0, liquidate_calculate_seize_ctokens<T1, T2>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::exchange_rate<T0>(v2), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::liquidation_incentive(v3), 0x2::coin::value<T1>(&arg2), arg4, arg5)), arg7), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::liq_revenue_factor(v3)), arg7)
    }

    public(friend) fun handle_mint<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64) : u64 {
        let v0 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::deposit_paused<T0>(v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::asset_deposit_paused());
        let v1 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_setting<T0>(v0);
        let v2 = &mut arg0.reserves;
        let v3 = accrue_interest<T0, T1>(v2, v1, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::interest_model<T0>(v0), arg3);
        assert!(!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::deposit_limit_breached<T0>(v3, 0x2::coin::value<T1>(&arg2), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::max_deposit_amount(v1)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::max_deposit_reached_error());
        let v4 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::mint_ctokens<T0, T1>(v3, arg2);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::deposit_ctoken<T0, T1>(borrow_obligation_mut<T0>(arg0, arg1), v4);
        0x2::balance::value<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::ctoken::CToken<T0, T1>>(&v4)
    }

    public(friend) fun handle_new_obligation<T0>(arg0: &mut Market<T0>, arg1: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>) {
        0x2::object_table::add<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&arg1), arg1);
    }

    fun handle_outflow<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: u64) {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::add_outflow(&mut arg0.limiters, 0x1::type_name::get<T1>(), arg2, arg1);
    }

    public(friend) fun handle_repay<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        let v1 = &mut arg0.reserves;
        let v2 = accrue_interest<T0, T1>(v1, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_setting<T0>(v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::interest_model<T0>(v0), arg3);
        let v3 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::repay_debt<T0, T1>(0x2::object_table::borrow_mut<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&mut arg0.obligations, arg1), 0x2::coin::value<T1>(&arg2), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow_index::value(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_index<T0>(v2)));
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::reduce_outflow(&mut arg0.limiters, 0x1::type_name::get<T1>(), arg3, 0x2::coin::value<T1>(&arg2) - v3);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::repay_amount<T0, T1>(v2, arg2);
        0x2::coin::split<T1>(&mut arg2, v3, arg4)
    }

    public(friend) fun handle_withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::withdraw_paused<T0>(v1), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::asset_withdraw_paused());
        let v2 = &mut arg0.reserves;
        accrue_interest<T0, T1>(v2, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_setting<T0>(v1), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::interest_model<T0>(v1), arg6);
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v4 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::withdraw_ctokens<T0, T1>(v3, arg2);
        assert!(is_obligation_safe<T0>(&arg0.assets, &arg0.reserves, v3, arg3, arg4, arg5), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::obligation_not_safe_after_operation());
        let v5 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::burn_ctokens<T0, T1>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(&mut arg0.reserves, v0), 0x2::coin::from_balance<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::ctoken::CToken<T0, T1>>(v4, arg7));
        handle_outflow<T0, T1>(arg0, 0x2::balance::value<T1>(&v5), arg6);
        (0x2::coin::from_balance<T1>(v5, arg7), 0x2::balance::value<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::ctoken::CToken<T0, T1>>(&v4))
    }

    public fun is_obligation_safe<T0>(arg0: &0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>, arg1: &0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>, arg2: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>, arg3: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg5: &0x2::clock::Clock) : bool {
        0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::ge(calculate_collaterals_usd<T0>(arg0, arg1, arg2, arg3, arg4, arg5), debts_value_usd<T0>(arg1, arg2, arg3, arg4, arg5))
    }

    fun liquidate_calculate_seize_ctokens<T0, T1>(arg0: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg2: u64, arg3: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from(arg2);
        let v1 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::add(v0, 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(v0, arg1)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg3, 0x1::type_name::get<T0>(), arg4)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value::get_price(arg3, 0x1::type_name::get<T1>(), arg4)), arg0);
        assert!(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::lt(v1, 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from(18446744073709551615)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::invariant_seize_tokens_crazy_big());
        0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::floor(v1)
    }

    public fun market_config<T0>(arg0: &Market<T0>) : &MarketConfiguration {
        let v0 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::borrow<MarketConfigurationKey, MarketConfiguration>(&arg0.id, v0)
    }

    public fun new_market_configuration(arg0: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) : MarketConfiguration {
        MarketConfiguration{close_factor: arg0}
    }

    public(friend) fun onboard_new_asset<T0, T1>(arg0: &mut Market<T0>, arg1: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::interest::InterestModel, arg2: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::BorrowConfig, arg3: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::NewLimiter, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::supports<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>, T1>(&arg0.assets), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::asset_already_onboarded());
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::add_limiter_from_struct<T1>(&mut arg0.limiters, arg3);
        0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::store<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>, T1>(&mut arg0.assets, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::new<T0>(arg1, arg2, arg5));
        0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::store<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>, T1>(&mut arg0.reserves, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::new<T0, T1>(arg5, arg4));
    }

    fun refresh_for_liquidation<T0>(arg0: &0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>, arg1: &mut 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::GenericCoinTypeStorage<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>, arg2: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::Obligation<T0>, arg3: u64) {
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::debt_types<T0>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(arg0, v2);
            let v4 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(arg1, v2);
            0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::accrue_interest<T0>(v4, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::repay_fee_rate(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_setting<T0>(v3)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::interest::calc_interest(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::interest_model<T0>(v3), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::util_rate<T0>(v4)), arg3);
            0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::accrue_interest<T0>(arg2, v2, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow_index::value(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::borrow_index<T0>(v4)));
            v1 = v1 + 1;
        };
        let v5 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::deposit_types<T0>(arg2);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v6);
            let v8 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(arg0, v7);
            v6 = v6 + 1;
            if (!0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::can_be_collateral<T0>(v8)) {
                continue
            };
            let v9 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(arg1, v7);
            0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::accrue_interest<T0>(v9, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::repay_fee_rate(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::borrow_setting<T0>(v8)), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::interest::calc_interest(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::interest_model<T0>(v8), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::util_rate<T0>(v9)), arg3);
        };
    }

    public(friend) fun repay_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>) {
        let v0 = 0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::flash_loan_ongoing<T0>(v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::flash_loan_not_active());
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::flash_loan_finished<T0>(v0);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::repay_flash_loan<T0, T1>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1, arg2);
    }

    public fun reserve_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0> {
        0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(&arg0.reserves, arg1)
    }

    public fun supported_assets<T0>(arg0: &Market<T0>) : vector<0x1::type_name::TypeName> {
        0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::keys<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&arg0.assets)
    }

    public(friend) fun take_revenue<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::take_revenue<T0, T1>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1), arg2)
    }

    public fun uid<T0>(arg0: &Market<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun update_asset_borrow<T0, T1>(arg0: &mut Market<T0>, arg1: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::BorrowConfig) {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::update_borrow<T0>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1);
    }

    public(friend) fun update_asset_collateral<T0, T1>(arg0: &mut Market<T0>, arg1: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Collateral) {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::update_collateral<T0>(0x650fedd29fc2fe2a16d12e13d4586281fdf57cbe4fd6943b4df507b38f2f8357::generic_store::load_mut_by_type<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1);
    }

    // decompiled from Move bytecode v6
}

