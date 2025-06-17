module 0xe18a7141dcaabb5487b44f27acf09de54c98dce9db8feb7ca82cc2468c8b8652::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0xe18a7141dcaabb5487b44f27acf09de54c98dce9db8feb7ca82cc2468c8b8652::oracle_config::OracleConfig, arg3: &0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::staked_sui_vault::StakedSuiVault, arg4: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg5: &0x2::clock::Clock) : (u64, u64) {
        0xe18a7141dcaabb5487b44f27acf09de54c98dce9db8feb7ca82cc2468c8b8652::oracle_config::assert_pyth_price_info_object(arg2, arg1);
        let v0 = 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from_scaled_val((0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::staked_sui_vault::sui_to_afsui_exchange_rate(arg3, arg4) as u256));
        let (v1, _, v3, v4) = 0xe18a7141dcaabb5487b44f27acf09de54c98dce9db8feb7ca82cc2468c8b8652::pyth_adaptor::get_pyth_price(arg0, arg1, arg2, arg5);
        assert!(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::le(v0, 0xe18a7141dcaabb5487b44f27acf09de54c98dce9db8feb7ca82cc2468c8b8652::oracle_config::max_exchange_rate(arg2)), 2);
        assert!(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::ge(v0, 0xe18a7141dcaabb5487b44f27acf09de54c98dce9db8feb7ca82cc2468c8b8652::oracle_config::min_exchange_rate(arg2)), 2);
        let v5 = 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::decimals();
        let v6 = if (v3 < v5) {
            0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::floor(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::mul(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from(v1), v0)) * 0x1::u64::pow(10, v5 - v3)
        } else {
            0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::floor(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::mul(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from(v1), v0)) / 0x1::u64::pow(10, v3 - v5)
        };
        assert!(v6 > 0, 1);
        (v6, v4)
    }

    public fun set_price_as_primary(arg0: &mut 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOraclePriceUpdateRequest<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0xe18a7141dcaabb5487b44f27acf09de54c98dce9db8feb7ca82cc2468c8b8652::oracle_config::OracleConfig, arg4: &0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::staked_sui_vault::StakedSuiVault, arg5: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg6: &0x2::clock::Clock) {
        let (v0, v1) = get_price(arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = Rule{dummy_field: false};
        0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::set_primary_price<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, Rule>(v2, arg0, 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::new(v0, v1));
    }

    public fun set_price_as_secondary(arg0: &mut 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOraclePriceUpdateRequest<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0xe18a7141dcaabb5487b44f27acf09de54c98dce9db8feb7ca82cc2468c8b8652::oracle_config::OracleConfig, arg4: &0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::staked_sui_vault::StakedSuiVault, arg5: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg6: &0x2::clock::Clock) {
        let (v0, v1) = get_price(arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = Rule{dummy_field: false};
        0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::set_secondary_price<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, Rule>(v2, arg0, 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::new(v0, v1));
    }

    // decompiled from Move bytecode v6
}

