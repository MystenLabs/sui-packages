module 0xbe76959d2973b89415a7c6043bec9398b4003059ec256c8fb66daef29eb10f49::holy_lottery {
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

    public entry fun buy(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        buy_impl(arg0, arg1, arg2, arg3);
    }

    fun buy_impl(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        assert!(arg2 <= 100, 4);
        let v0 = 1000000000 * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = v0 * 90 / 100;
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 - v2));
        let v3 = 0x2::tx_context::sender(arg3);
        if (!0x1::vector::contains<address>(&arg0.tickets, &v3)) {
            arg0.unique_participants = arg0.unique_participants + 1;
        };
        let v4 = 0;
        while (v4 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.tickets, v3);
            v4 = v4 + 1;
        };
        let v5 = TicketPurchased{
            buyer          : v3,
            tickets_bought : arg2,
            round          : arg0.round,
        };
        0x2::event::emit<TicketPurchased>(v5);
    }

    public entry fun buy_mixed(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 + arg4 > 0, 3);
        assert!(arg3 + arg4 <= 100, 4);
        let v0 = 0x2::tx_context::sender(arg5);
        if (arg3 > 0) {
            let v1 = 1000000000 * arg3;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 1);
            let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
            let v3 = v1 * 90 / 100;
            if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg5), v0);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1 - v3));
            if (!0x1::vector::contains<address>(&arg0.tickets, &v0)) {
                arg0.unique_participants = arg0.unique_participants + 1;
            };
            let v4 = 0;
            while (v4 < arg3) {
                0x1::vector::push_back<address>(&mut arg0.tickets, v0);
                v4 = v4 + 1;
            };
            let v5 = TicketPurchased{
                buyer          : v0,
                tickets_bought : arg3,
                round          : arg0.round,
            };
            0x2::event::emit<TicketPurchased>(v5);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (arg4 > 0) {
            let v6 = arg0.jui_ticket_price * arg4;
            assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2) >= v6, 5);
            let v7 = 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2);
            if (0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v7, arg5), v0);
            } else {
                0x2::balance::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v7);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut v7, v6), arg5), @0xf630fe565e79e3b5de154eefcc17409ba7bf54f68ffeeef692ed0dee96d70730);
            if (!0x1::vector::contains<address>(&arg0.tickets, &v0)) {
                arg0.unique_participants = arg0.unique_participants + 1;
            };
            let v8 = 0;
            while (v8 < arg4) {
                0x1::vector::push_back<address>(&mut arg0.tickets, v0);
                v8 = v8 + 1;
            };
            let v9 = TicketPurchased{
                buyer          : v0,
                tickets_bought : arg4,
                round          : arg0.round,
            };
            0x2::event::emit<TicketPurchased>(v9);
            let v10 = JuiBurned{
                buyer          : v0,
                tickets_bought : arg4,
                jui_amount     : v6,
                round          : arg0.round,
            };
            0x2::event::emit<JuiBurned>(v10);
        } else {
            0x2::coin::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2);
        };
    }

    public entry fun buy_tickets(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2) > 0, 2);
        buy_impl(arg0, arg1, arg3, arg4);
    }

    public entry fun buy_with_jui(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        assert!(arg2 <= 100, 4);
        let v0 = arg0.jui_ticket_price * arg2;
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1) >= v0, 5);
        let v1 = 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1);
        if (0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut v1, v0), arg3), @0xf630fe565e79e3b5de154eefcc17409ba7bf54f68ffeeef692ed0dee96d70730);
        let v2 = 0x2::tx_context::sender(arg3);
        if (!0x1::vector::contains<address>(&arg0.tickets, &v2)) {
            arg0.unique_participants = arg0.unique_participants + 1;
        };
        let v3 = 0;
        while (v3 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.tickets, v2);
            v3 = v3 + 1;
        };
        let v4 = TicketPurchased{
            buyer          : v2,
            tickets_bought : arg2,
            round          : arg0.round,
        };
        0x2::event::emit<TicketPurchased>(v4);
        let v5 = JuiBurned{
            buyer          : v2,
            tickets_bought : arg2,
            jui_amount     : v0,
            round          : arg0.round,
        };
        0x2::event::emit<JuiBurned>(v5);
    }

    public entry fun draw_winner(arg0: &mut LotteryState, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
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
        };
        0x2::transfer::share_object<LotteryState>(v0);
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

    public entry fun set_jui_price(arg0: &mut LotteryState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
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

    public entry fun withdraw_house(arg0: &mut LotteryState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.house_balance) == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.house_balance), arg1), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

