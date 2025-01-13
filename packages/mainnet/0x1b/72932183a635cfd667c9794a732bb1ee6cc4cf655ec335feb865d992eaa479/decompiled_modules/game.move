module 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game {
    struct PalyerResult has drop, store {
        owner: address,
        win_ticket_num: u64,
        lose_ticket_num: u64,
    }

    struct Ticket has drop, store {
        owner: address,
        number: u16,
    }

    struct Game<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u64,
        round: u64,
        max_number: u16,
        min_number: u16,
        win_number: 0x1::option::Option<u16>,
        result: 0x2::bag::Bag,
        total_balance: 0x2::balance::Balance<T0>,
        additional_amount: u64,
        lose_ticket_reward_balance: 0x2::balance::Balance<T1>,
        special_reward_balance: 0x2::balance::Balance<T1>,
        pay_fee_bp: u16,
        win_fee_bp: u16,
        ticket_price: u64,
        ticket_num: u64,
        win_ticket_num: u64,
        win_protocol_fee: u64,
        win_amount_per_ticket_t: u64,
        win_amount_per_ticket_s: u64,
        lose_amount_per_ticket_r: u64,
        tickets: vector<Ticket>,
        status: u8,
        create_at: u64,
        end_at: u64,
    }

    public(friend) fun add_pool_balance<T0, T1>(arg0: &mut Game<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        arg0.additional_amount = arg0.additional_amount + 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.total_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun add_tickets<T0, T1>(arg0: &mut Game<T0, T1>, arg1: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::FeeCollector<T0>, arg2: 0x2::balance::Balance<T0>, arg3: vector<u16>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 4);
        let v0 = arg0.ticket_price;
        let v1 = 0x1::vector::length<u16>(&arg3);
        assert!(0x2::balance::value<T0>(&arg2) >= v0 * v1, 3);
        0x2::balance::join<T0>(&mut arg0.total_balance, arg2);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::add_fee<T0>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_balance, calculate_pay_fee(v0, arg0.pay_fee_bp) * v1), arg5));
        arg0.ticket_num = arg0.ticket_num + v1;
        while (!0x1::vector::is_empty<u16>(&arg3)) {
            let v2 = Ticket{
                owner  : arg4,
                number : 0x1::vector::pop_back<u16>(&mut arg3),
            };
            0x1::vector::push_back<Ticket>(&mut arg0.tickets, v2);
        };
    }

    public(friend) fun calc_result<T0, T1>(arg0: &mut Game<T0, T1>) {
        assert!(arg0.status == 2, 4);
        let v0 = get_win_number<T0, T1>(arg0);
        let v1 = 0;
        let v2 = 0x1::option::borrow_with_default<u16>(&v0, &v1);
        while (!0x1::vector::is_empty<Ticket>(&arg0.tickets)) {
            let v3 = 0x1::vector::pop_back<Ticket>(&mut arg0.tickets);
            if (0x2::bag::contains<address>(&arg0.result, v3.owner)) {
                let v4 = 0x2::bag::borrow_mut<address, PalyerResult>(&mut arg0.result, v3.owner);
                let v5 = v3.number;
                if (&v5 == v2) {
                    arg0.win_ticket_num = arg0.win_ticket_num + 1;
                    v4.win_ticket_num = v4.win_ticket_num + 1;
                    continue
                };
                v4.lose_ticket_num = v4.lose_ticket_num + 1;
                continue
            };
            let v6 = v3.number;
            if (&v6 == v2) {
                arg0.win_ticket_num = arg0.win_ticket_num + 1;
                let v7 = PalyerResult{
                    owner           : v3.owner,
                    win_ticket_num  : 1,
                    lose_ticket_num : 0,
                };
                0x2::bag::add<address, PalyerResult>(&mut arg0.result, v3.owner, v7);
                continue
            };
            let v8 = PalyerResult{
                owner           : v3.owner,
                win_ticket_num  : 0,
                lose_ticket_num : 1,
            };
            0x2::bag::add<address, PalyerResult>(&mut arg0.result, v3.owner, v8);
        };
    }

    public fun calculate_pay_fee(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun calculate_win_amount_per_ticket_s(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun calculate_win_amount_per_ticket_t(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 - arg1) as u128) / (arg2 as u128)) as u64)
    }

    public fun calculate_win_fee(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public(friend) fun claim_reward<T0, T1>(arg0: &mut Game<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        assert!(arg0.status == 2, 4);
        assert!(0x2::bag::contains<address>(&arg0.result, arg1), 5);
        let v0 = 0x2::bag::borrow<address, PalyerResult>(&arg0.result, arg1);
        let v1 = v0.win_ticket_num;
        let v2 = v0.lose_ticket_num;
        let v3 = v1 * arg0.win_amount_per_ticket_t;
        let v4 = v1 * arg0.win_amount_per_ticket_s;
        let v5 = v2 * arg0.lose_amount_per_ticket_r;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_balance, v3, arg2), arg1);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.special_reward_balance, v4, arg2), arg1);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.lose_ticket_reward_balance, v5, arg2), arg1);
        };
        0x2::bag::remove<address, PalyerResult>(&mut arg0.result, arg1);
        (v1, v2, v3, v5, v4)
    }

    public(friend) fun create_random_winner_number<T0, T1>(arg0: &mut Game<T0, T1>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 4);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        arg0.win_number = 0x1::option::some<u16>(0x2::random::generate_u16_in_range(&mut v0, arg0.min_number, arg0.max_number));
        arg0.status = 2;
        arg0.end_at = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun distribute<T0, T1>(arg0: &mut Game<T0, T1>, arg1: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::FeeCollector<T0>, arg2: &mut 0x2::coin::TreasuryCap<T1>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 4);
        let v0 = get_total_winner_ticket_num<T0, T1>(arg0);
        if (v0 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_balance, 0x2::balance::value<T0>(&arg0.total_balance), arg4), arg3);
            0x2::coin::burn<T1>(arg2, 0x2::coin::take<T1>(&mut arg0.special_reward_balance, 0x2::balance::value<T1>(&arg0.special_reward_balance), arg4));
        } else {
            let v1 = calculate_win_fee(0x2::balance::value<T0>(&arg0.total_balance), arg0.win_fee_bp);
            arg0.win_protocol_fee = v1;
            arg0.win_amount_per_ticket_t = calculate_win_amount_per_ticket_t(0x2::balance::value<T0>(&arg0.total_balance), v1, v0);
            arg0.win_amount_per_ticket_s = calculate_win_amount_per_ticket_s(0x2::balance::value<T1>(&arg0.special_reward_balance), v0);
            0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::add_fee<T0>(arg1, 0x2::coin::take<T0>(&mut arg0.total_balance, v1, arg4));
        };
        0x2::balance::join<T1>(&mut arg0.lose_ticket_reward_balance, 0x2::coin::into_balance<T1>(0x2::coin::mint<T1>(arg2, (arg0.ticket_num - v0) * arg0.lose_amount_per_ticket_r, arg4)));
    }

    public fun get_create_time<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        arg0.create_at
    }

    public fun get_end_time<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        arg0.end_at
    }

    public fun get_game_id<T0, T1>(arg0: &Game<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Game<T0, T1>>(arg0)
    }

    public fun get_game_status<T0, T1>(arg0: &Game<T0, T1>) : u8 {
        arg0.status
    }

    public fun get_lose_ticket_reward_balance<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.lose_ticket_reward_balance)
    }

    public fun get_pool_balance<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.total_balance)
    }

    public fun get_special_reward_balance<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.special_reward_balance)
    }

    public fun get_ticket_price<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        arg0.ticket_price
    }

    public fun get_total_balance<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.total_balance)
    }

    public fun get_total_ticket_num<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        arg0.ticket_num
    }

    public fun get_total_winner_ticket_num<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        arg0.win_ticket_num
    }

    public fun get_version<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        arg0.version
    }

    public fun get_win_number<T0, T1>(arg0: &Game<T0, T1>) : 0x1::option::Option<u16> {
        arg0.win_number
    }

    public fun get_win_protocol_fee<T0, T1>(arg0: &Game<T0, T1>) : u64 {
        arg0.win_protocol_fee
    }

    public(friend) fun new_and_shared<T0, T1>(arg0: u64, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::counter::Counter<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64) {
        let v0 = Game<T0, T1>{
            id                         : 0x2::object::new(arg10),
            version                    : arg0,
            round                      : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::counter::get_count<T0>(arg8),
            max_number                 : arg1,
            min_number                 : arg2,
            win_number                 : 0x1::option::none<u16>(),
            result                     : 0x2::bag::new(arg10),
            total_balance              : 0x2::balance::zero<T0>(),
            additional_amount          : 0,
            lose_ticket_reward_balance : 0x2::balance::zero<T1>(),
            special_reward_balance     : 0x2::coin::into_balance<T1>(arg7),
            pay_fee_bp                 : arg3,
            win_fee_bp                 : arg4,
            ticket_price               : arg5,
            ticket_num                 : 0,
            win_ticket_num             : 0,
            win_protocol_fee           : 0,
            win_amount_per_ticket_t    : 0,
            win_amount_per_ticket_s    : 0,
            lose_amount_per_ticket_r   : arg6,
            tickets                    : 0x1::vector::empty<Ticket>(),
            status                     : 1,
            create_at                  : 0x2::clock::timestamp_ms(arg9),
            end_at                     : 0,
        };
        0x2::transfer::public_share_object<Game<T0, T1>>(v0);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::counter::increment<T0>(arg8);
        (0x2::object::id<Game<T0, T1>>(&v0), v0.create_at)
    }

    public(friend) fun set_version<T0, T1>(arg0: &mut Game<T0, T1>, arg1: u64) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

