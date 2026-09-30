module 0xc4c743f6b2c9c1d9cf729785fbf2393d2e8b7836300b349dbfed0e5321932c7c::daily {
    struct DailyLimiter<phantom T0> has store, key {
        id: 0x2::object::UID,
        minter: 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::MinterCap<T0>,
        per_day: u64,
        day: u64,
        minted_today: u64,
        minted_total: u64,
    }

    struct Wrapped has copy, drop {
        limiter: 0x2::object::ID,
        treasury: 0x2::object::ID,
        per_day: u64,
    }

    struct DailyMinted has copy, drop {
        limiter: 0x2::object::ID,
        day: u64,
        amount: u64,
        minted_today: u64,
    }

    public fun mint<T0>(arg0: &mut DailyLimiter<T0>, arg1: &mut 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::CappedTreasury<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 86400000;
        if (v0 != arg0.day) {
            arg0.day = v0;
            arg0.minted_today = 0;
        };
        assert!(arg2 <= arg0.per_day - arg0.minted_today, 1);
        let v1 = 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::mint<T0>(arg1, &arg0.minter, arg2, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        if (v2 > 0) {
            arg0.minted_today = arg0.minted_today + v2;
            arg0.minted_total = arg0.minted_total + v2;
            let v3 = DailyMinted{
                limiter      : 0x2::object::id<DailyLimiter<T0>>(arg0),
                day          : v0,
                amount       : v2,
                minted_today : arg0.minted_today,
            };
            0x2::event::emit<DailyMinted>(v3);
        };
        v1
    }

    public fun minted_total<T0>(arg0: &DailyLimiter<T0>) : u64 {
        arg0.minted_total
    }

    public fun per_day<T0>(arg0: &DailyLimiter<T0>) : u64 {
        arg0.per_day
    }

    public fun room_today<T0>(arg0: &DailyLimiter<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg1) / 86400000 != arg0.day) {
            arg0.per_day
        } else {
            arg0.per_day - arg0.minted_today
        }
    }

    public fun treasury_of<T0>(arg0: &DailyLimiter<T0>) : 0x2::object::ID {
        0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::treasury_of<T0>(&arg0.minter)
    }

    public fun wrap<T0>(arg0: 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::MinterCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : DailyLimiter<T0> {
        assert!(arg1 > 0, 2);
        let v0 = DailyLimiter<T0>{
            id           : 0x2::object::new(arg2),
            minter       : arg0,
            per_day      : arg1,
            day          : 0,
            minted_today : 0,
            minted_total : 0,
        };
        let v1 = Wrapped{
            limiter  : 0x2::object::id<DailyLimiter<T0>>(&v0),
            treasury : 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped::treasury_of<T0>(&v0.minter),
            per_day  : arg1,
        };
        0x2::event::emit<Wrapped>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

