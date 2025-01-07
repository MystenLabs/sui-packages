module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet {
    struct ClaimEvent has copy, drop {
        sender: address,
        epoches: vector<u64>,
        amount: u64,
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
    }

    public entry fun bet<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::Custodian<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::get_current_epoch<T0, T1>(arg1), 100);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<T1>(&arg4);
        let v2 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::new_user_bet_key<T0, T1>(arg3, v0);
        assert!(!0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::contain<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::UserBetKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::UserBet<T0, T1>>(arg1, v2), 103);
        let v3 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(arg3));
        assert!(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::is_valid_position(arg5), 101);
        assert!(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::bettable<T0, T1>(v3, 0x2::clock::timestamp_ms(arg6)), 104);
        assert!(v1 >= 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_min_bet_amount<T0, T1>(arg0), 102);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::update_bet_amount<T0, T1>(v3, v1, arg5);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::add<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::UserBetKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::UserBet<T0, T1>>(arg1, v2, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::new<T0, T1>(v0, arg5, v1, arg3, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0), 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0), arg7));
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::add_round_balance<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T1>(arg4));
    }

    public entry fun claim<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::State<T0, T1>, arg2: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::Custodian<T0, T1>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x2::balance::zero<T1>();
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            let v5 = *0x1::vector::borrow<u64>(&arg3, v1);
            v1 = v1 + 1;
            let (v6, v7, v8, _, _, v11, v12, v13, _, _, _, _, v18, v19, _, _, _) = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::get_round_info<T0, T1>(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::RoundInfo<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round::new_round_key<T0, T1>(v5)));
            if (!v7) {
                continue
            };
            let v23 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::borrow_mut<T0, T1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::UserBetKey<T0, T1>, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::UserBet<T0, T1>>(arg1, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::new_user_bet_key<T0, T1>(v5, v0));
            let (v24, v25, v26, v27, _) = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::get_bet_info<T0, T1>(v23);
            assert!(v6 == v26, 105);
            assert!(v6 == v5, 105);
            let v29 = 0x1::option::none<u64>();
            if (claimable(v7, v8, v12, v13, v27, v25, v24)) {
                0x1::option::fill<u64>(&mut v29, (((v25 as u128) * (v19 as u128) / (v18 as u128)) as u64));
                0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::set_claimed<T0, T1>(v23, true);
            } else if (refundable(v7, v8, v11, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_buffer_seconds<T0, T1>(arg0), v27, v25, arg4)) {
                0x1::option::fill<u64>(&mut v29, v25);
                0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::bet_registry::set_claimed<T0, T1>(v23, true);
            };
            if (0x1::option::is_some<u64>(&v29)) {
                let v30 = 0x1::option::extract<u64>(&mut v29);
                0x1::vector::push_back<u64>(&mut v3, v5);
                0x2::balance::join<T1>(&mut v4, 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::sub_round_balance<T0, T1>(arg2, v5, v30));
                v2 = v2 + v30;
            };
        };
        assert!(v2 > 0, 106);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg5), v0);
        let v31 = ClaimEvent{
            sender     : v0,
            epoches    : v3,
            amount     : v2,
            pool       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
            pair_name  : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
            pair_index : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
        };
        0x2::event::emit<ClaimEvent>(v31);
    }

    fun claimable(arg0: bool, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: u64, arg6: u8) : bool {
        arg2 == arg3 && false || arg0 && arg1 == 0 && arg5 != 0 && !arg4 && (arg3 > arg2 && 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::is_bull_position(arg6) || arg3 < arg2 && 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::is_bear_position(arg6))
    }

    public fun refundable(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : bool {
        arg0 && arg1 > 0 && arg5 != 0 && !arg4 && 0x2::clock::timestamp_ms(arg6) > arg2 + 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(arg3)
    }

    // decompiled from Move bytecode v6
}

