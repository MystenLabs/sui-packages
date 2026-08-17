module 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::asset_new {
    struct NewAssetWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        interest_model: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel,
        asset_config: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig,
    }

    struct UpdateAssetConfigWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        asset_config: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig,
    }

    struct NewAssetBuilder<phantom T0, phantom T1> {
        interest_model: 0x1::option::Option<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel>,
        asset_config: 0x1::option::Option<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>,
    }

    public fun create_asset_config_builder<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : NewAssetBuilder<T0, T1> {
        assert!(0x1::option::is_none<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>(&arg0.asset_config), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::duplicate_builder_call());
        arg0.asset_config = 0x1::option::some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset_admin::create_market_asset_config(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7));
        arg0
    }

    public fun create_interest_model_builder<T0, T1>(arg0: NewAssetBuilder<T0, T1>, arg1: &0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : NewAssetBuilder<T0, T1> {
        assert!(0x1::option::is_none<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel>(&arg0.interest_model), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::duplicate_builder_call());
        arg0.interest_model = 0x1::option::some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset_admin::create_interest_model(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8));
        arg0
    }

    public fun finalize_new_asset<T0, T1>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: NewAssetBuilder<T0, T1>, arg3: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel>(&arg2.interest_model), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>(&arg2.asset_config), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::missing_builder_field());
        let NewAssetBuilder {
            interest_model : v0,
            asset_config   : v1,
        } = arg2;
        let v2 = NewAssetWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>>(arg1),
            interest_model  : 0x1::option::destroy_some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel>(v0),
            asset_config    : 0x1::option::destroy_some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>(v1),
        };
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_new_wish_event<NewAssetWish<T0, T1>>(v2);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::store_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<NewAssetWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<NewAssetWish<T0, T1>>(), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::new_time_locked<NewAssetWish<T0, T1>>(v2, arg4, 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_duration_seconds(arg3), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun finalize_update_asset_config<T0, T1>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: NewAssetBuilder<T0, T1>, arg3: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>(&arg2.asset_config), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::missing_builder_field());
        assert!(0x1::option::is_none<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel>(&arg2.interest_model), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::invalid_builder_state());
        let NewAssetBuilder {
            interest_model : _,
            asset_config   : v1,
        } = arg2;
        let v2 = UpdateAssetConfigWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>>(arg1),
            asset_config    : 0x1::option::destroy_some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>(v1),
        };
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_new_wish_event<UpdateAssetConfigWish<T0, T1>>(v2);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::store_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<UpdateAssetConfigWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish<T0, T1>>(), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::new_time_locked<UpdateAssetConfigWish<T0, T1>>(v2, arg4, 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_duration_seconds(arg3), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun fulfill_new_asset_wish<T0, T1>(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::take_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<NewAssetWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<NewAssetWish<T0, T1>>());
        assert!(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::is_active<NewAssetWish<T0, T1>>(&v0, arg3), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::time_locked_not_active());
        let v1 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::into_inner<NewAssetWish<T0, T1>>(v0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_fulfill_wish_event<NewAssetWish<T0, T1>>(v1);
        let NewAssetWish {
            protocol_app_id : _,
            market_id       : _,
            interest_model  : v4,
            asset_config    : v5,
        } = v1;
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset_admin::onboard_new_asset<T0, T1>(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, arg3, arg4);
    }

    public fun fulfill_update_asset_config_wish<T0, T1>(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::take_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<UpdateAssetConfigWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetConfigWish<T0, T1>>());
        assert!(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::is_active<UpdateAssetConfigWish<T0, T1>>(&v0, arg3), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::time_locked_not_active());
        let v1 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::into_inner<UpdateAssetConfigWish<T0, T1>>(v0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_fulfill_wish_event<UpdateAssetConfigWish<T0, T1>>(v1);
        let UpdateAssetConfigWish {
            protocol_app_id : _,
            market_id       : _,
            asset_config    : v4,
        } = v1;
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset_admin::update_market_asset_config<T0, T1>(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::lending_admin_cap(arg0), arg1, arg2, v4);
    }

    public fun start_new_asset<T0, T1>(arg0: &0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) : NewAssetBuilder<T0, T1> {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder<T0, T1>{
            interest_model : 0x1::option::none<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>(),
        }
    }

    public fun start_update_asset_config<T0, T1>(arg0: &0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) : NewAssetBuilder<T0, T1> {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        NewAssetBuilder<T0, T1>{
            interest_model : 0x1::option::none<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel>(),
            asset_config   : 0x1::option::none<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset::AssetConfig>(),
        }
    }

    // decompiled from Move bytecode v6
}

