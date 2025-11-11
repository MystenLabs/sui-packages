module 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::asset_new {
    struct NewAssetWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel,
        asset_config: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig,
    }

    struct UpdateAssetConfigWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        asset_config: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig,
    }

    struct NewAssetBuilder {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x1::option::Option<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel>,
        asset_config: 0x1::option::Option<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>,
    }

    public fun finalize_new_asset(arg0: NewAssetBuilder, arg1: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel>(&arg0.interest_model), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>(&arg0.asset_config), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::missing_builder_field());
        let NewAssetBuilder {
            market_type    : v0,
            coin_type      : v1,
            interest_model : v2,
            asset_config   : v3,
        } = arg0;
        let v4 = NewAssetWish{
            market_type    : v0,
            coin_type      : v1,
            interest_model : 0x1::option::destroy_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel>(v2),
            asset_config   : 0x1::option::destroy_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>(v3),
        };
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::store_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<NewAssetWish>>(arg1, 0x1::type_name::with_defining_ids<NewAssetWish>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::new_time_locked<NewAssetWish>(v4, arg2));
    }

    public fun finalize_update_asset_config(arg0: NewAssetBuilder, arg1: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>(&arg0.asset_config), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::missing_builder_field());
        assert!(0x1::option::is_none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel>(&arg0.interest_model), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_builder_state());
        let NewAssetBuilder {
            market_type    : v0,
            coin_type      : v1,
            interest_model : _,
            asset_config   : v3,
        } = arg0;
        let v4 = UpdateAssetConfigWish{
            market_type  : v0,
            coin_type    : v1,
            asset_config : 0x1::option::destroy_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>(v3),
        };
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::store_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<UpdateAssetConfigWish>>(arg1, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::new_time_locked<UpdateAssetConfigWish>(v4, arg2));
    }

    public fun fulfill_new_asset_wish<T0, T1>(arg0: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg2: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::take_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<NewAssetWish>>(arg0, 0x1::type_name::with_defining_ids<NewAssetWish>());
        assert!(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::is_active<NewAssetWish>(&v0, arg3), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::time_locked_not_active());
        let NewAssetWish {
            market_type    : v1,
            coin_type      : v2,
            interest_model : v3,
            asset_config   : v4,
        } = 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::into_inner<NewAssetWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_coin_type());
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset_admin::onboard_new_asset<T0, T1>(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg0), arg1, arg2, v3, v4, arg3, arg4);
    }

    public fun fulfill_update_asset_config_wish<T0, T1>(arg0: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg2: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::take_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<UpdateAssetConfigWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish>());
        assert!(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::is_active<UpdateAssetConfigWish>(&v0, arg3), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::time_locked_not_active());
        let UpdateAssetConfigWish {
            market_type  : v1,
            coin_type    : v2,
            asset_config : v3,
        } = 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::into_inner<UpdateAssetConfigWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_coin_type());
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset_admin::update_market_asset_config<T0, T1>(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg0), arg1, arg2, v3);
    }

    public fun start_new_asset<T0, T1>(arg0: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) : NewAssetBuilder {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder{
            market_type    : 0x1::type_name::with_defining_ids<T0>(),
            coin_type      : 0x1::type_name::with_defining_ids<T1>(),
            interest_model : 0x1::option::none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>(),
        }
    }

    public fun start_update_asset_config<T0, T1>(arg0: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) : NewAssetBuilder {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder{
            market_type    : 0x1::type_name::with_defining_ids<T0>(),
            coin_type      : 0x1::type_name::with_defining_ids<T1>(),
            interest_model : 0x1::option::none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>(),
        }
    }

    public fun with_asset_config(arg0: NewAssetBuilder, arg1: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : NewAssetBuilder {
        assert!(0x1::option::is_none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>(&arg0.asset_config), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::duplicate_builder_call());
        arg0.asset_config = 0x1::option::some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig>(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset_admin::create_market_asset_config(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5));
        arg0
    }

    public fun with_interest_model(arg0: NewAssetBuilder, arg1: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : NewAssetBuilder {
        assert!(0x1::option::is_none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel>(&arg0.interest_model), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::duplicate_builder_call());
        arg0.interest_model = 0x1::option::some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel>(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset_admin::create_interest_model(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7));
        arg0
    }

    // decompiled from Move bytecode v6
}

