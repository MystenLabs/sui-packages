module 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::asset_new {
    struct NewAssetWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel,
        asset_config: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig,
    }

    struct UpdateAssetConfigWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        asset_config: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig,
    }

    struct NewAssetBuilder {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x1::option::Option<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>,
        asset_config: 0x1::option::Option<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>,
    }

    public fun finalize_new_asset(arg0: NewAssetBuilder, arg1: &mut 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>(&arg0.interest_model), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::missing_builder_field());
        assert!(0x1::option::is_some<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>(&arg0.asset_config), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::missing_builder_field());
        let NewAssetBuilder {
            market_type    : v0,
            coin_type      : v1,
            interest_model : v2,
            asset_config   : v3,
        } = arg0;
        let v4 = NewAssetWish{
            market_type    : v0,
            coin_type      : v1,
            interest_model : 0x1::option::destroy_some<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>(v2),
            asset_config   : 0x1::option::destroy_some<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>(v3),
        };
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::store_locked_update<0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::TimeLock<NewAssetWish>>(arg1, 0x1::type_name::with_defining_ids<NewAssetWish>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::new_time_locked<NewAssetWish>(v4, arg2, 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::time_lock_duration_seconds(arg1), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::time_lock_expriration_seconds(arg1)));
    }

    public fun finalize_update_asset_config(arg0: NewAssetBuilder, arg1: &mut 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>(&arg0.asset_config), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::missing_builder_field());
        assert!(0x1::option::is_none<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>(&arg0.interest_model), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::invalid_builder_state());
        let NewAssetBuilder {
            market_type    : v0,
            coin_type      : v1,
            interest_model : _,
            asset_config   : v3,
        } = arg0;
        let v4 = UpdateAssetConfigWish{
            market_type  : v0,
            coin_type    : v1,
            asset_config : 0x1::option::destroy_some<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>(v3),
        };
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::store_locked_update<0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::TimeLock<UpdateAssetConfigWish>>(arg1, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::new_time_locked<UpdateAssetConfigWish>(v4, arg2, 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::time_lock_duration_seconds(arg1), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::time_lock_expriration_seconds(arg1)));
    }

    public fun fulfill_new_asset_wish<T0, T1>(arg0: &mut 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::ProtocolApp, arg2: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::take_locked_update<0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::TimeLock<NewAssetWish>>(arg0, 0x1::type_name::with_defining_ids<NewAssetWish>());
        assert!(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::is_active<NewAssetWish>(&v0, arg3), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::time_locked_not_active());
        let NewAssetWish {
            market_type    : v1,
            coin_type      : v2,
            interest_model : v3,
            asset_config   : v4,
        } = 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::into_inner<NewAssetWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::invalid_coin_type());
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset_admin::onboard_new_asset<T0, T1>(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::lending_admin_cap(arg0), arg1, arg2, v3, v4, arg3, arg4);
    }

    public fun fulfill_update_asset_config_wish<T0, T1>(arg0: &mut 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::ProtocolApp, arg2: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::take_locked_update<0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::TimeLock<UpdateAssetConfigWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish>());
        assert!(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::is_active<UpdateAssetConfigWish>(&v0, arg3), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::time_locked_not_active());
        let UpdateAssetConfigWish {
            market_type  : v1,
            coin_type    : v2,
            asset_config : v3,
        } = 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::time_lock::into_inner<UpdateAssetConfigWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::invalid_coin_type());
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset_admin::update_market_asset_config<T0, T1>(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::lending_admin_cap(arg0), arg1, arg2, v3);
    }

    public fun start_new_asset<T0, T1>(arg0: &0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) : NewAssetBuilder {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder{
            market_type    : 0x1::type_name::with_defining_ids<T0>(),
            coin_type      : 0x1::type_name::with_defining_ids<T1>(),
            interest_model : 0x1::option::none<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>(),
        }
    }

    public fun start_update_asset_config<T0, T1>(arg0: &0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) : NewAssetBuilder {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder{
            market_type    : 0x1::type_name::with_defining_ids<T0>(),
            coin_type      : 0x1::type_name::with_defining_ids<T1>(),
            interest_model : 0x1::option::none<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>(),
        }
    }

    public fun with_asset_config(arg0: NewAssetBuilder, arg1: &0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : NewAssetBuilder {
        assert!(0x1::option::is_none<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>(&arg0.asset_config), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::duplicate_builder_call());
        arg0.asset_config = 0x1::option::some<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>(0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset_admin::create_market_asset_config(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5));
        arg0
    }

    public fun with_interest_model(arg0: NewAssetBuilder, arg1: &0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : NewAssetBuilder {
        assert!(0x1::option::is_none<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>(&arg0.interest_model), 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::errors::duplicate_builder_call());
        arg0.interest_model = 0x1::option::some<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>(0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset_admin::create_interest_model(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7));
        arg0
    }

    // decompiled from Move bytecode v6
}

