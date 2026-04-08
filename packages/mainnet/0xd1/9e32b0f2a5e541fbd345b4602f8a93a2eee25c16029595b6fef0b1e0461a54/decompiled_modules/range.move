module 0xd19e32b0f2a5e541fbd345b4602f8a93a2eee25c16029595b6fef0b1e0461a54::range {
    struct RangeSettingsCreatedEvent has copy, drop {
        settings_id: 0x2::object::ID,
        creator: address,
    }

    struct RangeParametersSetEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        min_stake: u64,
        max_stake: u64,
        min_zone_size: u64,
        max_zone_size: u64,
        max_number_of_games: u64,
        min_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        is_new: bool,
    }

    struct Range has copy, drop, store {
        dummy_field: bool,
    }

    struct RangeSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RangeSettings has store, key {
        id: 0x2::object::UID,
    }

    struct Parameters<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_stake: u64,
        max_stake: u64,
        min_zone_size: u64,
        max_zone_size: u64,
        max_number_of_games: u64,
        min_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    public fun admin_create_range_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_range_settings(arg0, arg2);
    }

    public fun admin_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg8: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg9: &mut 0x2::tx_context::TxContext) {
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun borrow_mut_parameters<T0>(arg0: &mut RangeSettings) : &mut Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621649480941573);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Parameters<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_parameters<T0>(arg0: &RangeSettings) : &Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621623711137797);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_range_settings(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &RangeSettings {
        let v0 = RangeSettingsKey{dummy_field: false};
        let v1 = Range{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Range, RangeSettingsKey, RangeSettings>(arg0, v1, v0), 13835340037065146371);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Range, RangeSettingsKey, RangeSettings>(arg0, v0)
    }

    fun borrow_range_settings_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut RangeSettings {
        let v0 = Range{dummy_field: false};
        let v1 = RangeSettingsKey{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Range, RangeSettingsKey, RangeSettings>(arg0, v0, v1), 13835340097194688515);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Range, RangeSettingsKey, RangeSettings>(arg0, v0, v1)
    }

    fun create_range_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RangeSettings{id: 0x2::object::new(arg1)};
        let v1 = Range{dummy_field: false};
        let v2 = RangeSettingsKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Range, RangeSettingsKey, RangeSettings>(arg0, v1, v2, v0);
        let v3 = RangeSettingsCreatedEvent{
            settings_id : 0x2::object::id<RangeSettings>(&v0),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RangeSettingsCreatedEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun manager_create_range_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Range>(arg1, 0x2::tx_context::sender(arg2));
        create_range_settings(arg0, arg2);
    }

    public fun manager_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg8: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg9: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Range>(arg1, 0x2::tx_context::sender(arg9));
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun max_allowed_rtp() : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_fraction(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(99), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(100))
    }

    fun parameters_exist<T0>(arg0: &RangeSettings) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    entry fun play<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: vector<0x1::string::String>, arg8: vector<vector<u8>>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x2::clock::Clock, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        play_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    fun play_internal<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: vector<0x1::string::String>, arg8: vector<vector<u8>>, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x2::clock::Clock, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = Range{dummy_field: false};
        let v2 = borrow_parameters<T0>(borrow_range_settings(arg0));
        let v3 = v2.min_stake;
        let v4 = v2.max_stake;
        let v5 = v2.max_rtp;
        let v6 = v2.min_rtp;
        assert!(arg3 > 0 && arg3 <= v2.max_number_of_games, 13836748378316996621);
        assert!(arg3 <= 100, 13836748382611963917);
        assert!(arg4 <= 100000000, 13837874286814298133);
        assert!(arg5 <= 100000000, 13838155766086107159);
        assert!(arg4 < arg5, 13838437245357916185);
        let v7 = arg5 - arg4;
        let v8 = if (arg6) {
            100000000 - v7
        } else {
            v7
        };
        let v9 = v8;
        assert!(v9 >= v2.min_zone_size, 13838718733219659803);
        assert!(v9 <= v2.max_zone_size, 13839000212491468829);
        let v10 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_fraction(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(v9), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(100000000));
        let v11 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::add(v6, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(v10, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::sub(v5, v6)));
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(&v11), 13837592863377063955);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&v11, &v5), 13837592867672031251);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&v11, &v6), 13837592871966998547);
        let v12 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(100000000), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v9)), v11);
        let v13 = 0x2::coin::value<T0>(&arg2);
        let v14 = 0x2::coin::into_balance<T0>(arg2);
        let v15 = 0x2::coin::zero<T0>(arg12);
        if (v13 > arg1) {
            0x2::coin::join<T0>(&mut v15, 0x2::coin::take<T0>(&mut v14, v13 - arg1, arg12));
        } else if (v13 < arg1) {
            let v16 = Range{dummy_field: false};
            0x2::coin::put<T0>(&mut v14, 0x3bbb757a9d4638488d874a205ddf8c4ead2e102748f7d3c9d79c56a2f09357d::free_bet::operator_claim_player_free_bet<T0, Range>(arg0, v16, v0, arg1 - v13, arg12));
        };
        assert!(0x2::balance::value<T0>(&v14) == arg1, 13837030025092530191);
        let v17 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_and_get_stake_ticket<T0, Range>(arg0, v1, 0x2::coin::from_balance<T0>(v14, arg12), arg3, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::compute_total_payout_for_uniform_multiplier(arg1, arg3, v12), v0, arg12);
        0x13a877d974d59f54d8affa4d345bf794cf8e9e936d9d22100c801c95b415930f::loyalty::process_stake_ticket<T0, Range>(&mut v17, arg0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::utils::build_metadata<0x1::string::String, vector<u8>>(arg7, arg8), arg9, arg10, arg11, arg12);
        let v18 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_single_game_stake_amounts<T0, Range>(&v17);
        let v19 = 0x2::random::new_generator(arg11, arg12);
        let v20 = 0;
        while (v20 < arg3) {
            let v21 = *0x1::vector::borrow<u64>(&v18, v20);
            assert!(v21 >= v3, 13836185806320435209);
            assert!(v21 <= v4, 13836467285592244235);
            let v22 = 0x2::random::generate_u64_in_range(&mut v19, 0, 100000000 - 1);
            let v23 = arg6 && (v22 < arg4 || v22 >= arg5) || v22 >= arg4 && v22 < arg5;
            let v24 = v23;
            let v25 = if (v24) {
                0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v21), v12))
            } else {
                0
            };
            let v26 = v25;
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_outcome_amount<T0, Range>(&mut v17, v26);
            let v27 = if (v24) {
                v12
            } else {
                0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
            };
            let v28 = v27;
            let v29 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"roll_value"), 0x2::bcs::to_bytes<u64>(&v22));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"win"), 0x2::bcs::to_bytes<bool>(&v24));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"payout_amount"), 0x2::bcs::to_bytes<u64>(&v26));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"payout_multiplier"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v28));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"left_point"), 0x2::bcs::to_bytes<u64>(&arg4));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"right_point"), 0x2::bcs::to_bytes<u64>(&arg5));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"is_out_range"), 0x2::bcs::to_bytes<bool>(&arg6));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"zone_size"), 0x2::bcs::to_bytes<u64>(&v7));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"winning_zone_size"), 0x2::bcs::to_bytes<u64>(&v9));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"win_probability"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v10));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"win_multiplier"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v12));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v29, 0x1::string::utf8(b"actual_rtp"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v11));
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_game_details<T0, Range>(&mut v17, v29);
            v20 = v20 + 1;
        };
        0x2::coin::join<T0>(&mut v15, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_and_destroy_stake_ticket<T0, Range>(arg0, v1, v17, arg11, arg12));
        v15
    }

    fun set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg7: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg2, 13835903317731311623);
        assert!(arg3 > 0 && arg3 <= 100000000, 13835903322026278919);
        assert!(arg3 <= arg4, 13835903326321246215);
        assert!(arg4 <= 100000000, 13835903330616213511);
        assert!(arg5 > 0 && arg5 <= 100, 13835903334911180807);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(&arg6), 13835903343501115399);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(&arg7), 13835903347796082695);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg6, &arg7), 13835903352091049991);
        let v0 = max_allowed_rtp();
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg7, &v0), 13835903360680984583);
        let v1 = borrow_range_settings_mut(arg0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = parameters_exist<T0>(v1);
        if (v3) {
            let v4 = borrow_mut_parameters<T0>(v1);
            v4.min_stake = arg1;
            v4.max_stake = arg2;
            v4.min_zone_size = arg3;
            v4.max_zone_size = arg4;
            v4.max_number_of_games = arg5;
            v4.min_rtp = arg6;
            v4.max_rtp = arg7;
        } else {
            let v5 = Parameters<T0>{
                id                  : 0x2::object::new(arg8),
                min_stake           : arg1,
                max_stake           : arg2,
                min_zone_size       : arg3,
                max_zone_size       : arg4,
                max_number_of_games : arg5,
                min_rtp             : arg6,
                max_rtp             : arg7,
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Parameters<T0>>(&mut v1.id, v2, v5);
        };
        let v6 = RangeParametersSetEvent<T0>{
            coin_type           : v2,
            min_stake           : arg1,
            max_stake           : arg2,
            min_zone_size       : arg3,
            max_zone_size       : arg4,
            max_number_of_games : arg5,
            min_rtp             : arg6,
            max_rtp             : arg7,
            is_new              : !v3,
        };
        0x2::event::emit<RangeParametersSetEvent<T0>>(v6);
    }

    // decompiled from Move bytecode v6
}

