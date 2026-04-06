module 0xf96cf4a245b0f13b19c19bc7e0ca8c36901c82a18b1516689b94e677b505ac3b::wheel {
    struct WheelParametersSetEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        min_stake: u64,
        max_stake: u64,
        max_number_of_spins: u64,
        is_new: bool,
    }

    struct WheelSettingsCreatedEvent has copy, drop {
        settings_id: 0x2::object::ID,
        creator: address,
    }

    struct WheelConfigUpsertedEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        config_number: u8,
        num_cases: u8,
        multipliers: vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>,
        min_stake: u64,
        max_stake: u64,
        is_playable: bool,
        is_new: bool,
    }

    struct WheelInitialConfigsEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct Wheel has copy, drop, store {
        dummy_field: bool,
    }

    struct WheelSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WheelSettings has store, key {
        id: 0x2::object::UID,
    }

    struct WheelConfig has copy, drop, store {
        num_cases: u8,
        multipliers: vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>,
        min_stake: u64,
        max_stake: u64,
        is_playable: bool,
    }

    struct Parameters<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_stake: u64,
        max_stake: u64,
        max_number_of_spins: u64,
        configs: 0x2::vec_map::VecMap<u8, WheelConfig>,
    }

    public fun admin_create_wheel_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_wheel_settings(arg0, arg2);
    }

    public fun admin_edit_config<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u8, arg3: u8, arg4: vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg5: u64, arg6: u64, arg7: bool) {
        edit_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun admin_set_initial_configs<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap) {
        let v0 = borrow_parameters<T0>(borrow_wheel_settings(arg0));
        let v1 = v0.min_stake;
        let v2 = v0.max_stake;
        let v3 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v4 = &mut v3;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v4, float_fraction(37, 25));
        admin_upsert_config<T0>(arg0, arg1, 0, 10, v3, v1, v2, true);
        let v5 = WheelInitialConfigsEvent<T0>{coin_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<WheelInitialConfigsEvent<T0>>(v5);
        let v6 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v7 = &mut v6;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, float_fraction(47, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v7, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        admin_upsert_config<T0>(arg0, arg1, 1, 10, v6, v1, v2, true);
        let v8 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v9 = &mut v8;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, float_fraction(49, 5));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        admin_upsert_config<T0>(arg0, arg1, 2, 10, v8, v1, v2, true);
        let v10 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v11 = &mut v10;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v11, float_fraction(37, 25));
        admin_upsert_config<T0>(arg0, arg1, 3, 20, v10, v1, v2, true);
        let v12 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v13 = &mut v12;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(89, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v13, float_fraction(37, 25));
        admin_upsert_config<T0>(arg0, arg1, 4, 20, v12, v1, v2, true);
        let v14 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v15 = &mut v14;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, float_fraction(196, 10));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        admin_upsert_config<T0>(arg0, arg1, 5, 20, v14, v1, v2, true);
        let v16 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v17 = &mut v16;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v17, float_fraction(37, 25));
        admin_upsert_config<T0>(arg0, arg1, 6, 30, v16, v1, v2, true);
        let v18 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v19 = &mut v18;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(79, 20));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(42, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(49, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v19, float_fraction(37, 25));
        admin_upsert_config<T0>(arg0, arg1, 7, 30, v18, v1, v2, true);
        let v20 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v21 = &mut v20;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, float_fraction(147, 5));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v21, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        admin_upsert_config<T0>(arg0, arg1, 8, 30, v20, v1, v2, true);
        let v22 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v23 = &mut v22;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v23, float_fraction(37, 25));
        admin_upsert_config<T0>(arg0, arg1, 9, 40, v22, v1, v2, true);
        let v24 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v25 = &mut v24;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(79, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(49, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v25, float_fraction(197, 100));
        admin_upsert_config<T0>(arg0, arg1, 10, 40, v24, v1, v2, true);
        let v26 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v27 = &mut v26;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, float_fraction(196, 5));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v27, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        admin_upsert_config<T0>(arg0, arg1, 11, 40, v26, v1, v2, true);
        let v28 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v29 = &mut v28;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(59, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v29, float_fraction(37, 25));
        admin_upsert_config<T0>(arg0, arg1, 12, 50, v28, v1, v2, true);
        let v30 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v31 = &mut v30;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(247, 50));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(74, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(197, 100));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(37, 25));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v31, float_fraction(197, 100));
        admin_upsert_config<T0>(arg0, arg1, 13, 50, v30, v1, v2, true);
        let v32 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>();
        let v33 = &mut v32;
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, float_fraction(49, 1));
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(v33, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero());
        admin_upsert_config<T0>(arg0, arg1, 14, 50, v32, v1, v2, true);
    }

    public fun admin_set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun admin_upsert_config<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u8, arg3: u8, arg4: vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg5: u64, arg6: u64, arg7: bool) {
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun borrow_mut_parameters<T0>(arg0: &mut WheelSettings) : &mut Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 2);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Parameters<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_parameters<T0>(arg0: &WheelSettings) : &Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 2);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_wheel_settings(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &WheelSettings {
        let v0 = WheelSettingsKey{dummy_field: false};
        let v1 = Wheel{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<Wheel, WheelSettingsKey, WheelSettings>(arg0, v1, v0), 1);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<Wheel, WheelSettingsKey, WheelSettings>(arg0, v0)
    }

    fun borrow_wheel_settings_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut WheelSettings {
        let v0 = Wheel{dummy_field: false};
        let v1 = WheelSettingsKey{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<Wheel, WheelSettingsKey, WheelSettings>(arg0, v0, v1), 1);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<Wheel, WheelSettingsKey, WheelSettings>(arg0, v0, v1)
    }

    fun compute_expected_value(arg0: &vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg1: u8) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float {
        let v0 = 0x1::vector::length<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(arg0);
        assert!(v0 == (arg1 as u64), 9);
        let v1 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
        let v2 = 0;
        while (v2 < v0) {
            v1 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::add(v1, *0x1::vector::borrow<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(arg0, v2));
            v2 = v2 + 1;
        };
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(v1, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(v0))
    }

    fun create_wheel_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WheelSettings{id: 0x2::object::new(arg1)};
        let v1 = Wheel{dummy_field: false};
        let v2 = WheelSettingsKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<Wheel, WheelSettingsKey, WheelSettings>(arg0, v1, v2, v0);
        let v3 = WheelSettingsCreatedEvent{
            settings_id : 0x2::object::id<WheelSettings>(&v0),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<WheelSettingsCreatedEvent>(v3);
    }

    fun edit_config<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u8, arg2: u8, arg3: vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg4: u64, arg5: u64, arg6: bool) {
        validate_config(arg2, &arg3, arg4, arg5);
        let v0 = borrow_wheel_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        assert!(0x2::vec_map::contains<u8, WheelConfig>(&v1.configs, &arg1), 7);
        let v2 = 0x2::vec_map::get_mut<u8, WheelConfig>(&mut v1.configs, &arg1);
        v2.num_cases = arg2;
        v2.multipliers = arg3;
        v2.min_stake = arg4;
        v2.max_stake = arg5;
        v2.is_playable = arg6;
        let v3 = WheelConfigUpsertedEvent<T0>{
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            config_number : arg1,
            num_cases     : arg2,
            multipliers   : arg3,
            min_stake     : arg4,
            max_stake     : arg5,
            is_playable   : arg6,
            is_new        : false,
        };
        0x2::event::emit<WheelConfigUpsertedEvent<T0>>(v3);
    }

    fun float_fraction(arg0: u64, arg1: u64) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float {
        assert!(arg1 > 0, 3);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_fraction(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::i64::from(arg0), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::i64::from(arg1))
    }

    fun generate_case_index(arg0: &mut 0x2::random::RandomGenerator, arg1: u8) : (u8, u64) {
        let v0 = 0x2::random::generate_u64_in_range(arg0, 0, 1000000000 - 1);
        let v1 = (arg1 as u64);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = if (v2 < 1000000000 % v1) {
                1
            } else {
                0
            };
            let v4 = 1000000000 / v1 + v3;
            if (v0 < v4) {
                return ((v2 as u8), v0)
            };
            v0 = v0 - v4;
            v2 = v2 + 1;
        };
        (arg1 - 1, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun manager_create_wheel_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Wheel>(arg1, 0x2::tx_context::sender(arg2));
        create_wheel_settings(arg0, arg2);
    }

    public fun manager_edit_config<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u8, arg3: u8, arg4: vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Wheel>(arg1, 0x2::tx_context::sender(arg8));
        edit_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun manager_set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Wheel>(arg1, 0x2::tx_context::sender(arg5));
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun manager_upsert_config<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u8, arg3: u8, arg4: vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Wheel>(arg1, 0x2::tx_context::sender(arg8));
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun parameters_exist<T0>(arg0: &WheelSettings) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    entry fun play<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        play_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun play_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = Wheel{dummy_field: false};
        let v2 = borrow_parameters<T0>(borrow_wheel_settings(arg0));
        assert!(0x2::vec_map::contains<u8, WheelConfig>(&v2.configs, &arg4), 7);
        let v3 = v2.min_stake;
        let v4 = v2.max_stake;
        let v5 = v2.max_number_of_spins;
        let WheelConfig {
            num_cases   : v6,
            multipliers : v7,
            min_stake   : v8,
            max_stake   : v9,
            is_playable : v10,
        } = *0x2::vec_map::get<u8, WheelConfig>(&v2.configs, &arg4);
        let v11 = v7;
        assert!(v10, 8);
        assert!(v3 <= v4, 3);
        assert!(v5 > 0 && v5 <= 100, 3);
        assert!(arg3 > 0 && arg3 <= v5, 6);
        assert!(v6 > 0 && v6 <= 200, 3);
        assert!(0x1::vector::length<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&v11) == (v6 as u64), 9);
        let v12 = 0x2::coin::value<T0>(&arg2);
        let v13 = 0x2::coin::into_balance<T0>(arg2);
        let v14 = 0x2::coin::zero<T0>(arg10);
        if (v12 > arg1) {
            0x2::coin::join<T0>(&mut v14, 0x2::coin::take<T0>(&mut v13, v12 - arg1, arg10));
        } else if (v12 < arg1) {
            let v15 = Wheel{dummy_field: false};
            0x2::coin::put<T0>(&mut v13, 0x45f6855a4bed5ecbc7cd0032c46c8126a8c0c81ad5376d05ff27e02ae1deef21::free_bet::operator_claim_player_free_bet<T0, Wheel>(arg0, v15, v0, arg1 - v12, arg10));
        };
        assert!(0x2::balance::value<T0>(&v13) == arg1, 10);
        let v16 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_put_and_get_stake_ticket<T0, Wheel>(arg0, v1, 0x2::coin::from_balance<T0>(v13, arg10), arg3, v0, arg10);
        0xd2ccfa506d533b8640918f958e1f9471338e47febab14bfb7ab8a5936620a74f::loyalty::process_stake_ticket<T0, Wheel>(&mut v16, arg0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::utils::build_metadata<0x1::string::String, vector<u8>>(arg5, arg6), arg7, arg8, arg9, arg10);
        let v17 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_single_game_stake_amounts<T0, Wheel>(&v16);
        let v18 = 0x2::random::new_generator(arg9, arg10);
        let v19 = 0;
        while (v19 < arg3) {
            let v20 = *0x1::vector::borrow<u64>(&v17, v19);
            assert!(v20 >= v3, 4);
            assert!(v20 <= v4, 5);
            assert!(v20 >= v8, 4);
            assert!(v20 <= v9, 5);
            let v21 = &mut v18;
            let (v22, v23) = generate_case_index(v21, v6);
            let v24 = v23;
            let v25 = *0x1::vector::borrow<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&v11, (v22 as u64));
            let v26 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::floor_to_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(v20), v25));
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_outcome_amount<T0, Wheel>(&mut v16, v26);
            let v27 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            let v28 = (v22 as u8);
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v27, 0x1::string::utf8(b"case_index"), 0x2::bcs::to_bytes<u8>(&v28));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v27, 0x1::string::utf8(b"multiplier"), 0x2::bcs::to_bytes<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&v25));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v27, 0x1::string::utf8(b"payout_amount"), 0x2::bcs::to_bytes<u64>(&v26));
            let v29 = (arg4 as u8);
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v27, 0x1::string::utf8(b"wheel_config"), 0x2::bcs::to_bytes<u8>(&v29));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v27, 0x1::string::utf8(b"spin_value"), 0x2::bcs::to_bytes<u64>(&v24));
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_game_details<T0, Wheel>(&mut v16, v27);
            v19 = v19 + 1;
        };
        0x2::coin::join<T0>(&mut v14, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_and_destroy_stake_ticket<T0, Wheel>(arg0, v1, v16, arg9, arg10));
        v14
    }

    fun set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg2, 3);
        assert!(arg3 > 0 && arg3 <= 100, 3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = borrow_wheel_settings_mut(arg0);
        let v2 = parameters_exist<T0>(v1);
        if (v2) {
            let v3 = borrow_mut_parameters<T0>(v1);
            v3.min_stake = arg1;
            v3.max_stake = arg2;
            v3.max_number_of_spins = arg3;
        } else {
            let v4 = Parameters<T0>{
                id                  : 0x2::object::new(arg4),
                min_stake           : arg1,
                max_stake           : arg2,
                max_number_of_spins : arg3,
                configs             : 0x2::vec_map::empty<u8, WheelConfig>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Parameters<T0>>(&mut v1.id, v0, v4);
        };
        let v5 = WheelParametersSetEvent<T0>{
            coin_type           : v0,
            min_stake           : arg1,
            max_stake           : arg2,
            max_number_of_spins : arg3,
            is_new              : !v2,
        };
        0x2::event::emit<WheelParametersSetEvent<T0>>(v5);
    }

    fun upsert_config<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u8, arg2: u8, arg3: vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg4: u64, arg5: u64, arg6: bool) {
        validate_config(arg2, &arg3, arg4, arg5);
        let v0 = borrow_wheel_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        let v2 = 0x2::vec_map::contains<u8, WheelConfig>(&v1.configs, &arg1);
        if (v2) {
            let v3 = 0x2::vec_map::get_mut<u8, WheelConfig>(&mut v1.configs, &arg1);
            v3.num_cases = arg2;
            v3.multipliers = arg3;
            v3.min_stake = arg4;
            v3.max_stake = arg5;
            v3.is_playable = arg6;
        } else {
            let v4 = WheelConfig{
                num_cases   : arg2,
                multipliers : arg3,
                min_stake   : arg4,
                max_stake   : arg5,
                is_playable : arg6,
            };
            0x2::vec_map::insert<u8, WheelConfig>(&mut v1.configs, arg1, v4);
        };
        let v5 = WheelConfigUpsertedEvent<T0>{
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            config_number : arg1,
            num_cases     : arg2,
            multipliers   : arg3,
            min_stake     : arg4,
            max_stake     : arg5,
            is_playable   : arg6,
            is_new        : !v2,
        };
        0x2::event::emit<WheelConfigUpsertedEvent<T0>>(v5);
    }

    fun validate_config(arg0: u8, arg1: &vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg2: u64, arg3: u64) {
        assert!(arg0 > 0, 3);
        assert!(arg0 <= 200, 11);
        assert!(0x1::vector::length<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(arg1) == (arg0 as u64), 9);
        assert!(arg3 > 0, 3);
        assert!(arg2 <= arg3, 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(arg1)) {
            assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(0x1::vector::borrow<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(arg1, v0)), 3);
            v0 = v0 + 1;
        };
        let v1 = compute_expected_value(arg1, arg0);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::lt(&v1, &v2), 3);
        let v3 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(v1, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(1000000));
        let v4 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(990000);
        let v5 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(800000);
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::gt(&v3, &v4), 12);
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::lt(&v3, &v5), 13);
    }

    // decompiled from Move bytecode v6
}

