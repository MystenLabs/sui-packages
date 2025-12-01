module 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::asset_new {
    struct NewAssetWish<phantom T0, phantom T1> has copy, drop, store {
        interest_model: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel,
        asset_config: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig,
    }

    struct UpdateAssetConfigWish<phantom T0, phantom T1> has copy, drop, store {
        asset_config: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig,
    }

    struct NewAssetBuilder<phantom T0, phantom T1> {
        interest_model: 0x1::option::Option<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>,
        asset_config: 0x1::option::Option<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>,
    }

    public fun finalize_new_asset<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &mut 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>(&arg0.interest_model), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::errors::missing_builder_field());
        assert!(0x1::option::is_some<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>(&arg0.asset_config), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::errors::missing_builder_field());
        let NewAssetBuilder {
            interest_model : v0,
            asset_config   : v1,
        } = arg0;
        let v2 = NewAssetWish<T0, T1>{
            interest_model : 0x1::option::destroy_some<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>(v0),
            asset_config   : 0x1::option::destroy_some<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>(v1),
        };
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::wish_event::emit_new_wish_event<NewAssetWish<T0, T1>>(v2);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::store_locked_update<0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::TimeLock<NewAssetWish<T0, T1>>>(arg1, 0x1::type_name::with_defining_ids<NewAssetWish<T0, T1>>(), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::new_time_locked<NewAssetWish<T0, T1>>(v2, arg2, 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::time_lock_duration_seconds(arg1), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::time_lock_expriration_seconds(arg1)));
    }

    public fun finalize_update_asset_config<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &mut 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>(&arg0.asset_config), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::errors::missing_builder_field());
        assert!(0x1::option::is_none<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>(&arg0.interest_model), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::errors::invalid_builder_state());
        let NewAssetBuilder {
            interest_model : _,
            asset_config   : v1,
        } = arg0;
        let v2 = UpdateAssetConfigWish<T0, T1>{asset_config: 0x1::option::destroy_some<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>(v1)};
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::wish_event::emit_new_wish_event<UpdateAssetConfigWish<T0, T1>>(v2);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::store_locked_update<0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::TimeLock<UpdateAssetConfigWish<T0, T1>>>(arg1, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish<T0, T1>>(), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::new_time_locked<UpdateAssetConfigWish<T0, T1>>(v2, arg2, 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::time_lock_duration_seconds(arg1), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::time_lock_expriration_seconds(arg1)));
    }

    public fun fulfill_new_asset_wish<T0, T1>(arg0: &mut 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg0);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::take_locked_update<0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::TimeLock<NewAssetWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<NewAssetWish<T0, T1>>());
        assert!(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::is_active<NewAssetWish<T0, T1>>(&v0, arg3), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::errors::time_locked_not_active());
        let v1 = 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::into_inner<NewAssetWish<T0, T1>>(v0);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::wish_event::emit_fulfill_wish_event<NewAssetWish<T0, T1>>(v1);
        let NewAssetWish {
            interest_model : v2,
            asset_config   : v3,
        } = v1;
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset_admin::onboard_new_asset<T0, T1>(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::lending_admin_cap(arg0), arg1, arg2, v2, v3, arg3, arg4);
    }

    public fun fulfill_update_asset_config_wish<T0, T1>(arg0: &mut 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg0);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::take_locked_update<0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::TimeLock<UpdateAssetConfigWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish<T0, T1>>());
        assert!(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::is_active<UpdateAssetConfigWish<T0, T1>>(&v0, arg3), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::errors::time_locked_not_active());
        let v1 = 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::time_lock::into_inner<UpdateAssetConfigWish<T0, T1>>(v0);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::wish_event::emit_fulfill_wish_event<UpdateAssetConfigWish<T0, T1>>(v1);
        let UpdateAssetConfigWish { asset_config: v2 } = v1;
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset_admin::update_market_asset_config<T0, T1>(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::lending_admin_cap(arg0), arg1, arg2, v2);
    }

    public fun start_new_asset<T0, T1>(arg0: &0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) : NewAssetBuilder<T0, T1> {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg0);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder<T0, T1>{
            interest_model : 0x1::option::none<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>(),
        }
    }

    public fun start_update_asset_config<T0, T1>(arg0: &0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) : NewAssetBuilder<T0, T1> {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg0);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder<T0, T1>{
            interest_model : 0x1::option::none<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>(),
        }
    }

    public fun with_asset_config<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : NewAssetBuilder<T0, T1> {
        assert!(0x1::option::is_none<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>(&arg0.asset_config), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::errors::duplicate_builder_call());
        arg0.asset_config = 0x1::option::some<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset_admin::create_market_asset_config(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5));
        arg0
    }

    public fun with_interest_model<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : NewAssetBuilder<T0, T1> {
        assert!(0x1::option::is_none<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>(&arg0.interest_model), 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::errors::duplicate_builder_call());
        arg0.interest_model = 0x1::option::some<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset_admin::create_interest_model(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7));
        arg0
    }

    // decompiled from Move bytecode v6
}

