module 0x74a73daff11c11ed05299c93ed770c62ec4dc6756fa99e271e251c2399f49fef::plinko {
    struct PlinkoParametersSetEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        min_stake: u64,
        max_stake: u64,
        max_number_of_balls: u64,
        is_new: bool,
    }

    struct PlinkoSettingsCreatedEvent has copy, drop {
        settings_id: 0x2::object::ID,
        creator: address,
    }

    struct PlinkoConfigUpsertedEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        config_number: u8,
        num_rows: u8,
        multipliers: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        min_stake: u64,
        max_stake: u64,
        is_playable: bool,
        is_new: bool,
    }

    struct Plinko has copy, drop, store {
        dummy_field: bool,
    }

    struct PlinkoSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PlinkoSettings has store, key {
        id: 0x2::object::UID,
    }

    struct PlinkoConfig has copy, drop, store {
        num_rows: u8,
        multipliers: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        min_stake: u64,
        max_stake: u64,
        is_playable: bool,
    }

    struct Parameters<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_stake: u64,
        max_stake: u64,
        max_number_of_balls: u64,
        configs: 0x2::vec_map::VecMap<u8, PlinkoConfig>,
    }

    public fun admin_create_plinko_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_plinko_settings(arg0, arg2);
    }

    public fun admin_edit_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8, arg3: u8, arg4: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg5: u64, arg6: u64, arg7: bool) {
        edit_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun admin_set_initial_configs<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap) {
        let v0 = borrow_parameters<T0>(borrow_plinko_settings(arg0));
        let v1 = v0.min_stake;
        let v2 = v0.max_stake;
        let v3 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v4 = &mut v3;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v4, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v4, float_fraction(3, 2));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v4, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v4, float_fraction(1, 2));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v4, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v4, float_fraction(3, 2));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v4, float_fraction(4, 1));
        upsert_config<T0>(arg0, 0, 6, v3, v1, v2, true);
        let v5 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v6 = &mut v5;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v6, float_fraction(6, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v6, float_fraction(9, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v6, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v6, float_fraction(2, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v6, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v6, float_fraction(9, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v6, float_fraction(6, 1));
        upsert_config<T0>(arg0, 1, 6, v5, v1, v2, true);
        let v7 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v8 = &mut v7;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v8, float_fraction(8, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v8, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v8, float_fraction(3, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v8, float_fraction(1, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v8, float_fraction(3, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v8, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v8, float_fraction(8, 1));
        upsert_config<T0>(arg0, 2, 6, v7, v1, v2, false);
        let v9 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v10 = &mut v9;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v10, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v10, float_fraction(7, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v10, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v10, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v10, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v10, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v10, float_fraction(7, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v10, float_fraction(5, 1));
        upsert_config<T0>(arg0, 3, 7, v9, v1, v2, true);
        let v11 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v12 = &mut v11;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v12, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v12, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v12, float_fraction(1, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v12, float_fraction(1, 2));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v12, float_fraction(1, 2));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v12, float_fraction(1, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v12, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v12, float_fraction(10, 1));
        upsert_config<T0>(arg0, 4, 7, v11, v1, v2, true);
        let v13 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v14 = &mut v13;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v14, float_fraction(20, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v14, float_fraction(29, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v14, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v14, float_fraction(1, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v14, float_fraction(1, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v14, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v14, float_fraction(29, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v14, float_fraction(20, 1));
        upsert_config<T0>(arg0, 5, 7, v13, v1, v2, false);
        let v15 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v16 = &mut v15;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(1, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(1, 2));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(1, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v16, float_fraction(5, 1));
        upsert_config<T0>(arg0, 6, 8, v15, v1, v2, true);
        let v17 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v18 = &mut v17;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(11, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(2, 5));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v18, float_fraction(11, 1));
        upsert_config<T0>(arg0, 7, 8, v17, v1, v2, true);
        let v19 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v20 = &mut v19;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(26, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(15, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(15, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v20, float_fraction(26, 1));
        upsert_config<T0>(arg0, 8, 8, v19, v1, v2, false);
        let v21 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v22 = &mut v21;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(51, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(15, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(1, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(1, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(15, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v22, float_fraction(51, 10));
        upsert_config<T0>(arg0, 9, 9, v21, v1, v2, true);
        let v23 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v24 = &mut v23;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(16, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(16, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(16, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v24, float_fraction(16, 1));
        upsert_config<T0>(arg0, 10, 9, v23, v1, v2, true);
        let v25 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v26 = &mut v25;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(45, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(6, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(6, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(6, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(6, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v26, float_fraction(45, 1));
        upsert_config<T0>(arg0, 11, 9, v25, v1, v2, false);
        let v27 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v28 = &mut v27;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(8, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v28, float_fraction(8, 1));
        upsert_config<T0>(arg0, 12, 10, v27, v1, v2, true);
        let v29 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v30 = &mut v29;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(20, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(6, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(4, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(6, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v30, float_fraction(20, 1));
        upsert_config<T0>(arg0, 13, 10, v29, v1, v2, true);
        let v31 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v32 = &mut v31;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(65, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v32, float_fraction(65, 1));
        upsert_config<T0>(arg0, 14, 10, v31, v1, v2, false);
        let v33 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v34 = &mut v33;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(84, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v34, float_fraction(84, 10));
        upsert_config<T0>(arg0, 15, 11, v33, v1, v2, true);
        let v35 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v36 = &mut v35;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(24, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(17, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(17, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v36, float_fraction(24, 1));
        upsert_config<T0>(arg0, 16, 11, v35, v1, v2, true);
        let v37 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v38 = &mut v37;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(100, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(14, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(4, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(4, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(14, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v38, float_fraction(100, 1));
        upsert_config<T0>(arg0, 17, 11, v37, v1, v2, false);
        let v39 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v40 = &mut v39;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(9, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v40, float_fraction(9, 1));
        upsert_config<T0>(arg0, 18, 12, v39, v1, v2, true);
        let v41 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v42 = &mut v41;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(30, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(35, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(6, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(6, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(35, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v42, float_fraction(30, 1));
        upsert_config<T0>(arg0, 19, 12, v41, v1, v2, true);
        let v43 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v44 = &mut v43;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(150, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(20, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(8, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(8, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(20, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v44, float_fraction(150, 1));
        upsert_config<T0>(arg0, 20, 12, v43, v1, v2, false);
        let v45 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v46 = &mut v45;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(8, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(16, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(12, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(12, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(16, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v46, float_fraction(8, 1));
        upsert_config<T0>(arg0, 21, 13, v45, v1, v2, false);
        let v47 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v48 = &mut v47;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(40, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(30, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(4, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(4, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(30, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v48, float_fraction(40, 1));
        upsert_config<T0>(arg0, 22, 13, v47, v1, v2, false);
        let v49 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v50 = &mut v49;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(220, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(33, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(11, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(40, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(40, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(11, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(33, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v50, float_fraction(220, 1));
        upsert_config<T0>(arg0, 23, 13, v49, v1, v2, false);
        let v51 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v52 = &mut v51;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(7, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(16, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(14, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(16, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(4, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v52, float_fraction(7, 1));
        upsert_config<T0>(arg0, 24, 14, v51, v1, v2, false);
        let v53 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v54 = &mut v53;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(50, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(40, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(40, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v54, float_fraction(50, 1));
        upsert_config<T0>(arg0, 25, 14, v53, v1, v2, false);
        let v55 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v56 = &mut v55;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(400, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(50, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(17, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(50, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(19, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(19, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(50, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(17, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(50, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v56, float_fraction(400, 1));
        upsert_config<T0>(arg0, 26, 14, v55, v1, v2, false);
        let v57 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v58 = &mut v57;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(11, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(7, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(3, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v58, float_fraction(11, 1));
        upsert_config<T0>(arg0, 27, 15, v57, v1, v2, false);
        let v59 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v60 = &mut v59;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(80, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(15, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(12, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(40, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(30, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(30, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(40, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(12, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(15, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v60, float_fraction(80, 1));
        upsert_config<T0>(arg0, 28, 15, v59, v1, v2, false);
        let v61 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v62 = &mut v61;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(600, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(80, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(23, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(80, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(30, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(30, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(80, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(23, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(80, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v62, float_fraction(600, 1));
        upsert_config<T0>(arg0, 29, 15, v61, v1, v2, false);
        let v63 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v64 = &mut v63;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(12, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(12, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(9, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(11, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(12, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(2, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(5, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v64, float_fraction(12, 1));
        upsert_config<T0>(arg0, 30, 16, v63, v1, v2, false);
        let v65 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v66 = &mut v65;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(100, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(40, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(50, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(30, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(3, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(5, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(10, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(13, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(30, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(50, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(10, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(40, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v66, float_fraction(100, 1));
        upsert_config<T0>(arg0, 31, 16, v65, v1, v2, false);
        let v67 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v68 = &mut v67;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(1000, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(110, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(20, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(90, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(40, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(2, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(20, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(40, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(90, 10));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(20, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(110, 1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v68, float_fraction(1000, 1));
        upsert_config<T0>(arg0, 32, 16, v67, v1, v2, false);
    }

    public fun admin_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun admin_upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8, arg3: u8, arg4: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg5: u64, arg6: u64, arg7: bool) {
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun borrow_mut_parameters<T0>(arg0: &mut PlinkoSettings) : &mut Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621696725581829);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Parameters<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_parameters<T0>(arg0: &PlinkoSettings) : &Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835621670955778053);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_plinko_settings(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &PlinkoSettings {
        let v0 = PlinkoSettingsKey{dummy_field: false};
        let v1 = Plinko{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Plinko, PlinkoSettingsKey, PlinkoSettings>(arg0, v1, v0), 13835340084309786627);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Plinko, PlinkoSettingsKey, PlinkoSettings>(arg0, v0)
    }

    fun borrow_plinko_settings_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut PlinkoSettings {
        let v0 = Plinko{dummy_field: false};
        let v1 = PlinkoSettingsKey{dummy_field: false};
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Plinko, PlinkoSettingsKey, PlinkoSettings>(arg0, v0, v1), 13835340144439328771);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Plinko, PlinkoSettingsKey, PlinkoSettings>(arg0, v0, v1)
    }

    fun compute_expected_value(arg0: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg1: u8) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = (arg1 as u64);
        let v1 = 1;
        let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero();
        let v3 = 0;
        while (v3 <= v0) {
            v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::add(v2, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(*0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg0, v3), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v1), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::math::pow_u64(2, v0)))));
            if (v3 < v0) {
                let v4 = (v1 as u128) * ((v0 - v3) as u128) / ((v3 + 1) as u128);
                v1 = (v4 as u64);
            };
            v3 = v3 + 1;
        };
        v2
    }

    fun create_plinko_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PlinkoSettings{id: 0x2::object::new(arg1)};
        let v1 = Plinko{dummy_field: false};
        let v2 = PlinkoSettingsKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Plinko, PlinkoSettingsKey, PlinkoSettings>(arg0, v1, v2, v0);
        let v3 = PlinkoSettingsCreatedEvent{
            settings_id : 0x2::object::id<PlinkoSettings>(&v0),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PlinkoSettingsCreatedEvent>(v3);
    }

    fun edit_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u8, arg2: u8, arg3: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg4: u64, arg5: u64, arg6: bool) {
        let v0 = borrow_plinko_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        assert!(0x2::vec_map::contains<u8, PlinkoConfig>(&v1.configs, &arg1), 13837030149646581775);
        validate_config(arg2, &arg3, arg4, arg5);
        let v2 = 0x2::vec_map::get_mut<u8, PlinkoConfig>(&mut v1.configs, &arg1);
        v2.num_rows = arg2;
        v2.multipliers = arg3;
        v2.min_stake = arg4;
        v2.max_stake = arg5;
        v2.is_playable = arg6;
        let v3 = PlinkoConfigUpsertedEvent<T0>{
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            config_number : arg1,
            num_rows      : arg2,
            multipliers   : arg3,
            min_stake     : arg4,
            max_stake     : arg5,
            is_playable   : arg6,
            is_new        : false,
        };
        0x2::event::emit<PlinkoConfigUpsertedEvent<T0>>(v3);
    }

    fun float_fraction(arg0: u64, arg1: u64) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        assert!(arg1 > 0, 13835902836694974471);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_fraction(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(arg0), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(arg1))
    }

    fun generate_slot_index(arg0: &mut 0x2::random::RandomGenerator, arg1: u8) : u8 {
        slot_index_from_random_value(arg1, 0x2::random::generate_u64_in_range(arg0, 0, sampled_random_upper_bound(arg1)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun manager_create_plinko_settings(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Plinko>(arg1, 0x2::tx_context::sender(arg2));
        create_plinko_settings(arg0, arg2);
    }

    public fun manager_edit_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u8, arg3: u8, arg4: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Plinko>(arg1, 0x2::tx_context::sender(arg8));
        edit_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun manager_set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Plinko>(arg1, 0x2::tx_context::sender(arg5));
        set_parameters<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun manager_upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u8, arg3: u8, arg4: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Plinko>(arg1, 0x2::tx_context::sender(arg8));
        upsert_config<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun max_expected_value() : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        float_fraction(99, 100)
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

    fun parameters_exist<T0>(arg0: &PlinkoSettings) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    entry fun play<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        play_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun play_internal<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = Plinko{dummy_field: false};
        let v2 = borrow_parameters<T0>(borrow_plinko_settings(arg0));
        assert!(0x2::vec_map::contains<u8, PlinkoConfig>(&v2.configs, &arg4), 13837033851908390927);
        let v3 = v2.min_stake;
        let v4 = v2.max_stake;
        let v5 = v2.max_number_of_balls;
        let PlinkoConfig {
            num_rows    : v6,
            multipliers : v7,
            min_stake   : v8,
            max_stake   : v9,
            is_playable : v10,
        } = *0x2::vec_map::get<u8, PlinkoConfig>(&v2.configs, &arg4);
        let v11 = v7;
        assert!(v10, 13837315404194643985);
        assert!(v3 <= v4, 13835908033605402631);
        assert!(v5 > 0 && v5 <= 100, 13835908037900369927);
        assert!(arg3 > 0 && arg3 <= v5, 13836752467125862413);
        assert!(v6 > 0 && v6 <= 63, 13835908046490304519);
        assert!(0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v11) == (v6 as u64) + 1, 13837596900646322195);
        let v12 = 0x2::coin::value<T0>(&arg2);
        let v13 = 0x2::coin::into_balance<T0>(arg2);
        let v14 = 0x2::coin::zero<T0>(arg10);
        if (v12 > arg1) {
            0x2::coin::join<T0>(&mut v14, 0x2::coin::take<T0>(&mut v13, v12 - arg1, arg10));
        } else if (v12 < arg1) {
            let v15 = Plinko{dummy_field: false};
            0x2::coin::put<T0>(&mut v13, 0x3bbb757a9d4638488d874a205ddf8c4ead2e102748f7d3c9d79c56a2f09357d::free_bet::operator_claim_player_free_bet<T0, Plinko>(arg0, v15, v0, arg1 - v12, arg10));
        };
        assert!(0x2::balance::value<T0>(&v13) == arg1, 13837878465817477141);
        let v16 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_and_get_stake_ticket<T0, Plinko>(arg0, v1, 0x2::coin::from_balance<T0>(v13, arg10), arg3, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::compute_total_payout_for_uniform_multiplier(arg1, arg3, max_multiplier(&v11)), v0, arg10);
        0x13a877d974d59f54d8affa4d345bf794cf8e9e936d9d22100c801c95b415930f::loyalty::process_stake_ticket<T0, Plinko>(&mut v16, arg0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::utils::build_metadata<0x1::string::String, vector<u8>>(arg5, arg6), arg7, arg8, arg9, arg10);
        let v17 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_single_game_stake_amounts<T0, Plinko>(&v16);
        let v18 = 0x2::random::new_generator(arg9, arg10);
        let v19 = 0;
        while (v19 < arg3) {
            let v20 = *0x1::vector::borrow<u64>(&v17, v19);
            assert!(v20 >= v3, 13836189787755118601);
            assert!(v20 <= v4, 13836471267026927627);
            assert!(v20 >= v8, 13836189796345053193);
            assert!(v20 <= v9, 13836471275616862219);
            let v21 = &mut v18;
            let v22 = generate_slot_index(v21, v6);
            let v23 = *0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v11, (v22 as u64));
            let v24 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v20), v23));
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_outcome_amount<T0, Plinko>(&mut v16, v24);
            let v25 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            let v26 = (v22 as u8);
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v25, 0x1::string::utf8(b"slot_index"), 0x2::bcs::to_bytes<u8>(&v26));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v25, 0x1::string::utf8(b"multiplier"), 0x2::bcs::to_bytes<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v23));
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v25, 0x1::string::utf8(b"payout_amount"), 0x2::bcs::to_bytes<u64>(&v24));
            let v27 = (arg4 as u8);
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v25, 0x1::string::utf8(b"plinko_config"), 0x2::bcs::to_bytes<u8>(&v27));
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::add_game_details<T0, Plinko>(&mut v16, v25);
            v19 = v19 + 1;
        };
        0x2::coin::join<T0>(&mut v14, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_and_destroy_stake_ticket<T0, Plinko>(arg0, v1, v16, arg9, arg10));
        v14
    }

    fun sampled_random_upper_bound(arg0: u8) : u64 {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::math::pow_u64(2, (arg0 as u64)) - 1
    }

    fun set_parameters<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg2, 13835903343501115399);
        assert!(arg3 > 0 && arg3 <= 100, 13835903347796082695);
        0x1::type_name::with_defining_ids<T0>();
        let v0 = borrow_plinko_settings_mut(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = parameters_exist<T0>(v0);
        if (v2) {
            let v3 = borrow_mut_parameters<T0>(v0);
            v3.min_stake = arg1;
            v3.max_stake = arg2;
            v3.max_number_of_balls = arg3;
        } else {
            let v4 = Parameters<T0>{
                id                  : 0x2::object::new(arg4),
                min_stake           : arg1,
                max_stake           : arg2,
                max_number_of_balls : arg3,
                configs             : 0x2::vec_map::empty<u8, PlinkoConfig>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Parameters<T0>>(&mut v0.id, v1, v4);
        };
        let v5 = PlinkoParametersSetEvent<T0>{
            coin_type           : v1,
            min_stake           : arg1,
            max_stake           : arg2,
            max_number_of_balls : arg3,
            is_new              : !v2,
        };
        0x2::event::emit<PlinkoParametersSetEvent<T0>>(v5);
    }

    fun slot_index_from_random_value(arg0: u8, arg1: u64) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < (arg0 as u64)) {
            if (arg1 >> (v1 as u8) & 1 == 1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun upsert_config<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u8, arg2: u8, arg3: vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg4: u64, arg5: u64, arg6: bool) {
        validate_config(arg2, &arg3, arg4, arg5);
        let v0 = borrow_plinko_settings_mut(arg0);
        let v1 = borrow_mut_parameters<T0>(v0);
        let v2 = 0x2::vec_map::contains<u8, PlinkoConfig>(&v1.configs, &arg1);
        if (v2) {
            let v3 = 0x2::vec_map::get_mut<u8, PlinkoConfig>(&mut v1.configs, &arg1);
            v3.num_rows = arg2;
            v3.multipliers = arg3;
            v3.min_stake = arg4;
            v3.max_stake = arg5;
            v3.is_playable = arg6;
        } else {
            let v4 = PlinkoConfig{
                num_rows    : arg2,
                multipliers : arg3,
                min_stake   : arg4,
                max_stake   : arg5,
                is_playable : arg6,
            };
            0x2::vec_map::insert<u8, PlinkoConfig>(&mut v1.configs, arg1, v4);
        };
        let v5 = PlinkoConfigUpsertedEvent<T0>{
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            config_number : arg1,
            num_rows      : arg2,
            multipliers   : arg3,
            min_stake     : arg4,
            max_stake     : arg5,
            is_playable   : arg6,
            is_new        : !v2,
        };
        0x2::event::emit<PlinkoConfigUpsertedEvent<T0>>(v5);
    }

    fun validate_config(arg0: u8, arg1: &vector<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg2: u64, arg3: u64) {
        assert!(arg0 > 0, 13835903785882746887);
        assert!(arg0 <= 63, 13838155589992448023);
        assert!(0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg1) == (arg0 as u64) + 1, 13837592644333731859);
        assert!(arg3 > 0, 13835903798767648775);
        assert!(arg2 <= arg3, 13835903803062616071);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg1)) {
            assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg1, v0)), 13835903828832419847);
            v0 = v0 + 1;
        };
        let v1 = compute_expected_value(arg1, arg0);
        let v2 = max_expected_value();
        let v3 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(8), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(10));
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&v1, &v2), 13838437133688766489);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&v1, &v3), 13838718612960575515);
    }

    // decompiled from Move bytecode v6
}

