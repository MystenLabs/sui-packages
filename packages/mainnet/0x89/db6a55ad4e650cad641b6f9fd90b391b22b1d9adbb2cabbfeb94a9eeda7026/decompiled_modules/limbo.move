module 0x89db6a55ad4e650cad641b6f9fd90b391b22b1d9adbb2cabbfeb94a9eeda7026::limbo {
    struct Limbo has copy, drop, store {
        dummy_field: bool,
    }

    struct LimboSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LimboSettings has store, key {
        id: 0x2::object::UID,
    }

    struct Parameters<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_stake: u64,
        max_stake: u64,
        max_payout: u64,
        min_target_multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_target_multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_number_of_games: u64,
        min_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    struct LimboParametersSetEvent<phantom T0> has copy, drop {
        min_stake: u64,
        max_stake: u64,
        max_payout: u64,
        min_target_multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_target_multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_number_of_games: u64,
        min_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        is_new: bool,
    }

    struct LimboSettingsCreatedEvent has copy, drop {
        settings_id: 0x2::object::ID,
        creator: address,
    }

    public fun admin_create_limbo_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_limbo_settings(arg0, arg2);
    }

    public fun admin_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg6: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg7: u64, arg8: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg9: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg10: &mut 0x2::tx_context::TxContext) {
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun borrow_limbo_settings(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &LimboSettings {
        let v0 = LimboSettingsKey{dummy_field: false};
        let v1 = Limbo{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Limbo, LimboSettingsKey, LimboSettings>(arg0, v1, v0), 13835340015590309891);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Limbo, LimboSettingsKey, LimboSettings>(arg0, v0)
    }

    fun borrow_limbo_settings_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut LimboSettings {
        let v0 = Limbo{dummy_field: false};
        let v1 = LimboSettingsKey{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Limbo, LimboSettingsKey, LimboSettings>(arg0, v0, v1), 13835340075719852035);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Limbo, LimboSettingsKey, LimboSettings>(arg0, v0, v1)
    }

    fun borrow_mut_parameters<T0>(arg0: &mut LimboSettings) : &mut Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621628006105093);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Parameters<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_parameters<T0>(arg0: &LimboSettings) : &Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621602236301317);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    fun create_limbo_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LimboSettings{id: 0x2::object::new(arg1)};
        let v1 = Limbo{dummy_field: false};
        let v2 = LimboSettingsKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Limbo, LimboSettingsKey, LimboSettings>(arg0, v1, v2, v0);
        let v3 = LimboSettingsCreatedEvent{
            settings_id : 0x2::object::id<LimboSettings>(&v0),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<LimboSettingsCreatedEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun manager_create_limbo_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Limbo>(arg1, 0x2::tx_context::sender(arg2));
        create_limbo_settings(arg0, arg2);
    }

    public fun manager_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg6: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg7: u64, arg8: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg9: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg10: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Limbo>(arg1, 0x2::tx_context::sender(arg10));
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun max_allowed_rtp() : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_fraction(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(99), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(100))
    }

    fun parameters_exist<T0>(arg0: &LimboSettings) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    entry fun play<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>, arg7: vector<vector<u8>>, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        play_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    fun play_internal<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>, arg7: vector<vector<u8>>, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = Limbo{dummy_field: false};
        assert!(arg5 > 0, 13835903901846863879);
        let v2 = borrow_parameters<T0>(borrow_limbo_settings(arg0));
        let v3 = v2.min_stake;
        let v4 = v2.max_stake;
        let v5 = v2.max_payout;
        let v6 = v2.max_rtp;
        let v7 = v2.min_rtp;
        let v8 = v2.max_target_multiplier;
        let v9 = v2.min_target_multiplier;
        assert!(arg3 > 0 && arg3 <= v2.max_number_of_games, 13836185488492855305);
        assert!(arg3 <= 100, 13836185492787822601);
        let v10 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_fraction(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(arg4), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(arg5));
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&v10, &v9), 13837311422759960593);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&v10, &v8), 13837592902031769619);
        let v11 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1);
        let v12 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::sub(v8, v11);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive(&v12), 13835904069350588423);
        let v13 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::sub(v6, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::sub(v10, v11), v12), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::sub(v6, v7)));
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(&v13), 13838155912114995223);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&v13, &v6), 13838155916409962519);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&v13, &v7), 13838155920704929815);
        let v14 = 0x2::coin::value<T0>(&arg2);
        let v15 = 0x2::coin::into_balance<T0>(arg2);
        let v16 = 0x2::coin::zero<T0>(arg11);
        if (v14 > arg1) {
            0x2::coin::join<T0>(&mut v16, 0x2::coin::take<T0>(&mut v15, v14 - arg1, arg11));
        } else if (v14 < arg1) {
            let v17 = Limbo{dummy_field: false};
            0x2::coin::put<T0>(&mut v15, 0x3bbb757a9d4638488d874a205ddf8c4ead2e102748f7d3c9d79c56a2f09357d::free_bet::operator_claim_player_free_bet<T0, Limbo>(arg0, v17, v0, arg1 - v14, arg11));
        };
        assert!(0x2::balance::value<T0>(&v15) == arg1, 13837030110991876111);
        let v18 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_and_get_stake_ticket<T0, Limbo>(arg0, v1, 0x2::coin::from_balance<T0>(v15, arg11), arg3, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::compute_total_payout_for_uniform_multiplier(arg1, arg3, v10), v0, arg11);
        0x13a877d974d59f54d8affa4d345bf794cf8e9e936d9d22100c801c95b415930f::loyalty::process_stake_ticket<T0, Limbo>(&mut v18, arg0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::utils::build_metadata<0x1::string::String, vector<u8>>(arg6, arg7), arg8, arg9, arg10, arg11);
        let v19 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_single_game_stake_amounts<T0, Limbo>(&v18);
        let v20 = 0x2::random::new_generator(arg10, arg11);
        let v21 = 0;
        while (v21 < arg3) {
            let v22 = *0x1::vector::borrow<u64>(&v19, v21);
            assert!(v22 >= v3, 13836467341426819083);
            assert!(v22 <= v4, 13836748820698628109);
            let v23 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v22), v10));
            assert!(v23 <= v5, 13837874737785864213);
            let v24 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1000000), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(0x2::random::generate_u64_in_range(&mut v20, 0, 1000000) + 1)), v13);
            let v25 = !0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&v24, &v10);
            let v26 = if (v25) {
                v23
            } else {
                0
            };
            let v27 = v26;
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_outcome_amount<T0, Limbo>(&mut v18, v27);
            let v28 = if (v25) {
                v10
            } else {
                0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
            };
            let v29 = v28;
            let v30 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v30, 0x1::string::utf8(b"payout_amount"), 0x2::bcs::to_bytes<u64>(&v27));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v30, 0x1::string::utf8(b"win"), 0x2::bcs::to_bytes<bool>(&v25));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v30, 0x1::string::utf8(b"roll_multiplier"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v24));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v30, 0x1::string::utf8(b"payout_multiplier"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v29));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v30, 0x1::string::utf8(b"target_multiplier"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v10));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v30, 0x1::string::utf8(b"actual_rtp"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v13));
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_game_details<T0, Limbo>(&mut v18, v30);
            v21 = v21 + 1;
        };
        0x2::coin::join<T0>(&mut v16, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_and_destroy_stake_ticket<T0, Limbo>(arg0, v1, v18, arg10, arg11));
        v16
    }

    fun set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: u64, arg3: u64, arg4: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg5: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg6: u64, arg7: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg8: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg2, 13835903296256475143);
        assert!(arg3 > 0, 13835903300551442439);
        assert!(arg6 > 0 && arg6 <= 100, 13835903304846409735);
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&arg4, &v0), 13835903322026278919);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg5, &v0), 13835903326321246215);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg4, &arg5), 13835903330616213511);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(&arg7), 13835903339206148103);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(&arg8), 13835903343501115399);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg7, &arg8), 13835903347796082695);
        let v1 = max_allowed_rtp();
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg8, &v1), 13835903356386017287);
        let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1000000), arg7);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg5, &v2), 13838436648357462041);
        let v3 = borrow_limbo_settings_mut(arg0);
        let v4 = parameters_exist<T0>(v3);
        if (v4) {
            let v5 = borrow_mut_parameters<T0>(v3);
            v5.min_stake = arg1;
            v5.max_stake = arg2;
            v5.max_payout = arg3;
            v5.min_target_multiplier = arg4;
            v5.max_target_multiplier = arg5;
            v5.max_number_of_games = arg6;
            v5.min_rtp = arg7;
            v5.max_rtp = arg8;
        } else {
            let v6 = Parameters<T0>{
                id                    : 0x2::object::new(arg9),
                min_stake             : arg1,
                max_stake             : arg2,
                max_payout            : arg3,
                min_target_multiplier : arg4,
                max_target_multiplier : arg5,
                max_number_of_games   : arg6,
                min_rtp               : arg7,
                max_rtp               : arg8,
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Parameters<T0>>(&mut v3.id, 0x1::type_name::with_defining_ids<T0>(), v6);
        };
        let v7 = LimboParametersSetEvent<T0>{
            min_stake             : arg1,
            max_stake             : arg2,
            max_payout            : arg3,
            min_target_multiplier : arg4,
            max_target_multiplier : arg5,
            max_number_of_games   : arg6,
            min_rtp               : arg7,
            max_rtp               : arg8,
            is_new                : !v4,
        };
        0x2::event::emit<LimboParametersSetEvent<T0>>(v7);
    }

    // decompiled from Move bytecode v6
}

