module 0x16aa15e2d247f60ef016806cbca0890fdbe54f6366003679d86e06914049c1eb::holy_lottery {
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

    struct RoundExtended has copy, drop {
        round: u64,
        participants: u64,
    }

    public entry fun buy_tickets(arg0: &mut LotteryState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(arg3 <= 100, 4);
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2) > 0, 2);
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2) >= 1000000000000000, 5);
        let v0 = 500000000 * arg3;
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
        let v4 = 0;
        while (v4 < arg3) {
            0x1::vector::push_back<address>(&mut arg0.tickets, v3);
            v4 = v4 + 1;
        };
        let v5 = TicketPurchased{
            buyer          : v3,
            tickets_bought : arg3,
            round          : arg0.round,
        };
        0x2::event::emit<TicketPurchased>(v5);
    }

    fun count_unique_participants(arg0: &vector<address>) : u64 {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg0)) {
            let v2 = *0x1::vector::borrow<address>(arg0, v1);
            if (!0x1::vector::contains<address>(&v0, &v2)) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::length<address>(&v0)
    }

    public entry fun draw_winner(arg0: &mut LotteryState, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x1::vector::length<address>(&arg0.tickets);
        let v1 = count_unique_participants(&arg0.tickets);
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
        let v4 = *0x1::vector::borrow<address>(&arg0.tickets, 0x2::random::generate_u64_in_range(&mut v3, 0, v0));
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg2), v4);
        arg0.last_winner = v4;
        arg0.last_prize = v5;
        arg0.round = arg0.round + 1;
        arg0.tickets = 0x1::vector::empty<address>();
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
            id            : 0x2::object::new(arg0),
            tickets       : 0x1::vector::empty<address>(),
            prize_pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            house_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            round         : 1,
            last_winner   : @0x0,
            last_prize    : 0,
            admin         : 0x2::tx_context::sender(arg0),
            next_draw_at  : 0,
        };
        0x2::transfer::share_object<LotteryState>(v0);
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

    public entry fun withdraw_house(arg0: &mut LotteryState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.house_balance) == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.house_balance), arg1), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

