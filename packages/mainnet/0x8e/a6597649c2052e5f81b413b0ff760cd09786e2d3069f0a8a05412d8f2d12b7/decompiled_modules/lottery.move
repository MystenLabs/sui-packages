module 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::lottery {
    struct ClaimPrizeEvent<phantom T0> has copy, drop {
        sender: address,
        epoch: u64,
        ticket_number: u64,
        amount: u64,
        pool: 0x1::string::String,
    }

    public entry fun claim<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::Version, arg1: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg2: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::State<T0>, arg3: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>, arg4: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::Ticket<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::assert_current_version(arg0);
        assert!(!0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::is_claimed<T0>(arg4), 106);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::get_epoch<T0>(arg4);
        let v2 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::borrow<T0, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundInfo<T0>>(arg2, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::new_round_key<T0>(v1));
        assert!(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::is_finished<T0>(v2), 102);
        let v3 = if (0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::is_error<T0>(v2)) {
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_ticket_price<T0>(v2)
        } else {
            let v4 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::get_reward_level(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_winning_number<T0>(v2), 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::get_lottery_number<T0>(arg4));
            assert!(v4 > 0, 104);
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_reward_by_level<T0>(v2, v4)
        };
        assert!(v3 > 0, 105);
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::ticket_claimed<T0>(arg4, v3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::sub_round_balance<T0>(arg3, v1, v3), arg5), v0);
        let v5 = ClaimPrizeEvent<T0>{
            sender        : v0,
            epoch         : v1,
            ticket_number : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::get_ticket_number<T0>(arg4),
            amount        : v3,
            pool          : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_pool<T0>(arg1),
        };
        0x2::event::emit<ClaimPrizeEvent<T0>>(v5);
    }

    public entry fun purchase_tickets<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::Version, arg1: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg2: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::State<T0>, arg3: &mut 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::Custodian<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::version::assert_current_version(arg0);
        assert!(arg4 == 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::get_current_epoch<T0>(arg2), 100);
        let v0 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_reward_breakdown<T0>(arg1);
        let v1 = 0x1::vector::length<u64>(&v0);
        assert!(arg5 > 0 && 0x1::vector::length<u8>(&arg6) == v1 * arg5, 101);
        let v2 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::state::borrow_mut<T0, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::RoundInfo<T0>>(arg2, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::new_round_key<T0>(arg4));
        assert!(0x2::coin::value<T0>(&arg7) == arg5 * 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_ticket_price<T0>(v2), 103);
        let v3 = 0x2::tx_context::sender(arg9);
        assert!(0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::buyable<T0>(v2, 0x2::clock::timestamp_ms(arg8)), 102);
        let v4 = 1;
        let v5 = 0x1::vector::empty<u64>();
        loop {
            let v6 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::get_total_tickets<T0>(v2) + v4;
            if (v4 > arg5) {
                break
            };
            let v7 = 0x1::vector::empty<u8>();
            let v8 = 0;
            loop {
                if (v8 >= v1) {
                    break
                };
                0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&arg6, v8 + (v4 - 1) * v1));
                v8 = v8 + 1;
            };
            let (v9, v10) = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::new<T0>(v3, arg4, v6, v7, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_pool<T0>(arg1), arg9);
            0x2::transfer::public_transfer<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::Ticket<T0>>(v9, v3);
            0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::add_ticket<T0>(v2, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::new_ticket_key<T0>(arg4, v6), v10);
            0x1::vector::push_back<u64>(&mut v5, v6);
            v4 = v4 + 1;
        };
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round::add_user_tickets<T0>(v2, v3, v5);
        0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian::add_round_balance<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(arg7));
    }

    // decompiled from Move bytecode v6
}

