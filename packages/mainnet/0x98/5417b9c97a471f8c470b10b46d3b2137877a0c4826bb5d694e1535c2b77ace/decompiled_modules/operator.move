module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::operator {
    struct OperatorCap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    struct PriceOracleErrorEvent has copy, drop {
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
        price: u128,
        price_decimal: u16,
        round: u64,
        round_timestamp: u64,
        price_timestamp: u64,
        error_code: u64,
    }

    struct PriceOracleEvent has copy, drop {
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
        price: u128,
        round: u64,
        price_decimal: u16,
        round_timestamp: u64,
        price_timestamp: u64,
    }

    public entry fun execute_round<T0, T1>(arg0: &OperatorCap<T0, T1>, arg1: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg2: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg3: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::Custodian<T0, T1>, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::is_genesis_start<T0, T1>(arg2);
        let v1 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::is_genesis_lock<T0, T1>(arg2);
        assert!(v0 || !v1, 4);
        if (!v0 && !v1) {
            genesis_start_round<T0, T1>(arg1, arg2, arg3, arg5, arg6);
        } else if (v0 && !v1) {
            genesis_lock_round<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        } else if (v0 && v1) {
            let v2 = 0x2::clock::timestamp_ms(arg5);
            let (v3, v4, v5, v6) = get_price_oracle<T0, T1>(arg1, arg2, arg4, v2);
            let v7 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::get_current_epoch<T0, T1>(arg2);
            if (v6 > 0) {
                stop_lock_round<T0, T1>(arg1, arg2, v7, v3, v4, v5, v6, v2);
                stop_end_round<T0, T1>(arg1, arg2, v7 - 1, v3, v4, v5, v6, v2);
                0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::update_state<T0, T1>(arg2, v7, v3, arg6);
                0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::update_genesis<T0, T1>(arg2, false, false, arg6);
            } else {
                safe_lock_round<T0, T1>(arg1, arg2, v7, v3, v4, v5, v2);
                safe_end_round<T0, T1>(arg1, arg2, v7 - 1, v3, v4, v5, v2);
                0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::add_treasury_balance<T0, T1>(arg3, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::sub_round_balance<T0, T1>(arg3, v7 - 1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::calculate_rewards<T0, T1>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg2, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(v7 - 1)), v7 - 1)));
                0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::update_state<T0, T1>(arg2, v7 + 1, v3, arg6);
                safe_start_round<T0, T1>(arg1, arg2, arg3, v7 + 1, v2, arg6);
            };
        };
    }

    public entry fun force_stop<T0, T1>(arg0: &OperatorCap<T0, T1>, arg1: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg2: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::update_genesis<T0, T1>(arg2, false, false, arg3);
        let v0 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::get_current_epoch<T0, T1>(arg2);
        if (v0 > 1) {
            0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::force_stop_round<T0, T1>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg2, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(v0)), v0, 13);
        };
        if (v0 > 2) {
            0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::force_stop_round<T0, T1>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg2, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(v0 - 1)), v0 - 1, 13);
        };
    }

    fun genesis_lock_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::Custodian<T0, T1>, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::is_genesis_start<T0, T1>(arg1), 1);
        assert!(!0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::is_genesis_lock<T0, T1>(arg1), 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let (v1, v2, v3, v4) = get_price_oracle<T0, T1>(arg0, arg1, arg3, v0);
        let v5 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::get_current_epoch<T0, T1>(arg1);
        if (v4 > 0) {
            0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::stop_lock_round<T0, T1>(arg0, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(v5)), v5, v1, v2, v3, v0, v4);
        } else {
            safe_lock_round<T0, T1>(arg0, arg1, v5, v1, v2, v3, v0);
        };
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::update_state<T0, T1>(arg1, v5 + 1, v1, arg5);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::add<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(v5 + 1), 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::start_round<T0, T1>(arg0, v5 + 1, v0, arg5));
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::update_genesis<T0, T1>(arg1, true, true, arg5);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::new_round_balance<T0, T1>(arg2, v5 + 1);
    }

    fun genesis_start_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::Custodian<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::is_genesis_start<T0, T1>(arg1), 2);
        let v0 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::get_current_epoch<T0, T1>(arg1) + 1;
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::update_state<T0, T1>(arg1, v0, 0, arg4);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::add<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(v0), 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::start_round<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg3), arg4));
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::update_genesis<T0, T1>(arg1, true, false, arg4);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::new_round_balance<T0, T1>(arg2, v0);
    }

    fun get_price_oracle<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: u64) : (u64, u128, u16, u64) {
        let (v0, v1, v2, v3) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg2, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0));
        let v4 = 0;
        if (arg3 > (v2 as u64) + 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_oracle_update_allowance<T0, T1>(arg0)) || arg3 < (v2 as u64) - 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_oracle_update_allowance<T0, T1>(arg0))) {
            v4 = 11;
        };
        if (v3 <= 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::get_oracle_lastest_round_id<T0, T1>(arg1)) {
            v4 = 12;
        };
        let v5 = PriceOracleEvent{
            pool            : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
            pair_name       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
            pair_index      : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
            price           : v0,
            round           : v3,
            price_decimal   : v1,
            round_timestamp : arg3,
            price_timestamp : (v2 as u64),
        };
        0x2::event::emit<PriceOracleEvent>(v5);
        if (v4 > 0) {
            let v6 = PriceOracleErrorEvent{
                pool            : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
                pair_name       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
                pair_index      : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
                price           : v0,
                price_decimal   : v1,
                round           : v3,
                round_timestamp : arg3,
                price_timestamp : (v2 as u64),
                error_code      : v4,
            };
            0x2::event::emit<PriceOracleErrorEvent>(v6);
        };
        (v3, v0, v1, v4)
    }

    public(friend) fun new_operator<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap<T0, T1>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap<T0, T1>>(v0, arg0);
    }

    fun safe_end_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: u64, arg3: u64, arg4: u128, arg5: u16, arg6: u64) {
        let v0 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(arg2);
        assert!(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::contain<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, v0), 9);
        let v1 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, v0);
        if (!0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::is_finished<T0, T1>(v1)) {
            assert!(arg6 >= 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::get_close_timestamp<T0, T1>(v1) - 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_buffer_seconds<T0, T1>(arg0)), 10);
            assert!(arg6 <= 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::get_close_timestamp<T0, T1>(v1) + 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_buffer_seconds<T0, T1>(arg0)), 10);
            0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::end_round<T0, T1>(arg0, v1, arg2, arg3, arg4, arg5, arg6);
        };
    }

    fun safe_lock_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: u64, arg3: u64, arg4: u128, arg5: u16, arg6: u64) {
        let v0 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(arg2);
        assert!(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::contain<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, v0), 7);
        let v1 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, v0);
        if (!0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::is_finished<T0, T1>(v1)) {
            assert!(arg6 >= 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::get_lock_timestamp<T0, T1>(v1) - 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_buffer_seconds<T0, T1>(arg0)), 8);
            assert!(arg6 <= 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::get_lock_timestamp<T0, T1>(v1) + 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_buffer_seconds<T0, T1>(arg0)), 8);
            0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::lock_round<T0, T1>(arg0, v1, arg2, arg3, arg4, arg5, arg6);
        };
    }

    fun safe_start_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::Custodian<T0, T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::is_genesis_start<T0, T1>(arg1), 1);
        assert!(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::contain<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(arg3 - 1)), 5);
        assert!(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::is_finished<T0, T1>(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(arg3 - 2))), 6);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::add<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(arg3), 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::start_round<T0, T1>(arg0, arg3, arg4, arg5));
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::new_round_balance<T0, T1>(arg2, arg3);
    }

    fun stop_end_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: u64, arg3: u64, arg4: u128, arg5: u16, arg6: u64, arg7: u64) {
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::stop_end_round<T0, T1>(arg0, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(arg2)), arg2, arg3, arg4, arg5, arg7, arg6);
    }

    fun stop_lock_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: u64, arg3: u64, arg4: u128, arg5: u16, arg6: u64, arg7: u64) {
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::stop_lock_round<T0, T1>(arg0, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(arg2)), arg2, arg3, arg4, arg5, arg7, arg6);
    }

    public entry fun update_configuration<T0, T1>(arg0: &OperatorCap<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u32) {
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::update<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

