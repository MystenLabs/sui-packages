module 0x1744ad0bd8d88ce9b288f5d1eb57c9757d5916e7ad1f5ef2d0608dd55a41ddeb::lot {
    struct TicketBoughtEvent has copy, drop, store {
        pool: 0x2::object::ID,
        buyer: address,
        tickets: u64,
        timestamp_ms: u64,
    }

    struct PoolPausedEvent has copy, drop, store {
        pool: 0x2::object::ID,
    }

    struct PoolResumedEvent has copy, drop, store {
        pool: 0x2::object::ID,
    }

    struct PoolResetEvent has copy, drop, store {
        pool: 0x2::object::ID,
    }

    struct TimerStartedEvent has copy, drop, store {
        pool: 0x2::object::ID,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct WinnerRecordedEvent has copy, drop, store {
        pool: 0x2::object::ID,
        winner: address,
    }

    struct Purchase has drop, store {
        buyer: address,
        tickets: u64,
        timestamp_ms: u64,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        pool_type: u8,
        ticket_price: u64,
        dev_wallet: address,
        purchases: vector<Purchase>,
        start_time_ms: u64,
        end_time_ms: u64,
        last_winner: 0x1::option::Option<address>,
    }

    public entry fun buy_ticket(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2 >= 1, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.ticket_price * arg2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.dev_wallet);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v2 = Purchase{
            buyer        : v0,
            tickets      : arg2,
            timestamp_ms : v1,
        };
        0x1::vector::push_back<Purchase>(&mut arg0.purchases, v2);
        let v3 = TicketBoughtEvent{
            pool         : 0x2::object::id<Pool>(arg0),
            buyer        : v0,
            tickets      : arg2,
            timestamp_ms : v1,
        };
        0x2::event::emit<TicketBoughtEvent>(v3);
    }

    public entry fun clear_purchases(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 6);
        arg0.purchases = 0x1::vector::empty<Purchase>();
    }

    public fun get_pool_info(arg0: &Pool) : (u8, u64, address, u64, u64, &0x1::option::Option<address>, &vector<Purchase>) {
        (arg0.pool_type, arg0.ticket_price, arg0.dev_wallet, arg0.start_time_ms, arg0.end_time_ms, &arg0.last_winner, &arg0.purchases)
    }

    public entry fun init_pools(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 1);
        let v0 = Pool{
            id            : 0x2::object::new(arg0),
            pool_type     : 2,
            ticket_price  : 500000000,
            dev_wallet    : @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3,
            purchases     : 0x1::vector::empty<Purchase>(),
            start_time_ms : 0,
            end_time_ms   : 0,
            last_winner   : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = Pool{
            id            : 0x2::object::new(arg0),
            pool_type     : 12,
            ticket_price  : 500000000,
            dev_wallet    : @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3,
            purchases     : 0x1::vector::empty<Purchase>(),
            start_time_ms : 0,
            end_time_ms   : 0,
            last_winner   : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Pool>(v1);
    }

    public entry fun pause_pool(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 7);
        let v0 = PoolPausedEvent{pool: 0x2::object::id<Pool>(arg0)};
        0x2::event::emit<PoolPausedEvent>(v0);
    }

    public entry fun record_data(arg0: &mut Pool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 12);
        arg0.last_winner = 0x1::option::some<address>(arg1);
        let v0 = WinnerRecordedEvent{
            pool   : 0x2::object::id<Pool>(arg0),
            winner : arg1,
        };
        0x2::event::emit<WinnerRecordedEvent>(v0);
    }

    public entry fun reset_pool(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 9);
        arg0.purchases = 0x1::vector::empty<Purchase>();
        arg0.start_time_ms = 0;
        arg0.end_time_ms = 0;
        let v0 = PoolResetEvent{pool: 0x2::object::id<Pool>(arg0)};
        0x2::event::emit<PoolResetEvent>(v0);
    }

    public entry fun resume_pool(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 8);
        let v0 = PoolResumedEvent{pool: 0x2::object::id<Pool>(arg0)};
        0x2::event::emit<PoolResumedEvent>(v0);
    }

    public entry fun set_dev_wallet(arg0: &mut Pool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 5);
        arg0.dev_wallet = arg1;
    }

    public entry fun set_ticket_price(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 4);
        arg0.ticket_price = arg1;
    }

    public entry fun start_timer_twelve_hours(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 11);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        arg0.start_time_ms = v0;
        arg0.end_time_ms = v0 + 43200000;
        let v1 = TimerStartedEvent{
            pool          : 0x2::object::id<Pool>(arg0),
            start_time_ms : v0,
            end_time_ms   : arg0.end_time_ms,
        };
        0x2::event::emit<TimerStartedEvent>(v1);
    }

    public entry fun start_timer_two_hours(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xd260040dc09f031acc853f1f53222285448e2c0e0a75855dd9ad11eed61358a3, 10);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        arg0.start_time_ms = v0;
        arg0.end_time_ms = v0 + 7200000;
        let v1 = TimerStartedEvent{
            pool          : 0x2::object::id<Pool>(arg0),
            start_time_ms : v0,
            end_time_ms   : arg0.end_time_ms,
        };
        0x2::event::emit<TimerStartedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

