module 0xe14da14335e447badce718ab503f2bc7488dc2c26961a4d14eb2648e5bdda728::holy_lottery {
    struct LotteryState has key {
        id: 0x2::object::UID,
        tickets: vector<address>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        house_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        round: u64,
        last_winner: address,
        last_prize: u64,
        admin: address,
        next_draw_at: u64,
        jui_ticket_price: u64,
        unique_participants: u64,
        whale_bonus_round: 0x2::table::Table<address, u64>,
        draw_ready_at: u64,
        paid_round: 0x2::table::Table<address, u64>,
    }

    struct TicketPurchased has copy, drop {
        buyer: address,
        tickets_bought: u64,
        round: u64,
    }

    struct WinnerDrawn has copy, drop {
        winner: address,
        prize_mist: u64,
        round: u64,
    }

    struct JuiBurned has copy, drop {
        buyer: address,
        tickets_bought: u64,
        jui_amount: u64,
        round: u64,
    }

    struct RoundExtended has copy, drop {
        round: u64,
        participants: u64,
    }

    struct WhaleBonusAwarded has copy, drop {
        buyer: address,
        bonus_scrolls: u64,
        tier: u8,
        round: u64,
    }

    struct DrawScheduled has copy, drop {
        round: u64,
        draw_ready_at: u64,
    }

    struct FaithScrollsAdded has copy, drop {
        user: address,
        count: u64,
        round: u64,
    }

    struct PaidScrollsAdded has copy, drop {
        user: address,
        count: u64,
        round: u64,
    }

    struct FaithScrollsSpent has copy, drop {
        user: address,
        count: u64,
        round: u64,
    }

    struct PilgrimageCap has store, key {
        id: 0x2::object::UID,
    }

    struct TitheCap has store, key {
        id: 0x2::object::UID,
    }

    struct FaithBalance has key {
        id: 0x2::object::UID,
        owner: address,
        scrolls: u64,
    }

    public entry fun add_faith_scrolls(arg0: &mut LotteryState, arg1: &PilgrimageCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        if (!0x1::vector::contains<address>(&arg0.tickets, &arg2)) {
            arg0.unique_participants = arg0.unique_participants + 1;
        };
        let v0 = 0;
        while (v0 < arg3) {
            0x1::vector::push_back<address>(&mut arg0.tickets, arg2);
            v0 = v0 + 1;
        };
        let v1 = FaithScrollsAdded{
            user  : arg2,
            count : arg3,
            round : arg0.round,
        };
        0x2::event::emit<FaithScrollsAdded>(v1);
    }

    public entry fun add_paid_scrolls(arg0: &mut LotteryState, arg1: &TitheCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        if (!0x1::vector::contains<address>(&arg0.tickets, &arg2)) {
            arg0.unique_participants = arg0.unique_participants + 1;
        };
        let v0 = 0;
        while (v0 < arg3) {
            0x1::vector::push_back<address>(&mut arg0.tickets, arg2);
            v0 = v0 + 1;
        };
        let v1 = PaidScrollsAdded{
            user  : arg2,
            count : arg3,
            round : arg0.round,
        };
        0x2::event::emit<PaidScrollsAdded>(v1);
    }

    public entry fun admin_issue_faith_balance(arg0: &LotteryState, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg2 > 0, 3);
        let v0 = FaithBalance{
            id      : 0x2::object::new(arg3),
            owner   : arg1,
            scrolls : arg2,
        };
        0x2::transfer::transfer<FaithBalance>(v0, arg1);
    }

    fun apply_whale_bonus(arg0: &mut LotteryState, arg1: u64, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.whale_bonus_round, arg3)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.whale_bonus_round, arg3) = arg0.round;
        } else {
            0x2::table::add<address, u64>(&mut arg0.whale_bonus_round, arg3, arg0.round);
        };
        let v0 = 0;
        while (v0 < arg1) {
            0x1::vector::push_back<address>(&mut arg0.tickets, arg3);
            v0 = v0 + 1;
        };
        let v1 = WhaleBonusAwarded{
            buyer         : arg3,
            bonus_scrolls : arg1,
            tier          : arg2,
            round         : arg0.round,
        };
        0x2::event::emit<WhaleBonusAwarded>(v1);
    }

    public entry fun burn_faith_balance(arg0: FaithBalance, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 8);
        let FaithBalance {
            id      : v0,
            owner   : _,
            scrolls : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun burn_scroll(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(arg3 <= 100, 4);
        let v0 = arg0.jui_ticket_price * arg3;
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1) >= v0, 5);
        let v1 = 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1);
        if (0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut v1, v0), arg5), @0xf630fe565e79e3b5de154eefcc17409ba7bf54f68ffeeef692ed0dee96d70730);
        let v2 = 0x2::tx_context::sender(arg5);
        if (!0x1::vector::contains<address>(&arg0.tickets, &v2)) {
            arg0.unique_participants = arg0.unique_participants + 1;
        };
        let v3 = 0;
        while (v3 < arg3) {
            0x1::vector::push_back<address>(&mut arg0.tickets, v2);
            v3 = v3 + 1;
        };
        let v4 = TicketPurchased{
            buyer          : v2,
            tickets_bought : arg3,
            round          : arg0.round,
        };
        0x2::event::emit<TicketPurchased>(v4);
        let v5 = JuiBurned{
            buyer          : v2,
            tickets_bought : arg3,
            jui_amount     : v0,
            round          : arg0.round,
        };
        0x2::event::emit<JuiBurned>(v5);
        mark_paid_and_check_threshold(arg0, v2, arg4);
    }

    public entry fun burn_scroll_v2(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(arg3 <= 100, 4);
        let v0 = arg0.jui_ticket_price * arg3;
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1) >= v0, 5);
        let v1 = 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1);
        if (0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut v1, v0), arg5), @0xf630fe565e79e3b5de154eefcc17409ba7bf54f68ffeeef692ed0dee96d70730);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = !0x1::vector::contains<address>(&arg0.tickets, &v2);
        if (v3) {
            arg0.unique_participants = arg0.unique_participants + 1;
        };
        let v4 = 0;
        while (v4 < arg3) {
            0x1::vector::push_back<address>(&mut arg0.tickets, v2);
            v4 = v4 + 1;
        };
        let v5 = TicketPurchased{
            buyer          : v2,
            tickets_bought : arg3,
            round          : arg0.round,
        };
        0x2::event::emit<TicketPurchased>(v5);
        let v6 = JuiBurned{
            buyer          : v2,
            tickets_bought : arg3,
            jui_amount     : v0,
            round          : arg0.round,
        };
        0x2::event::emit<JuiBurned>(v6);
        mark_paid_and_check_threshold(arg0, v2, arg4);
        if (v3) {
            let (v7, v8) = check_whale_bonus(arg0, 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2), v2);
            if (v7 > 0) {
                apply_whale_bonus(arg0, v7, v8, v2, arg5);
            };
        };
    }

    fun check_whale_bonus(arg0: &LotteryState, arg1: u64, arg2: address) : (u64, u8) {
        if (arg1 < 1000000000000000) {
            return (0, 0)
        };
        if (0x2::table::contains<address, u64>(&arg0.whale_bonus_round, arg2) && *0x2::table::borrow<address, u64>(&arg0.whale_bonus_round, arg2) == arg0.round) {
            return (0, 0)
        };
        if (arg1 >= 30000000000000000) {
            (60, 4)
        } else if (arg1 >= 20000000000000000) {
            (25, 3)
        } else if (arg1 >= 10000000000000000) {
            (10, 2)
        } else {
            (1, 1)
        }
    }

    public entry fun collect_tithe(arg0: &mut LotteryState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.house_balance) == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.house_balance), arg1), arg0.admin);
    }

    public entry fun deposit_to_prize_pool(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = v0 * 90 / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 - v2));
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
    }

    public fun draw_ready_at(arg0: &LotteryState) : u64 {
        arg0.draw_ready_at
    }

    public entry fun force_close_round(arg0: &mut LotteryState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg1), arg0.admin);
        };
        arg0.round = arg0.round + 1;
        arg0.tickets = 0x1::vector::empty<address>();
        arg0.unique_participants = 0;
        arg0.draw_ready_at = 0;
        let v0 = RoundExtended{
            round        : arg0.round - 1,
            participants : 0,
        };
        0x2::event::emit<RoundExtended>(v0);
    }

    public fun get_round(arg0: &LotteryState) : u64 {
        arg0.round
    }

    public fun has_paid_ticket(arg0: &LotteryState, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.paid_round, arg1) && *0x2::table::borrow<address, u64>(&arg0.paid_round, arg1) == arg0.round
    }

    public fun house_balance_mist(arg0: &LotteryState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.house_balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryState{
            id                  : 0x2::object::new(arg0),
            tickets             : 0x1::vector::empty<address>(),
            prize_pool          : 0x2::balance::zero<0x2::sui::SUI>(),
            house_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            round               : 1,
            last_winner         : @0x0,
            last_prize          : 0,
            admin               : 0x2::tx_context::sender(arg0),
            next_draw_at        : 0,
            jui_ticket_price    : 100000000000000000,
            unique_participants : 0,
            whale_bonus_round   : 0x2::table::new<address, u64>(arg0),
            draw_ready_at       : 0,
            paid_round          : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<LotteryState>(v0);
    }

    public entry fun invoke_the_mountain(arg0: &mut LotteryState, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0.tickets);
        let v1 = arg0.unique_participants;
        let v2 = if (v1 < 5) {
            true
        } else if (arg0.draw_ready_at == 0) {
            true
        } else {
            0x2::clock::timestamp_ms(arg2) < arg0.draw_ready_at
        };
        if (v2) {
            let v3 = RoundExtended{
                round        : arg0.round,
                participants : v1,
            };
            0x2::event::emit<RoundExtended>(v3);
            return
        };
        assert!(v0 > 0, 3);
        let v4 = 0x2::random::new_generator(arg1, arg3);
        let v5 = *0x1::vector::borrow<address>(&arg0.tickets, 0x2::random::generate_u64_in_range(&mut v4, 0, v0 - 1));
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg3), v5);
        arg0.last_winner = v5;
        arg0.last_prize = v6;
        arg0.round = arg0.round + 1;
        arg0.tickets = 0x1::vector::empty<address>();
        arg0.unique_participants = 0;
        arg0.draw_ready_at = 0;
        let v7 = WinnerDrawn{
            winner     : v5,
            prize_mist : v6,
            round      : arg0.round - 1,
        };
        0x2::event::emit<WinnerDrawn>(v7);
    }

    public fun issue_faith_balance(arg0: &PilgrimageCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = FaithBalance{
            id      : 0x2::object::new(arg3),
            owner   : arg1,
            scrolls : arg2,
        };
        0x2::transfer::transfer<FaithBalance>(v0, arg1);
    }

    public entry fun issue_pilgrimage_cap(arg0: &LotteryState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        let v0 = PilgrimageCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<PilgrimageCap>(v0);
    }

    public entry fun issue_tithe_cap(arg0: &LotteryState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        let v0 = TitheCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<TitheCap>(v0);
    }

    public fun jui_ticket_price(arg0: &LotteryState) : u64 {
        arg0.jui_ticket_price
    }

    public fun last_prize(arg0: &LotteryState) : u64 {
        arg0.last_prize
    }

    public fun last_winner(arg0: &LotteryState) : address {
        arg0.last_winner
    }

    fun mark_paid_and_check_threshold(arg0: &mut LotteryState, arg1: address, arg2: &0x2::clock::Clock) {
        if (0x2::table::contains<address, u64>(&arg0.paid_round, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.paid_round, arg1) = arg0.round;
        } else {
            0x2::table::add<address, u64>(&mut arg0.paid_round, arg1, arg0.round);
        };
        if (arg0.unique_participants >= 5 && arg0.draw_ready_at == 0) {
            arg0.draw_ready_at = 0x2::clock::timestamp_ms(arg2) + 3600000;
            let v0 = DrawScheduled{
                round         : arg0.round,
                draw_ready_at : arg0.draw_ready_at,
            };
            0x2::event::emit<DrawScheduled>(v0);
        };
    }

    public entry fun merge_faith_balance(arg0: &mut FaithBalance, arg1: FaithBalance, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 8);
        assert!(arg0.owner == arg1.owner, 9);
        let FaithBalance {
            id      : v0,
            owner   : _,
            scrolls : v2,
        } = arg1;
        0x2::object::delete(v0);
        arg0.scrolls = arg0.scrolls + v2;
    }

    public fun prize_pool_mist(arg0: &LotteryState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun round(arg0: &LotteryState) : u64 {
        arg0.round
    }

    public entry fun seal_and_burn(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 + arg5 > 0, 3);
        assert!(arg4 + arg5 <= 100, 4);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = !0x1::vector::contains<address>(&arg0.tickets, &v0);
        let v2 = v1;
        if (arg4 > 0) {
            let v3 = 1000000000 * arg4;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 1);
            let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
            let v5 = v3 * 90 / 100;
            if (0x2::balance::value<0x2::sui::SUI>(&v4) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg7), v0);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v5));
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v3 - v5));
            if (v1) {
                arg0.unique_participants = arg0.unique_participants + 1;
            };
            let v6 = 0;
            while (v6 < arg4) {
                0x1::vector::push_back<address>(&mut arg0.tickets, v0);
                v6 = v6 + 1;
            };
            let v7 = TicketPurchased{
                buyer          : v0,
                tickets_bought : arg4,
                round          : arg0.round,
            };
            0x2::event::emit<TicketPurchased>(v7);
            if (v1) {
                let (v8, v9) = check_whale_bonus(arg0, 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg3), v0);
                if (v8 > 0) {
                    apply_whale_bonus(arg0, v8, v9, v0, arg7);
                };
                v2 = false;
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (arg5 > 0) {
            let v10 = arg0.jui_ticket_price * arg5;
            assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2) >= v10, 5);
            let v11 = 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2);
            if (0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v11) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v11, arg7), v0);
            } else {
                0x2::balance::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v11);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut v11, v10), arg7), @0xf630fe565e79e3b5de154eefcc17409ba7bf54f68ffeeef692ed0dee96d70730);
            if (v2) {
                arg0.unique_participants = arg0.unique_participants + 1;
            };
            let v12 = 0;
            while (v12 < arg5) {
                0x1::vector::push_back<address>(&mut arg0.tickets, v0);
                v12 = v12 + 1;
            };
            let v13 = TicketPurchased{
                buyer          : v0,
                tickets_bought : arg5,
                round          : arg0.round,
            };
            0x2::event::emit<TicketPurchased>(v13);
            let v14 = JuiBurned{
                buyer          : v0,
                tickets_bought : arg5,
                jui_amount     : v10,
                round          : arg0.round,
            };
            0x2::event::emit<JuiBurned>(v14);
        } else {
            0x2::coin::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2);
        };
        mark_paid_and_check_threshold(arg0, v0, arg6);
    }

    public entry fun seal_scroll(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(arg3 <= 100, 4);
        let v0 = 1000000000 * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = v0 * 90 / 100;
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 - v2));
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = !0x1::vector::contains<address>(&arg0.tickets, &v3);
        if (v4) {
            arg0.unique_participants = arg0.unique_participants + 1;
        };
        let v5 = 0;
        while (v5 < arg3) {
            0x1::vector::push_back<address>(&mut arg0.tickets, v3);
            v5 = v5 + 1;
        };
        let v6 = TicketPurchased{
            buyer          : v3,
            tickets_bought : arg3,
            round          : arg0.round,
        };
        0x2::event::emit<TicketPurchased>(v6);
        mark_paid_and_check_threshold(arg0, v3, arg4);
        if (v4) {
            let (v7, v8) = check_whale_bonus(arg0, 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2), v3);
            if (v7 > 0) {
                apply_whale_bonus(arg0, v7, v8, v3, arg5);
            };
        };
    }

    public entry fun seal_scroll_legacy(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2) > 0, 2);
        seal_scroll(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_scroll_price(arg0: &mut LotteryState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg1 > 0, 1);
        arg0.jui_ticket_price = arg1;
    }

    public entry fun spend_faith_scrolls(arg0: &mut FaithBalance, arg1: &mut LotteryState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 8);
        assert!(arg2 > 0 && arg2 <= arg0.scrolls, 3);
        let v0 = arg0.owner;
        assert!(0x2::table::contains<address, u64>(&arg1.paid_round, v0) && *0x2::table::borrow<address, u64>(&arg1.paid_round, v0) == arg1.round, 7);
        arg0.scrolls = arg0.scrolls - arg2;
        if (!0x1::vector::contains<address>(&arg1.tickets, &v0)) {
            arg1.unique_participants = arg1.unique_participants + 1;
        };
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<address>(&mut arg1.tickets, v0);
            v1 = v1 + 1;
        };
        let v2 = FaithScrollsSpent{
            user  : v0,
            count : arg2,
            round : arg1.round,
        };
        0x2::event::emit<FaithScrollsSpent>(v2);
    }

    public fun tickets_for(arg0: &LotteryState, arg1: address) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.tickets)) {
            if (*0x1::vector::borrow<address>(&arg0.tickets, v1) == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun total_tickets(arg0: &LotteryState) : u64 {
        0x1::vector::length<address>(&arg0.tickets)
    }

    public entry fun transfer_admin(arg0: &mut LotteryState, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public fun unique_participants(arg0: &LotteryState) : u64 {
        arg0.unique_participants
    }

    public fun whale_bonus_claimed(arg0: &LotteryState, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.whale_bonus_round, arg1) && *0x2::table::borrow<address, u64>(&arg0.whale_bonus_round, arg1) == arg0.round
    }

    // decompiled from Move bytecode v7
}

