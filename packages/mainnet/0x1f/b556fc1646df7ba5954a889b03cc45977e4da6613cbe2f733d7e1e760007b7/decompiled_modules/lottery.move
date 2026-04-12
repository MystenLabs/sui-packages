module 0x1fb556fc1646df7ba5954a889b03cc45977e4da6613cbe2f733d7e1e760007b7::lottery {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Ticket has key {
        id: 0x2::object::UID,
        owner: address,
        game_type: u8,
        numbers: vector<u8>,
        round_id: u64,
        timestamp: u64,
    }

    struct Jackpot has key {
        id: 0x2::object::UID,
        game_type: u8,
        balance: 0x2::balance::Balance<USDC>,
        current_round: u64,
        last_draw_timestamp: u64,
        accumulated_rounds_no_winner: u64,
    }

    struct DrawResult has key {
        id: 0x2::object::UID,
        game_type: u8,
        round_id: u64,
        winning_numbers: vector<u8>,
        prize_pool: 0x2::balance::Balance<USDC>,
        claimed: bool,
        draw_timestamp: u64,
        claim_deadline: u64,
    }

    struct TicketPurchased has copy, drop {
        buyer: address,
        game_type: u8,
        round_id: u64,
        numbers: vector<u8>,
        ticket_id: 0x2::object::ID,
    }

    struct DrawExecuted has copy, drop {
        game_type: u8,
        round_id: u64,
        winning_numbers: vector<u8>,
        prize_pool_amount: u64,
        claim_deadline: u64,
    }

    struct PrizeClaimed has copy, drop {
        winner: address,
        game_type: u8,
        round_id: u64,
        amount: u64,
    }

    struct UnclaimedPrizeReclaimed has copy, drop {
        game_type: u8,
        round_id: u64,
        amount: u64,
    }

    public fun buy_ticket(arg0: u8, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<USDC>, arg3: &mut Jackpot, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < 10000000000000, 12);
        assert!(arg3.game_type == arg0, 5);
        let v1 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v1, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 6, 2);
        let v2 = 0;
        while (v2 < 6) {
            assert!(*0x1::vector::borrow<u8>(&arg1, v2) <= 9, 3);
            v2 = v2 + 1;
        };
        let v3 = ticket_price(arg0);
        assert!(0x2::coin::value<USDC>(arg2) >= v3, 4);
        let v4 = 0x2::coin::split<USDC>(arg2, v3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut v4, v3 - v3 * 80 / 100, arg5), @0x97f21242460ebee4f3406aa4adf82d591bbb35ebfbf5595deee97213304920db);
        0x2::balance::join<USDC>(&mut arg3.balance, 0x2::coin::into_balance<USDC>(v4));
        let v5 = arg3.current_round;
        let v6 = 0x2::object::new(arg5);
        let v7 = Ticket{
            id        : v6,
            owner     : 0x2::tx_context::sender(arg5),
            game_type : arg0,
            numbers   : arg1,
            round_id  : v5,
            timestamp : v0,
        };
        0x2::transfer::transfer<Ticket>(v7, 0x2::tx_context::sender(arg5));
        let v8 = TicketPurchased{
            buyer     : 0x2::tx_context::sender(arg5),
            game_type : arg0,
            round_id  : v5,
            numbers   : copy_vector(&arg1),
            ticket_id : 0x2::object::uid_to_inner(&v6),
        };
        0x2::event::emit<TicketPurchased>(v8);
    }

    public fun claim_prize(arg0: Ticket, arg1: &mut DrawResult, arg2: &mut Jackpot, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.game_type == arg1.game_type, 5);
        assert!(arg0.game_type == arg1.game_type, 8);
        assert!(arg0.round_id == arg1.round_id, 7);
        assert!(!arg1.claimed, 10);
        assert!(is_winner(&arg0.numbers, &arg1.winning_numbers), 9);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::from_balance<USDC>(0x2::balance::withdraw_all<USDC>(&mut arg1.prize_pool), arg3), v0);
        arg1.claimed = true;
        arg2.accumulated_rounds_no_winner = 0;
        let v1 = PrizeClaimed{
            winner    : v0,
            game_type : arg1.game_type,
            round_id  : arg1.round_id,
            amount    : 0x2::balance::value<USDC>(&arg1.prize_pool),
        };
        0x2::event::emit<PrizeClaimed>(v1);
        let Ticket {
            id        : v2,
            owner     : _,
            game_type : _,
            numbers   : _,
            round_id  : _,
            timestamp : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    fun copy_vector(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun create_jackpot(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Jackpot{
            id                           : 0x2::object::new(arg1),
            game_type                    : arg0,
            balance                      : 0x2::balance::zero<USDC>(),
            current_round                : 1,
            last_draw_timestamp          : 0,
            accumulated_rounds_no_winner : 0,
        };
        0x2::transfer::share_object<Jackpot>(v0);
    }

    public fun draw_claim_deadline(arg0: &DrawResult) : u64 {
        arg0.claim_deadline
    }

    fun draw_interval(arg0: u8) : u64 {
        if (arg0 == 0) {
            604800000
        } else if (arg0 == 1) {
            2592000000
        } else {
            604800000
        }
    }

    public fun draw_is_claimed(arg0: &DrawResult) : bool {
        arg0.claimed
    }

    public fun draw_prize_amount(arg0: &DrawResult) : u64 {
        0x2::balance::value<USDC>(&arg0.prize_pool)
    }

    public fun draw_winning_numbers(arg0: &DrawResult) : vector<u8> {
        copy_vector(&arg0.winning_numbers)
    }

    entry fun execute_draw(arg0: &AdminCap, arg1: &mut Jackpot, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < 10000000000000, 12);
        assert!(arg1.last_draw_timestamp == 0 || v0 >= arg1.last_draw_timestamp + draw_interval(arg1.game_type), 6);
        let v1 = v0 + 2592000000;
        let v2 = 0x2::random::new_generator(arg2, arg4);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 6) {
            0x1::vector::push_back<u8>(&mut v3, 0x2::random::generate_u8_in_range(&mut v2, 0, 9));
            v4 = v4 + 1;
        };
        let v5 = arg1.current_round;
        let v6 = DrawResult{
            id              : 0x2::object::new(arg4),
            game_type       : arg1.game_type,
            round_id        : v5,
            winning_numbers : v3,
            prize_pool      : 0x2::balance::withdraw_all<USDC>(&mut arg1.balance),
            claimed         : false,
            draw_timestamp  : v0,
            claim_deadline  : v1,
        };
        0x2::transfer::share_object<DrawResult>(v6);
        arg1.current_round = arg1.current_round + 1;
        arg1.last_draw_timestamp = v0;
        arg1.accumulated_rounds_no_winner = arg1.accumulated_rounds_no_winner + 1;
        let v7 = DrawExecuted{
            game_type         : arg1.game_type,
            round_id          : v5,
            winning_numbers   : copy_vector(&v3),
            prize_pool_amount : 0x2::balance::value<USDC>(&arg1.balance),
            claim_deadline    : v1,
        };
        0x2::event::emit<DrawExecuted>(v7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        create_jackpot(0, arg0);
        create_jackpot(1, arg0);
        create_jackpot(2, arg0);
    }

    fun is_winner(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 6) {
            return false
        };
        if (0x1::vector::length<u8>(arg1) != 6) {
            return false
        };
        let v0 = 0;
        while (v0 < 6) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun jackpot_accumulated_rounds(arg0: &Jackpot) : u64 {
        arg0.accumulated_rounds_no_winner
    }

    public fun jackpot_balance(arg0: &Jackpot) : u64 {
        0x2::balance::value<USDC>(&arg0.balance)
    }

    public fun jackpot_round(arg0: &Jackpot) : u64 {
        arg0.current_round
    }

    public fun reclaim_unclaimed_prize(arg0: &AdminCap, arg1: &mut DrawResult, arg2: &mut Jackpot, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < 10000000000000, 12);
        assert!(arg2.game_type == arg1.game_type, 5);
        assert!(!arg1.claimed, 10);
        assert!(v0 > arg1.claim_deadline, 11);
        0x2::balance::join<USDC>(&mut arg2.balance, 0x2::balance::withdraw_all<USDC>(&mut arg1.prize_pool));
        arg1.claimed = true;
        let v1 = UnclaimedPrizeReclaimed{
            game_type : arg1.game_type,
            round_id  : arg1.round_id,
            amount    : 0x2::balance::value<USDC>(&arg1.prize_pool),
        };
        0x2::event::emit<UnclaimedPrizeReclaimed>(v1);
    }

    fun ticket_price(arg0: u8) : u64 {
        if (arg0 == 0) {
            5000000
        } else if (arg0 == 1) {
            10000000
        } else {
            25000000
        }
    }

    // decompiled from Move bytecode v6
}

