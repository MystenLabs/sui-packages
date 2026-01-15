module 0x5d01d029d1c3098377937b776d446025e2a727f40d329ab50a35c6968cc2c69c::lottery {
    struct Ticket has store {
        player: address,
        numbers: vector<u64>,
    }

    struct Lottery has key {
        id: 0x2::object::UID,
        admin: address,
        fee_pool: 0x2::balance::Balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>,
        prize_pool: 0x2::balance::Balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>,
        tickets: vector<Ticket>,
        winning_numbers: vector<u64>,
        is_open_for_entries: bool,
        current_round: u64,
        history: vector<DrawResult>,
    }

    struct DrawResult has copy, drop, store {
        round_number: u64,
        winning_numbers: vector<u64>,
        prize_distributed: u64,
        winner_count: u64,
        winner: vector<address>,
        prize_per: u64,
    }

    struct LotClock has key {
        id: 0x2::object::UID,
        admin: address,
        start_time: u64,
        already_start: bool,
    }

    struct TicketPurchased has copy, drop {
        player: address,
        numbers: vector<u64>,
    }

    struct WinnersDrawn has copy, drop {
        winning_numbers: vector<u64>,
        winner_count: u64,
        prize_per_winner: u64,
    }

    struct PrizeDeposited has copy, drop {
        amount: u64,
    }

    struct PrizeWithdrawn has copy, drop {
        amount_withdrawn: u64,
    }

    entry fun admin_close_lottery(arg0: &mut Lottery, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.is_open_for_entries = false;
    }

    entry fun admin_open_lottery(arg0: &mut Lottery, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.is_open_for_entries = true;
    }

    entry fun collect_revenue(arg0: &mut Lottery, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>>(0x2::coin::take<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.fee_pool, 0x2::balance::value<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&arg0.fee_pool), arg1), arg0.admin);
    }

    entry fun deposit_prize(arg0: &mut Lottery, arg1: 0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::balance::join<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.prize_pool, 0x2::coin::into_balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(arg1));
        let v0 = PrizeDeposited{amount: 0x2::coin::value<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&arg1)};
        0x2::event::emit<PrizeDeposited>(v0);
    }

    entry fun distribute_prize(arg0: &mut Lottery, arg1: &mut LotClock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(!arg0.is_open_for_entries, 2);
        let v0 = find_winners(arg0);
        let v1 = 0x1::vector::length<address>(&v0);
        let v2 = 0;
        let v3 = 0;
        if (v1 > 0) {
            let v4 = 0x2::balance::value<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&arg0.prize_pool) / v1;
            v2 = v4;
            v3 = v4 * v1;
            let v5 = 0;
            while (v5 < v1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>>(0x2::coin::take<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.prize_pool, v4, arg3), *0x1::vector::borrow<address>(&v0, v5));
                v5 = v5 + 1;
            };
            let v6 = WinnersDrawn{
                winning_numbers  : arg0.winning_numbers,
                winner_count     : v1,
                prize_per_winner : v4,
            };
            0x2::event::emit<WinnersDrawn>(v6);
        };
        let v7 = DrawResult{
            round_number      : arg0.current_round,
            winning_numbers   : arg0.winning_numbers,
            prize_distributed : v3,
            winner_count      : v1,
            winner            : v0,
            prize_per         : v2,
        };
        0x1::vector::push_back<DrawResult>(&mut arg0.history, v7);
        reset_lottery(arg0);
        reset_timer(arg1, arg2, arg3);
    }

    fun do_numbers_match(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        if (0x1::vector::length<u64>(arg0) != 0x1::vector::length<u64>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            if (0x1::vector::borrow<u64>(arg1, v0) != 0x1::vector::borrow<u64>(arg0, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    entry fun draw_winning_numbers(arg0: &mut Lottery, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg0.is_open_for_entries, 1);
        assert!(!0x1::vector::is_empty<Ticket>(&arg0.tickets), 3);
        assert!(0x1::vector::is_empty<u64>(&arg0.winning_numbers), 8);
        arg0.is_open_for_entries = false;
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x1::vector::empty<u64>();
        while (0x1::vector::length<u64>(&v1) < 3) {
            0x1::vector::push_back<u64>(&mut v1, 0x2::random::generate_u64_in_range(&mut v0, 1, 25));
        };
        arg0.winning_numbers = v1;
    }

    entry fun emergency_withdraw_prize(arg0: &mut Lottery, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        assert!(!arg0.is_open_for_entries, 2);
        let v0 = 0x2::balance::value<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&arg0.prize_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>>(0x2::coin::take<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.prize_pool, v0, arg1), arg0.admin);
            let v1 = PrizeWithdrawn{amount_withdrawn: v0};
            0x2::event::emit<PrizeWithdrawn>(v1);
        };
    }

    fun find_winners(arg0: &Lottery) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &arg0.tickets;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Ticket>(v1)) {
            let v3 = 0x1::vector::borrow<Ticket>(v1, v2);
            if (do_numbers_match(&v3.numbers, &arg0.winning_numbers)) {
                0x1::vector::push_back<address>(&mut v0, v3.player);
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Lottery{
            id                  : 0x2::object::new(arg0),
            admin               : 0x2::tx_context::sender(arg0),
            fee_pool            : 0x2::balance::zero<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(),
            prize_pool          : 0x2::balance::zero<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(),
            tickets             : 0x1::vector::empty<Ticket>(),
            winning_numbers     : 0x1::vector::empty<u64>(),
            is_open_for_entries : true,
            current_round       : 1,
            history             : 0x1::vector::empty<DrawResult>(),
        };
        let v1 = LotClock{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            start_time    : 0,
            already_start : false,
        };
        0x2::transfer::share_object<LotClock>(v1);
        0x2::transfer::share_object<Lottery>(v0);
    }

    entry fun purchase_ticket(arg0: &mut Lottery, arg1: vector<u64>, arg2: 0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.is_open_for_entries, 1);
        assert!(0x2::coin::value<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&arg2) == 10000, 4);
        validate_ticket_numbers(&arg1);
        0x2::balance::join<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.fee_pool, 0x2::coin::into_balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(arg2));
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Ticket{
            player  : v0,
            numbers : arg1,
        };
        0x1::vector::push_back<Ticket>(&mut arg0.tickets, v1);
        let v2 = TicketPurchased{
            player  : v0,
            numbers : arg1,
        };
        0x2::event::emit<TicketPurchased>(v2);
    }

    fun reset_lottery(arg0: &mut Lottery) {
        while (!0x1::vector::is_empty<Ticket>(&arg0.tickets)) {
            let Ticket {
                player  : _,
                numbers : _,
            } = 0x1::vector::pop_back<Ticket>(&mut arg0.tickets);
        };
        arg0.winning_numbers = 0x1::vector::empty<u64>();
        arg0.is_open_for_entries = true;
        arg0.current_round = arg0.current_round + 1;
    }

    fun reset_timer(arg0: &mut LotClock, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.start_time = 0x2::clock::timestamp_ms(arg1);
    }

    entry fun start_lottery(arg0: &mut LotClock, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg0.already_start == false, 9);
        arg0.already_start = true;
        arg0.start_time = 0x2::clock::timestamp_ms(arg1);
    }

    fun validate_ticket_numbers(arg0: &vector<u64>) {
        assert!(0x1::vector::length<u64>(arg0) == 3, 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v1 = *0x1::vector::borrow<u64>(arg0, v0);
            assert!(v1 >= 1 && v1 <= 25, 6);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

