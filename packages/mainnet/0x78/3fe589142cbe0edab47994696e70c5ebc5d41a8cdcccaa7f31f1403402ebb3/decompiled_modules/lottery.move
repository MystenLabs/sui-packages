module 0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery {
    struct LotteryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotteryPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        no: u64,
        create_time: u64,
        status: u8,
        user_deposit: 0x2::vec_map::VecMap<address, u64>,
        joined_ticket_numbers: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
        winner_ticket_id: 0x2::object::ID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        hold_on_time: u64,
        asset_index: 0x2::vec_map::VecMap<0x1::string::String, u8>,
    }

    struct Lottery has key {
        id: 0x2::object::UID,
        lottery_pool_id: 0x2::object::ID,
        ticket_pool_id: 0x2::object::ID,
    }

    public entry fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::Ticket, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: &mut LotteryPool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::ticket_is_in_pool(arg3), 15);
        assert!(arg5.winner_ticket_id == 0x2::object::id<0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::Ticket>(arg3), 36);
        assert!(arg5.status == 2, 37);
        arg5.status = 3;
        let v0 = 0x2::tx_context::sender(arg6);
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_vault::claim_reward_entry<T0>(arg0, arg1, arg2, arg4, &v0, &arg5.account_cap, arg6);
    }

    fun createLotteryPool(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x2::clock::Clock) : LotteryPool {
        let v0 = 0x2::vec_map::empty<0x1::string::String, u8>();
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0, 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"), 0);
        LotteryPool{
            id                    : 0x2::object::new(arg0),
            name                  : 0x1::string::utf8(b"LuckOneSui"),
            no                    : 1,
            create_time           : 0x2::clock::timestamp_ms(arg1),
            status                : 1,
            user_deposit          : 0x2::vec_map::empty<address, u64>(),
            joined_ticket_numbers : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
            winner_ticket_id      : 0x2::object::id_from_address(@0x0),
            account_cap           : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
            hold_on_time          : 86400000,
            asset_index           : v0,
        }
    }

    public entry fun drawLottery<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut Lottery, arg3: &mut LotteryPool, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 1, 38);
        assert!(0x2::clock::timestamp_ms(arg0) >= arg3.create_time + arg3.hold_on_time, 34);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg3.asset_index, v1), 12);
        let v2 = 0x2::random::new_generator(arg1, arg9);
        let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x2::object::ID>(&arg3.joined_ticket_numbers, 0x2::random::generate_u64_in_range(&mut v2, 0, 0x2::vec_map::size<0x1::string::String, 0x2::object::ID>(&arg3.joined_ticket_numbers) - 1));
        arg3.winner_ticket_id = *v4;
        arg3.status = 2;
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_vault::get_reward_claimable_rewards<T0>(arg0, arg7, arg4, &arg3.account_cap, 0x2::object::id<LotteryPool>(arg3), arg3.no, *v4, *v3, arg9);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x2::vec_map::size<address, u64>(&arg3.user_deposit)) {
            let (_, v8) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg3.user_deposit, v6);
            v5 = v5 + *v8;
            v6 = v6 + 1;
        };
        let v9 = *0x2::vec_map::get<0x1::string::String, u8>(&arg3.asset_index, v1);
        let v10 = 0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_vault::withdraw<T1>(v9, &arg3.account_cap, v5, arg4, arg5, arg6, arg7, arg0, arg8, arg9);
        let v11 = arg3.no + 1;
        let v12 = createLotteryPool(arg9, arg0);
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_vault::deposit<T1>(v9, &v12.account_cap, v10, arg4, arg5, arg6, arg7, arg0);
        v12.no = v11;
        let v13 = 0x2::object::id<LotteryPool>(&v12);
        arg2.lottery_pool_id = v13;
        0x2::transfer::share_object<LotteryPool>(v12);
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_event::emit_lottery_start(v13, v11, 0x2::vec_map::size<address, u64>(&v12.user_deposit));
    }

    public entry fun exitLotteryPool<T0>(arg0: &mut LotteryPool, arg1: &mut 0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::Ticket, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::ticket_is_in_pool(arg1), 15);
        assert!(arg0.status == 1, 38);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.create_time + arg0.hold_on_time - 3600000, 35);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.asset_index, v1), 12);
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::removeTicket(arg1);
        let v2 = 0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::getMutTicketNumberSet(arg1);
        let v3 = 0x1::vector::length<0x1::string::String>(v2) * 1000000000;
        let v4 = v3;
        let v5 = 0x2::tx_context::sender(arg8);
        let v6 = 0x2::vec_map::get<address, u64>(&arg0.user_deposit, &v5);
        let v7 = if (*v6 < v3) {
            v4 = *v6;
            0
        } else {
            *v6 - v3
        };
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::string::String>(v2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.joined_ticket_numbers, 0x1::vector::borrow<0x1::string::String>(v2, v8));
            v8 = v8 + 1;
        };
        let v11 = 0x2::tx_context::sender(arg8);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.user_deposit, &v11);
        if (v7 > 0) {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg8), v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_vault::withdraw<T0>(*0x2::vec_map::get<0x1::string::String, u8>(&arg0.asset_index, v1), &arg0.account_cap, v4, arg2, arg3, arg4, arg5, arg6, arg7, arg8), 0x2::tx_context::sender(arg8));
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_event::emit_ticket_number_invalid(0x2::object::id<LotteryPool>(arg0), arg0.no, 0x2::object::id<0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::Ticket>(arg1), *v2, 0x2::tx_context::sender(arg8), v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryAdminCap{id: 0x2::object::new(arg0)};
        let v1 = Lottery{
            id              : 0x2::object::new(arg0),
            lottery_pool_id : 0x2::object::id_from_address(@0x1),
            ticket_pool_id  : 0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::createTicketPool(arg0),
        };
        0x2::transfer::share_object<Lottery>(v1);
        0x2::transfer::public_transfer<LotteryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun joinLotteryPool<T0>(arg0: &mut LotteryPool, arg1: &mut 0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::TicketPool, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &0x2::clock::Clock, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 38);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.asset_index, v1), 12);
        let v2 = 0x2::coin::value<T0>(&arg2) / 1000000000;
        assert!(v2 > 0, 13);
        assert!(0x2::coin::value<T0>(&arg2) % 1000000000 == 0, 13);
        let v3 = 0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::getTicket(arg1, arg0.no, arg8, arg9);
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::addTicketNumber(&mut v3, arg0.no, v2, arg7);
        let v4 = 0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::getTicketNumberSet(&v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(v4)) {
            0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg0.joined_ticket_numbers, *0x1::vector::borrow<0x1::string::String>(v4, v5), 0x2::object::id<0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::Ticket>(&v3));
            v5 = v5 + 1;
        };
        let v6 = 0x2::coin::value<T0>(&arg2);
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_vault::deposit<T0>(*0x2::vec_map::get<0x1::string::String, u8>(&arg0.asset_index, v1), &arg0.account_cap, arg2, arg3, arg6, arg5, arg4, arg7);
        let v7 = 0x2::tx_context::sender(arg9);
        if (0x2::vec_map::contains<address, u64>(&arg0.user_deposit, &v7)) {
            let v8 = 0x2::tx_context::sender(arg9);
            let v9 = 0x2::tx_context::sender(arg9);
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.user_deposit, &v9);
            0x2::vec_map::insert<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg9), *0x2::vec_map::get<address, u64>(&arg0.user_deposit, &v8) + v6);
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg9), v6);
        };
        let v12 = 0x2::object::id<LotteryPool>(arg0);
        0x2::transfer::public_transfer<0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::Ticket>(v3, 0x2::tx_context::sender(arg9));
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_event::emit_generate_ticket(v12, arg0.no, 0x2::object::id<0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_ticket::Ticket>(&v3), 0x2::tx_context::sender(arg9));
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_event::emit_user_buy_ticket(v12, arg0.no, 0x2::tx_context::sender(arg9), v6);
    }

    public entry fun startFirstLottery(arg0: &LotteryAdminCap, arg1: &mut Lottery, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.lottery_pool_id == 0x2::object::id_from_address(@0x1), 11);
        let v0 = createLotteryPool(arg3, arg2);
        let v1 = 0x2::object::id<LotteryPool>(&v0);
        arg1.lottery_pool_id = v1;
        0x2::transfer::share_object<LotteryPool>(v0);
        0x783fe589142cbe0edab47994696e70c5ebc5d41a8cdcccaa7f31f1403402ebb3::lottery_event::emit_lottery_start(v1, v0.no, 0x2::vec_map::size<address, u64>(&v0.user_deposit));
    }

    // decompiled from Move bytecode v6
}

