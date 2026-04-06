module 0xd419ac01faf0f2075e37ba125b3ed96c411b1b23373dc3ed353e40dee0537d13::coinflip {
    struct CoinflipParametersSetEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        house_edge: u64,
        min_stake: u64,
        max_stake: u64,
        is_new: bool,
    }

    struct CoinflipSettingsCreatedEvent has copy, drop {
        settings_id: 0x2::object::ID,
        creator: address,
    }

    struct CoinFlip has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinFlipSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinFlipSettings has store, key {
        id: 0x2::object::UID,
    }

    struct Parameters<phantom T0> has store, key {
        id: 0x2::object::UID,
        house_edge: u64,
        min_stake: u64,
        max_stake: u64,
    }

    public fun admin_create_coinflip_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_coinflip_settings(arg0, arg2);
    }

    public fun admin_set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun borrow_coinflip_settings(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &CoinFlipSettings {
        let v0 = CoinFlipSettingsKey{dummy_field: false};
        let v1 = CoinFlip{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<CoinFlip, CoinFlipSettingsKey, CoinFlipSettings>(arg0, v1, v0), 13836465949857611790);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<CoinFlip, CoinFlipSettingsKey, CoinFlipSettings>(arg0, v0)
    }

    fun borrow_coinflip_settings_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut CoinFlipSettings {
        let v0 = CoinFlip{dummy_field: false};
        let v1 = CoinFlipSettingsKey{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<CoinFlip, CoinFlipSettingsKey, CoinFlipSettings>(arg0, v0, v1), 13836466009987153934);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<CoinFlip, CoinFlipSettingsKey, CoinFlipSettings>(arg0, v0, v1)
    }

    fun borrow_mut_parameters<T0>(arg0: &mut CoinFlipSettings) : &mut Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621666661007368);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Parameters<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_parameters<T0>(arg0: &CoinFlipSettings) : &Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621640891203592);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    fun create_coinflip_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinFlipSettings{id: 0x2::object::new(arg1)};
        let v1 = CoinFlip{dummy_field: false};
        let v2 = CoinFlipSettingsKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<CoinFlip, CoinFlipSettingsKey, CoinFlipSettings>(arg0, v1, v2, v0);
        let v3 = CoinflipSettingsCreatedEvent{
            settings_id : 0x2::object::id<CoinFlipSettings>(&v0),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CoinflipSettingsCreatedEvent>(v3);
    }

    fun encode_coin_side(arg0: bool) : vector<u8> {
        let v0 = if (arg0) {
            0x1::string::utf8(b"tails")
        } else {
            0x1::string::utf8(b"heads")
        };
        let v1 = v0;
        0x2::bcs::to_bytes<0x1::string::String>(&v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun manager_create_coinflip_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<CoinFlip>(arg1, 0x2::tx_context::sender(arg2));
        create_coinflip_settings(arg0, arg2);
    }

    public fun manager_set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<CoinFlip>(arg1, 0x2::tx_context::sender(arg5));
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    fun parameters_exist<T0>(arg0: &CoinFlipSettings) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    entry fun play<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        play_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun play_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = CoinFlip{dummy_field: false};
        let v2 = borrow_parameters<T0>(borrow_coinflip_settings(arg0));
        let v3 = v2.house_edge;
        let v4 = v2.min_stake;
        let v5 = v2.max_stake;
        assert!(v3 >= 1000000, 13837311139292315668);
        assert!(v3 <= 10000000, 13835340818749390854);
        assert!(v4 <= v5, 13837029672905408530);
        assert!(arg3 > 0 && arg3 <= 100, 13837029677200375826);
        let v6 = 0x2::coin::value<T0>(&arg2);
        let v7 = 0x2::coin::into_balance<T0>(arg2);
        let v8 = 0x2::coin::zero<T0>(arg10);
        if (v6 > arg1) {
            0x2::coin::join<T0>(&mut v8, 0x2::coin::take<T0>(&mut v7, v6 - arg1, arg10));
        } else if (v6 < arg1) {
            let v9 = CoinFlip{dummy_field: false};
            0x2::coin::put<T0>(&mut v7, 0x45f6855a4bed5ecbc7cd0032c46c8126a8c0c81ad5376d05ff27e02ae1deef21::free_bet::operator_claim_player_free_bet<T0, CoinFlip>(arg0, v9, v0, arg1 - v6, arg10));
        };
        assert!(0x2::balance::value<T0>(&v7) == arg1, 13836748275237978128);
        let v10 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_put_and_get_stake_ticket<T0, CoinFlip>(arg0, v1, 0x2::coin::from_balance<T0>(v7, arg10), arg3, v0, arg10);
        0xd2ccfa506d533b8640918f958e1f9471338e47febab14bfb7ab8a5936620a74f::loyalty::process_stake_ticket<T0, CoinFlip>(&mut v10, arg0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::utils::build_metadata<0x1::string::String, vector<u8>>(arg5, arg6), arg7, arg8, arg9, arg10);
        let v11 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_single_game_stake_amounts<T0, CoinFlip>(&v10);
        let v12 = 0x2::random::new_generator(arg9, arg10);
        let v13 = 0;
        while (v13 < arg3) {
            let v14 = *0x1::vector::borrow<u64>(&v11, v13);
            assert!(v14 >= v4, 13835904013516210186);
            assert!(v14 <= v5, 13836185492788019212);
            assert!(v14 <= 9223372036854775807, 13837029922013511698);
            if (0x2::random::generate_u64_in_range(&mut v12, 0, 100000000) < win_threshold_from_house_edge(v3)) {
                0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_outcome_amount<T0, CoinFlip>(&mut v10, v14 * 2);
                let v15 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
                0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v15, 0x1::string::utf8(b"player_bet"), encode_coin_side(arg4));
                0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v15, 0x1::string::utf8(b"coin_outcome"), encode_coin_side(arg4));
                0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_game_details<T0, CoinFlip>(&mut v10, v15);
            } else {
                0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_outcome_amount<T0, CoinFlip>(&mut v10, 0);
                let v16 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
                0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v16, 0x1::string::utf8(b"player_bet"), encode_coin_side(arg4));
                0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v16, 0x1::string::utf8(b"coin_outcome"), encode_coin_side(!arg4));
                0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_game_details<T0, CoinFlip>(&mut v10, v16);
            };
            v13 = v13 + 1;
        };
        0x2::coin::join<T0>(&mut v8, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_and_destroy_stake_ticket<T0, CoinFlip>(arg0, v1, v10, arg9, arg10));
        v8
    }

    fun set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1000000, 13837310752745259028);
        assert!(arg1 <= 10000000, 13835340432202334214);
        assert!(arg2 <= arg3, 13837029286358351890);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = borrow_coinflip_settings_mut(arg0);
        let v2 = parameters_exist<T0>(v1);
        if (v2) {
            let v3 = borrow_mut_parameters<T0>(v1);
            v3.house_edge = arg1;
            v3.min_stake = arg2;
            v3.max_stake = arg3;
        } else {
            let v4 = Parameters<T0>{
                id         : 0x2::object::new(arg4),
                house_edge : arg1,
                min_stake  : arg2,
                max_stake  : arg3,
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Parameters<T0>>(&mut v1.id, v0, v4);
        };
        let v5 = CoinflipParametersSetEvent<T0>{
            coin_type  : v0,
            house_edge : arg1,
            min_stake  : arg2,
            max_stake  : arg3,
            is_new     : !v2,
        };
        0x2::event::emit<CoinflipParametersSetEvent<T0>>(v5);
    }

    fun win_threshold_from_house_edge(arg0: u64) : u64 {
        (100000000 - arg0) / 2
    }

    // decompiled from Move bytecode v6
}

