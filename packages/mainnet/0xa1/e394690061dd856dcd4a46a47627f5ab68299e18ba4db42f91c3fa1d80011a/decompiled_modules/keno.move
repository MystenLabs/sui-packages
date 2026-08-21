module 0xa1e394690061dd856dcd4a46a47627f5ab68299e18ba4db42f91c3fa1d80011a::keno {
    struct KenoParametersSetEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        min_stake: u64,
        max_stake: u64,
        is_new: bool,
    }

    struct KenoSettingsCreatedEvent has copy, drop {
        settings_id: 0x2::object::ID,
        creator: address,
    }

    struct KenoConfigUpsertedEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        config_number: u8,
        board_size: u8,
        draw_count: u8,
        min_picks: u8,
        max_picks: u8,
        paytable: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        min_stake: u64,
        max_stake: u64,
        max_payout: u64,
        max_number_of_games: u64,
        min_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        is_playable: bool,
        is_new: bool,
    }

    struct Keno has copy, drop, store {
        dummy_field: bool,
    }

    struct KenoSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct KenoSettings has store, key {
        id: 0x2::object::UID,
    }

    struct KenoConfig has copy, drop, store {
        board_size: u8,
        draw_count: u8,
        min_picks: u8,
        max_picks: u8,
        paytable: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        min_stake: u64,
        max_stake: u64,
        max_payout: u64,
        max_number_of_games: u64,
        min_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        max_rtp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        is_playable: bool,
    }

    struct Parameters<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_stake: u64,
        max_stake: u64,
        configs: 0x2::vec_map::VecMap<u8, KenoConfig>,
    }

    public fun admin_create_keno_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_keno_settings(arg0, arg2);
    }

    public fun admin_edit_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg13: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg14: bool) {
        edit_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun admin_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        set_parameters<T0>(arg0, arg2, arg3, arg4);
    }

    public fun admin_upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg13: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg14: bool) {
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun admin_upsert_config_hundredths<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: vector<u64>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool) {
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, paytable_from_hundredths(arg7), arg8, arg9, arg10, arg11, float_fraction(arg12, 10000), float_fraction(arg13, 10000), arg14);
    }

    public fun borrow_keno_settings(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &KenoSettings {
        let v0 = KenoSettingsKey{dummy_field: false};
        let v1 = Keno{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Keno, KenoSettingsKey, KenoSettings>(arg0, v1, v0), 13835340281878478854);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Keno, KenoSettingsKey, KenoSettings>(arg0, v0)
    }

    fun borrow_keno_settings_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut KenoSettings {
        let v0 = Keno{dummy_field: false};
        let v1 = KenoSettingsKey{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Keno, KenoSettingsKey, KenoSettings>(arg0, v0, v1), 13835340342008020998);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Keno, KenoSettingsKey, KenoSettings>(arg0, v0, v1)
    }

    fun borrow_mut_parameters<T0>(arg0: &mut KenoSettings) : &mut Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621894294274056);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Parameters<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_parameters<T0>(arg0: &KenoSettings) : &Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621868524470280);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    fun choose(arg0: u8, arg1: u8) : u64 {
        if (arg1 > arg0) {
            return 0
        };
        let v0 = arg1;
        if ((arg1 as u64) > ((arg0 - arg1) as u64)) {
            v0 = arg0 - arg1;
        };
        let v1 = 1;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = v1 * ((arg0 - v2) as u128);
            v1 = v3 / ((v2 + 1) as u128);
            v2 = v2 + 1;
        };
        (v1 as u64)
    }

    fun compute_expected_value(arg0: u8, arg1: u8, arg2: u8, arg3: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg4: u8) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = choose(arg0, arg1);
        assert!(v0 > 0, 13835903970566537226);
        let v1 = if (arg4 < arg1) {
            arg4
        } else {
            arg1
        };
        let v2 = if (arg1 > arg0 - arg4) {
            arg1 - arg0 - arg4
        } else {
            0
        };
        let v3 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero();
        let v4 = v2;
        while (v4 <= v1) {
            let v5 = choose(arg4, v4) * choose(arg0 - arg4, arg1 - v4);
            if (v5 > 0) {
                v3 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::add(v3, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(paytable_multiplier(arg3, arg2, arg4, v4), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v5), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v0))));
            };
            v4 = v4 + 1;
        };
        v3
    }

    fun count_hits(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg1)) {
            let v2 = *0x1::vector::borrow<u8>(arg1, v1);
            if (0x1::vector::contains<u8>(arg0, &v2)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun create_keno_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = KenoSettings{id: 0x2::object::new(arg1)};
        let v1 = Keno{dummy_field: false};
        let v2 = KenoSettingsKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Keno, KenoSettingsKey, KenoSettings>(arg0, v1, v2, v0);
        let v3 = KenoSettingsCreatedEvent{
            settings_id : 0x2::object::id<KenoSettings>(&v0),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<KenoSettingsCreatedEvent>(v3);
    }

    fun draw_unique_numbers(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: u8) : vector<u8> {
        let v0 = b"";
        let v1 = 1;
        while (v1 <= arg1) {
            0x1::vector::push_back<u8>(&mut v0, v1);
            v1 = v1 + 1;
        };
        let v2 = b"";
        let v3 = 0;
        while (v3 < arg2) {
            0x1::vector::push_back<u8>(&mut v2, 0x1::vector::swap_remove<u8>(&mut v0, 0x2::random::generate_u64_in_range(arg0, 0, 0x1::vector::length<u8>(&v0) - 1)));
            v3 = v3 + 1;
        };
        while (0x1::vector::length<u8>(&v0) > 0) {
            0x1::vector::pop_back<u8>(&mut v0);
        };
        0x1::vector::destroy_empty<u8>(v0);
        v2
    }

    fun edit_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg12: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg13: bool) {
        validate_config(arg2, arg3, arg4, arg5, &arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v0 = borrow_keno_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        assert!(0x2::vec_map::contains<u8, KenoConfig>(&v1.configs, &arg1), 13837031373712457746);
        let v2 = 0x2::vec_map::get_mut<u8, KenoConfig>(&mut v1.configs, &arg1);
        v2.board_size = arg2;
        v2.draw_count = arg3;
        v2.min_picks = arg4;
        v2.max_picks = arg5;
        v2.paytable = arg6;
        v2.min_stake = arg7;
        v2.max_stake = arg8;
        v2.max_payout = arg9;
        v2.max_number_of_games = arg10;
        v2.min_rtp = arg11;
        v2.max_rtp = arg12;
        v2.is_playable = arg13;
        let v3 = KenoConfigUpsertedEvent<T0>{
            coin_type           : 0x1::type_name::with_defining_ids<T0>(),
            config_number       : arg1,
            board_size          : arg2,
            draw_count          : arg3,
            min_picks           : arg4,
            max_picks           : arg5,
            paytable            : arg6,
            min_stake           : arg7,
            max_stake           : arg8,
            max_payout          : arg9,
            max_number_of_games : arg10,
            min_rtp             : arg11,
            max_rtp             : arg12,
            is_playable         : arg13,
            is_new              : false,
        };
        0x2::event::emit<KenoConfigUpsertedEvent<T0>>(v3);
    }

    fun expected_paytable_length(arg0: u8, arg1: u8) : u64 {
        let v0 = 0;
        while (arg0 <= arg1) {
            let v1 = v0 + (arg0 as u64);
            v0 = v1 + 1;
            arg0 = arg0 + 1;
        };
        v0
    }

    fun float_fraction(arg0: u64, arg1: u64) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        assert!(arg1 > 0, 13835902974134124554);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_fraction(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(arg0), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun manager_create_keno_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Keno>(arg1, 0x2::tx_context::sender(arg2));
        create_keno_settings(arg0, arg2);
    }

    public fun manager_edit_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg13: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Keno>(arg1, 0x2::tx_context::sender(arg15));
        edit_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun manager_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Keno>(arg1, 0x2::tx_context::sender(arg4));
        set_parameters<T0>(arg0, arg2, arg3, arg4);
    }

    public fun manager_upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg13: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Keno>(arg1, 0x2::tx_context::sender(arg15));
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    fun max_allowed_rtp() : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        float_fraction(99, 100)
    }

    fun max_multiplier_for_pick_count(arg0: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg1: u8, arg2: u8) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = paytable_offset(arg1, arg2);
        let v1 = *0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg0, v0);
        let v2 = 1;
        while (v2 <= (arg2 as u64)) {
            let v3 = 0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg0, v0 + v2);
            if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(v3, &v1)) {
                v1 = *v3;
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun min_allowed_rtp() : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        float_fraction(80, 100)
    }

    fun parameters_exist<T0>(arg0: &KenoSettings) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    fun paytable_from_hundredths(arg0: vector<u64>) : vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float> {
        let v0 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&mut v0, float_fraction(*0x1::vector::borrow<u64>(&arg0, v1), 100));
            v1 = v1 + 1;
        };
        v0
    }

    fun paytable_multiplier(arg0: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg1: u8, arg2: u8, arg3: u8) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        *0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg0, paytable_offset(arg1, arg2) + (arg3 as u64))
    }

    fun paytable_offset(arg0: u8, arg1: u8) : u64 {
        let v0 = 0;
        while (arg0 < arg1) {
            let v1 = v0 + (arg0 as u64);
            v0 = v1 + 1;
            arg0 = arg0 + 1;
        };
        v0
    }

    entry fun play<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: vector<vector<u8>>, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        play_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::read_price_quote(arg8), arg9, arg10, arg11)
    }

    fun play_internal<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: vector<vector<u8>>, arg8: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::PriceQuote, arg9: &0x2::clock::Clock, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = Keno{dummy_field: false};
        let v2 = borrow_parameters<T0>(borrow_keno_settings(arg0));
        assert!(0x2::vec_map::contains<u8, KenoConfig>(&v2.configs, &arg4), 13837032765281861650);
        let v3 = v2.min_stake;
        let v4 = v2.max_stake;
        let KenoConfig {
            board_size          : v5,
            draw_count          : v6,
            min_picks           : v7,
            max_picks           : v8,
            paytable            : v9,
            min_stake           : v10,
            max_stake           : v11,
            max_payout          : v12,
            max_number_of_games : v13,
            min_rtp             : _,
            max_rtp             : _,
            is_playable         : v16,
        } = *0x2::vec_map::get<u8, KenoConfig>(&v2.configs, &arg4);
        let v17 = v9;
        let v18 = v6;
        let v19 = v5;
        assert!(v16, 13837314343337918484);
        assert!(v3 <= v4, 13835906972748677130);
        assert!(arg3 > 0 && arg3 <= v13, 13836751401974169616);
        assert!(arg3 <= 100, 13836751406269136912);
        validate_picks(v19, v7, v8, &arg5);
        let v20 = (0x1::vector::length<u8>(&arg5) as u8);
        let v21 = compute_expected_value(v19, v18, v7, &v17, v20);
        let v22 = max_multiplier_for_pick_count(&v17, v7, v20);
        let v23 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::compute_single_game_stake_amounts(arg1, arg3);
        let v24 = 0;
        while (v24 < 0x1::vector::length<u64>(&v23)) {
            let v25 = *0x1::vector::borrow<u64>(&v23, v24);
            assert!(v25 >= v3, 13836188525034930188);
            assert!(v25 <= v4, 13836470004306739214);
            assert!(v25 >= v10, 13836188533624864780);
            assert!(v25 <= v11, 13836470012896673806);
            assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v25), v22)) <= v12, 13839003309163085856);
            v24 = v24 + 1;
        };
        let v26 = 0x2::coin::value<T0>(&arg2);
        let v27 = 0x2::coin::into_balance<T0>(arg2);
        let v28 = 0x2::coin::zero<T0>(arg11);
        if (v26 > arg1) {
            0x2::coin::join<T0>(&mut v28, 0x2::coin::take<T0>(&mut v27, v26 - arg1, arg11));
        } else if (v26 < arg1) {
            let v29 = Keno{dummy_field: false};
            0x2::coin::put<T0>(&mut v27, 0x3bbb757a9d4638488d874a205ddf8c4ead2e102748f7d3c9d79c56a2f09357d::free_bet::operator_claim_player_free_bet<T0, Keno>(arg0, v29, v0, arg1 - v26, arg11));
        };
        assert!(0x2::balance::value<T0>(&v27) == arg1, 13837877508039966744);
        let v30 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_and_get_stake_ticket<T0, Keno>(arg0, v1, 0x2::coin::from_balance<T0>(v27, arg11), arg3, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::compute_total_payout_for_uniform_multiplier(arg1, arg3, v22), v0, arg11);
        0x13a877d974d59f54d8affa4d345bf794cf8e9e936d9d22100c801c95b415930f::loyalty::process_stake_ticket_with_quote<T0, Keno>(&mut v30, arg0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::utils::build_metadata<0x1::string::String, vector<u8>>(arg6, arg7), arg8, arg9, arg10, arg11);
        let v31 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_single_game_stake_amounts<T0, Keno>(&v30);
        let v32 = 0x2::random::new_generator(arg10, arg11);
        let v33 = 0;
        while (v33 < arg3) {
            let v34 = *0x1::vector::borrow<u64>(&v31, v33);
            assert!(v34 >= v3, 13836188851452444684);
            assert!(v34 <= v4, 13836470330724253710);
            assert!(v34 >= v10, 13836188860042379276);
            assert!(v34 <= v11, 13836470339314188302);
            let v35 = &mut v32;
            let v36 = draw_unique_numbers(v35, v19, v18);
            let v37 = count_hits(&arg5, &v36);
            let v38 = paytable_multiplier(&v17, v7, v20, v37);
            let v39 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v34), v38));
            assert!(v39 <= v12, 13839003639875567648);
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_outcome_amount<T0, Keno>(&mut v30, v39);
            let v40 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            let v41 = (arg4 as u8);
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"keno_config"), 0x2::bcs::to_bytes<u8>(&v41));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"board_size"), 0x2::bcs::to_bytes<u8>(&v19));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"draw_count"), 0x2::bcs::to_bytes<u8>(&v18));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"picks"), 0x2::bcs::to_bytes<vector<u8>>(&arg5));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"drawn_numbers"), 0x2::bcs::to_bytes<vector<u8>>(&v36));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"hit_count"), 0x2::bcs::to_bytes<u8>(&v37));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"multiplier"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v38));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"payout_amount"), 0x2::bcs::to_bytes<u64>(&v39));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v40, 0x1::string::utf8(b"actual_rtp"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v21));
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_game_details<T0, Keno>(&mut v30, v40);
            v33 = v33 + 1;
        };
        0x2::coin::join<T0>(&mut v28, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_and_destroy_stake_ticket<T0, Keno>(arg0, v1, v30, arg10, arg11));
        v28
    }

    entry fun play_v2<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: vector<vector<u8>>, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        play_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::read_price_quote_v2(arg8), arg9, arg10, arg11)
    }

    fun set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg2, 13835903536774840330);
        let v0 = borrow_keno_settings_mut(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = parameters_exist<T0>(v0);
        if (v2) {
            let v3 = borrow_mut_parameters<T0>(v0);
            v3.min_stake = arg1;
            v3.max_stake = arg2;
        } else {
            let v4 = Parameters<T0>{
                id        : 0x2::object::new(arg3),
                min_stake : arg1,
                max_stake : arg2,
                configs   : 0x2::vec_map::empty<u8, KenoConfig>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Parameters<T0>>(&mut v0.id, v1, v4);
        };
        let v5 = KenoParametersSetEvent<T0>{
            coin_type : v1,
            min_stake : arg1,
            max_stake : arg2,
            is_new    : !v2,
        };
        0x2::event::emit<KenoParametersSetEvent<T0>>(v5);
    }

    fun upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg12: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg13: bool) {
        validate_config(arg2, arg3, arg4, arg5, &arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v0 = borrow_keno_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        let v2 = 0x2::vec_map::contains<u8, KenoConfig>(&v1.configs, &arg1);
        if (v2) {
            let v3 = 0x2::vec_map::get_mut<u8, KenoConfig>(&mut v1.configs, &arg1);
            v3.board_size = arg2;
            v3.draw_count = arg3;
            v3.min_picks = arg4;
            v3.max_picks = arg5;
            v3.paytable = arg6;
            v3.min_stake = arg7;
            v3.max_stake = arg8;
            v3.max_payout = arg9;
            v3.max_number_of_games = arg10;
            v3.min_rtp = arg11;
            v3.max_rtp = arg12;
            v3.is_playable = arg13;
        } else {
            let v4 = KenoConfig{
                board_size          : arg2,
                draw_count          : arg3,
                min_picks           : arg4,
                max_picks           : arg5,
                paytable            : arg6,
                min_stake           : arg7,
                max_stake           : arg8,
                max_payout          : arg9,
                max_number_of_games : arg10,
                min_rtp             : arg11,
                max_rtp             : arg12,
                is_playable         : arg13,
            };
            0x2::vec_map::insert<u8, KenoConfig>(&mut v1.configs, arg1, v4);
        };
        let v5 = KenoConfigUpsertedEvent<T0>{
            coin_type           : 0x1::type_name::with_defining_ids<T0>(),
            config_number       : arg1,
            board_size          : arg2,
            draw_count          : arg3,
            min_picks           : arg4,
            max_picks           : arg5,
            paytable            : arg6,
            min_stake           : arg7,
            max_stake           : arg8,
            max_payout          : arg9,
            max_number_of_games : arg10,
            min_rtp             : arg11,
            max_rtp             : arg12,
            is_playable         : arg13,
            is_new              : !v2,
        };
        0x2::event::emit<KenoConfigUpsertedEvent<T0>>(v5);
    }

    fun validate_config(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg10: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) {
        assert!(arg0 > 0 && arg0 <= 40, 13835904279804182538);
        assert!(arg1 > 0 && arg1 <= 10, 13835904284099149834);
        assert!(arg1 <= arg0, 13835904288394117130);
        assert!(arg2 > 0 && arg2 <= arg3, 13835904292689084426);
        assert!(arg3 <= 10, 13835904296984051722);
        assert!(arg3 <= arg0, 13835904301279019018);
        assert!(arg5 <= arg6, 13835904305573986314);
        assert!(arg6 > 0, 13835904309868953610);
        assert!(arg7 > 0, 13835904314163920906);
        assert!(arg6 <= 227737581156908044, 13835904331343790090);
        assert!(arg7 <= arg6 * 81, 13839282035360858146);
        assert!(arg8 > 0 && arg8 <= 100, 13835904348523659274);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(&arg9), 13835904361408561162);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(&arg10), 13835904365703528458);
        let v0 = min_allowed_rtp();
        let v1 = max_allowed_rtp();
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&arg9, &v0), 13835904378588430346);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg10, &v1), 13835904382883397642);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg9, &arg10), 13835904387178364938);
        assert!(0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg4) == expected_paytable_length(arg2, arg3), 13837593245629349910);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg4)) {
            assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg4, v2)), 13835904412948168714);
            v2 = v2 + 1;
        };
        while (arg2 <= arg3) {
            let v3 = compute_expected_value(arg0, arg1, arg2, arg4, arg2);
            assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&v3, &arg10), 13838437717804515356);
            assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&v3, &arg9), 13838719197076324382);
            arg2 = arg2 + 1;
        };
    }

    fun validate_picks(arg0: u8, arg1: u8, arg2: u8, arg3: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg3);
        assert!(v0 >= (arg1 as u64) && v0 <= (arg2 as u64), 13838155963654799386);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg3, v1);
            assert!(v2 > 0 && v2 <= arg0, 13838155980834668570);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(v2 != *0x1::vector::borrow<u8>(arg3, v3), 13838155993719570458);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

