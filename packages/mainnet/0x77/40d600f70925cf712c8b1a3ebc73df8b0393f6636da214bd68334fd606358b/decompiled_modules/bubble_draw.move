module 0x7740d600f70925cf712c8b1a3ebc73df8b0393f6636da214bd68334fd606358b::bubble_draw {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BubbleDraw has key {
        id: 0x2::object::UID,
        round: u64,
        round_start: u64,
        bubble_count: u64,
        participants: vector<address>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_rounds: u64,
        total_paid_out: u64,
        total_bubbles_sold: u64,
        paused: bool,
    }

    struct BubblesPurchased has copy, drop {
        buyer: address,
        round: u64,
        bubble_count: u64,
        amount: u64,
    }

    struct DrawComplete has copy, drop {
        round: u64,
        winner: address,
        prize: u64,
        treasury_amount: u64,
        total_bubbles: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    entry fun buy_bubbles(arg0: &mut BubbleDraw, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(arg2 > 0, 1);
        assert!(arg2 <= 100, 4);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.round_start + 3300000, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = (((1000000000 as u128) * (arg2 as u128)) as u64);
        assert!(v0 >= v1, 2);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v0 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v0 - v1), arg4), 0x2::tx_context::sender(arg4));
        };
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::split<0x2::sui::SUI>(&mut v2, (((v3 as u128) * (7000 as u128) / (10000 as u128)) as u64)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v2);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = 0;
        while (v5 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.participants, v4);
            v5 = v5 + 1;
        };
        arg0.bubble_count = arg0.bubble_count + arg2;
        arg0.total_bubbles_sold = arg0.total_bubbles_sold + arg2;
        let v6 = BubblesPurchased{
            buyer        : v4,
            round        : arg0.round,
            bubble_count : arg2,
            amount       : v3,
        };
        0x2::event::emit<BubblesPurchased>(v6);
    }

    entry fun create_draw(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BubbleDraw{
            id                 : 0x2::object::new(arg2),
            round              : 1,
            round_start        : 0x2::clock::timestamp_ms(arg1),
            bubble_count       : 0,
            participants       : 0x1::vector::empty<address>(),
            pot                : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_rounds       : 0,
            total_paid_out     : 0,
            total_bubbles_sold : 0,
            paused             : false,
        };
        0x2::transfer::share_object<BubbleDraw>(v0);
    }

    entry fun draw_winner(arg0: &mut BubbleDraw, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.round_start + 3300000, 0);
        assert!(arg0.bubble_count > 0, 1);
        let v1 = 0x2::random::new_generator(arg1, arg3);
        let v2 = *0x1::vector::borrow<address>(&arg0.participants, 0x2::random::generate_u64_in_range(&mut v1, 0, arg0.bubble_count - 1));
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v3), arg3), v2);
        };
        let v4 = DrawComplete{
            round           : arg0.round,
            winner          : v2,
            prize           : v3,
            treasury_amount : 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury),
            total_bubbles   : arg0.bubble_count,
        };
        0x2::event::emit<DrawComplete>(v4);
        arg0.total_rounds = arg0.total_rounds + 1;
        arg0.total_paid_out = arg0.total_paid_out + v3;
        arg0.round = arg0.round + 1;
        arg0.round_start = v0;
        arg0.bubble_count = 0;
        arg0.participants = 0x1::vector::empty<address>();
    }

    entry fun emergency_withdraw(arg0: &mut BubbleDraw, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        let v2 = 0x2::tx_context::sender(arg2);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v0), arg2), v2);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v1), arg2), v2);
        };
    }

    public fun get_bubble_count(arg0: &BubbleDraw) : u64 {
        arg0.bubble_count
    }

    public fun get_pot_value(arg0: &BubbleDraw) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun get_round(arg0: &BubbleDraw) : u64 {
        arg0.round
    }

    public fun get_round_start(arg0: &BubbleDraw) : u64 {
        arg0.round_start
    }

    public fun get_total_bubbles_sold(arg0: &BubbleDraw) : u64 {
        arg0.total_bubbles_sold
    }

    public fun get_total_paid_out(arg0: &BubbleDraw) : u64 {
        arg0.total_paid_out
    }

    public fun get_total_rounds(arg0: &BubbleDraw) : u64 {
        arg0.total_rounds
    }

    public fun get_treasury_value(arg0: &BubbleDraw) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun set_paused(arg0: &mut BubbleDraw, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    entry fun skip_round(arg0: &mut BubbleDraw, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.round_start + 3300000, 0);
        assert!(arg0.bubble_count == 0, 5);
        arg0.round = arg0.round + 1;
        arg0.round_start = v0;
    }

    entry fun withdraw_treasury(arg0: &mut BubbleDraw, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        if (v0 > 0) {
            let v1 = 0x2::tx_context::sender(arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v0), arg2), v1);
            let v2 = TreasuryWithdrawn{
                amount    : v0,
                recipient : v1,
            };
            0x2::event::emit<TreasuryWithdrawn>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

