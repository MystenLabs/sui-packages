module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker {
    struct Ticker has key {
        id: 0x2::object::UID,
        version: u64,
        genesis_ms: u64,
        sub_ms: u64,
        sigma_ppb: u64,
        step_q64: u64,
        max_fold: u64,
        last_tick: u64,
        last_price: u64,
        day: u64,
        last_draw_ms: u64,
        hist: 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::history::Header,
    }

    struct DayKey has copy, drop, store {
        day: u64,
    }

    struct DayEnd has copy, drop, store {
        last_tick: u64,
        price: u64,
    }

    struct Ticks has copy, drop {
        ticker: 0x2::object::ID,
        first: u64,
        prices: vector<u64>,
    }

    struct DayReset has copy, drop {
        ticker: 0x2::object::ID,
        day: u64,
        last_tick: u64,
        price: u64,
    }

    struct SigmaChanged has copy, drop {
        ticker: 0x2::object::ID,
        sigma_ppb: u64,
        from_tick: u64,
    }

    struct TickerCreated has copy, drop {
        ticker: 0x2::object::ID,
        genesis_ms: u64,
        sub_ms: u64,
        sigma_ppb: u64,
        pages: u64,
        max_fold: u64,
    }

    struct MaxFoldChanged has copy, drop {
        ticker: 0x2::object::ID,
        max_fold: u64,
    }

    struct TickerMigrated has copy, drop {
        ticker: 0x2::object::ID,
        version: u64,
    }

    public fun oldest(arg0: &Ticker) : u64 {
        0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::history::oldest(&arg0.hist)
    }

    public fun create(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 50000 && arg2 <= 3000000, 0);
        assert!(arg3 >= 50 && arg3 <= 1000, 0);
        assert!(arg5 >= 1 && arg5 <= 256, 0);
        assert!(arg4 <= 1000000 && arg4 * 64 * arg3 >= 3000000, 0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = v0 - v0 % arg3;
        let v2 = 0x2::object::new(arg6);
        let v3 = TickerCreated{
            ticker     : 0x2::object::uid_to_inner(&v2),
            genesis_ms : v1,
            sub_ms     : arg3,
            sigma_ppb  : arg2,
            pages      : arg4,
            max_fold   : arg5,
        };
        0x2::event::emit<TickerCreated>(v3);
        let v4 = Ticker{
            id           : v2,
            version      : 1,
            genesis_ms   : v1,
            sub_ms       : arg3,
            sigma_ppb    : arg2,
            step_q64     : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::walk::step_q64(arg2, arg3),
            max_fold     : arg5,
            last_tick    : 0,
            last_price   : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::walk::start_price(),
            day          : v1 / 86400000,
            last_draw_ms : v0,
            hist         : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::history::new(&mut v2, 0, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::walk::start_price(), arg4),
        };
        0x2::transfer::share_object<Ticker>(v4);
    }

    public fun day(arg0: &Ticker) : u64 {
        arg0.day
    }

    public fun day_end(arg0: &Ticker, arg1: u64) : (u64, u64) {
        let v0 = DayKey{day: arg1};
        assert!(0x2::dynamic_field::exists<DayKey>(&arg0.id, v0), 1);
        let v1 = DayKey{day: arg1};
        let v2 = 0x2::dynamic_field::borrow<DayKey, DayEnd>(&arg0.id, v1);
        (v2.last_tick, v2.price)
    }

    fun draw(arg0: &mut Ticker, arg1: &0x2::random::Random, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg4);
        let v1 = arg0.last_tick + 1;
        let v2 = vector[];
        let v3 = arg0.last_price;
        let v4 = arg0.day;
        while (v1 < v1 + arg2) {
            let v5 = (arg0.genesis_ms + v1 * arg0.sub_ms) / 86400000;
            if (v5 != v4) {
                let v6 = DayKey{day: v4};
                let v7 = DayEnd{
                    last_tick : v1 - 1,
                    price     : v3,
                };
                0x2::dynamic_field::add<DayKey, DayEnd>(&mut arg0.id, v6, v7);
                let v8 = DayReset{
                    ticker    : 0x2::object::id<Ticker>(arg0),
                    day       : v4,
                    last_tick : v1 - 1,
                    price     : v3,
                };
                0x2::event::emit<DayReset>(v8);
                v4 = v5;
                v3 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::walk::step(0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::walk::start_price(), 0x2::random::generate_u256(&mut v0), arg0.step_q64);
            } else {
                v3 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::walk::step(v3, 0x2::random::generate_u256(&mut v0), arg0.step_q64);
            };
            0x1::vector::push_back<u64>(&mut v2, v3);
            v1 = v1 + 1;
        };
        0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::history::push_all(&mut arg0.id, &mut arg0.hist, v1, &v2);
        arg0.last_tick = v1 + arg2 - 1;
        arg0.last_price = v3;
        arg0.day = v4;
        arg0.last_draw_ms = arg3;
        let v9 = Ticks{
            ticker : 0x2::object::id<Ticker>(arg0),
            first  : v1,
            prices : v2,
        };
        0x2::event::emit<Ticks>(v9);
    }

    public fun extremes_in_window(arg0: &Ticker, arg1: u64, arg2: u64) : (bool, u64, u64) {
        let v0 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::history::oldest(&arg0.hist);
        let v1 = if (arg1 < v0) {
            v0
        } else {
            arg1
        };
        let v2 = if (arg2 > arg0.last_tick) {
            arg0.last_tick
        } else {
            arg2
        };
        if (v1 > v2) {
            return (false, 0, 0)
        };
        let (v3, v4) = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::history::extremes(&arg0.id, &arg0.hist, v1, v2);
        (true, v3, v4)
    }

    public fun genesis_ms(arg0: &Ticker) : u64 {
        arg0.genesis_ms
    }

    public fun has_day_end(arg0: &Ticker, arg1: u64) : bool {
        let v0 = DayKey{day: arg1};
        0x2::dynamic_field::exists<DayKey>(&arg0.id, v0)
    }

    public fun last_draw_ms(arg0: &Ticker) : u64 {
        arg0.last_draw_ms
    }

    public fun last_price(arg0: &Ticker) : u64 {
        arg0.last_price
    }

    public fun last_tick(arg0: &Ticker) : u64 {
        arg0.last_tick
    }

    public fun migrate(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Ticker) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
        let v0 = TickerMigrated{
            ticker  : 0x2::object::id<Ticker>(arg1),
            version : 1,
        };
        0x2::event::emit<TickerMigrated>(v0);
    }

    public fun price_at(arg0: &Ticker, arg1: u64) : u64 {
        0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::history::price(&arg0.id, &arg0.hist, arg1)
    }

    public fun set_max_fold(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Ticker, arg2: u64) {
        assert!(arg1.version == 1, 2);
        assert!(arg2 >= 1 && arg2 <= 256, 0);
        arg1.max_fold = arg2;
        let v0 = MaxFoldChanged{
            ticker   : 0x2::object::id<Ticker>(arg1),
            max_fold : arg2,
        };
        0x2::event::emit<MaxFoldChanged>(v0);
    }

    public fun set_sigma(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Ticker, arg2: u64) {
        assert!(arg1.version == 1, 2);
        assert!(arg2 >= 50000 && arg2 <= 3000000, 0);
        arg1.sigma_ppb = arg2;
        arg1.step_q64 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::walk::step_q64(arg2, arg1.sub_ms);
        let v0 = SigmaChanged{
            ticker    : 0x2::object::id<Ticker>(arg1),
            sigma_ppb : arg2,
            from_tick : arg1.last_tick + 1,
        };
        0x2::event::emit<SigmaChanged>(v0);
    }

    public fun sigma_ppb(arg0: &Ticker) : u64 {
        arg0.sigma_ppb
    }

    public fun sub_ms(arg0: &Ticker) : u64 {
        arg0.sub_ms
    }

    entry fun tick(arg0: &mut Ticker, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = (v0 - arg0.genesis_ms) / arg0.sub_ms;
        if (v1 <= arg0.last_tick) {
            return
        };
        let v2 = v1 - arg0.last_tick;
        let v3 = if (v2 > arg0.max_fold) {
            arg0.max_fold
        } else {
            v2
        };
        draw(arg0, arg1, v3, v0, arg3);
    }

    public fun version(arg0: &Ticker) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

