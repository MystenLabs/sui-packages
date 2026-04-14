module 0x7b48b3fb0529d581ce414377df8b5dd6e3683e513f0d9caf71c2386c0bafdb24::lottery {
    struct LOTTERY has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Ticket<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        game_type: u8,
        numbers: vector<u8>,
        round_id: u64,
        timestamp: u64,
        game_name: 0x1::string::String,
    }

    struct Jackpot<phantom T0> has key {
        id: 0x2::object::UID,
        game_type: u8,
        balance: 0x2::balance::Balance<T0>,
        current_round: u64,
        last_draw_timestamp: u64,
        accumulated_rounds_no_winner: u64,
    }

    struct DrawResult<phantom T0> has key {
        id: 0x2::object::UID,
        game_type: u8,
        round_id: u64,
        winning_numbers: vector<u8>,
        prize_pool: 0x2::balance::Balance<T0>,
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

    public entry fun buy_ticket<T0>(arg0: u8, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut Jackpot<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
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
        assert!(0x2::coin::value<T0>(arg2) >= v3, 4);
        let v4 = 0x2::coin::split<T0>(arg2, v3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, v3 - v3 * 80 / 100, arg5), @0x97f21242460ebee4f3406aa4adf82d591bbb35ebfbf5595deee97213304920db);
        0x2::balance::join<T0>(&mut arg3.balance, 0x2::coin::into_balance<T0>(v4));
        let v5 = arg3.current_round;
        let v6 = 0x2::object::new(arg5);
        let v7 = if (arg0 == 0) {
            0x1::string::utf8(b"BitPlay")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Bitpass")
        } else {
            0x1::string::utf8(b"PowerBit")
        };
        let v8 = Ticket<T0>{
            id        : v6,
            owner     : 0x2::tx_context::sender(arg5),
            game_type : arg0,
            numbers   : arg1,
            round_id  : v5,
            timestamp : v0,
            game_name : v7,
        };
        0x2::transfer::transfer<Ticket<T0>>(v8, 0x2::tx_context::sender(arg5));
        let v9 = TicketPurchased{
            buyer     : 0x2::tx_context::sender(arg5),
            game_type : arg0,
            round_id  : v5,
            numbers   : copy_vector(&arg1),
            ticket_id : 0x2::object::uid_to_inner(&v6),
        };
        0x2::event::emit<TicketPurchased>(v9);
    }

    public entry fun claim_prize<T0>(arg0: Ticket<T0>, arg1: &mut DrawResult<T0>, arg2: &mut Jackpot<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.game_type == arg1.game_type, 5);
        assert!(arg0.game_type == arg1.game_type, 8);
        assert!(arg0.round_id == arg1.round_id, 7);
        assert!(!arg1.claimed, 10);
        assert!(is_winner(&arg0.numbers, &arg1.winning_numbers), 9);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.prize_pool), arg3), v0);
        arg1.claimed = true;
        arg2.accumulated_rounds_no_winner = 0;
        let v1 = PrizeClaimed{
            winner    : v0,
            game_type : arg1.game_type,
            round_id  : arg1.round_id,
            amount    : 0x2::balance::value<T0>(&arg1.prize_pool),
        };
        0x2::event::emit<PrizeClaimed>(v1);
        let Ticket {
            id        : v2,
            owner     : _,
            game_type : _,
            numbers   : _,
            round_id  : _,
            timestamp : _,
            game_name : _,
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

    public entry fun create_jackpot<T0>(arg0: &AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Jackpot<T0>{
            id                           : 0x2::object::new(arg2),
            game_type                    : arg1,
            balance                      : 0x2::balance::zero<T0>(),
            current_round                : 1,
            last_draw_timestamp          : 0,
            accumulated_rounds_no_winner : 0,
        };
        0x2::transfer::share_object<Jackpot<T0>>(v0);
    }

    public fun draw_deadline<T0>(arg0: &DrawResult<T0>) : u64 {
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

    public fun draw_is_claimed<T0>(arg0: &DrawResult<T0>) : bool {
        arg0.claimed
    }

    public fun draw_prize_amount<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.prize_pool)
    }

    public fun draw_winning_numbers<T0>(arg0: &DrawResult<T0>) : vector<u8> {
        copy_vector(&arg0.winning_numbers)
    }

    public entry fun execute_draw<T0>(arg0: &AdminCap, arg1: &mut Jackpot<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
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
        let v6 = DrawResult<T0>{
            id              : 0x2::object::new(arg4),
            game_type       : arg1.game_type,
            round_id        : v5,
            winning_numbers : v3,
            prize_pool      : 0x2::balance::withdraw_all<T0>(&mut arg1.balance),
            claimed         : false,
            draw_timestamp  : v0,
            claim_deadline  : v1,
        };
        0x2::transfer::share_object<DrawResult<T0>>(v6);
        arg1.current_round = arg1.current_round + 1;
        arg1.last_draw_timestamp = v0;
        arg1.accumulated_rounds_no_winner = arg1.accumulated_rounds_no_winner + 1;
        let v7 = DrawExecuted{
            game_type         : arg1.game_type,
            round_id          : v5,
            winning_numbers   : copy_vector(&v3),
            prize_pool_amount : 0x2::balance::value<T0>(&arg1.balance),
            claim_deadline    : v1,
        };
        0x2::event::emit<DrawExecuted>(v7);
    }

    fun init(arg0: LOTTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<LOTTERY>(arg0, arg1);
        let v2 = 0x2::display::new<Ticket<0x2::sui::SUI>>(&v1, arg1);
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Bittery Lottery Ticket"));
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Official Bittery Lottery ticket on Sui"));
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://bitteryapp.com/nft/ticket.png"));
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bitteryapp.com"));
        0x2::display::update_version<Ticket<0x2::sui::SUI>>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket<0x2::sui::SUI>>>(v2, 0x2::tx_context::sender(arg1));
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

    public fun jackpot_accumulated<T0>(arg0: &Jackpot<T0>) : u64 {
        arg0.accumulated_rounds_no_winner
    }

    public fun jackpot_balance<T0>(arg0: &Jackpot<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun jackpot_round<T0>(arg0: &Jackpot<T0>) : u64 {
        arg0.current_round
    }

    public entry fun reclaim_unclaimed_prize<T0>(arg0: &AdminCap, arg1: &mut DrawResult<T0>, arg2: &mut Jackpot<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < 10000000000000, 12);
        assert!(arg2.game_type == arg1.game_type, 5);
        assert!(!arg1.claimed, 10);
        assert!(v0 > arg1.claim_deadline, 11);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.prize_pool));
        arg1.claimed = true;
        let v1 = UnclaimedPrizeReclaimed{
            game_type : arg1.game_type,
            round_id  : arg1.round_id,
            amount    : 0x2::balance::value<T0>(&arg1.prize_pool),
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

