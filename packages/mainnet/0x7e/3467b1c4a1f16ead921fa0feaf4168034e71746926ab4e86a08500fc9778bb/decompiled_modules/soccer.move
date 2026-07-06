module 0x7e3467b1c4a1f16ead921fa0feaf4168034e71746926ab4e86a08500fc9778bb::soccer {
    struct SoccerParametersSetEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        min_stake: u64,
        max_stake: u64,
        max_number_of_shots: u64,
        is_new: bool,
    }

    struct SoccerSettingsCreatedEvent has copy, drop {
        settings_id: 0x2::object::ID,
        creator: address,
    }

    struct SoccerConfigUpsertedEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        config_number: u8,
        num_zones: u64,
        shot_zone_ids: vector<u8>,
        shot_zone_win_weights: vector<u64>,
        shot_zone_multipliers: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        shot_zone_goal_outcome_codes: vector<u16>,
        shot_zone_miss_outcome_codes: vector<u16>,
        min_stake: u64,
        max_stake: u64,
        is_playable: bool,
        is_new: bool,
    }

    struct SoccerConfigRemovedEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        config_number: u8,
        num_zones: u64,
        shot_zone_ids: vector<u8>,
        shot_zone_win_weights: vector<u64>,
        shot_zone_multipliers: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        shot_zone_goal_outcome_codes: vector<u16>,
        shot_zone_miss_outcome_codes: vector<u16>,
        min_stake: u64,
        max_stake: u64,
        is_playable: bool,
    }

    struct SoccerCountryUpsertedEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        country_id: u16,
        label: 0x1::string::String,
        is_new: bool,
    }

    struct SoccerCountryRemovedEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        country_id: u16,
    }

    struct Soccer has copy, drop, store {
        dummy_field: bool,
    }

    struct SoccerSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SoccerSettings has store, key {
        id: 0x2::object::UID,
    }

    struct SoccerConfig has copy, drop, store {
        shot_zone_ids: vector<u8>,
        shot_zone_win_weights: vector<u64>,
        shot_zone_multipliers: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        shot_zone_goal_outcome_codes: vector<u16>,
        shot_zone_miss_outcome_codes: vector<u16>,
        min_stake: u64,
        max_stake: u64,
        is_playable: bool,
    }

    struct Parameters<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_stake: u64,
        max_stake: u64,
        max_number_of_shots: u64,
        configs: 0x2::vec_map::VecMap<u8, SoccerConfig>,
        countries: 0x2::vec_map::VecMap<u16, 0x1::string::String>,
    }

    public fun admin_create_soccer_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_soccer_settings(arg0, arg2);
    }

    public fun admin_remove_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8) {
        remove_config<T0>(arg0, arg2);
    }

    public fun admin_remove_country<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u16) {
        remove_country<T0>(arg0, arg2);
    }

    public fun admin_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun admin_upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg6: vector<u16>, arg7: vector<u16>, arg8: u64, arg9: u64, arg10: bool) {
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun admin_upsert_country<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u16, arg3: 0x1::string::String) {
        upsert_country<T0>(arg0, arg2, arg3);
    }

    fun assert_zone_vectors_match(arg0: &vector<u8>, arg1: &vector<u64>, arg2: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg3: &vector<u16>, arg4: &vector<u16>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 3);
        assert!(v0 <= 200, 11);
        assert!(0x1::vector::length<u64>(arg1) == v0, 9);
        assert!(0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg2) == v0, 9);
        assert!(0x1::vector::length<u16>(arg3) == v0, 9);
        assert!(0x1::vector::length<u16>(arg4) == v0, 9);
        v0
    }

    fun borrow_mut_parameters<T0>(arg0: &mut SoccerSettings) : &mut Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 2);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Parameters<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_parameters<T0>(arg0: &SoccerSettings) : &Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 2);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_soccer_settings(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &SoccerSettings {
        let v0 = SoccerSettingsKey{dummy_field: false};
        let v1 = Soccer{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Soccer, SoccerSettingsKey, SoccerSettings>(arg0, v1, v0), 1);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Soccer, SoccerSettingsKey, SoccerSettings>(arg0, v0)
    }

    fun borrow_soccer_settings_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut SoccerSettings {
        let v0 = Soccer{dummy_field: false};
        let v1 = SoccerSettingsKey{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Soccer, SoccerSettingsKey, SoccerSettings>(arg0, v0, v1), 1);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Soccer, SoccerSettingsKey, SoccerSettings>(arg0, v0, v1)
    }

    fun compute_zone_expected_value(arg0: u64, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(arg0), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(10000)), arg1)
    }

    fun compute_zone_payout(arg0: u64, arg1: bool, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) : u64 {
        if (arg1) {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(arg0), arg2))
        } else {
            0
        }
    }

    fun create_soccer_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SoccerSettings{id: 0x2::object::new(arg1)};
        let v1 = Soccer{dummy_field: false};
        let v2 = SoccerSettingsKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Soccer, SoccerSettingsKey, SoccerSettings>(arg0, v1, v2, v0);
        let v3 = SoccerSettingsCreatedEvent{
            settings_id : 0x2::object::id<SoccerSettings>(&v0),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<SoccerSettingsCreatedEvent>(v3);
    }

    fun find_shot_zone_index(arg0: &vector<u8>, arg1: u8) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 15
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun manager_create_soccer_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Soccer>(arg1, 0x2::tx_context::sender(arg2));
        create_soccer_settings(arg0, arg2);
    }

    public fun manager_remove_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Soccer>(arg1, 0x2::tx_context::sender(arg3));
        remove_config<T0>(arg0, arg2);
    }

    public fun manager_remove_country<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Soccer>(arg1, 0x2::tx_context::sender(arg3));
        remove_country<T0>(arg0, arg2);
    }

    public fun manager_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Soccer>(arg1, 0x2::tx_context::sender(arg5));
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun manager_upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u8, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg6: vector<u16>, arg7: vector<u16>, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Soccer>(arg1, 0x2::tx_context::sender(arg11));
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun manager_upsert_country<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u16, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Soccer>(arg1, 0x2::tx_context::sender(arg4));
        upsert_country<T0>(arg0, arg2, arg3);
    }

    fun max_multiplier(arg0: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = *0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg0, 0);
        let v1 = 1;
        while (v1 < 0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg0)) {
            let v2 = 0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg0, v1);
            if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(v2, &v0)) {
                v0 = *v2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun parameters_exist<T0>(arg0: &SoccerSettings) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    entry fun play<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: u16, arg6: u8, arg7: vector<0x1::string::String>, arg8: vector<vector<u8>>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x2::clock::Clock, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        play_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    fun play_internal<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: u16, arg6: u8, arg7: vector<0x1::string::String>, arg8: vector<vector<u8>>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x2::clock::Clock, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = Soccer{dummy_field: false};
        let v2 = borrow_parameters<T0>(borrow_soccer_settings(arg0));
        assert!(0x2::vec_map::contains<u16, 0x1::string::String>(&v2.countries, &arg5), 14);
        assert!(0x2::vec_map::contains<u8, SoccerConfig>(&v2.configs, &arg4), 7);
        let v3 = v2.min_stake;
        let v4 = v2.max_stake;
        let SoccerConfig {
            shot_zone_ids                : v5,
            shot_zone_win_weights        : v6,
            shot_zone_multipliers        : v7,
            shot_zone_goal_outcome_codes : v8,
            shot_zone_miss_outcome_codes : v9,
            min_stake                    : v10,
            max_stake                    : v11,
            is_playable                  : v12,
        } = *0x2::vec_map::get<u8, SoccerConfig>(&v2.configs, &arg4);
        let v13 = v9;
        let v14 = v8;
        let v15 = v7;
        let v16 = v6;
        let v17 = v5;
        assert!(v12, 8);
        assert!(arg3 > 0 && arg3 <= v2.max_number_of_shots, 6);
        assert_zone_vectors_match(&v17, &v16, &v15, &v14, &v13);
        let v18 = find_shot_zone_index(&v17, arg6);
        let v19 = *0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v15, v18);
        let v20 = 0x2::coin::value<T0>(&arg2);
        let v21 = 0x2::coin::into_balance<T0>(arg2);
        let v22 = 0x2::coin::zero<T0>(arg12);
        if (v20 > arg1) {
            0x2::coin::join<T0>(&mut v22, 0x2::coin::take<T0>(&mut v21, v20 - arg1, arg12));
        } else if (v20 < arg1) {
            let v23 = Soccer{dummy_field: false};
            0x2::coin::put<T0>(&mut v21, 0x3bbb757a9d4638488d874a205ddf8c4ead2e102748f7d3c9d79c56a2f09357d::free_bet::operator_claim_player_free_bet<T0, Soccer>(arg0, v23, v0, arg1 - v20, arg12));
        };
        assert!(0x2::balance::value<T0>(&v21) == arg1, 10);
        let v24 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_and_get_stake_ticket<T0, Soccer>(arg0, v1, 0x2::coin::from_balance<T0>(v21, arg12), arg3, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::compute_total_payout_for_uniform_multiplier(arg1, arg3, max_multiplier(&v15)), v0, arg12);
        0x13a877d974d59f54d8affa4d345bf794cf8e9e936d9d22100c801c95b415930f::loyalty::process_stake_ticket<T0, Soccer>(&mut v24, arg0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::utils::build_metadata<0x1::string::String, vector<u8>>(arg7, arg8), arg9, arg10, arg11, arg12);
        let v25 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_single_game_stake_amounts<T0, Soccer>(&v24);
        let v26 = 0x2::random::new_generator(arg11, arg12);
        let v27 = 0;
        while (v27 < arg3) {
            let v28 = *0x1::vector::borrow<u64>(&v25, v27);
            assert!(v28 >= v3, 4);
            assert!(v28 <= v4, 5);
            assert!(v28 >= v10, 4);
            assert!(v28 <= v11, 5);
            let v29 = 0x2::random::generate_u64_in_range(&mut v26, 0, shot_zone_random_upper_bound());
            let v30 = v29 < *0x1::vector::borrow<u64>(&v16, v18);
            let v31 = if (v30) {
                *0x1::vector::borrow<u16>(&v14, v18)
            } else {
                *0x1::vector::borrow<u16>(&v13, v18)
            };
            let v32 = v31;
            let v33 = compute_zone_payout(v28, v30, v19);
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_outcome_amount<T0, Soccer>(&mut v24, v33);
            let v34 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            let v35 = (arg4 as u8);
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v34, 0x1::string::utf8(b"soccer_config"), 0x2::bcs::to_bytes<u8>(&v35));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v34, 0x1::string::utf8(b"outcome_code"), 0x2::bcs::to_bytes<u16>(&v32));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v34, 0x1::string::utf8(b"country_id"), 0x2::bcs::to_bytes<u16>(&arg5));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v34, 0x1::string::utf8(b"shot_zone_id"), 0x2::bcs::to_bytes<u8>(&arg6));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v34, 0x1::string::utf8(b"is_goal"), 0x2::bcs::to_bytes<bool>(&v30));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v34, 0x1::string::utf8(b"multiplier"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v19));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v34, 0x1::string::utf8(b"payout_amount"), 0x2::bcs::to_bytes<u64>(&v33));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v34, 0x1::string::utf8(b"draw_value"), 0x2::bcs::to_bytes<u64>(&v29));
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_game_details<T0, Soccer>(&mut v24, v34);
            v27 = v27 + 1;
        };
        0x2::coin::join<T0>(&mut v22, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_and_destroy_stake_ticket<T0, Soccer>(arg0, v1, v24, arg11, arg12));
        v22
    }

    fun remove_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u8) {
        let v0 = borrow_soccer_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        assert!(0x2::vec_map::contains<u8, SoccerConfig>(&v1.configs, &arg1), 7);
        let (_, v3) = 0x2::vec_map::remove<u8, SoccerConfig>(&mut v1.configs, &arg1);
        let SoccerConfig {
            shot_zone_ids                : v4,
            shot_zone_win_weights        : v5,
            shot_zone_multipliers        : v6,
            shot_zone_goal_outcome_codes : v7,
            shot_zone_miss_outcome_codes : v8,
            min_stake                    : v9,
            max_stake                    : v10,
            is_playable                  : v11,
        } = v3;
        let v12 = v4;
        let v13 = SoccerConfigRemovedEvent<T0>{
            coin_type                    : 0x1::type_name::with_defining_ids<T0>(),
            config_number                : arg1,
            num_zones                    : 0x1::vector::length<u8>(&v12),
            shot_zone_ids                : v12,
            shot_zone_win_weights        : v5,
            shot_zone_multipliers        : v6,
            shot_zone_goal_outcome_codes : v7,
            shot_zone_miss_outcome_codes : v8,
            min_stake                    : v9,
            max_stake                    : v10,
            is_playable                  : v11,
        };
        0x2::event::emit<SoccerConfigRemovedEvent<T0>>(v13);
    }

    fun remove_country<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u16) {
        let v0 = borrow_soccer_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        assert!(0x2::vec_map::contains<u16, 0x1::string::String>(&v1.countries, &arg1), 14);
        let (_, _) = 0x2::vec_map::remove<u16, 0x1::string::String>(&mut v1.countries, &arg1);
        let v4 = SoccerCountryRemovedEvent<T0>{
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            country_id : arg1,
        };
        0x2::event::emit<SoccerCountryRemovedEvent<T0>>(v4);
    }

    fun set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg2, 3);
        assert!(arg3 > 0 && arg3 <= 100, 3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = borrow_soccer_settings_mut(arg0);
        let v2 = parameters_exist<T0>(v1);
        if (v2) {
            let v3 = borrow_mut_parameters<T0>(v1);
            v3.min_stake = arg1;
            v3.max_stake = arg2;
            v3.max_number_of_shots = arg3;
        } else {
            let v4 = Parameters<T0>{
                id                  : 0x2::object::new(arg4),
                min_stake           : arg1,
                max_stake           : arg2,
                max_number_of_shots : arg3,
                configs             : 0x2::vec_map::empty<u8, SoccerConfig>(),
                countries           : 0x2::vec_map::empty<u16, 0x1::string::String>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Parameters<T0>>(&mut v1.id, v0, v4);
        };
        let v5 = SoccerParametersSetEvent<T0>{
            coin_type           : v0,
            min_stake           : arg1,
            max_stake           : arg2,
            max_number_of_shots : arg3,
            is_new              : !v2,
        };
        0x2::event::emit<SoccerParametersSetEvent<T0>>(v5);
    }

    fun shot_zone_random_upper_bound() : u64 {
        10000 - 1
    }

    fun upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u8, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg5: vector<u16>, arg6: vector<u16>, arg7: u64, arg8: u64, arg9: bool) {
        validate_config(&arg2, &arg3, &arg4, &arg5, &arg6, arg7, arg8);
        let v0 = borrow_soccer_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        let v2 = 0x2::vec_map::contains<u8, SoccerConfig>(&v1.configs, &arg1);
        if (v2) {
            let v3 = 0x2::vec_map::get_mut<u8, SoccerConfig>(&mut v1.configs, &arg1);
            v3.shot_zone_ids = arg2;
            v3.shot_zone_win_weights = arg3;
            v3.shot_zone_multipliers = arg4;
            v3.shot_zone_goal_outcome_codes = arg5;
            v3.shot_zone_miss_outcome_codes = arg6;
            v3.min_stake = arg7;
            v3.max_stake = arg8;
            v3.is_playable = arg9;
        } else {
            let v4 = SoccerConfig{
                shot_zone_ids                : arg2,
                shot_zone_win_weights        : arg3,
                shot_zone_multipliers        : arg4,
                shot_zone_goal_outcome_codes : arg5,
                shot_zone_miss_outcome_codes : arg6,
                min_stake                    : arg7,
                max_stake                    : arg8,
                is_playable                  : arg9,
            };
            0x2::vec_map::insert<u8, SoccerConfig>(&mut v1.configs, arg1, v4);
        };
        let v5 = SoccerConfigUpsertedEvent<T0>{
            coin_type                    : 0x1::type_name::with_defining_ids<T0>(),
            config_number                : arg1,
            num_zones                    : 0x1::vector::length<u8>(&arg2),
            shot_zone_ids                : arg2,
            shot_zone_win_weights        : arg3,
            shot_zone_multipliers        : arg4,
            shot_zone_goal_outcome_codes : arg5,
            shot_zone_miss_outcome_codes : arg6,
            min_stake                    : arg7,
            max_stake                    : arg8,
            is_playable                  : arg9,
            is_new                       : !v2,
        };
        0x2::event::emit<SoccerConfigUpsertedEvent<T0>>(v5);
    }

    fun upsert_country<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u16, arg2: 0x1::string::String) {
        let v0 = borrow_soccer_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        let v2 = 0x2::vec_map::contains<u16, 0x1::string::String>(&v1.countries, &arg1);
        if (v2) {
            *0x2::vec_map::get_mut<u16, 0x1::string::String>(&mut v1.countries, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<u16, 0x1::string::String>(&mut v1.countries, arg1, arg2);
        };
        let v3 = SoccerCountryUpsertedEvent<T0>{
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            country_id : arg1,
            label      : arg2,
            is_new     : !v2,
        };
        0x2::event::emit<SoccerCountryUpsertedEvent<T0>>(v3);
    }

    fun validate_config(arg0: &vector<u8>, arg1: &vector<u64>, arg2: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg3: &vector<u16>, arg4: &vector<u16>, arg5: u64, arg6: u64) {
        assert!(arg5 <= arg6, 3);
        assert!(arg6 > 0, 3);
        validate_zone_entries(arg0, arg1, arg2);
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(990000);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(800000);
        let v2 = 0;
        while (v2 < assert_zone_vectors_match(arg0, arg1, arg2, arg3, arg4)) {
            let v3 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(compute_zone_expected_value(*0x1::vector::borrow<u64>(arg1, v2), *0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg2, v2)), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1000000));
            assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&v3, &v0), 12);
            assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&v3, &v1), 13);
            v2 = v2 + 1;
        };
    }

    fun validate_zone_entries(arg0: &vector<u8>, arg1: &vector<u64>, arg2: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v0);
            let v3 = 0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg2, v0);
            assert!(v2 > 0 && v2 < 10000, 3);
            assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive(v3), 3);
            let v4 = v0 + 1;
            while (v4 < v1) {
                assert!(*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg0, v4), 3);
                v4 = v4 + 1;
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

