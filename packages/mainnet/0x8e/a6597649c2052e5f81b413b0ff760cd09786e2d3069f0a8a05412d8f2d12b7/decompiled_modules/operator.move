module 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::operator {
    struct OperatorCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    public entry fun execute_end_round<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::Version, arg1: &OperatorCap<T0>, arg2: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg3: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::State<T0>, arg4: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::assert_current_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::get_current_epoch<T0>(arg3);
        let v2 = get_round_by_epoch<T0>(arg3, v1);
        assert!(!0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::is_finished<T0>(v2), 2);
        let v3 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_reward_breakdown<T0>(arg2);
        assert!(0x1::vector::length<u64>(&v3) == 0x1::vector::length<u8>(&arg5), 3);
        let v4 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_close_timestamp<T0>(v2);
        let v5 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::to_miliseconds(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_buffer_seconds<T0>(arg2));
        assert!(v0 >= v4 - v5 && v0 <= v4 + v5, 1);
        if (!true) {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::drand_lib::verify_round_time(v4 / 1000, arg6, arg7);
        };
        let (_, v7, v8, v9, v10, v11) = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::calculate_rewards<T0>(arg2, v2, arg5);
        let v12 = v10;
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::end_round<T0>(arg2, v2, arg5, arg6, arg7, v12, v11);
        if (v7 > 0) {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::add_treasury_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_round_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_epoch<T0>(v2), v7));
        };
        if (v8 > 0) {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::add_reserve_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_round_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_epoch<T0>(v2), v8));
        };
        if (v9 > 0) {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::add_next_pool_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_round_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_epoch<T0>(v2), v9));
        };
        if (*0x1::vector::borrow<u64>(&v12, 0x1::vector::length<u64>(&v12) - 1) > 0) {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::add_next_pool_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_reserve_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::get_value_with_rate(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::get_reserve_value<T0>(arg4), 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_treasury_reserve_transfer_rate<T0>(arg2))));
        };
    }

    public entry fun execute_start_round<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::Version, arg1: &OperatorCap<T0>, arg2: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg3: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::State<T0>, arg4: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::assert_current_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::get_current_epoch<T0>(arg3);
        let v2 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::to_miliseconds(arg6);
        let v3 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::to_miliseconds(arg7);
        assert!(v2 > v0, 5);
        assert!(v3 > v2, 6);
        if (v1 > 0) {
            let v4 = get_round_by_epoch<T0>(arg3, v1);
            assert!(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::is_finished<T0>(v4), 2);
        };
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::update_current_epoch<T0>(arg3, v1 + 1);
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::add<T0, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundInfo<T0>>(arg3, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::new_round_key<T0>(v1 + 1), 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::start_round<T0>(arg2, v1 + 1, v0, v2, v3, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::get_next_pool_value<T0>(arg4), arg5, arg9));
        let v5 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::get_value_with_rate(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::get_next_pool_value<T0>(arg4), 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_treasury_reserve_rate<T0>(arg2));
        if (v5 > 0) {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::new_round_balance<T0>(arg4, v1 + 1, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_next_pool_balance<T0>(arg4, v5));
        } else {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::new_round_balance<T0>(arg4, v1 + 1, 0x2::balance::zero<T0>());
        };
    }

    fun get_round_by_epoch<T0>(arg0: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::State<T0>, arg1: u64) : &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundInfo<T0> {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::borrow_mut<T0, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundInfo<T0>>(arg0, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::new_round_key<T0>(arg1))
    }

    public(friend) fun new_operator<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap<T0>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap<T0>>(v0, arg0);
    }

    public entry fun stop_round<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::Version, arg1: &OperatorCap<T0>, arg2: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg3: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::State<T0>, arg4: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::assert_current_version(arg0);
        let v0 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::get_current_epoch<T0>(arg3);
        let v1 = get_round_by_epoch<T0>(arg3, v0);
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::stop_round<T0>(arg2, v1, 4);
        let v2 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_init_prize_pool<T0>(v1);
        if (v2 > 0) {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::add_next_pool_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_round_balance<T0>(arg4, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_epoch<T0>(v1), v2));
        };
    }

    public entry fun update_configuration<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::Version, arg1: &OperatorCap<T0>, arg2: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: 0x1::string::String) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::assert_current_version(arg0);
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::update<T0>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

