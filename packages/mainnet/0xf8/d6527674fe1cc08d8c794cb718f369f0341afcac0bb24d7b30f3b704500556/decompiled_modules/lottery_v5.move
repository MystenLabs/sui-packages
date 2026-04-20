module 0xf8d6527674fe1cc08d8c794cb718f369f0341afcac0bb24d7b30f3b704500556::lottery_v5 {
    struct LOTTERY_V5 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Jackpot<phantom T0> has key {
        id: 0x2::object::UID,
        game_type: u8,
        balance: 0x2::balance::Balance<T0>,
        current_round: u64,
        participants: vector<address>,
        is_draw_pending: bool,
    }

    struct Ticket<phantom T0> has key {
        id: 0x2::object::UID,
        game_type: u8,
        round_id: u64,
        numbers: vector<u8>,
        game_name: 0x1::string::String,
    }

    struct DrawResult<phantom T0> has key {
        id: 0x2::object::UID,
        game_type: u8,
        round_id: u64,
        winning_numbers: vector<u8>,
        prize_per_winner: u64,
        winning_tier: u8,
        is_fallback_mode: bool,
        fallback_participants: vector<address>,
        claimed_addresses: vector<address>,
        prize_pool: 0x2::balance::Balance<T0>,
        claim_deadline: u64,
    }

    struct TicketPurchased has copy, drop {
        buyer: address,
        game_type: u8,
        round_id: u64,
        numbers: vector<u8>,
    }

    struct DrawRequested has copy, drop {
        game_type: u8,
        round_id: u64,
    }

    struct DrawFinalized has copy, drop {
        game_type: u8,
        round_id: u64,
        winning_numbers: vector<u8>,
        winning_tier: u8,
        is_fallback_mode: bool,
        prize_per_winner: u64,
        total_winners: u64,
    }

    struct RoundAccumulated has copy, drop {
        game_type: u8,
        round_id: u64,
        accumulated_balance: u64,
    }

    struct PrizeClaimed has copy, drop {
        winner: address,
        game_type: u8,
        round_id: u64,
        amount: u64,
    }

    struct UnclaimedReclaimed has copy, drop {
        game_type: u8,
        round_id: u64,
        amount: u64,
    }

    public entry fun buy_ticket<T0>(arg0: u8, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut Jackpot<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.is_draw_pending, 6);
        assert!(arg3.game_type == arg0, 5);
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 6, 2);
        let v1 = 0;
        while (v1 < 6) {
            assert!(*0x1::vector::borrow<u8>(&arg1, v1) <= 9, 3);
            v1 = v1 + 1;
        };
        let v2 = ticket_price(arg0);
        assert!(0x2::coin::value<T0>(arg2) >= v2, 4);
        let v3 = 0x2::coin::split<T0>(arg2, v2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v2 - v2 * 80 / 100, arg4), @0x97f21242460ebee4f3406aa4adf82d591bbb35ebfbf5595deee97213304920db);
        0x2::balance::join<T0>(&mut arg3.balance, 0x2::coin::into_balance<T0>(v3));
        let v4 = 0x2::tx_context::sender(arg4);
        if (!0x1::vector::contains<address>(&arg3.participants, &v4)) {
            0x1::vector::push_back<address>(&mut arg3.participants, v4);
        };
        let v5 = arg3.current_round;
        let v6 = Ticket<T0>{
            id        : 0x2::object::new(arg4),
            game_type : arg0,
            round_id  : v5,
            numbers   : arg1,
            game_name : game_name(arg0),
        };
        0x2::transfer::transfer<Ticket<T0>>(v6, v4);
        let v7 = TicketPurchased{
            buyer     : v4,
            game_type : arg0,
            round_id  : v5,
            numbers   : copy_vec_u8(&arg1),
        };
        0x2::event::emit<TicketPurchased>(v7);
    }

    fun calculate_tier(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        while (v1 < 6 && !v2) {
            if (*0x1::vector::borrow<u8>(arg0, v1) == *0x1::vector::borrow<u8>(arg1, v1)) {
                v0 = v0 + 1;
            } else {
                v2 = true;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun claim_prize<T0>(arg0: Ticket<T0>, arg1: &mut DrawResult<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.game_type == arg1.game_type, 9);
        assert!(arg0.round_id == arg1.round_id, 8);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg1.claim_deadline, 12);
        assert!(!0x1::vector::contains<address>(&arg1.claimed_addresses, &v0), 11);
        if (arg1.is_fallback_mode) {
            assert!(0x1::vector::contains<address>(&arg1.fallback_participants, &v0), 14);
        } else {
            assert!(calculate_tier(&arg0.numbers, &arg1.winning_numbers) >= arg1.winning_tier, 10);
        };
        0x1::vector::push_back<address>(&mut arg1.claimed_addresses, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.prize_pool, arg1.prize_per_winner), arg3), v0);
        let v1 = PrizeClaimed{
            winner    : v0,
            game_type : arg1.game_type,
            round_id  : arg1.round_id,
            amount    : arg1.prize_per_winner,
        };
        0x2::event::emit<PrizeClaimed>(v1);
        let Ticket {
            id        : v2,
            game_type : _,
            round_id  : _,
            numbers   : _,
            game_name : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    fun clear_vec_address(arg0: &mut vector<address>) {
        while (!0x1::vector::is_empty<address>(arg0)) {
            0x1::vector::pop_back<address>(arg0);
        };
    }

    fun copy_vec_address(arg0: &vector<address>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg0)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun copy_vec_u8(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun create_game<T0>(arg0: &AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 1);
        let v1 = Jackpot<T0>{
            id              : 0x2::object::new(arg2),
            game_type       : arg1,
            balance         : 0x2::balance::zero<T0>(),
            current_round   : 1,
            participants    : 0x1::vector::empty<address>(),
            is_draw_pending : false,
        };
        0x2::transfer::share_object<Jackpot<T0>>(v1);
    }

    public fun draw_deadline<T0>(arg0: &DrawResult<T0>) : u64 {
        arg0.claim_deadline
    }

    public fun draw_is_fallback<T0>(arg0: &DrawResult<T0>) : bool {
        arg0.is_fallback_mode
    }

    public fun draw_pool_remaining<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.prize_pool)
    }

    public fun draw_prize_per<T0>(arg0: &DrawResult<T0>) : u64 {
        arg0.prize_per_winner
    }

    public fun draw_winning_numbers<T0>(arg0: &DrawResult<T0>) : vector<u8> {
        copy_vec_u8(&arg0.winning_numbers)
    }

    public fun draw_winning_tier<T0>(arg0: &DrawResult<T0>) : u8 {
        arg0.winning_tier
    }

    public entry fun finalize_draw<T0>(arg0: &mut Jackpot<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_draw_pending, 7);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 6) {
            0x1::vector::push_back<u8>(&mut v1, 0x2::random::generate_u8_in_range(&mut v0, 0, 9));
            v2 = v2 + 1;
        };
        let v3 = arg0.current_round;
        let v4 = arg0.game_type;
        if (v4 == 2) {
            let v5 = arg3 == 0;
            let v6 = if (v5) {
                0x1::vector::length<address>(&arg0.participants)
            } else {
                arg4
            };
            let v7 = if (v6 > 0) {
                0x2::balance::value<T0>(&arg0.balance) / v6
            } else {
                0
            };
            let v8 = DrawResult<T0>{
                id                    : 0x2::object::new(arg5),
                game_type             : v4,
                round_id              : v3,
                winning_numbers       : v1,
                prize_per_winner      : v7,
                winning_tier          : arg3,
                is_fallback_mode      : v5,
                fallback_participants : copy_vec_address(&arg0.participants),
                claimed_addresses     : 0x1::vector::empty<address>(),
                prize_pool            : 0x2::balance::withdraw_all<T0>(&mut arg0.balance),
                claim_deadline        : 0x2::clock::timestamp_ms(arg2) + 2592000000,
            };
            0x2::transfer::share_object<DrawResult<T0>>(v8);
            let v9 = DrawFinalized{
                game_type        : v4,
                round_id         : v3,
                winning_numbers  : copy_vec_u8(&v1),
                winning_tier     : arg3,
                is_fallback_mode : v5,
                prize_per_winner : v7,
                total_winners    : v6,
            };
            0x2::event::emit<DrawFinalized>(v9);
        } else if (arg4 > 0) {
            let v10 = 0x2::balance::value<T0>(&arg0.balance) / arg4;
            let v11 = DrawResult<T0>{
                id                    : 0x2::object::new(arg5),
                game_type             : v4,
                round_id              : v3,
                winning_numbers       : v1,
                prize_per_winner      : v10,
                winning_tier          : 6,
                is_fallback_mode      : false,
                fallback_participants : 0x1::vector::empty<address>(),
                claimed_addresses     : 0x1::vector::empty<address>(),
                prize_pool            : 0x2::balance::withdraw_all<T0>(&mut arg0.balance),
                claim_deadline        : 0x2::clock::timestamp_ms(arg2) + 2592000000,
            };
            0x2::transfer::share_object<DrawResult<T0>>(v11);
            let v12 = DrawFinalized{
                game_type        : v4,
                round_id         : v3,
                winning_numbers  : copy_vec_u8(&v1),
                winning_tier     : 6,
                is_fallback_mode : false,
                prize_per_winner : v10,
                total_winners    : arg4,
            };
            0x2::event::emit<DrawFinalized>(v12);
        } else {
            let v13 = RoundAccumulated{
                game_type           : v4,
                round_id            : v3,
                accumulated_balance : 0x2::balance::value<T0>(&arg0.balance),
            };
            0x2::event::emit<RoundAccumulated>(v13);
            let v14 = DrawFinalized{
                game_type        : v4,
                round_id         : v3,
                winning_numbers  : copy_vec_u8(&v1),
                winning_tier     : 0,
                is_fallback_mode : false,
                prize_per_winner : 0,
                total_winners    : 0,
            };
            0x2::event::emit<DrawFinalized>(v14);
        };
        arg0.current_round = arg0.current_round + 1;
        let v15 = &mut arg0.participants;
        clear_vec_address(v15);
        arg0.is_draw_pending = false;
    }

    fun game_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"BitPlay")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"BitPass")
        } else {
            0x1::string::utf8(b"PowerBit")
        }
    }

    fun init(arg0: LOTTERY_V5, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<LOTTERY_V5>(arg0, arg1);
        let v2 = 0x2::display::new<Ticket<0x2::sui::SUI>>(&v1, arg1);
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Bittery Lottery Ticket"));
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Official Bittery Lottery ticket on Sui"));
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://bitteryapp.com/nft/ticket.png"));
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bitteryapp.com"));
        0x2::display::update_version<Ticket<0x2::sui::SUI>>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket<0x2::sui::SUI>>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun jackpot_balance<T0>(arg0: &Jackpot<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun jackpot_draw_pending<T0>(arg0: &Jackpot<T0>) : bool {
        arg0.is_draw_pending
    }

    public fun jackpot_participants<T0>(arg0: &Jackpot<T0>) : u64 {
        0x1::vector::length<address>(&arg0.participants)
    }

    public fun jackpot_round<T0>(arg0: &Jackpot<T0>) : u64 {
        arg0.current_round
    }

    public entry fun reclaim_unclaimed<T0>(arg0: &AdminCap, arg1: &mut DrawResult<T0>, arg2: &mut Jackpot<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.claim_deadline, 13);
        assert!(arg1.game_type == arg2.game_type, 5);
        let v0 = 0x2::balance::value<T0>(&arg1.prize_pool);
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.prize_pool));
            let v1 = UnclaimedReclaimed{
                game_type : arg1.game_type,
                round_id  : arg1.round_id,
                amount    : v0,
            };
            0x2::event::emit<UnclaimedReclaimed>(v1);
        };
    }

    public entry fun request_draw<T0>(arg0: &mut Jackpot<T0>) {
        assert!(!arg0.is_draw_pending, 6);
        arg0.is_draw_pending = true;
        let v0 = DrawRequested{
            game_type : arg0.game_type,
            round_id  : arg0.current_round,
        };
        0x2::event::emit<DrawRequested>(v0);
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

