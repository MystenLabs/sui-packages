module 0x2ef642c6a635604fdd4d41a5998823db3ce219518c2a7c87de8458a4ae1d11ea::betting_escrow {
    struct BETTING_ESCROW has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BettingRegistry has key {
        id: 0x2::object::UID,
        total_events: u64,
        total_volume: u64,
        total_payouts: u64,
    }

    struct BettingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        event_id: 0x1::string::String,
        admin: address,
        yes_pool: 0x2::balance::Balance<T0>,
        no_pool: 0x2::balance::Balance<T0>,
        yes_total: u64,
        no_total: u64,
        lock_time: u64,
        min_bet: u64,
        status: u8,
        created_at: u64,
    }

    struct BetReceipt has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        amount: u64,
        claimed: bool,
    }

    struct EventCreated has copy, drop {
        pool_id: 0x2::object::ID,
        event_id: 0x1::string::String,
        admin: address,
        lock_time: u64,
        min_bet: u64,
        timestamp: u64,
    }

    struct BetPlaced has copy, drop {
        pool_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        amount: u64,
        timestamp: u64,
    }

    struct EventResolved has copy, drop {
        pool_id: 0x2::object::ID,
        result: u8,
        yes_total: u64,
        no_total: u64,
        timestamp: u64,
    }

    struct WinningsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        bettor: address,
        bet_amount: u64,
        payout: u64,
        timestamp: u64,
    }

    struct RefundClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        bettor: address,
        refund_amount: u64,
        timestamp: u64,
    }

    public fun claim_refund<T0>(arg0: &mut BettingPool<T0>, arg1: &mut BetReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::uid_to_inner(&arg0.id), 9);
        assert!(!arg1.claimed, 6);
        assert!(arg0.status == 4, 7);
        let v0 = arg1.amount;
        let v1 = if (arg1.side == 0) {
            0x2::balance::split<T0>(&mut arg0.yes_pool, v0)
        } else {
            0x2::balance::split<T0>(&mut arg0.no_pool, v0)
        };
        arg1.claimed = true;
        let v2 = RefundClaimed{
            pool_id       : 0x2::object::uid_to_inner(&arg0.id),
            receipt_id    : 0x2::object::uid_to_inner(&arg1.id),
            bettor        : arg1.bettor,
            refund_amount : v0,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RefundClaimed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg1.bettor);
    }

    public fun claim_winnings<T0>(arg0: &mut BettingPool<T0>, arg1: &mut BetReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::uid_to_inner(&arg0.id), 9);
        assert!(!arg1.claimed, 6);
        let v0 = arg0.status == 2;
        let v1 = arg0.status == 3;
        assert!(v0 || v1, 3);
        assert!(v0 && arg1.side == 0 || v1 && arg1.side == 1, 5);
        let v2 = if (v0) {
            arg0.yes_total
        } else {
            arg0.no_total
        };
        assert!(v2 > 0, 10);
        let v3 = (((arg1.amount as u128) * ((0x2::balance::value<T0>(&arg0.yes_pool) + 0x2::balance::value<T0>(&arg0.no_pool)) as u128) / (v2 as u128)) as u64);
        let v4 = 0x2::balance::zero<T0>();
        if (v0) {
            let v5 = 0x2::balance::value<T0>(&arg0.no_pool);
            if (v5 > 0) {
                let v6 = if (v3 > v5) {
                    v5
                } else {
                    v3
                };
                0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg0.no_pool, v6));
            };
            let v7 = v3 - 0x2::balance::value<T0>(&v4);
            if (v7 > 0) {
                0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg0.yes_pool, v7));
            };
        } else {
            let v8 = 0x2::balance::value<T0>(&arg0.yes_pool);
            if (v8 > 0) {
                let v9 = if (v3 > v8) {
                    v8
                } else {
                    v3
                };
                0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg0.yes_pool, v9));
            };
            let v10 = v3 - 0x2::balance::value<T0>(&v4);
            if (v10 > 0) {
                0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg0.no_pool, v10));
            };
        };
        arg1.claimed = true;
        let v11 = WinningsClaimed{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            receipt_id : 0x2::object::uid_to_inner(&arg1.id),
            bettor     : arg1.bettor,
            bet_amount : arg1.amount,
            payout     : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WinningsClaimed>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg3), arg1.bettor);
    }

    public fun create_event<T0>(arg0: &AdminCap, arg1: &mut BettingRegistry, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = BettingPool<T0>{
            id         : v0,
            event_id   : arg2,
            admin      : 0x2::tx_context::sender(arg6),
            yes_pool   : 0x2::balance::zero<T0>(),
            no_pool    : 0x2::balance::zero<T0>(),
            yes_total  : 0,
            no_total   : 0,
            lock_time  : arg3,
            min_bet    : arg4,
            status     : 0,
            created_at : 0x2::clock::timestamp_ms(arg5),
        };
        arg1.total_events = arg1.total_events + 1;
        let v2 = EventCreated{
            pool_id   : 0x2::object::uid_to_inner(&v0),
            event_id  : v1.event_id,
            admin     : 0x2::tx_context::sender(arg6),
            lock_time : arg3,
            min_bet   : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<EventCreated>(v2);
        0x2::transfer::share_object<BettingPool<T0>>(v1);
    }

    public fun get_lock_time<T0>(arg0: &BettingPool<T0>) : u64 {
        arg0.lock_time
    }

    public fun get_min_bet<T0>(arg0: &BettingPool<T0>) : u64 {
        arg0.min_bet
    }

    public fun get_no_balance<T0>(arg0: &BettingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.no_pool)
    }

    public fun get_no_total<T0>(arg0: &BettingPool<T0>) : u64 {
        arg0.no_total
    }

    public fun get_pool_admin<T0>(arg0: &BettingPool<T0>) : address {
        arg0.admin
    }

    public fun get_pool_event_id<T0>(arg0: &BettingPool<T0>) : 0x1::string::String {
        arg0.event_id
    }

    public fun get_pool_status<T0>(arg0: &BettingPool<T0>) : u8 {
        arg0.status
    }

    public fun get_receipt_amount(arg0: &BetReceipt) : u64 {
        arg0.amount
    }

    public fun get_receipt_bettor(arg0: &BetReceipt) : address {
        arg0.bettor
    }

    public fun get_receipt_pool_id(arg0: &BetReceipt) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun get_receipt_side(arg0: &BetReceipt) : u8 {
        arg0.side
    }

    public fun get_total_events(arg0: &BettingRegistry) : u64 {
        arg0.total_events
    }

    public fun get_total_payouts(arg0: &BettingRegistry) : u64 {
        arg0.total_payouts
    }

    public fun get_total_volume(arg0: &BettingRegistry) : u64 {
        arg0.total_volume
    }

    public fun get_yes_balance<T0>(arg0: &BettingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.yes_pool)
    }

    public fun get_yes_total<T0>(arg0: &BettingPool<T0>) : u64 {
        arg0.yes_total
    }

    fun init(arg0: BETTING_ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = BettingRegistry{
            id            : 0x2::object::new(arg1),
            total_events  : 0,
            total_volume  : 0,
            total_payouts : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, @0x57adebad88a3bcab03807f9b25b10ff4fe77de976ca9b4b3b592c15e705eae62);
        0x2::transfer::transfer<AdminCap>(v1, @0x49214995f77cf38c2588df12d4d54a324c211e806567100694e39f07d34b8c2e);
        0x2::transfer::share_object<BettingRegistry>(v2);
    }

    public fun invalidate_event<T0>(arg0: &AdminCap, arg1: &mut BettingPool<T0>) {
        assert!(arg1.status == 0 || arg1.status == 1, 4);
        arg1.status = 4;
    }

    public fun is_pool_active<T0>(arg0: &BettingPool<T0>) : bool {
        arg0.status == 0
    }

    public fun is_pool_resolved<T0>(arg0: &BettingPool<T0>) : bool {
        arg0.status == 2 || arg0.status == 3
    }

    public fun is_receipt_claimed(arg0: &BetReceipt) : bool {
        arg0.claimed
    }

    public fun lock_betting<T0>(arg0: &AdminCap, arg1: &mut BettingPool<T0>) {
        assert!(arg1.status == 0, 2);
        arg1.status = 1;
    }

    public fun place_bet<T0>(arg0: &mut BettingRegistry, arg1: &mut BettingPool<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg1.lock_time, 2);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 >= arg1.min_bet, 8);
        if (arg2 == 0) {
            0x2::balance::join<T0>(&mut arg1.yes_pool, 0x2::coin::into_balance<T0>(arg3));
            arg1.yes_total = arg1.yes_total + v1;
        } else {
            0x2::balance::join<T0>(&mut arg1.no_pool, 0x2::coin::into_balance<T0>(arg3));
            arg1.no_total = arg1.no_total + v1;
        };
        arg0.total_volume = arg0.total_volume + v1;
        let v2 = 0x2::object::new(arg5);
        let v3 = BetReceipt{
            id      : v2,
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            bettor  : 0x2::tx_context::sender(arg5),
            side    : arg2,
            amount  : v1,
            claimed : false,
        };
        let v4 = BetPlaced{
            pool_id    : 0x2::object::uid_to_inner(&arg1.id),
            receipt_id : 0x2::object::uid_to_inner(&v2),
            bettor     : 0x2::tx_context::sender(arg5),
            side       : arg2,
            amount     : v1,
            timestamp  : v0,
        };
        0x2::event::emit<BetPlaced>(v4);
        0x2::transfer::transfer<BetReceipt>(v3, 0x2::tx_context::sender(arg5));
    }

    public fun resolve_event<T0>(arg0: &AdminCap, arg1: &mut BettingRegistry, arg2: &mut BettingPool<T0>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(arg2.status == 0 || arg2.status == 1, 4);
        if (arg3 == 0) {
            arg2.status = 2;
        } else {
            arg2.status = 3;
        };
        arg1.total_payouts = arg1.total_payouts + arg2.yes_total + arg2.no_total;
        let v0 = EventResolved{
            pool_id   : 0x2::object::uid_to_inner(&arg2.id),
            result    : arg3,
            yes_total : arg2.yes_total,
            no_total  : arg2.no_total,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EventResolved>(v0);
    }

    // decompiled from Move bytecode v6
}

