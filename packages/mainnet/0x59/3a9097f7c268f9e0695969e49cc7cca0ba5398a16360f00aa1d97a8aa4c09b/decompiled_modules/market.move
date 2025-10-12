module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market {
    struct MarketConfiguration has copy, drop, store {
        close_factor: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
    }

    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        assets: 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>,
        reserves: 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>,
        emode_group_registry: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>,
    }

    struct MarketConfigurationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CircuitBreakKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun id<T0>(arg0: &Market<T0>) : &0x2::object::ID {
        0x2::object::uid_as_inner(&arg0.id)
    }

    public(friend) fun new<T0>(arg0: MarketConfiguration, arg1: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = Market<T0>{
            id                   : 0x2::object::new(arg1),
            version              : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::current_version::current_version(),
            assets               : 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::new<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(arg1),
            reserves             : 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::new<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(arg1),
            emode_group_registry : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::new_e_mode_registry(arg1),
            obligations          : 0x2::object_table::new<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(arg1),
        };
        let v1 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::add<MarketConfigurationKey, MarketConfiguration>(&mut v0.id, v1, arg0);
        let v2 = CircuitBreakKey{dummy_field: false};
        0x2::dynamic_field::add<CircuitBreakKey, bool>(&mut v0.id, v2, false);
        v0
    }

    fun accrue_interest<T0, T1>(arg0: &mut 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>, arg1: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::AssetConfig, arg2: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::interest::InterestModel, arg3: u64) : &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0> {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(arg0, 0x1::type_name::get<T1>());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::accrue_interest<T0>(v0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::repay_fee_rate(arg1), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::interest::calc_interest(arg2, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::util_rate<T0>(v0)), arg3);
        v0
    }

    public fun asset_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0> {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&arg0.assets, arg1)
    }

    public(friend) fun borrow_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::FlashLoan<T0, T1>) {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::flash_loan_paused<T0>(v0), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::flash_loan_paused_for_asset());
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::flash_loan_ongoing<T0>(v0), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::flash_loan_ongoing());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::flash_loan_triggered<T0>(v0);
        let (v1, v2) = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::borrow_flash_loan<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg2, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::fee_rate(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::flash_loan(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_emode(&arg0.emode_group_registry, arg1, 0x1::type_name::get<T1>()))));
        (0x2::coin::from_balance<T1>(v1, arg3), v2)
    }

    public fun borrow_obligation<T0>(arg0: &Market<T0>, arg1: 0x2::object::ID) : &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    fun borrow_obligation_mut<T0>(arg0: &mut Market<T0>, arg1: 0x2::object::ID) : &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0> {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v1 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::market_id<T0>(v0);
        assert!(&v1 == 0x2::object::uid_as_inner(&arg0.id), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::obligation_from_different_market());
        v0
    }

    public fun collaterals_usd_for_borrow<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>, arg2: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v2 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::deposit_types<T0>(arg2);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::collateral(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_emode(arg0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(arg2), v3));
            if (!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::can_be_collateral(v4)) {
                continue
            };
            let v5 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::collateral_factor(v4);
            let v6 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::usd_value(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::get_price(arg4, v3, arg5), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::exchange_rate<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(arg1, v3)), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::ctoken_amount_by_coin<T0>(arg2, v3))), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg3, v3));
            v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v1, v6);
            v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v0, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(v6, v5));
        };
        (v0, v1)
    }

    public fun collaterals_usd_for_liquidation<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>, arg2: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v2 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::deposit_types<T0>(arg2);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::collateral(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_emode(arg0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(arg2), v3));
            if (!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::can_be_collateral(v4)) {
                continue
            };
            let v5 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::liquidation_factor(v4);
            let v6 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::usd_value(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::get_price(arg4, v3, arg5), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::exchange_rate<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(arg1, v3)), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::ctoken_amount_by_coin<T0>(arg2, v3))), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg3, v3));
            v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v1, v6);
            v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v0, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(v6, v5));
        };
        (v0, v1)
    }

    public fun debts_value_usd<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>, arg2: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
        let v2 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::debt_types<T0>(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v5 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::usd_value(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::get_price(arg4, v4, arg5), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::debt::debt(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::debt<T0>(arg2, v4), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow_index::value(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::borrow_index<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(arg1, v4)))), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg3, v4));
            v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v0, v5);
            v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v1, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(v5, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_weight(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_emode(arg0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(arg2), v4)))));
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    public(friend) fun discharge_circuit_break<T0>(arg0: &mut Market<T0>) {
        let v0 = CircuitBreakKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<CircuitBreakKey, bool>(&mut arg0.id, v0) = false;
    }

    public fun emode_registry<T0>(arg0: &Market<T0>) : &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry {
        &arg0.emode_group_registry
    }

    public(friend) fun emode_registry_mut<T0>(arg0: &mut Market<T0>) : &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry {
        &mut arg0.emode_group_registry
    }

    fun ensure_liquidate_borrow_allowed<T0, T1>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>, arg1: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry, arg2: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>, arg3: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg4: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg7: &0x2::clock::Clock) {
        let (v0, _) = debts_value_usd<T0>(arg1, arg2, arg0, arg4, arg6, arg7);
        let (v2, v3) = collaterals_usd_for_liquidation<T0>(arg1, arg2, arg0, arg4, arg6, arg7);
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::ge(v0, v2), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::liquidation_obligation_still_safe());
        if (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::le(v3, v0)) {
            return
        };
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::le(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(arg5), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::debt::unsafe_debt_amount(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::debt<T0>(arg0, 0x1::type_name::get<T1>())), arg3)), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::liquidation_close_factor_exceeded());
    }

    public(friend) fun ensure_version_matches<T0>(arg0: &Market<T0>) {
        assert!(arg0.version == 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::current_version::current_version(), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::version_mismatch());
    }

    public(friend) fun handle_borrow<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64) : (0x2::balance::Balance<T1>, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        assert!(arg2 > 0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::zero_debt_to_repay_error());
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&mut arg0.assets, v0);
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::borrow_paused<T0>(v1), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::borrow_paused_for_asset());
        let v2 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::min_borrow_amount(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::asset_config<T0>(v1));
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v4 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(v3), 0x1::type_name::get<T1>());
        let v5 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::max_borrow_amount(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow(v4));
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::limiter::add_outflow(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_mut_borrow_limiter(v4), arg6, arg2);
        let v6 = &mut arg0.reserves;
        refresh_obligation_borrow_interest<T0>(&arg0.assets, v6, v3, arg6);
        let v7 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow_index::value(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::borrow_index<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&arg0.reserves, v0)));
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::try_borrow_asset<T0, T1>(v3, arg2, v7);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v3, v2);
        assert!(is_obligation_safe<T0>(&arg0.emode_group_registry, &arg0.reserves, 0x2::object_table::borrow<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&arg0.obligations, arg1), arg3, arg4, arg5), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::obligation_not_safe_after_operation());
        let v8 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&mut arg0.reserves, v0);
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::borrow_limit_breached<T0>(v8, arg2, v5), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_borrow_limit_exceeded());
        (0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::borrow_amount<T0, T1>(v8, arg2), v7)
    }

    public(friend) fun handle_liquidation<T0, T1, T2>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        assert!(0x2::coin::value<T1>(&arg2) != 0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::liquidation_zero_repay());
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v1 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::collateral(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_emode(&arg0.emode_group_registry, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(v0), 0x1::type_name::get<T2>()));
        assert!(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::can_be_collateral(v1), 13906836489330753535);
        let v2 = &mut arg0.reserves;
        refresh_obligation_assets_interest<T0>(&arg0.assets, &arg0.emode_group_registry, v2, v0, arg6);
        ensure_liquidate_borrow_allowed<T0, T1>(v0, &arg0.emode_group_registry, &arg0.reserves, market_config<T0>(arg0).close_factor, arg3, 0x2::coin::value<T1>(&arg2), arg4, arg5);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::unsafe_repay_debt_only<T0, T1>(v0, 0x2::coin::value<T1>(&arg2));
        let v3 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T2>());
        let v4 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::withdraw_ctokens<T0, T2>(v0, liquidate_calculate_seize_ctokens<T1, T2>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::exchange_rate<T0>(v3), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::liquidation_incentive(v1), 0x2::coin::value<T1>(&arg2), arg4, arg5));
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::repay_amount<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg2);
        (0x2::coin::from_balance<T2>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::liquidate_ctokens<T0, T2>(v3, 0x2::coin::from_balance<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::ctoken::CToken<T0, T2>>(v4, arg7), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::liquidation_fee_rate(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::asset_config<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T2>())))), arg7), 0x2::balance::value<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::ctoken::CToken<T0, T2>>(&v4))
    }

    public(friend) fun handle_mint<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64) : u64 {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::deposit_paused<T0>(v0), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::deposit_paused_for_asset());
        let v1 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::asset_config<T0>(v0);
        let v2 = &mut arg0.reserves;
        let v3 = accrue_interest<T0, T1>(v2, v1, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::interest_model<T0>(v0), arg3);
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::deposit_limit_breached<T0>(v3, 0x2::coin::value<T1>(&arg2), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::max_deposit_amount(v1)), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_deposit_limit_exceeded());
        let v4 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::mint_ctokens<T0, T1>(v3, arg2);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::deposit_ctoken<T0, T1>(borrow_obligation_mut<T0>(arg0, arg1), v4);
        0x2::balance::value<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::ctoken::CToken<T0, T1>>(&v4)
    }

    public(friend) fun handle_new_obligation<T0>(arg0: &mut Market<T0>, arg1: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>) {
        0x2::object_table::add<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&arg1), arg1);
    }

    public(friend) fun handle_repay<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        let v1 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::min_borrow_amount(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::asset_config<T0>(v0));
        let v2 = &mut arg0.reserves;
        let v3 = accrue_interest<T0, T1>(v2, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::asset_config<T0>(v0), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::interest_model<T0>(v0), arg3);
        let v4 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v5 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow_index::value(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::borrow_index<T0>(v3));
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::enforce_post_borrow_repay_invariant<T0, T1>(v4, v1);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::limiter::reduce_outflow(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_mut_borrow_limiter(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(v4), 0x1::type_name::get<T1>())), arg3, 0x2::coin::value<T1>(&arg2));
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::repay_amount<T0, T1>(v3, arg2);
        (0x2::coin::split<T1>(&mut arg2, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::repay_debt<T0, T1>(v4, 0x2::coin::value<T1>(&arg2), v5), arg4), v5)
    }

    public(friend) fun handle_withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::withdraw_paused<T0>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&arg0.assets, v0)), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::withdraw_paused_for_asset());
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let v2 = &mut arg0.reserves;
        refresh_obligation_borrow_interest<T0>(&arg0.assets, v2, v1, arg6);
        let v3 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::withdraw_ctokens<T0, T1>(v1, arg2);
        assert!(is_obligation_safe<T0>(&arg0.emode_group_registry, &arg0.reserves, v1, arg3, arg4, arg5), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::obligation_not_safe_after_operation());
        let v4 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::burn_ctokens<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&mut arg0.reserves, v0), 0x2::coin::from_balance<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::ctoken::CToken<T0, T1>>(v3, arg7));
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::limiter::add_outflow(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_mut_deposit_limiter(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_mut_emode(&mut arg0.emode_group_registry, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(v1), 0x1::type_name::get<T1>())), arg6, 0x2::balance::value<T1>(&v4));
        (0x2::coin::from_balance<T1>(v4, arg7), 0x2::balance::value<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::ctoken::CToken<T0, T1>>(&v3))
    }

    public fun has_circuit_break_triggered<T0>(arg0: &Market<T0>) : bool {
        let v0 = CircuitBreakKey{dummy_field: false};
        *0x2::dynamic_field::borrow<CircuitBreakKey, bool>(&arg0.id, v0)
    }

    public fun is_obligation_safe<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry, arg1: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>, arg2: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock) : bool {
        let (_, v1) = debts_value_usd<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v2, _) = collaterals_usd_for_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::ge(v2, v1)
    }

    fun liquidate_calculate_seize_ctokens<T0, T1>(arg0: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg2: u64, arg3: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(arg2);
        let v1 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::div(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::div(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(v0, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(v0, arg1)), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::get_price(arg3, 0x1::type_name::get<T0>(), arg4)), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::get_price(arg3, 0x1::type_name::get<T1>(), arg4)), arg0);
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::lt(v1, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(18446744073709551615)), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invariant_seize_tokens_crazy_big());
        0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(v1)
    }

    public(friend) fun market_asset_borrow_mut<T0, T1>(arg0: &mut Market<T0>) : &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0> {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>())
    }

    public fun market_config<T0>(arg0: &Market<T0>) : &MarketConfiguration {
        let v0 = MarketConfigurationKey{dummy_field: false};
        0x2::dynamic_field::borrow<MarketConfigurationKey, MarketConfiguration>(&arg0.id, v0)
    }

    public(friend) fun new_market_configuration(arg0: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) : MarketConfiguration {
        MarketConfiguration{close_factor: arg0}
    }

    public(friend) fun onboard_new_asset<T0, T1>(arg0: &mut Market<T0>, arg1: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::interest::InterestModel, arg2: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::AssetConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::supports<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>, T1>(&arg0.assets), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::asset_already_onboarded());
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::store<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>, T1>(&mut arg0.assets, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::new<T0>(arg1, arg2, arg4));
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::store<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>, T1>(&mut arg0.reserves, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::new<T0, T1>(arg4, arg3));
    }

    fun refresh_obligation_assets_interest<T0>(arg0: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>, arg1: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::EModeGroupRegistry, arg2: &mut 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>, arg3: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>, arg4: u64) {
        refresh_obligation_borrow_interest<T0>(arg0, arg2, arg3, arg4);
        let v0 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::deposit_types<T0>(arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(arg0, v2);
            v1 = v1 + 1;
            if (!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::can_be_collateral(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::collateral(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::emode::borrow_emode(arg1, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(arg3), v2)))) {
                continue
            };
            let v4 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(arg2, v2);
            0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::accrue_interest<T0>(v4, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::repay_fee_rate(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::asset_config<T0>(v3)), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::interest::calc_interest(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::interest_model<T0>(v3), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::util_rate<T0>(v4)), arg4);
        };
    }

    fun refresh_obligation_borrow_interest<T0>(arg0: &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>, arg1: &mut 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::GenericCoinTypeStorage<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>, arg2: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::Obligation<T0>, arg3: u64) {
        let v0 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::debt_types<T0>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let v3 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(arg0, v2);
            let v4 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(arg1, v2);
            0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::accrue_interest<T0>(v4, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::repay_fee_rate(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::asset_config<T0>(v3)), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::interest::calc_interest(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::interest_model<T0>(v3), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::util_rate<T0>(v4)), arg3);
            0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::accrue_interest<T0>(arg2, v2, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow_index::value(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::borrow_index<T0>(v4)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun repay_flash_loan<T0, T1>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::FlashLoan<T0, T1>) {
        let v0 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&mut arg0.assets, 0x1::type_name::get<T1>());
        assert!(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::flash_loan_ongoing<T0>(v0), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::flash_loan_not_ongoing());
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::flash_loan_finished<T0>(v0);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::repay_flash_loan<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1, arg2);
    }

    public fun reserve_by_type<T0>(arg0: &Market<T0>, arg1: 0x1::type_name::TypeName) : &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0> {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&arg0.reserves, arg1)
    }

    public fun supported_assets<T0>(arg0: &Market<T0>) : vector<0x1::type_name::TypeName> {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::keys<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::asset::Asset<T0>>(&arg0.assets)
    }

    public(friend) fun take_revenue<T0, T1>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::take_revenue<T0, T1>(0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::generic_store::load_mut_by_type<0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::Reserve<T0>>(&mut arg0.reserves, 0x1::type_name::get<T1>()), arg1), arg2)
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

