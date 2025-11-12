module 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::market {
    struct MarketConfiguration has copy, drop, store {
        close_factor: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
    }

    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        assets: 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>,
        reserves: 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>,
        deposit_limiters: 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::WitTable<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::Limiters, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::Limiter>,
        borrow_limiters: 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::WitTable<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::Limiters, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::Limiter>,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>,
    }

    struct MarketConfigurationKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: MarketConfiguration, arg1: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = Market<T0>{
            id               : 0x2::object::new(arg1),
            version          : 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::current_version::current_version(),
            assets           : 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::new<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(arg1),
            reserves         : 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::new<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(arg1),
            deposit_limiters : 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::init_table(arg1),
            borrow_limiters  : 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::init_table(arg1),
            obligations      : 0x2::object_table::new<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(arg1),
        };
        let v1 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::add<MarketConfigurationKey, MarketConfiguration>(&mut v0.id, v1, arg0);
        v0
    }

    public(friend) fun change_operation_status<T0, T1>(arg0: &mut Market<T0>, arg1: u8, arg2: bool) {
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::change_operation_status<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1, arg2);
    }

    public(friend) fun update_interest_model<T0, T1>(arg0: &mut Market<T0>, arg1: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::interest::InterestModel) {
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::update_interest_model<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1);
    }

    fun accrue_interest<T0, T1>(arg0: &mut 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>, arg1: &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::BorrowConfig, arg2: &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::interest::InterestModel, arg3: u64) : &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0> {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(arg0, 0x1::type_name::get<T1>());
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::accrue_interest<T0>(v0, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::repay_fee_rate(arg1), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::interest::calc_interest(arg2, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::util_rate<T0>(v0)), arg3);
        v0
    }

    public fun asset_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0> {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&arg0.assets, arg1)
    }

    public(friend) fun borrow_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::FlashLoan<T0, T1>) {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::flash_loan_paused<T0>(v0), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::flash_loan_paused_for_asset());
        assert!(!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::flash_loan_ongoing<T0>(v0), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::flash_loan_ongoing());
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::flash_loan_triggered<T0>(v0);
        let (v1, v2) = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::borrow_flash_loan<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::flash_loan_fee_rate(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_setting<T0>(v0)));
        (0x2::coin::from_balance<T1>(v1, arg2), v2)
    }

    public fun borrow_obligation<T0>(arg0: &Market<T0>, arg1: 0x2::object::ID) : &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    fun borrow_obligation_mut<T0>(arg0: &mut Market<T0>, arg1: 0x2::object::ID) : &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0> {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v1 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::market_id<T0>(v0);
        assert!(&v1 == 0x2::object::uid_as_inner(&arg0.id), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::obligation_from_different_market());
        v0
    }

    public fun collaterals_usd_for_borrow<T0>(arg0: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>, arg2: &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v2 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::deposit_types<T0>(arg2);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(arg0, v3);
            if (!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::can_be_collateral<T0>(v4)) {
                continue
            };
            let v5 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::value::usd_value(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::value::get_price(arg4, v3, arg5), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::exchange_rate<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(arg1, v3)), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::ctoken_amount_by_coin<T0>(arg2, v3))), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg3, v3));
            v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v1, v5);
            v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v0, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(v5, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::collateral_factor(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::collateral_setting<T0>(v4))));
        };
        (v0, v1)
    }

    public fun collaterals_usd_for_liquidation<T0>(arg0: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>, arg2: &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v2 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::deposit_types<T0>(arg2);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(arg0, v3);
            if (!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::can_be_collateral<T0>(v4)) {
                continue
            };
            let v5 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::value::usd_value(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::value::get_price(arg4, v3, arg5), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::exchange_rate<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(arg1, v3)), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::ctoken_amount_by_coin<T0>(arg2, v3))), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg3, v3));
            v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v1, v5);
            v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v0, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(v5, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::liquidation_factor(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::collateral_setting<T0>(v4))));
        };
        (v0, v1)
    }

    public fun debts_value_usd<T0>(arg0: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>, arg2: &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v2 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::debt_types<T0>(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v5 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::value::usd_value(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::value::get_price(arg4, v4, arg5), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::debt(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::debt<T0>(arg2, v4), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::borrow_index::value(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::borrow_index<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(arg1, v4)))), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg3, v4));
            v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v0, v5);
            v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v1, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(v5, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_weight(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_setting<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(arg0, v4)))));
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    public(friend) fun drain_reserve<T0, T1>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::drain<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>())), arg1)
    }

    public(friend) fun enable_asset_collateral<T0, T1>(arg0: &mut Market<T0>, arg1: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Collateral) {
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::enable_as_collateral<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1);
    }

    fun ensure_liquidate_borrow_allowed<T0, T1>(arg0: &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>, arg2: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>, arg3: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg4: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg7: &0x2::clock::Clock) {
        let (v0, _) = debts_value_usd<T0>(arg1, arg2, arg0, arg4, arg6, arg7);
        let (v2, v3) = collaterals_usd_for_liquidation<T0>(arg1, arg2, arg0, arg4, arg6, arg7);
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::ge(v0, v2), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::liquidation_obligation_still_safe());
        if (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::le(v3, v0)) {
            return
        };
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::le(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(arg5), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::unsafe_debt_amount(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::debt<T0>(arg0, 0x1::type_name::get<T1>())), arg3)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::liquidation_close_factor_exceeded());
    }

    public(friend) fun ensure_version_matches<T0>(arg0: &Market<T0>) {
        assert!(arg0.version == 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::current_version::current_version(), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::version_mismatch());
    }

    public(friend) fun handle_borrow<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64) : 0x2::balance::Balance<T1> {
        assert!(arg2 > 0, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::zero_debt_to_repay_error());
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::add_outflow(&mut arg0.borrow_limiters, 0x1::type_name::get<T1>(), arg6, arg2);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_paused<T0>(v1), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::borrow_paused_for_asset());
        let v2 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_setting<T0>(v1);
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v4 = &mut arg0.reserves;
        refresh_obligation_borrow_interest<T0>(&arg0.assets, v4, v3, arg6);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::try_borrow_asset<T0, T1>(v3, arg2, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::borrow_index::value(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::borrow_index<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&arg0.reserves, v0))));
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v3, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::min_borrow_amount(v2));
        assert!(is_obligation_safe<T0>(&arg0.assets, &arg0.reserves, 0x2::object_table::borrow<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&arg0.obligations, arg1), arg3, arg4, arg5), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::obligation_not_safe_after_operation());
        let v5 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&mut arg0.reserves, v0);
        assert!(!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::borrow_limit_breached<T0>(v5, arg2, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::max_borrow_amount(v2)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::market_borrow_limit_exceeded());
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::borrow_amount<T0, T1>(v5, arg2)
    }

    public(friend) fun handle_liquidation<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        assert!(0x2::coin::value<T1>(&arg2) != 0, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::liquidation_zero_repay());
        assert!(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::can_be_collateral<T0>(asset_by_type<T0>(arg0, 0x1::type_name::get<T2>())), 13906836648244543487);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v1 = &mut arg0.reserves;
        refresh_obligation_assets_interest<T0>(&arg0.assets, v1, v0, arg6);
        ensure_liquidate_borrow_allowed<T0, T1>(v0, &arg0.assets, &arg0.reserves, market_config<T0>(arg0).close_factor, arg3, 0x2::coin::value<T1>(&arg2), arg4, arg5);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::unsafe_repay_debt_only<T0, T1>(v0, 0x2::coin::value<T1>(&arg2));
        let v2 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T2>());
        let v3 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::collateral_setting<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T2>()));
        let v4 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::withdraw_ctokens<T0, T2>(v0, liquidate_calculate_seize_ctokens<T1, T2>(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::exchange_rate<T0>(v2), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::liquidation_incentive(v3), 0x2::coin::value<T1>(&arg2), arg4, arg5));
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::repay_amount<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg2);
        (0x2::coin::from_balance<T2>(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::liquidate_ctokens<T0, T2>(v2, 0x2::coin::from_balance<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken::CToken<T0, T2>>(v4, arg7), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::liq_revenue_factor(v3)), arg7), 0x2::balance::value<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken::CToken<T0, T2>>(&v4))
    }

    public(friend) fun handle_mint<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64) : u64 {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::deposit_paused<T0>(v0), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::deposit_paused_for_asset());
        let v1 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_setting<T0>(v0);
        let v2 = &mut arg0.reserves;
        let v3 = accrue_interest<T0, T1>(v2, v1, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::interest_model<T0>(v0), arg3);
        assert!(!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::deposit_limit_breached<T0>(v3, 0x2::coin::value<T1>(&arg2), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::max_deposit_amount(v1)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::market_deposit_limit_exceeded());
        let v4 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::mint_ctokens<T0, T1>(v3, arg2);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::deposit_ctoken<T0, T1>(borrow_obligation_mut<T0>(arg0, arg1), v4);
        0x2::balance::value<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken::CToken<T0, T1>>(&v4)
    }

    public(friend) fun handle_new_obligation<T0>(arg0: &mut Market<T0>, arg1: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>) {
        0x2::object_table::add<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&arg1), arg1);
    }

    public(friend) fun handle_repay<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        let v1 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::min_borrow_amount(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_setting<T0>(v0));
        let v2 = &mut arg0.reserves;
        let v3 = accrue_interest<T0, T1>(v2, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_setting<T0>(v0), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::interest_model<T0>(v0), arg3);
        let v4 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v4, v1);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::repay_amount<T0, T1>(v3, arg2);
        0x2::coin::split<T1>(&mut arg2, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::repay_debt<T0, T1>(v4, 0x2::coin::value<T1>(&arg2), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::borrow_index::value(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::borrow_index<T0>(v3))), arg4)
    }

    public(friend) fun handle_withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::withdraw_paused<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&arg0.assets, v0)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::withdraw_paused_for_asset());
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v2 = &mut arg0.reserves;
        refresh_obligation_borrow_interest<T0>(&arg0.assets, v2, v1, arg6);
        let v3 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::withdraw_ctokens<T0, T1>(v1, arg2);
        assert!(is_obligation_safe<T0>(&arg0.assets, &arg0.reserves, v1, arg3, arg4, arg5), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::obligation_not_safe_after_operation());
        let v4 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::burn_ctokens<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&mut arg0.reserves, v0), 0x2::coin::from_balance<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken::CToken<T0, T1>>(v3, arg7));
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::add_outflow(&mut arg0.deposit_limiters, 0x1::type_name::get<T1>(), arg6, 0x2::balance::value<T1>(&v4));
        (0x2::coin::from_balance<T1>(v4, arg7), 0x2::balance::value<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken::CToken<T0, T1>>(&v3))
    }

    public fun is_obligation_safe<T0>(arg0: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>, arg2: &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg5: &0x2::clock::Clock) : bool {
        let (_, v1) = debts_value_usd<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v2, _) = collaterals_usd_for_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::ge(v2, v1)
    }

    fun liquidate_calculate_seize_ctokens<T0, T1>(arg0: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg2: u64, arg3: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(arg2);
        let v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::div(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::div(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v0, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(v0, arg1)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::value::get_price(arg3, 0x1::type_name::get<T0>(), arg4)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::value::get_price(arg3, 0x1::type_name::get<T1>(), arg4)), arg0);
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::lt(v1, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(18446744073709551615)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::invariant_seize_tokens_crazy_big());
        0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(v1)
    }

    public fun market_config<T0>(arg0: &Market<T0>) : &MarketConfiguration {
        let v0 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::borrow<MarketConfigurationKey, MarketConfiguration>(&arg0.id, v0)
    }

    public fun new_market_configuration(arg0: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) : MarketConfiguration {
        MarketConfiguration{close_factor: arg0}
    }

    public(friend) fun onboard_new_asset<T0, T1>(arg0: &mut Market<T0>, arg1: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::interest::InterestModel, arg2: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::BorrowConfig, arg3: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::NewLimiter, arg4: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::NewLimiter, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::supports<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>, T1>(&arg0.assets), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::asset_already_onboarded());
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::add_limiter_from_struct<T1>(&mut arg0.borrow_limiters, arg3);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::add_limiter_from_struct<T1>(&mut arg0.deposit_limiters, arg4);
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::store<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>, T1>(&mut arg0.assets, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::new<T0>(arg1, arg2, arg6));
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::store<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>, T1>(&mut arg0.reserves, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::new<T0, T1>(arg6, arg5));
    }

    public fun rate_limit_usage<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) : (0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::RateLimitUsage, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::RateLimitUsage) {
        (0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::current_rate_limit_usage(&arg0.deposit_limiters, arg1, arg2), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::current_rate_limit_usage(&arg0.borrow_limiters, arg1, arg2))
    }

    fun refresh_obligation_assets_interest<T0>(arg0: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>, arg1: &mut 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>, arg2: &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>, arg3: u64) {
        refresh_obligation_borrow_interest<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::deposit_types<T0>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(arg0, v2);
            v1 = v1 + 1;
            if (!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::can_be_collateral<T0>(v3)) {
                continue
            };
            let v4 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(arg1, v2);
            0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::accrue_interest<T0>(v4, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::repay_fee_rate(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_setting<T0>(v3)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::interest::calc_interest(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::interest_model<T0>(v3), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::util_rate<T0>(v4)), arg3);
        };
    }

    fun refresh_obligation_borrow_interest<T0>(arg0: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>, arg1: &mut 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>, arg2: &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::Obligation<T0>, arg3: u64) {
        let v0 = 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::debt_types<T0>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(arg0, v2);
            let v4 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(arg1, v2);
            0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::accrue_interest<T0>(v4, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::repay_fee_rate(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::borrow_setting<T0>(v3)), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::interest::calc_interest(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::interest_model<T0>(v3), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::util_rate<T0>(v4)), arg3);
            0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation::accrue_interest<T0>(arg2, v2, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::borrow_index::value(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::borrow_index<T0>(v4)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun repay_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::FlashLoan<T0, T1>) {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::flash_loan_ongoing<T0>(v0), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::flash_loan_not_ongoing());
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::flash_loan_finished<T0>(v0);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::repay_flash_loan<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1, arg2);
    }

    public fun reserve_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0> {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&arg0.reserves, arg1)
    }

    public fun supported_assets<T0>(arg0: &Market<T0>) : vector<0x1::type_name::TypeName> {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::keys<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&arg0.assets)
    }

    public(friend) fun take_revenue<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::take_revenue<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1), arg2)
    }

    public fun uid<T0>(arg0: &Market<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun update_asset_borrow<T0, T1>(arg0: &mut Market<T0>, arg1: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::BorrowConfig) {
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::update_borrow<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1);
    }

    public(friend) fun update_asset_collateral<T0, T1>(arg0: &mut Market<T0>, arg1: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Collateral) {
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::update_collateral<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>()), arg1);
    }

    public(friend) fun update_deposit_limiter<T0, T1>(arg0: &mut Market<T0>, arg1: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::NewLimiter) {
        assert!(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::supports<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>, T1>(&arg0.assets), 258);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::add_limiter_from_struct<T1>(&mut arg0.deposit_limiters, arg1);
    }

    public(friend) fun update_withdraw_limit<T0, T1>(arg0: &mut Market<T0>, arg1: u64) {
        assert!(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::supports<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::asset::Asset<T0>, T1>(&arg0.assets), 258);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::limiter::update_outflow_limit_params(&mut arg0.deposit_limiters, 0x1::type_name::get<T1>(), arg1);
    }

    // decompiled from Move bytecode v6
}

