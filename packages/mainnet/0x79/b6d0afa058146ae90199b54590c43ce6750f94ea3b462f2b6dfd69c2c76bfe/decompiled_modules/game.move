module 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::game {
    struct WinPlayer has store {
        owner: address,
        ticket_num: u64,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        round: u64,
        max_number: u16,
        min_number: u16,
        win_number: 0x1::option::Option<u16>,
        win_player: vector<WinPlayer>,
        total_balance: 0x2::balance::Balance<T0>,
        pay_fee_bp: u16,
        win_fee_bp: u16,
        ticket_price: u64,
        ticket_num: u64,
        status: u8,
        create_at: u64,
        commit_end_at: u64,
        reveal_end_at: u64,
    }

    public(friend) fun add_pool_balance<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.total_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun add_ticket_commit<T0>(arg0: &mut Game<T0>, arg1: &mut 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::fee_collector::FeeCollector<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        let v0 = arg0.ticket_price;
        assert!(0x2::coin::value<T0>(&arg2) >= v0, 4);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::fee_collector::add_fee<T0>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, calculate_pay_fee(v0, arg0.pay_fee_bp)), arg3));
        0x2::balance::join<T0>(&mut arg0.total_balance, v1);
        arg0.ticket_num = arg0.ticket_num + 1;
    }

    public(friend) fun add_winner<T0>(arg0: &mut Game<T0>, arg1: address) {
        assert!(arg0.status == 1, 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<WinPlayer>(&arg0.win_player)) {
            let v1 = 0x1::vector::borrow_mut<WinPlayer>(&mut arg0.win_player, v0);
            if (v1.owner == arg1) {
                v1.ticket_num = v1.ticket_num + 1;
                return
            };
            v0 = v0 + 1;
        };
        let v2 = WinPlayer{
            owner      : arg1,
            ticket_num : 1,
        };
        0x1::vector::push_back<WinPlayer>(&mut arg0.win_player, v2);
    }

    public fun calculate_pay_fee(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun calculate_win_amount_per_ticket(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 - arg1) as u128) / (arg2 as u128)) as u64)
    }

    public fun calculate_win_fee(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public(friend) fun create_random_winner_number<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        arg0.win_number = 0x1::option::some<u16>(0x2::random::generate_u16_in_range(&mut v0, arg0.min_number, arg0.max_number));
        arg0.status = 1;
        arg0.commit_end_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun get_commit_end_time<T0>(arg0: &Game<T0>) : u64 {
        arg0.commit_end_at
    }

    public fun get_create_time<T0>(arg0: &Game<T0>) : u64 {
        arg0.create_at
    }

    public fun get_game_id<T0>(arg0: &Game<T0>) : 0x2::object::ID {
        0x2::object::id<Game<T0>>(arg0)
    }

    public fun get_game_status<T0>(arg0: &Game<T0>) : u8 {
        arg0.status
    }

    public fun get_message<T0>(arg0: &Game<T0>, arg1: 0x1::string::String) : vector<u8> {
        let v0 = get_win_number<T0>(arg0);
        assert!(0x1::option::is_some<u16>(&v0), 5);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, ((*0x1::option::borrow<u16>(&v0) / 256) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((*0x1::option::borrow<u16>(&v0) % 256) as u8));
        0x1::vector::append<u8>(&mut v1, *0x1::string::as_bytes(&arg1));
        v1
    }

    public fun get_reveal_end_time<T0>(arg0: &Game<T0>) : u64 {
        arg0.reveal_end_at
    }

    public fun get_ticket_price<T0>(arg0: &Game<T0>) : u64 {
        arg0.ticket_price
    }

    public fun get_total_balance<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_balance)
    }

    public fun get_total_winner_num<T0>(arg0: &Game<T0>) : u64 {
        0x1::vector::length<WinPlayer>(&arg0.win_player)
    }

    public fun get_total_winner_ticket_num<T0>(arg0: &Game<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<WinPlayer>(&arg0.win_player)) {
            v0 = v0 + 0x1::vector::borrow<WinPlayer>(&arg0.win_player, v1).ticket_num;
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_version<T0>(arg0: &Game<T0>) : u64 {
        arg0.version
    }

    public fun get_win_number<T0>(arg0: &Game<T0>) : 0x1::option::Option<u16> {
        arg0.win_number
    }

    public fun get_winner_ticket_num<T0>(arg0: &Game<T0>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<WinPlayer>(&arg0.win_player)) {
            let v1 = 0x1::vector::borrow<WinPlayer>(&arg0.win_player, v0);
            if (v1.owner == arg1) {
                return v1.ticket_num
            };
            v0 = v0 + 1;
        };
        0
    }

    public(friend) fun new_and_shared<T0>(arg0: u64, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u64, arg6: &mut 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::counter::Counter<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64) {
        let v0 = Game<T0>{
            id            : 0x2::object::new(arg8),
            version       : arg0,
            round         : 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::counter::get_count<T0>(arg6),
            max_number    : arg1,
            min_number    : arg2,
            win_number    : 0x1::option::none<u16>(),
            win_player    : 0x1::vector::empty<WinPlayer>(),
            total_balance : 0x2::balance::zero<T0>(),
            pay_fee_bp    : arg3,
            win_fee_bp    : arg4,
            ticket_price  : arg5,
            ticket_num    : 0,
            status        : 0,
            create_at     : 0x2::clock::timestamp_ms(arg7),
            commit_end_at : 0,
            reveal_end_at : 0,
        };
        0x2::transfer::public_share_object<Game<T0>>(v0);
        0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::counter::increment<T0>(arg6);
        (0x2::object::id<Game<T0>>(&v0), v0.create_at)
    }

    public(friend) fun set_version<T0>(arg0: &mut Game<T0>, arg1: u64) {
        arg0.version = arg1;
    }

    public(friend) fun to_happy_end_state<T0>(arg0: &mut Game<T0>, arg1: &mut 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::fee_collector::FeeCollector<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg0.status == 1, 5);
        let v0 = calculate_win_fee(0x2::balance::value<T0>(&arg0.total_balance), arg0.win_fee_bp);
        let v1 = calculate_win_amount_per_ticket(0x2::balance::value<T0>(&arg0.total_balance), v0, get_total_winner_ticket_num<T0>(arg0));
        0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::fee_collector::add_fee<T0>(arg1, 0x2::coin::take<T0>(&mut arg0.total_balance, v0, arg3));
        let v2 = 0;
        let v3 = get_total_winner_num<T0>(arg0);
        while (v2 < v3) {
            let v4 = 0x1::vector::borrow<WinPlayer>(&arg0.win_player, v2);
            if (v2 == v3 - 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_balance, 0x2::balance::value<T0>(&arg0.total_balance), arg3), v4.owner);
                break
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_balance, v1 * v4.ticket_num, arg3), v4.owner);
            v2 = v2 + 1;
        };
        arg0.status = 2;
        arg0.reveal_end_at = 0x2::clock::timestamp_ms(arg2);
        (v0, v1)
    }

    public(friend) fun to_sad_end_state<T0>(arg0: &mut Game<T0>, arg1: &mut 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::fee_collector::FeeCollector<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 5);
        0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::fee_collector::add_last_round_pool_balance<T0>(arg1, 0x2::coin::take<T0>(&mut arg0.total_balance, 0x2::balance::value<T0>(&arg0.total_balance), arg3));
        arg0.status = 3;
        arg0.reveal_end_at = 0x2::clock::timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v6
}

