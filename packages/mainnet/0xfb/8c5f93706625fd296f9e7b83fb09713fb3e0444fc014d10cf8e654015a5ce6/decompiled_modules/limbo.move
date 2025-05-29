module 0xf4149f5a45d6bceab6d741214ffa5c654041421592427041729f0a5b02faa0ef::limbo {
    struct Limbo has copy, drop, store {
        dummy_field: bool,
    }

    struct LimboSettings has store, key {
        id: 0x2::object::UID,
        house_edge: u64,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun assert_valid_package_version(arg0: &LimboSettings) {
        let v0 = 1;
        if (!0x2::vec_set::contains<u64>(&arg0.version_set, &v0)) {
            err_invalid_package_version();
        };
    }

    fun err_invalid_house_edge() {
        abort 6
    }

    fun err_invalid_package_version() {
        abort 5
    }

    public fun get_threshold(arg0: u64) : u64 {
        10000000 - ((1000000000 / (arg0 as u128)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LimboSettings{
            id          : 0x2::object::new(arg0),
            house_edge  : 150000,
            version_set : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<LimboSettings>(v1);
    }

    fun one_game<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &LimboSettings, arg2: &mut 0x2::random::RandomGenerator, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>, u64) {
        assert!(arg3 >= 101 && arg3 <= 10000, 2);
        let v0 = payout_amount(arg4, arg3);
        let v1 = Limbo{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Limbo>(arg0, v1, v0, arg5);
        let v2 = 0;
        let v3 = 0x2::random::generate_u64_in_range(arg2, 0, 10000000 + arg1.house_edge);
        if (v3 > get_threshold(arg3) && v3 <= 10000000) {
            v2 = v0 + arg4;
        };
        (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, Limbo>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), arg3, 0x1::option::none<u64>(), arg4, v2, v3), v2)
    }

    public fun payout_amount(arg0: u64, arg1: u64) : u64 {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(arg0, arg1 - 100, 100)
    }

    entry fun play<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &LimboSettings, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: vector<u64>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg4) <= 100, 1);
        assert_valid_package_version(arg1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg2, arg6);
        let v0 = 0x2::random::new_generator(arg2, arg6);
        let v1 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>();
        let v2 = 0;
        while (!0x1::vector::is_empty<u64>(&arg4)) {
            let v3 = &mut v0;
            let (v4, v5) = one_game<T0>(arg0, arg1, v3, 0x1::vector::pop_back<u64>(&mut arg4), 0x2::coin::value<T0>(&arg3) / 0x1::vector::length<u64>(&arg4), arg6);
            let v6 = v4;
            0x1::debug::print<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>(&v6);
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>(&mut v1, v6);
            v2 = v2 + v5;
        };
        settle_game_helper<T0>(arg0, arg3, v2, arg6);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg5), v1);
    }

    public fun set_house_edge(arg0: &mut LimboSettings, arg1: &AdminCap, arg2: u64) {
        if (arg2 > 500000 || arg2 < 100000) {
            err_invalid_house_edge();
        };
        arg0.house_edge = arg2;
    }

    fun settle_game_helper<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Limbo{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Limbo>(arg0, v0, arg1);
        if (arg2 > 0) {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<u64>(&arg2), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, Limbo>(arg0, v0, arg2, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

