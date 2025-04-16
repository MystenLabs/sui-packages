module 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery {
    struct LotteryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotteryPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        no: u64,
        create_time: u64,
        status: u8,
        user_deposit: 0x2::linked_table::LinkedTable<address, u64>,
        amount_deposit: u64,
        index_ticket_number: 0x2::table::Table<u128, JoinTicketInfo>,
        ticket_number_index: 0x2::table::Table<0x1::string::String, u128>,
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
        ticket_pool_id: 0x2::object::ID,
    }

    public entry fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::Ticket, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: &mut LotteryPool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::ticket_is_in_pool(arg3), 15);
        assert!(arg5.winner_ticket_id == 0x2::object::id<0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::Ticket>(arg3), 36);
        assert!(arg5.status == 2, 37);
        arg5.status = 3;
        let v0 = 0x2::tx_context::sender(arg6);
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_vault::claim_reward_entry<T0>(arg0, arg1, arg2, arg4, &v0, &arg5.account_cap, arg6);
    }

    fun createLotteryPool(arg0: u64, arg1: 0x2::linked_table::LinkedTable<address, u64>, arg2: 0x2::table::Table<u128, JoinTicketInfo>, arg3: 0x2::table::Table<0x1::string::String, u128>, arg4: &mut 0x2::tx_context::TxContext, arg5: &0x2::clock::Clock) : LotteryPool {
        let v0 = 0x2::vec_map::empty<0x1::string::String, u8>();
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0, 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"), 0);
        LotteryPool{
            id                  : 0x2::object::new(arg4),
            name                : 0x1::string::utf8(b"LuckOneSui"),
            no                  : 1,
            create_time         : 0x2::clock::timestamp_ms(arg5),
            status              : 1,
            user_deposit        : arg1,
            amount_deposit      : arg0,
            index_ticket_number : arg2,
            ticket_number_index : arg3,
            winner_ticket_id    : 0x2::object::id_from_address(@0x0),
            account_cap         : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg4),
            hold_on_time        : 86400000,
            asset_index         : v0,
        }
    }

    public entry fun drawLottery<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut Lottery, arg3: &mut LotteryPool, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 1, 38);
        assert!(0x2::clock::timestamp_ms(arg0) >= arg3.create_time + arg3.hold_on_time, 34);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg3.asset_index, v1), 12);
        let v2 = 0x2::random::new_generator(arg1, arg9);
        let v3 = 0x2::table::borrow<u128, JoinTicketInfo>(&arg3.index_ticket_number, (0x2::random::generate_u64_in_range(&mut v2, 0, 0x2::table::length<0x1::string::String, u128>(&arg3.ticket_number_index) - 1) as u128));
        arg3.winner_ticket_id = v3.ticket_id;
        arg3.status = 2;
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_vault::get_reward_claimable_rewards<T0>(arg0, arg7, arg4, &arg3.account_cap, 0x2::object::id<LotteryPool>(arg3), arg3.no, v3.ticket_id, v3.ticket_number, arg9);
        let v4 = arg3.amount_deposit;
        let v5 = *0x2::vec_map::get<0x1::string::String, u8>(&arg3.asset_index, v1);
        let v6 = 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_vault::withdraw<T1>(v5, &arg3.account_cap, v4, arg4, arg5, arg6, arg7, arg0, arg8, arg9);
        let v7 = arg3.no + 1;
        let v8 = 0x2::linked_table::new<address, u64>(arg9);
        let (v9, v10) = 0x2::linked_table::pop_front<address, u64>(&mut arg3.user_deposit);
        0x2::linked_table::push_back<address, u64>(&mut v8, v9, v10);
        while (0x2::linked_table::length<address, u64>(&arg3.user_deposit) > 0) {
            let (v11, v12) = 0x2::linked_table::pop_front<address, u64>(&mut arg3.user_deposit);
            0x2::linked_table::push_back<address, u64>(&mut v8, v11, v12);
        };
        let v13 = 0x2::table::new<u128, JoinTicketInfo>(arg9);
        let v14 = 0x2::table::new<0x1::string::String, u128>(arg9);
        let v15 = 0;
        let v16 = 0;
        while (v16 < 0x2::table::length<u128, JoinTicketInfo>(&arg3.index_ticket_number)) {
            let v17 = 0x2::table::borrow<u128, JoinTicketInfo>(&arg3.index_ticket_number, v15);
            if (v17.is_in_pool) {
                0x2::table::add<u128, JoinTicketInfo>(&mut v13, v15, *v17);
                0x2::table::add<0x1::string::String, u128>(&mut v14, v17.ticket_number, v15);
                v15 = v15 + 1;
            };
            v16 = v16 + 1;
        };
        let v18 = createLotteryPool(v4, v8, v13, v14, arg9, arg0);
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_vault::deposit<T1>(v5, &v18.account_cap, v6, arg4, arg5, arg6, arg7, arg0);
        v18.no = v7;
        let v19 = 0x2::object::id<LotteryPool>(&v18);
        arg2.lottery_pool_id = v19;
        0x2::transfer::share_object<LotteryPool>(v18);
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_event::emit_lottery_start(v19, v7, 0x2::linked_table::length<address, u64>(&v18.user_deposit));
    }

    public entry fun exitLotteryPool<T0>(arg0: &mut LotteryPool, arg1: &mut 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::Ticket, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::ticket_is_in_pool(arg1), 15);
        assert!(arg0.status == 1, 38);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.create_time + arg0.hold_on_time - 3600000, 35);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.asset_index, v1), 12);
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::removeTicket(arg1);
        let v2 = 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::getMutTicketNumberSet(arg1);
        let v3 = 0x1::vector::length<0x1::string::String>(v2) * 1000000000;
        let v4 = v3;
        let v5 = 0x2::linked_table::borrow<address, u64>(&arg0.user_deposit, 0x2::tx_context::sender(arg8));
        let v6 = if (*v5 < v3) {
            v4 = *v5;
            0
        } else {
            *v5 - v3
        };
        arg0.amount_deposit = arg0.amount_deposit - v4;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::string::String>(v2)) {
            let v8 = 0x1::vector::borrow<0x1::string::String>(v2, v7);
            if (0x2::table::contains<0x1::string::String, u128>(&arg0.ticket_number_index, *v8)) {
                0x2::table::remove<u128, JoinTicketInfo>(&mut arg0.index_ticket_number, 0x2::table::remove<0x1::string::String, u128>(&mut arg0.ticket_number_index, *v8));
            };
            v7 = v7 + 1;
        };
        0x2::linked_table::remove<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg8));
        if (v6 > 0) {
            0x2::linked_table::push_back<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg8), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_vault::withdraw<T0>(*0x2::vec_map::get<0x1::string::String, u8>(&arg0.asset_index, v1), &arg0.account_cap, v4, arg2, arg3, arg4, arg5, arg6, arg7, arg8), 0x2::tx_context::sender(arg8));
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_event::emit_ticket_number_invalid(0x2::object::id<LotteryPool>(arg0), arg0.no, 0x2::object::id<0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::Ticket>(arg1), *v2, 0x2::tx_context::sender(arg8), v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryAdminCap{id: 0x2::object::new(arg0)};
        let v1 = Lottery{
            id              : 0x2::object::new(arg0),
            lottery_pool_id : 0x2::object::id_from_address(@0x1),
            ticket_pool_id  : 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::createTicketPool(arg0),
        };
        0x2::transfer::share_object<Lottery>(v1);
        0x2::transfer::public_transfer<LotteryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun joinLotteryPool<T0>(arg0: &mut LotteryPool, arg1: &mut 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::TicketPool, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &0x2::clock::Clock, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 38);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = &v0;
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.asset_index, v1), 12);
        let v2 = 0x2::coin::value<T0>(&arg2) / 1000000000;
        assert!(v2 > 0, 13);
        assert!(0x2::coin::value<T0>(&arg2) % 1000000000 == 0, 13);
        let v3 = 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::getTicket(arg1, arg0.no, arg8, arg9);
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::addTicketNumber(&mut v3, arg0.no, v2, arg7);
        let v4 = 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::getTicketNumberSet(&v3);
        let v5 = 0;
        let v6 = (0x2::table::length<u128, JoinTicketInfo>(&arg0.index_ticket_number) as u128);
        while (v5 < 0x1::vector::length<0x1::string::String>(v4)) {
            let v7 = 0x1::vector::borrow<0x1::string::String>(v4, v5);
            let v8 = JoinTicketInfo{
                ticket_number : *v7,
                ticket_id     : 0x2::object::id<0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::Ticket>(&v3),
                is_in_pool    : true,
            };
            0x2::table::add<u128, JoinTicketInfo>(&mut arg0.index_ticket_number, v6, v8);
            0x2::table::add<0x1::string::String, u128>(&mut arg0.ticket_number_index, *v7, v6);
            v6 = v6 + 1;
            v5 = v5 + 1;
        };
        let v9 = 0x2::coin::value<T0>(&arg2);
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_vault::deposit<T0>(*0x2::vec_map::get<0x1::string::String, u8>(&arg0.asset_index, v1), &arg0.account_cap, arg2, arg3, arg6, arg5, arg4, arg7);
        if (0x2::linked_table::contains<address, u64>(&arg0.user_deposit, 0x2::tx_context::sender(arg9))) {
            0x2::linked_table::remove<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg9));
            0x2::linked_table::push_back<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg9), *0x2::linked_table::borrow<address, u64>(&arg0.user_deposit, 0x2::tx_context::sender(arg9)) + v9);
        } else {
            0x2::linked_table::push_back<address, u64>(&mut arg0.user_deposit, 0x2::tx_context::sender(arg9), v9);
        };
        arg0.amount_deposit = arg0.amount_deposit + v9;
        let v10 = 0x2::object::id<LotteryPool>(arg0);
        0x2::transfer::public_transfer<0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::Ticket>(v3, 0x2::tx_context::sender(arg9));
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_event::emit_generate_ticket(v10, arg0.no, 0x2::object::id<0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket::Ticket>(&v3), 0x2::tx_context::sender(arg9));
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_event::emit_user_buy_ticket(v10, arg0.no, 0x2::tx_context::sender(arg9), v9);
    }

    public entry fun startFirstLottery(arg0: &LotteryAdminCap, arg1: &mut Lottery, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.lottery_pool_id == 0x2::object::id_from_address(@0x1), 11);
        let v0 = 0x2::linked_table::new<address, u64>(arg3);
        let v1 = 0x2::table::new<u128, JoinTicketInfo>(arg3);
        let v2 = 0x2::table::new<0x1::string::String, u128>(arg3);
        let v3 = createLotteryPool(0, v0, v1, v2, arg3, arg2);
        let v4 = 0x2::object::id<LotteryPool>(&v3);
        arg1.lottery_pool_id = v4;
        0x2::transfer::share_object<LotteryPool>(v3);
        0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_event::emit_lottery_start(v4, v3.no, 0x2::linked_table::length<address, u64>(&v3.user_deposit));
    }

    public entry fun stop_lottery<T0>(arg0: &LotteryAdminCap, arg1: &mut Lottery, arg2: &mut LotteryPool, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = *0x2::vec_map::get<0x1::string::String, u8>(&arg2.asset_index, &v0);
        let (v2, v3) = 0x2::linked_table::pop_front<address, u64>(&mut arg2.user_deposit);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_vault::withdraw<T0>(v1, &arg2.account_cap, v3, arg3, arg4, arg5, arg6, arg8, arg7, arg9), v2);
        while (0x2::linked_table::length<address, u64>(&arg2.user_deposit) > 0) {
            let (v4, v5) = 0x2::linked_table::pop_front<address, u64>(&mut arg2.user_deposit);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_vault::withdraw<T0>(v1, &arg2.account_cap, v5, arg3, arg4, arg5, arg6, arg8, arg7, arg9), v4);
        };
        arg2.status = 4;
        arg1.lottery_pool_id = 0x2::object::id_from_address(@0x1);
    }

    // decompiled from Move bytecode v6
}

