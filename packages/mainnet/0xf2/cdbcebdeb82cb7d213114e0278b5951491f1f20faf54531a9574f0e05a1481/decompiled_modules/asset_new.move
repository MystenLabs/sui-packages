module 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::asset_new {
    struct NewAssetWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        interest_model: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel,
        asset_config: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig,
    }

    struct UpdateAssetConfigWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        asset_config: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig,
    }

    struct NewAssetBuilder<phantom T0, phantom T1> {
        interest_model: 0x1::option::Option<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel>,
        asset_config: 0x1::option::Option<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>,
    }

    public fun create_asset_config_builder<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg2: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : NewAssetBuilder<T0, T1> {
        assert!(0x1::option::is_none<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>(&arg0.asset_config), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::duplicate_builder_call());
        arg0.asset_config = 0x1::option::some<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset_admin::create_market_asset_config(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7));
        arg0
    }

    public fun create_interest_model_builder<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg2: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : NewAssetBuilder<T0, T1> {
        assert!(0x1::option::is_none<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel>(&arg0.interest_model), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::duplicate_builder_call());
        arg0.interest_model = 0x1::option::some<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel>(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset_admin::create_interest_model(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8));
        arg0
    }

    public fun finalize_new_asset<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg2: NewAssetBuilder<T0, T1>, arg3: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel>(&arg2.interest_model), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::missing_builder_field());
        assert!(0x1::option::is_some<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>(&arg2.asset_config), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::missing_builder_field());
        let NewAssetBuilder {
            interest_model : v0,
            asset_config   : v1,
        } = arg2;
        let v2 = NewAssetWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>>(arg1),
            interest_model  : 0x1::option::destroy_some<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel>(v0),
            asset_config    : 0x1::option::destroy_some<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>(v1),
        };
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::wish_event::emit_new_wish_event<NewAssetWish<T0, T1>>(v2);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::store_locked_update<0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::TimeLock<NewAssetWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<NewAssetWish<T0, T1>>(), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::new_time_locked<NewAssetWish<T0, T1>>(v2, arg4, 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::time_lock_duration_seconds(arg3), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun finalize_update_asset_config<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg2: NewAssetBuilder<T0, T1>, arg3: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>(&arg2.asset_config), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::missing_builder_field());
        assert!(0x1::option::is_none<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel>(&arg2.interest_model), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::invalid_builder_state());
        let NewAssetBuilder {
            interest_model : _,
            asset_config   : v1,
        } = arg2;
        let v2 = UpdateAssetConfigWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>>(arg1),
            asset_config    : 0x1::option::destroy_some<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>(v1),
        };
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::wish_event::emit_new_wish_event<UpdateAssetConfigWish<T0, T1>>(v2);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::store_locked_update<0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::TimeLock<UpdateAssetConfigWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish<T0, T1>>(), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::new_time_locked<UpdateAssetConfigWish<T0, T1>>(v2, arg4, 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::time_lock_duration_seconds(arg3), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun fulfill_new_asset_wish<T0, T1>(arg0: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::take_locked_update<0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::TimeLock<NewAssetWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<NewAssetWish<T0, T1>>());
        assert!(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::is_active<NewAssetWish<T0, T1>>(&v0, arg3), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::time_locked_not_active());
        let v1 = 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::into_inner<NewAssetWish<T0, T1>>(v0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::wish_event::emit_fulfill_wish_event<NewAssetWish<T0, T1>>(v1);
        let NewAssetWish {
            protocol_app_id : _,
            market_id       : _,
            interest_model  : v4,
            asset_config    : v5,
        } = v1;
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset_admin::onboard_new_asset<T0, T1>(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, arg3, arg4);
    }

    public fun fulfill_update_asset_config_wish<T0, T1>(arg0: &mut 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::take_locked_update<0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::TimeLock<UpdateAssetConfigWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish<T0, T1>>());
        assert!(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::is_active<UpdateAssetConfigWish<T0, T1>>(&v0, arg3), 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::errors::time_locked_not_active());
        let v1 = 0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::time_lock::into_inner<UpdateAssetConfigWish<T0, T1>>(v0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::wish_event::emit_fulfill_wish_event<UpdateAssetConfigWish<T0, T1>>(v1);
        let UpdateAssetConfigWish {
            protocol_app_id : _,
            market_id       : _,
            asset_config    : v4,
        } = v1;
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset_admin::update_market_asset_config<T0, T1>(0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::lending_admin_cap(arg0), arg1, arg2, v4);
    }

    public fun start_new_asset<T0, T1>(arg0: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) : NewAssetBuilder<T0, T1> {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder<T0, T1>{
            interest_model : 0x1::option::none<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>(),
        }
    }

    public fun start_update_asset_config<T0, T1>(arg0: &0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) : NewAssetBuilder<T0, T1> {
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_functional(arg0);
        0xf2cdbcebdeb82cb7d213114e0278b5951491f1f20faf54531a9574f0e05a1481::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder<T0, T1>{
            interest_model : 0x1::option::none<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::asset::AssetConfig>(),
        }
    }

    // decompiled from Move bytecode v6
}

