module 0x1e89f9ca1eff305e30969e80f73df9870b93734483fcc619bfac74a3e42c6793::lottery_v6 {
    struct LOTTERY_V6 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Jackpot<phantom T0> has key {
        id: 0x2::object::UID,
        game_type: u8,
        ticket_price: u64,
        balance: 0x2::balance::Balance<T0>,
        current_round: u64,
        round_start_ms: u64,
        sales_duration_ms: u64,
        close_buffer_ms: u64,
        reopen_buffer_ms: u64,
        participants: vector<address>,
        is_draw_pending: bool,
        draw_requested_at: u64,
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
        tier6_pool: 0x2::balance::Balance<T0>,
        tier5_pool: 0x2::balance::Balance<T0>,
        tier4_pool: 0x2::balance::Balance<T0>,
        tier3_pool: 0x2::balance::Balance<T0>,
        tier2_pool: 0x2::balance::Balance<T0>,
        tier1_pool: 0x2::balance::Balance<T0>,
        fallback_pool: 0x2::balance::Balance<T0>,
        tier6_total: u64,
        tier5_total: u64,
        tier4_total: u64,
        tier3_total: u64,
        tier2_total: u64,
        tier1_total: u64,
        fallback_total: u64,
        tier6_claims: u64,
        tier5_claims: u64,
        tier4_claims: u64,
        tier3_claims: u64,
        tier2_claims: u64,
        tier1_claims: u64,
        fallback_claims: u64,
        claimed_addresses: vector<address>,
        fallback_participants: vector<address>,
        is_fallback_mode: bool,
        claim_deadline: u64,
        next_round_open_ms: u64,
    }

    struct GameCreated has copy, drop {
        game_type: u8,
        ticket_price: u64,
        sales_duration_ms: u64,
        close_buffer_ms: u64,
        reopen_buffer_ms: u64,
    }

    struct TicketPurchased has copy, drop {
        buyer: address,
        game_type: u8,
        round_id: u64,
        numbers: vector<u8>,
        round_closes_at: u64,
    }

    struct DrawRequested has copy, drop {
        game_type: u8,
        round_id: u64,
        draw_available_at: u64,
    }

    struct DrawFinalized has copy, drop {
        game_type: u8,
        round_id: u64,
        winning_numbers: vector<u8>,
        caller_reward: u64,
        next_round_open_ms: u64,
    }

    struct PrizeClaimed has copy, drop {
        winner: address,
        game_type: u8,
        round_id: u64,
        tier: u8,
        amount: u64,
    }

    struct UnclaimedReclaimed has copy, drop {
        game_type: u8,
        round_id: u64,
        amount: u64,
    }

    public entry fun buy_ticket<T0>(arg0: u8, arg1: vector<u8>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut Jackpot<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = arg3.round_start_ms + arg3.sales_duration_ms;
        assert!(v0 >= arg3.round_start_ms, 19);
        assert!(v0 < v1, 6);
        assert!(!arg3.is_draw_pending, 8);
        assert!(arg3.game_type == arg0, 5);
        let v2 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v2, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 6, 2);
        let v3 = 0;
        while (v3 < 6) {
            assert!(*0x1::vector::borrow<u8>(&arg1, v3) <= 9, 3);
            v3 = v3 + 1;
        };
        let v4 = arg3.ticket_price;
        assert!(0x2::coin::value<T0>(arg2) >= v4, 4);
        let v5 = 0x2::coin::split<T0>(arg2, v4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, v4 - v4 * 80 / 100, arg5), @0x97f21242460ebee4f3406aa4adf82d591bbb35ebfbf5595deee97213304920db);
        0x2::balance::join<T0>(&mut arg3.balance, 0x2::coin::into_balance<T0>(v5));
        let v6 = 0x2::tx_context::sender(arg5);
        if (!0x1::vector::contains<address>(&arg3.participants, &v6)) {
            0x1::vector::push_back<address>(&mut arg3.participants, v6);
        };
        let v7 = arg3.current_round;
        let v8 = Ticket<T0>{
            id        : 0x2::object::new(arg5),
            game_type : arg0,
            round_id  : v7,
            numbers   : arg1,
            game_name : game_name(arg0),
        };
        0x2::transfer::transfer<Ticket<T0>>(v8, v6);
        let v9 = TicketPurchased{
            buyer           : v6,
            game_type       : arg0,
            round_id        : v7,
            numbers         : copy_vec_u8(&arg1),
            round_closes_at : v1,
        };
        0x2::event::emit<TicketPurchased>(v9);
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
        assert!(arg0.game_type == arg1.game_type, 12);
        assert!(arg0.round_id == arg1.round_id, 11);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg1.claim_deadline, 15);
        assert!(!0x1::vector::contains<address>(&arg1.claimed_addresses, &v0), 14);
        let v1 = calculate_tier(&arg0.numbers, &arg1.winning_numbers);
        let v2 = if (arg1.game_type == 2) {
            if (v1 == 0) {
                assert!(arg1.is_fallback_mode, 13);
                assert!(0x1::vector::contains<address>(&arg1.fallback_participants, &v0), 17);
                let v3 = 0x2::balance::value<T0>(&arg1.fallback_pool);
                assert!(v3 > 0, 18);
                let v4 = v3 / (0x1::vector::length<address>(&arg1.fallback_participants) - arg1.fallback_claims);
                arg1.fallback_claims = arg1.fallback_claims + 1;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fallback_pool, v4), arg3), v0);
                v4
            } else {
                arg1.is_fallback_mode = false;
                if (v1 >= 6) {
                    let v5 = 0x2::balance::value<T0>(&arg1.tier6_pool);
                    assert!(v5 > 0, 18);
                    let v6 = arg1.tier6_claims + 1;
                    let v7 = arg1.tier6_total / v6;
                    let v8 = v7;
                    if (v7 > v5) {
                        v8 = v5;
                    };
                    arg1.tier6_claims = v6;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tier6_pool, v8), arg3), v0);
                    v8
                } else if (v1 >= 5) {
                    let v9 = 0x2::balance::value<T0>(&arg1.tier5_pool);
                    assert!(v9 > 0, 18);
                    let v10 = arg1.tier5_claims + 1;
                    let v11 = arg1.tier5_total / v10;
                    let v12 = v11;
                    if (v11 > v9) {
                        v12 = v9;
                    };
                    arg1.tier5_claims = v10;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tier5_pool, v12), arg3), v0);
                    v12
                } else if (v1 >= 4) {
                    let v13 = 0x2::balance::value<T0>(&arg1.tier4_pool);
                    assert!(v13 > 0, 18);
                    let v14 = arg1.tier4_claims + 1;
                    let v15 = arg1.tier4_total / v14;
                    let v16 = v15;
                    if (v15 > v13) {
                        v16 = v13;
                    };
                    arg1.tier4_claims = v14;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tier4_pool, v16), arg3), v0);
                    v16
                } else if (v1 >= 3) {
                    let v17 = 0x2::balance::value<T0>(&arg1.tier3_pool);
                    assert!(v17 > 0, 18);
                    let v18 = arg1.tier3_claims + 1;
                    let v19 = arg1.tier3_total / v18;
                    let v20 = v19;
                    if (v19 > v17) {
                        v20 = v17;
                    };
                    arg1.tier3_claims = v18;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tier3_pool, v20), arg3), v0);
                    v20
                } else if (v1 >= 2) {
                    let v21 = 0x2::balance::value<T0>(&arg1.tier2_pool);
                    assert!(v21 > 0, 18);
                    let v22 = arg1.tier2_claims + 1;
                    let v23 = arg1.tier2_total / v22;
                    let v24 = v23;
                    if (v23 > v21) {
                        v24 = v21;
                    };
                    arg1.tier2_claims = v22;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tier2_pool, v24), arg3), v0);
                    v24
                } else {
                    let v25 = 0x2::balance::value<T0>(&arg1.tier1_pool);
                    assert!(v25 > 0, 18);
                    let v26 = arg1.tier1_claims + 1;
                    let v27 = arg1.tier1_total / v26;
                    let v28 = v27;
                    if (v27 > v25) {
                        v28 = v25;
                    };
                    arg1.tier1_claims = v26;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tier1_pool, v28), arg3), v0);
                    v28
                }
            }
        } else {
            assert!(v1 == 6, 13);
            let v29 = 0x2::balance::value<T0>(&arg1.tier6_pool);
            assert!(v29 > 0, 18);
            let v30 = arg1.tier6_claims + 1;
            let v31 = arg1.tier6_total / v30;
            let v32 = v31;
            if (v31 > v29) {
                v32 = v29;
            };
            arg1.tier6_claims = v30;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tier6_pool, v32), arg3), v0);
            v32
        };
        0x1::vector::push_back<address>(&mut arg1.claimed_addresses, v0);
        let v33 = PrizeClaimed{
            winner    : v0,
            game_type : arg1.game_type,
            round_id  : arg1.round_id,
            tier      : v1,
            amount    : v2,
        };
        0x2::event::emit<PrizeClaimed>(v33);
        let Ticket {
            id        : v34,
            game_type : _,
            round_id  : _,
            numbers   : _,
            game_name : _,
        } = arg0;
        0x2::object::delete(v34);
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

    public entry fun create_game<T0>(arg0: &AdminCap, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 1);
        let v1 = GameCreated{
            game_type         : arg1,
            ticket_price      : arg2,
            sales_duration_ms : arg3,
            close_buffer_ms   : arg4,
            reopen_buffer_ms  : arg5,
        };
        0x2::event::emit<GameCreated>(v1);
        let v2 = Jackpot<T0>{
            id                : 0x2::object::new(arg7),
            game_type         : arg1,
            ticket_price      : arg2,
            balance           : 0x2::balance::zero<T0>(),
            current_round     : 1,
            round_start_ms    : 0x2::clock::timestamp_ms(arg6),
            sales_duration_ms : arg3,
            close_buffer_ms   : arg4,
            reopen_buffer_ms  : arg5,
            participants      : 0x1::vector::empty<address>(),
            is_draw_pending   : false,
            draw_requested_at : 0,
        };
        0x2::transfer::share_object<Jackpot<T0>>(v2);
    }

    public fun draw_deadline<T0>(arg0: &DrawResult<T0>) : u64 {
        arg0.claim_deadline
    }

    public fun draw_fallback_remaining<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fallback_pool)
    }

    public fun draw_is_fallback<T0>(arg0: &DrawResult<T0>) : bool {
        arg0.is_fallback_mode
    }

    public fun draw_tier1_remaining<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tier1_pool)
    }

    public fun draw_tier2_remaining<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tier2_pool)
    }

    public fun draw_tier3_remaining<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tier3_pool)
    }

    public fun draw_tier4_remaining<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tier4_pool)
    }

    public fun draw_tier5_remaining<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tier5_pool)
    }

    public fun draw_tier6_remaining<T0>(arg0: &DrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tier6_pool)
    }

    public fun draw_winning_numbers<T0>(arg0: &DrawResult<T0>) : vector<u8> {
        copy_vec_u8(&arg0.winning_numbers)
    }

    public entry fun finalize_draw<T0>(arg0: &mut Jackpot<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.is_draw_pending, 9);
        assert!(v0 >= arg0.round_start_ms + arg0.sales_duration_ms + arg0.close_buffer_ms, 10);
        let v1 = 0x2::random::new_generator(arg1, arg3);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 6) {
            0x1::vector::push_back<u8>(&mut v2, 0x2::random::generate_u8_in_range(&mut v1, 0, 9));
            v3 = v3 + 1;
        };
        let v4 = arg0.current_round;
        let v5 = arg0.game_type;
        let v6 = 0x2::balance::value<T0>(&arg0.balance);
        let v7 = v0 + arg0.reopen_buffer_ms;
        let v8 = v6 * 50 / 10000;
        if (v8 > 0 && v6 > v8) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v8), arg3), 0x2::tx_context::sender(arg3));
        };
        let v9 = 0x2::balance::value<T0>(&arg0.balance);
        if (v5 == 2) {
            let v10 = v9 * 50 / 100;
            let v11 = v9 * 20 / 100;
            let v12 = v9 * 15 / 100;
            let v13 = v9 * 10 / 100;
            let v14 = v9 * 3 / 100;
            let v15 = v9 * 2 / 100;
            let v16 = DrawFinalized{
                game_type          : v5,
                round_id           : v4,
                winning_numbers    : copy_vec_u8(&v2),
                caller_reward      : v8,
                next_round_open_ms : v7,
            };
            0x2::event::emit<DrawFinalized>(v16);
            let v17 = DrawResult<T0>{
                id                    : 0x2::object::new(arg3),
                game_type             : v5,
                round_id              : v4,
                winning_numbers       : v2,
                tier6_pool            : 0x2::balance::split<T0>(&mut arg0.balance, v10),
                tier5_pool            : 0x2::balance::split<T0>(&mut arg0.balance, v11),
                tier4_pool            : 0x2::balance::split<T0>(&mut arg0.balance, v12),
                tier3_pool            : 0x2::balance::split<T0>(&mut arg0.balance, v13),
                tier2_pool            : 0x2::balance::split<T0>(&mut arg0.balance, v14),
                tier1_pool            : 0x2::balance::split<T0>(&mut arg0.balance, v15),
                fallback_pool         : 0x2::balance::withdraw_all<T0>(&mut arg0.balance),
                tier6_total           : v10,
                tier5_total           : v11,
                tier4_total           : v12,
                tier3_total           : v13,
                tier2_total           : v14,
                tier1_total           : v15,
                fallback_total        : v9 - v10 - v11 - v12 - v13 - v14 - v15,
                tier6_claims          : 0,
                tier5_claims          : 0,
                tier4_claims          : 0,
                tier3_claims          : 0,
                tier2_claims          : 0,
                tier1_claims          : 0,
                fallback_claims       : 0,
                claimed_addresses     : 0x1::vector::empty<address>(),
                fallback_participants : copy_vec_address(&arg0.participants),
                is_fallback_mode      : 0x1::vector::length<address>(&arg0.participants) > 0,
                claim_deadline        : v0 + 2592000000,
                next_round_open_ms    : v7,
            };
            0x2::transfer::share_object<DrawResult<T0>>(v17);
        } else {
            let v18 = 0x2::balance::withdraw_all<T0>(&mut arg0.balance);
            let v19 = DrawFinalized{
                game_type          : v5,
                round_id           : v4,
                winning_numbers    : copy_vec_u8(&v2),
                caller_reward      : v8,
                next_round_open_ms : v7,
            };
            0x2::event::emit<DrawFinalized>(v19);
            let v20 = DrawResult<T0>{
                id                    : 0x2::object::new(arg3),
                game_type             : v5,
                round_id              : v4,
                winning_numbers       : v2,
                tier6_pool            : v18,
                tier5_pool            : 0x2::balance::zero<T0>(),
                tier4_pool            : 0x2::balance::zero<T0>(),
                tier3_pool            : 0x2::balance::zero<T0>(),
                tier2_pool            : 0x2::balance::zero<T0>(),
                tier1_pool            : 0x2::balance::zero<T0>(),
                fallback_pool         : 0x2::balance::zero<T0>(),
                tier6_total           : 0x2::balance::value<T0>(&v18),
                tier5_total           : 0,
                tier4_total           : 0,
                tier3_total           : 0,
                tier2_total           : 0,
                tier1_total           : 0,
                fallback_total        : 0,
                tier6_claims          : 0,
                tier5_claims          : 0,
                tier4_claims          : 0,
                tier3_claims          : 0,
                tier2_claims          : 0,
                tier1_claims          : 0,
                fallback_claims       : 0,
                claimed_addresses     : 0x1::vector::empty<address>(),
                fallback_participants : 0x1::vector::empty<address>(),
                is_fallback_mode      : false,
                claim_deadline        : v0 + 2592000000,
                next_round_open_ms    : v7,
            };
            0x2::transfer::share_object<DrawResult<T0>>(v20);
        };
        arg0.current_round = arg0.current_round + 1;
        arg0.round_start_ms = v7;
        arg0.is_draw_pending = false;
        arg0.draw_requested_at = 0;
        let v21 = &mut arg0.participants;
        clear_vec_address(v21);
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

    fun init(arg0: LOTTERY_V6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<LOTTERY_V6>(arg0, arg1);
        let v2 = 0x2::display::new<Ticket<0x2::sui::SUI>>(&v1, arg1);
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Bittery Lottery Ticket V6"));
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"4f6666696369616c2042697474657279204c6f7474657279207469636b657420e28094204175746f6e6f6d6f757320446563656e7472616c697a65642045646974696f6e"));
        0x2::display::add<Ticket<0x2::sui::SUI>>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://bitteryapp.com/nft/ticket-v6.png"));
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

    public fun jackpot_draw_time<T0>(arg0: &Jackpot<T0>) : u64 {
        arg0.round_start_ms + arg0.sales_duration_ms + arg0.close_buffer_ms
    }

    public fun jackpot_participants<T0>(arg0: &Jackpot<T0>) : u64 {
        0x1::vector::length<address>(&arg0.participants)
    }

    public fun jackpot_round<T0>(arg0: &Jackpot<T0>) : u64 {
        arg0.current_round
    }

    public fun jackpot_sales_close<T0>(arg0: &Jackpot<T0>) : u64 {
        arg0.round_start_ms + arg0.sales_duration_ms
    }

    public entry fun reclaim_unclaimed<T0>(arg0: &AdminCap, arg1: &mut DrawResult<T0>, arg2: &mut Jackpot<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.claim_deadline, 16);
        assert!(arg1.game_type == arg2.game_type, 5);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0x2::balance::value<T0>(&arg1.tier6_pool);
        if (v2 > 0) {
            v1 = v0 + v2;
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.tier6_pool));
        };
        let v3 = 0x2::balance::value<T0>(&arg1.tier5_pool);
        if (v3 > 0) {
            v1 = v1 + v3;
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.tier5_pool));
        };
        let v4 = 0x2::balance::value<T0>(&arg1.tier4_pool);
        if (v4 > 0) {
            v1 = v1 + v4;
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.tier4_pool));
        };
        let v5 = 0x2::balance::value<T0>(&arg1.tier3_pool);
        if (v5 > 0) {
            v1 = v1 + v5;
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.tier3_pool));
        };
        let v6 = 0x2::balance::value<T0>(&arg1.tier2_pool);
        if (v6 > 0) {
            v1 = v1 + v6;
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.tier2_pool));
        };
        let v7 = 0x2::balance::value<T0>(&arg1.tier1_pool);
        if (v7 > 0) {
            v1 = v1 + v7;
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.tier1_pool));
        };
        let v8 = 0x2::balance::value<T0>(&arg1.fallback_pool);
        if (v8 > 0) {
            v1 = v1 + v8;
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::withdraw_all<T0>(&mut arg1.fallback_pool));
        };
        if (v1 > 0) {
            let v9 = UnclaimedReclaimed{
                game_type : arg1.game_type,
                round_id  : arg1.round_id,
                amount    : v1,
            };
            0x2::event::emit<UnclaimedReclaimed>(v9);
        };
    }

    public entry fun request_draw<T0>(arg0: &mut Jackpot<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.round_start_ms + arg0.sales_duration_ms;
        assert!(!arg0.is_draw_pending, 8);
        assert!(v0 >= v1, 7);
        arg0.is_draw_pending = true;
        arg0.draw_requested_at = v0;
        let v2 = DrawRequested{
            game_type         : arg0.game_type,
            round_id          : arg0.current_round,
            draw_available_at : v1 + arg0.close_buffer_ms,
        };
        0x2::event::emit<DrawRequested>(v2);
    }

    // decompiled from Move bytecode v6
}

