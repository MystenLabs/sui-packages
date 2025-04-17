module 0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery {
    struct LotteryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotteryPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        no: u64,
        create_time: u64,
        status: u8,
        amount_deposit: u64,
        winner_ticket_id: 0x2::object::ID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        hold_on_time: u64,
        asset_index: 0x2::vec_map::VecMap<0x1::string::String, u8>,
    }

    struct JoinTicketInfo has copy, drop, store {
        ticket_number: 0x1::string::String,
        ticket_id: 0x2::object::ID,
        is_in_pool: bool,
    }

    struct Lottery has key {
        id: 0x2::object::UID,
        lottery_pool_id: 0x2::object::ID,
        round: u64,
        ticket_pool_id: 0x2::object::ID,
        index_ticket_number: 0x2::table::Table<u64, JoinTicketInfo>,
        ticket_number_index: 0x2::table::Table<0x1::string::String, u64>,
        index: u64,
        user_deposit: 0x2::linked_table::LinkedTable<address, u64>,
    }

    public entry fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::Ticket, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: &mut LotteryPool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::ticket_is_in_pool(arg3), 15);
        assert!(arg5.winner_ticket_id == 0x2::object::id<0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::Ticket>(arg3), 36);
        assert!(arg5.status == 2, 37);
        arg5.status = 3;
        let v0 = 0x2::tx_context::sender(arg6);
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_vault::claim_reward_entry<T0>(arg0, arg1, arg2, arg4, &v0, &arg5.account_cap, arg6);
    }

    fun createLotteryPool(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) : LotteryPool {
        let v0 = 0x2::vec_map::empty<0x1::string::String, u8>();
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0, 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"), 0);
        LotteryPool{
            id               : 0x2::object::new(arg2),
            name             : 0x1::string::utf8(b"LuckOneSui"),
            no               : arg0,
            create_time      : 0x2::clock::timestamp_ms(arg3),
            status           : 1,
            amount_deposit   : arg1,
            winner_ticket_id : 0x2::object::id_from_address(@0x0),
            account_cap      : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2),
            hold_on_time     : 86400000,
            asset_index      : v0,
        }
    }

    public entry fun drawLottery<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut Lottery, arg3: &mut LotteryPool, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 1, 38);
        assert!(0x2::clock::timestamp_ms(arg0) >= arg3.create_time + arg3.hold_on_time, 34);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg3.asset_index, v1), 12);
        let v2 = 0x2::random::new_generator(arg1, arg9);
        let v3 = 0x2::random::generate_u64_in_range(&mut v2, 0, 0x2::table::length<0x1::string::String, u64>(&arg2.ticket_number_index) - 1);
        while (!0x2::table::contains<u64, JoinTicketInfo>(&arg2.index_ticket_number, v3)) {
            v3 = 0x2::random::generate_u64_in_range(&mut v2, 0, 0x2::table::length<0x1::string::String, u64>(&arg2.ticket_number_index) - 1);
        };
        let v4 = 0x2::table::borrow<u64, JoinTicketInfo>(&arg2.index_ticket_number, v3);
        arg3.winner_ticket_id = v4.ticket_id;
        arg3.status = 2;
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_vault::get_reward_claimable_rewards<T0>(arg0, arg7, arg4, &arg3.account_cap, 0x2::object::id<LotteryPool>(arg3), arg3.no, v4.ticket_id, v4.ticket_number, arg9);
        let v5 = arg3.amount_deposit;
        let v6 = *0x2::vec_map::get<0x1::string::String, u8>(&arg3.asset_index, v1);
        let v7 = 0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_vault::withdraw<T1>(v6, &arg3.account_cap, v5, arg4, arg5, arg6, arg7, arg0, arg8, arg9);
        arg2.round = arg2.round + 1;
        let v8 = createLotteryPool(arg2.round, v5, arg9, arg0);
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_vault::deposit<T1>(v6, &v8.account_cap, v7, arg4, arg5, arg6, arg7, arg0);
        let v9 = 0x2::object::id<LotteryPool>(&v8);
        arg2.lottery_pool_id = v9;
        0x2::transfer::share_object<LotteryPool>(v8);
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_event::emit_lottery_start(v9, arg2.round, 0x2::linked_table::length<address, u64>(&arg2.user_deposit));
    }

    public entry fun exitLotteryPool<T0>(arg0: &mut Lottery, arg1: &mut LotteryPool, arg2: &mut 0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::Ticket, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::ticket_is_in_pool(arg2), 15);
        assert!(arg1.status == 1, 38);
        assert!(0x2::clock::timestamp_ms(arg7) < arg1.create_time + arg1.hold_on_time - 3600000, 35);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg1.asset_index, v1), 12);
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::removeTicket(arg2);
        let v2 = 0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::getMutTicketNumberSet(arg2);
        let v3 = 0x1::vector::length<0x1::string::String>(v2) * 1000000000;
        let v4 = v3;
        let v5 = 0x2::linked_table::borrow<address, u64>(&arg0.user_deposit, 0x2::tx_context::sender(arg9));
        let v6 = if (*v5 < v3) {
            v4 = *v5;
            0
        } else {
            *v5 - v3
        };
        arg1.amount_deposit = arg1.amount_deposit - v4;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::string::String>(v2)) {
            let v8 = 0x1::vector::borrow<0x1::string::String>(v2, v7);
            if (0x2::table::contains<0x1::string::String, u64>(&arg0.ticket_number_index, *v8)) {
                0x2::table::remove<u64, JoinTicketInfo>(&mut arg0.index_ticket_number, 0x2::table::remove<0x1::string::String, u64>(&mut arg0.ticket_number_index, *v8));
            };
            v7 = v7 + 1;
        };
        0x2::linked_table::remove<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg9));
        if (v6 > 0) {
            0x2::linked_table::push_back<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg9), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_vault::withdraw<T0>(*0x2::vec_map::get<0x1::string::String, u8>(&arg1.asset_index, v1), &arg1.account_cap, v4, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_event::emit_ticket_number_invalid(0x2::object::id<LotteryPool>(arg1), arg1.no, 0x2::object::id<0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::Ticket>(arg2), *v2, 0x2::tx_context::sender(arg9), v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryAdminCap{id: 0x2::object::new(arg0)};
        let v1 = Lottery{
            id                  : 0x2::object::new(arg0),
            lottery_pool_id     : 0x2::object::id_from_address(@0x1),
            round               : 1,
            ticket_pool_id      : 0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::createTicketPool(arg0),
            index_ticket_number : 0x2::table::new<u64, JoinTicketInfo>(arg0),
            ticket_number_index : 0x2::table::new<0x1::string::String, u64>(arg0),
            index               : 0,
            user_deposit        : 0x2::linked_table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Lottery>(v1);
        0x2::transfer::public_transfer<LotteryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun joinLotteryPool<T0>(arg0: &mut Lottery, arg1: &mut LotteryPool, arg2: &mut 0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::TicketPool, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 38);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg1.asset_index, v1), 12);
        let v2 = 0x2::coin::value<T0>(&arg3) / 1000000000;
        assert!(v2 > 0, 13);
        assert!(v2 <= 10, 13);
        assert!(0x2::coin::value<T0>(&arg3) % 1000000000 == 0, 13);
        let v3 = 0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::getTicket(arg2, arg1.no, arg9, arg10);
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::addTicketNumber(&mut v3, arg1.no, v2, arg8);
        let v4 = 0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::getTicketNumberSet(&v3);
        let v5 = 0;
        let v6 = arg0.index;
        while (v5 < 0x1::vector::length<0x1::string::String>(v4)) {
            let v7 = 0x1::vector::borrow<0x1::string::String>(v4, v5);
            let v8 = JoinTicketInfo{
                ticket_number : *v7,
                ticket_id     : 0x2::object::id<0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::Ticket>(&v3),
                is_in_pool    : true,
            };
            0x2::table::add<u64, JoinTicketInfo>(&mut arg0.index_ticket_number, v6, v8);
            0x2::table::add<0x1::string::String, u64>(&mut arg0.ticket_number_index, *v7, v6);
            v6 = v6 + 1;
            v5 = v5 + 1;
        };
        arg0.index = v6;
        let v9 = 0x2::coin::value<T0>(&arg3);
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_vault::deposit<T0>(*0x2::vec_map::get<0x1::string::String, u8>(&arg1.asset_index, v1), &arg1.account_cap, arg3, arg4, arg7, arg6, arg5, arg8);
        if (0x2::linked_table::contains<address, u64>(&arg0.user_deposit, 0x2::tx_context::sender(arg10))) {
            0x2::linked_table::remove<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg10));
            0x2::linked_table::push_back<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg10), *0x2::linked_table::borrow<address, u64>(&arg0.user_deposit, 0x2::tx_context::sender(arg10)) + v9);
        } else {
            0x2::linked_table::push_back<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg10), v9);
        };
        arg1.amount_deposit = arg1.amount_deposit + v9;
        let v10 = 0x2::object::id<LotteryPool>(arg1);
        0x2::transfer::public_transfer<0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::Ticket>(v3, 0x2::tx_context::sender(arg10));
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_event::emit_generate_ticket(v10, arg1.no, 0x2::object::id<0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_ticket::Ticket>(&v3), 0x2::tx_context::sender(arg10));
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_event::emit_user_buy_ticket(v10, arg1.no, 0x2::tx_context::sender(arg10), v9);
    }

    public entry fun startFirstLottery(arg0: &LotteryAdminCap, arg1: &mut Lottery, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.lottery_pool_id == 0x2::object::id_from_address(@0x1), 11);
        let v0 = createLotteryPool(arg1.round, 0, arg3, arg2);
        let v1 = 0x2::object::id<LotteryPool>(&v0);
        arg1.lottery_pool_id = v1;
        0x2::transfer::share_object<LotteryPool>(v0);
        0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_event::emit_lottery_start(v1, v0.no, 0x2::linked_table::length<address, u64>(&arg1.user_deposit));
    }

    public entry fun stopLottery<T0>(arg0: &LotteryAdminCap, arg1: &mut Lottery, arg2: &mut LotteryPool, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = *0x2::vec_map::get<0x1::string::String, u8>(&arg2.asset_index, &v0);
        let (v2, v3) = 0x2::linked_table::pop_front<address, u64>(&mut arg1.user_deposit);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_vault::withdraw<T0>(v1, &arg2.account_cap, v3, arg3, arg4, arg5, arg6, arg8, arg7, arg9), v2);
        while (0x2::linked_table::length<address, u64>(&arg1.user_deposit) > 0) {
            let (v4, v5) = 0x2::linked_table::pop_front<address, u64>(&mut arg1.user_deposit);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x44c474d58214a660f8bd203fe9c4b6574311f752ee0666b45bf479fea99ec424::lottery_vault::withdraw<T0>(v1, &arg2.account_cap, v5, arg3, arg4, arg5, arg6, arg8, arg7, arg9), v4);
        };
        arg2.status = 4;
        arg1.lottery_pool_id = 0x2::object::id_from_address(@0x1);
        arg1.round = arg1.round + 1;
    }

    // decompiled from Move bytecode v6
}

