module 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::lottery {
    struct ClaimPrizeEvent<phantom T0> has copy, drop {
        sender: address,
        epoch: u64,
        ticket_number: u64,
        amount: u64,
        pool: 0x1::string::String,
    }

    public entry fun claim<T0>(arg0: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::version::Version, arg1: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::Configuration<T0>, arg2: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::State<T0>, arg3: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::Custodian<T0>, arg4: 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::Ticket<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::version::assert_current_version(arg0);
        assert!(!0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::is_claimed<T0>(&arg4), 106);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::get_epoch<T0>(&arg4);
        let v2 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::borrow<T0, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::RoundKey<T0>, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::RoundInfo<T0>>(arg2, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::new_round_key<T0>(v1));
        assert!(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::is_finished<T0>(v2), 102);
        let v3 = if (0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::is_error<T0>(v2)) {
            0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::get_price<T0>(&arg4)
        } else {
            let v4 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::utils::get_reward_level(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::get_winning_number<T0>(v2), 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::get_lottery_number<T0>(&arg4));
            assert!(v4 > 0, 104);
            0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::get_reward_by_level<T0>(v2, v4)
        };
        assert!(v3 > 0, 105);
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::ticket_claimed<T0>(&mut arg4, v3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::sub_round_balance<T0>(arg3, v1, v3), arg5), v0);
        let v5 = ClaimPrizeEvent<T0>{
            sender        : v0,
            epoch         : v1,
            ticket_number : 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::get_ticket_number<T0>(&arg4),
            amount        : v3,
            pool          : 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::get_pool<T0>(arg1),
        };
        0x2::event::emit<ClaimPrizeEvent<T0>>(v5);
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::burn<T0>(arg4);
    }

    fun do_purchase_tickets<T0>(arg0: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::Configuration<T0>, arg1: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::State<T0>, arg2: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::Custodian<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::get_current_epoch<T0>(arg1), 100);
        let v0 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::borrow_mut<T0, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::RoundKey<T0>, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::RoundInfo<T0>>(arg1, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::new_round_key<T0>(arg3));
        let v1 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::get_reward_breakdown<T0>(arg0);
        let v2 = 0x1::vector::length<u64>(&v1);
        assert!(arg5 > 0 && 0x1::vector::length<u8>(&arg6) == v2 * arg5, 101);
        assert!(0x2::coin::value<T0>(&arg7) == arg5 * arg4, 103);
        let v3 = 0x2::tx_context::sender(arg9);
        assert!(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::buyable<T0>(v0, 0x2::clock::timestamp_ms(arg8)), 102);
        let v4 = 1;
        let v5 = 0x1::vector::empty<u64>();
        loop {
            let v6 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::get_total_tickets<T0>(v0) + v4;
            if (v4 > arg5) {
                break
            };
            let v7 = 0x1::vector::empty<u8>();
            let v8 = 0;
            loop {
                if (v8 >= v2) {
                    break
                };
                0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&arg6, v8 + (v4 - 1) * v2));
                v8 = v8 + 1;
            };
            let (v9, v10) = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::new<T0>(v3, arg3, v6, v7, arg4, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::get_pool<T0>(arg0), arg9);
            0x2::transfer::public_transfer<0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::Ticket<T0>>(v9, v3);
            0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::add_ticket<T0>(v0, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket::new_ticket_key<T0>(arg3, v6), v10);
            0x1::vector::push_back<u64>(&mut v5, v6);
            v4 = v4 + 1;
        };
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::add_user_tickets<T0>(v0, v3, v5);
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::add_round_balance<T0>(arg2, arg3, 0x2::coin::into_balance<T0>(arg7));
    }

    public entry fun purchase_ticket_discount<T0, T1: store + key>(arg0: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::version::Version, arg1: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::Configuration<T0>, arg2: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::State<T0>, arg3: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::Custodian<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::kiosk::Kiosk, arg9: 0x2::object::ID, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg10) - 0x1e84464c622c0ba9ace8ed520bb7fdc83d63f788c30f8a7464cb929744c0313f::stake::get_staked_timestamp<T1>(arg8, arg9) >= 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::get_staked_time_to_discount<T0>(arg1), 107);
        let v0 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::get_ticket_price<T0>(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::borrow_mut<T0, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::RoundKey<T0>, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::RoundInfo<T0>>(arg2, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::new_round_key<T0>(arg4)));
        do_purchase_tickets<T0>(arg1, arg2, arg3, arg4, v0 - ((((v0 * 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::get_discount_percentage<T0>(arg1)) as u128) / 10000) as u64), arg5, arg6, arg7, arg10, arg11);
    }

    public entry fun purchase_tickets<T0>(arg0: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::version::Version, arg1: &0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::configuration::Configuration<T0>, arg2: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::State<T0>, arg3: &mut 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::custodian::Custodian<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::version::assert_current_version(arg0);
        let v0 = 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::get_ticket_price<T0>(0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state::borrow_mut<T0, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::RoundKey<T0>, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::RoundInfo<T0>>(arg2, 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::round::new_round_key<T0>(arg4)));
        do_purchase_tickets<T0>(arg1, arg2, arg3, arg4, v0, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

