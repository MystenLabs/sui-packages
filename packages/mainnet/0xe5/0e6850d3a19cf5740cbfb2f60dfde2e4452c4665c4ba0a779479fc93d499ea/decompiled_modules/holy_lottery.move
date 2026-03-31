module 0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery {
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

    struct PilgrimageCap has store, key {
        id: 0x2::object::UID,
    }

    struct TitheCap has store, key {
        id: 0x2::object::UID,
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

    public entry fun burn_scroll(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(arg3 <= 100, 4);
        let v0 = arg0.jui_ticket_price * arg3;
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1) >= v0, 5);
        let v1 = 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1);
        if (0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut v1, v0), arg4), @0xf630fe565e79e3b5de154eefcc17409ba7bf54f68ffeeef692ed0dee96d70730);
        let v2 = 0x2::tx_context::sender(arg4);
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
    }

    fun check_whale_bonus(arg0: &LotteryState, arg1: u64, arg2: address) : (u64, u8) {
        if (arg1 < 10000000000000000) {
            return (0, 0)
        };
        if (0x2::table::contains<address, u64>(&arg0.whale_bonus_round, arg2) && *0x2::table::borrow<address, u64>(&arg0.whale_bonus_round, arg2) == arg0.round) {
            return (0, 0)
        };
        if (arg1 >= 30000000000000000) {
            (4, 3)
        } else if (arg1 >= 20000000000000000) {
            (2, 2)
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

    public fun get_round(arg0: &LotteryState) : u64 {
        arg0.round
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
        };
        0x2::transfer::share_object<LotteryState>(v0);
    }

    public entry fun invoke_the_mountain(arg0: &mut LotteryState, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x1::vector::length<address>(&arg0.tickets);
        let v1 = arg0.unique_participants;
        if (v1 < 10) {
            let v2 = RoundExtended{
                round        : arg0.round,
                participants : v1,
            };
            0x2::event::emit<RoundExtended>(v2);
            return
        };
        assert!(v0 > 0, 3);
        let v3 = 0x2::random::new_generator(arg1, arg2);
        let v4 = *0x1::vector::borrow<address>(&arg0.tickets, 0x2::random::generate_u64_in_range(&mut v3, 0, v0 - 1));
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg2), v4);
        arg0.last_winner = v4;
        arg0.last_prize = v5;
        arg0.round = arg0.round + 1;
        arg0.tickets = 0x1::vector::empty<address>();
        arg0.unique_participants = 0;
        let v6 = WinnerDrawn{
            winner     : v4,
            prize_mist : v5,
            round      : arg0.round - 1,
        };
        0x2::event::emit<WinnerDrawn>(v6);
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

    public fun prize_pool_mist(arg0: &LotteryState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun round(arg0: &LotteryState) : u64 {
        arg0.round
    }

    public entry fun seal_and_burn(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 + arg5 > 0, 3);
        assert!(arg4 + arg5 <= 100, 4);
        let v0 = 0x2::tx_context::sender(arg6);
        if (arg4 > 0) {
            let v1 = 1000000000 * arg4;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 1);
            let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
            let v3 = v1 * 90 / 100;
            if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg6), v0);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1 - v3));
            let v4 = !0x1::vector::contains<address>(&arg0.tickets, &v0);
            if (v4) {
                arg0.unique_participants = arg0.unique_participants + 1;
            };
            let v5 = 0;
            while (v5 < arg4) {
                0x1::vector::push_back<address>(&mut arg0.tickets, v0);
                v5 = v5 + 1;
            };
            let v6 = TicketPurchased{
                buyer          : v0,
                tickets_bought : arg4,
                round          : arg0.round,
            };
            0x2::event::emit<TicketPurchased>(v6);
            if (v4) {
                let (v7, v8) = check_whale_bonus(arg0, 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg3), v0);
                if (v7 > 0) {
                    apply_whale_bonus(arg0, v7, v8, v0, arg6);
                };
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (arg5 > 0) {
            let v9 = arg0.jui_ticket_price * arg5;
            assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2) >= v9, 5);
            let v10 = 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2);
            if (0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v10) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v10, arg6), v0);
            } else {
                0x2::balance::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v10);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut v10, v9), arg6), @0xf630fe565e79e3b5de154eefcc17409ba7bf54f68ffeeef692ed0dee96d70730);
            if (!0x1::vector::contains<address>(&arg0.tickets, &v0)) {
                arg0.unique_participants = arg0.unique_participants + 1;
            };
            let v11 = 0;
            while (v11 < arg5) {
                0x1::vector::push_back<address>(&mut arg0.tickets, v0);
                v11 = v11 + 1;
            };
            let v12 = TicketPurchased{
                buyer          : v0,
                tickets_bought : arg5,
                round          : arg0.round,
            };
            0x2::event::emit<TicketPurchased>(v12);
            let v13 = JuiBurned{
                buyer          : v0,
                tickets_bought : arg5,
                jui_amount     : v9,
                round          : arg0.round,
            };
            0x2::event::emit<JuiBurned>(v13);
        } else {
            0x2::coin::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2);
        };
    }

    public entry fun seal_scroll(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(arg3 <= 100, 4);
        let v0 = 1000000000 * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = v0 * 90 / 100;
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 - v2));
        let v3 = 0x2::tx_context::sender(arg4);
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
        if (v4) {
            let (v7, v8) = check_whale_bonus(arg0, 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2), v3);
            if (v7 > 0) {
                apply_whale_bonus(arg0, v7, v8, v3, arg4);
            };
        };
    }

    public entry fun seal_scroll_legacy(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2) > 0, 2);
        seal_scroll(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_scroll_price(arg0: &mut LotteryState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg1 > 0, 1);
        arg0.jui_ticket_price = arg1;
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

    // decompiled from Move bytecode v6
}

