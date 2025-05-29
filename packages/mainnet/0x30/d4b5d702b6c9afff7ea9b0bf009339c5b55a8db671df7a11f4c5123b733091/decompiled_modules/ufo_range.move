module 0x3d37357bac2e9644920b5c51d403938c32ea76e9ec848b1a526b208e76da1707::ufo_range {
    struct UFORange has copy, drop, store {
        dummy_field: bool,
    }

    struct UFORangeSettings has store, key {
        id: 0x2::object::UID,
        house_edge: u64,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun assert_valid_package_version(arg0: &UFORangeSettings) {
        let v0 = 1;
        if (!0x2::vec_set::contains<u64>(&arg0.version_set, &v0)) {
            err_invalid_package_version();
        };
    }

    fun err_invalid_house_edge() {
        abort 9
    }

    fun err_invalid_package_version() {
        abort 8
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = UFORangeSettings{
            id          : 0x2::object::new(arg0),
            house_edge  : 150,
            version_set : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<UFORangeSettings>(v1);
    }

    fun one_game<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &UFORangeSettings, arg2: &mut 0x2::random::RandomGenerator, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) : (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::RangeGame, u64) {
        assert!(arg4 == 0 || arg4 == 1, 0);
        assert!(arg5 <= 10000, 1);
        assert!(arg6 >= 1, 2);
        assert!(arg5 >= arg6, 3);
        let v0 = if (arg4 == 0) {
            arg5 - arg6
        } else {
            10000 - arg5 - arg6
        };
        let v1 = 0;
        assert!(v0 >= 100, 7);
        let v2 = ((10000 * 1000000 * (arg3 as u128) / (v0 as u128) / 1000000) as u64) - arg3;
        let v3 = UFORange{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, UFORange>(arg0, v3, v2, arg7);
        let v4 = 0x2::random::generate_u64_in_range(arg2, 1, 10001 + arg1.house_edge);
        if (v4 > 10000 && false || arg4 == 0 && v4 >= arg6 && v4 <= arg5 || v4 <= arg6 || v4 >= arg5) {
            v1 = v2 + arg3;
        };
        let v5 = UFORange{dummy_field: false};
        (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_range_game_event<T0, UFORange>(arg0, v5, arg3, v1, arg4, arg6, arg5, v4), v1)
    }

    entry fun play<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &UFORangeSettings, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: vector<u64>, arg5: vector<vector<u64>>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg4);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<vector<u64>>(&arg5) == v0, 5);
        assert_valid_package_version(arg1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg2, arg7);
        let v1 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::RangeGame>();
        let v2 = 0x2::random::new_generator(arg2, arg7);
        let v3 = 0;
        while (!0x1::vector::is_empty<u64>(&arg4)) {
            let v4 = 0x1::vector::pop_back<vector<u64>>(&mut arg5);
            assert!(0x1::vector::length<u64>(&v4) == 2, 6);
            let v5 = &mut v2;
            let (v6, v7) = one_game<T0>(arg0, arg1, v5, 0x2::coin::value<T0>(&arg3) / v0, 0x1::vector::pop_back<u64>(&mut arg4), *0x1::vector::borrow<u64>(&v4, 1), *0x1::vector::borrow<u64>(&v4, 0), arg7);
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::RangeGame>(&mut v1, v6);
            v3 = v3 + v7;
        };
        settle_game_helper<T0>(arg0, arg3, v3, arg7);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg7), arg6, v1);
    }

    public fun set_house_edge(arg0: &mut UFORangeSettings, arg1: &AdminCap, arg2: u64) {
        if (arg2 > 500 || arg2 < 100) {
            err_invalid_house_edge();
        };
        arg0.house_edge = arg2;
    }

    fun settle_game_helper<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = UFORange{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, UFORange>(arg0, v0, arg1);
        if (arg2 > 0) {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<u64>(&arg2), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, UFORange>(arg0, v0, arg2, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

