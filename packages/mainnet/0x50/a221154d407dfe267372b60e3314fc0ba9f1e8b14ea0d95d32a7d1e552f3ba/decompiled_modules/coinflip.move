module 0x50a221154d407dfe267372b60e3314fc0ba9f1e8b14ea0d95d32a7d1e552f3ba::coinflip {
    struct Coinflip has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinflipSettings has store, key {
        id: 0x2::object::UID,
        house_edge: u64,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_version(arg0: &mut CoinflipSettings, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.version_set, arg2);
    }

    fun assert_valid_package_version(arg0: &CoinflipSettings) {
        let v0 = 1;
        if (!0x2::vec_set::contains<u64>(&arg0.version_set, &v0)) {
            err_invalid_package_version();
        };
    }

    fun err_invalid_house_edge() {
        abort 3
    }

    fun err_invalid_package_version() {
        abort 2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CoinflipSettings{
            id          : 0x2::object::new(arg0),
            house_edge  : 15,
            version_set : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<CoinflipSettings>(v1);
    }

    fun one_game<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &CoinflipSettings, arg2: &mut 0x2::random::RandomGenerator, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>, u64) {
        assert!(arg3 < 2, 0);
        let v0 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::ranges::from_single_range(arg3 * 500, arg3 * 500 + 500 - arg1.house_edge);
        let v1 = Coinflip{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Coinflip>(arg0, v1, arg4, arg5);
        let v2 = 0x2::random::generate_u64_in_range(arg2, 1, 1000);
        let v3 = if (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::ranges::contains(&v0, v2)) {
            arg4 * 2
        } else {
            0
        };
        (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, Coinflip>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), arg3, 0x1::option::none<u64>(), arg4, v3, v2), v3)
    }

    entry fun play<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &CoinflipSettings, arg2: &0x2::random::Random, arg3: vector<u64>, arg4: 0x2::coin::Coin<T0>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg3) <= 50, 1);
        assert_valid_package_version(arg1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg2, arg6);
        let v0 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>();
        let v1 = 0x2::random::new_generator(arg2, arg6);
        let v2 = 0;
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v3 = &mut v1;
            let (v4, v5) = one_game<T0>(arg0, arg1, v3, 0x1::vector::pop_back<u64>(&mut arg3), 0x2::coin::value<T0>(&arg4) / 0x1::vector::length<u64>(&arg3), arg6);
            v2 = v2 + v5;
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>(&mut v0, v4);
        };
        settle_game_helper<T0>(arg0, arg4, v2, arg6);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg5), v0);
    }

    public fun remove_version(arg0: &mut CoinflipSettings, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg2);
    }

    public fun set_house_edge(arg0: &mut CoinflipSettings, arg1: &AdminCap, arg2: u64) {
        if (arg2 > 50 || arg2 < 10) {
            err_invalid_house_edge();
        };
        arg0.house_edge = arg2;
    }

    fun settle_game_helper<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Coinflip{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Coinflip>(arg0, v0, arg1);
        if (arg2 > 0) {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<u64>(&arg2), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, Coinflip>(arg0, v0, arg2, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

