module 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::asset_new {
    struct NewAssetWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        interest_model: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel,
        asset_config: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig,
    }

    struct UpdateAssetConfigWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        asset_config: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig,
    }

    struct NewAssetBuilder<phantom T0, phantom T1> {
        interest_model: 0x1::option::Option<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel>,
        asset_config: 0x1::option::Option<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>,
    }

    public fun create_asset_config_builder<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : NewAssetBuilder<T0, T1> {
        assert!(0x1::option::is_none<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>(&arg0.asset_config), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::duplicate_builder_call());
        arg0.asset_config = 0x1::option::some<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset_admin::create_market_asset_config(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7));
        arg0
    }

    public fun create_interest_model_builder<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : NewAssetBuilder<T0, T1> {
        assert!(0x1::option::is_none<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel>(&arg0.interest_model), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::duplicate_builder_call());
        arg0.interest_model = 0x1::option::some<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel>(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset_admin::create_interest_model(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8));
        arg0
    }

    public fun finalize_new_asset<T0, T1>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: NewAssetBuilder<T0, T1>, arg3: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel>(&arg2.interest_model), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>(&arg2.asset_config), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::missing_builder_field());
        let NewAssetBuilder {
            interest_model : v0,
            asset_config   : v1,
        } = arg2;
        let v2 = NewAssetWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>>(arg1),
            interest_model  : 0x1::option::destroy_some<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel>(v0),
            asset_config    : 0x1::option::destroy_some<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>(v1),
        };
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_new_wish_event<NewAssetWish<T0, T1>>(v2);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::store_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<NewAssetWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<NewAssetWish<T0, T1>>(), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::new_time_locked<NewAssetWish<T0, T1>>(v2, arg4, 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_duration_seconds(arg3), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun finalize_update_asset_config<T0, T1>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: NewAssetBuilder<T0, T1>, arg3: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>(&arg2.asset_config), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::missing_builder_field());
        assert!(0x1::option::is_none<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel>(&arg2.interest_model), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::invalid_builder_state());
        let NewAssetBuilder {
            interest_model : _,
            asset_config   : v1,
        } = arg2;
        let v2 = UpdateAssetConfigWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>>(arg1),
            asset_config    : 0x1::option::destroy_some<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>(v1),
        };
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_new_wish_event<UpdateAssetConfigWish<T0, T1>>(v2);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::store_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<UpdateAssetConfigWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish<T0, T1>>(), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::new_time_locked<UpdateAssetConfigWish<T0, T1>>(v2, arg4, 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_duration_seconds(arg3), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun fulfill_new_asset_wish<T0, T1>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::take_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<NewAssetWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<NewAssetWish<T0, T1>>());
        assert!(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::is_active<NewAssetWish<T0, T1>>(&v0, arg3), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::time_locked_not_active());
        let v1 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::into_inner<NewAssetWish<T0, T1>>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_fulfill_wish_event<NewAssetWish<T0, T1>>(v1);
        let NewAssetWish {
            protocol_app_id : _,
            market_id       : _,
            interest_model  : v4,
            asset_config    : v5,
        } = v1;
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset_admin::onboard_new_asset<T0, T1>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, arg3, arg4);
    }

    public fun fulfill_update_asset_config_wish<T0, T1>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::take_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<UpdateAssetConfigWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish<T0, T1>>());
        assert!(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::is_active<UpdateAssetConfigWish<T0, T1>>(&v0, arg3), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::time_locked_not_active());
        let v1 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::into_inner<UpdateAssetConfigWish<T0, T1>>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_fulfill_wish_event<UpdateAssetConfigWish<T0, T1>>(v1);
        let UpdateAssetConfigWish {
            protocol_app_id : _,
            market_id       : _,
            asset_config    : v4,
        } = v1;
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset_admin::update_market_asset_config<T0, T1>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg2, v4);
    }

    public fun start_new_asset<T0, T1>(arg0: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) : NewAssetBuilder<T0, T1> {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder<T0, T1>{
            interest_model : 0x1::option::none<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>(),
        }
    }

    public fun start_update_asset_config<T0, T1>(arg0: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) : NewAssetBuilder<T0, T1> {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder<T0, T1>{
            interest_model : 0x1::option::none<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::asset::AssetConfig>(),
        }
    }

    // decompiled from Move bytecode v6
}

