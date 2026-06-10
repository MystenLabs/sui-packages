module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::subscription {
    struct Subscription has key {
        id: 0x2::object::UID,
        payer: address,
        payee: address,
        label: 0x1::string::String,
        amount_per_period: u64,
        period_ms: u64,
        total_periods: u64,
        periods_claimed: u64,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        cancelled: bool,
        created_at_ms: u64,
        next_claim_at_ms: u64,
    }

    struct SubscriptionCreated has copy, drop {
        subscription_id: 0x2::object::ID,
        payer: address,
        payee: address,
        amount_per_period: u64,
        period_ms: u64,
        total_periods: u64,
        next_claim_at_ms: u64,
    }

    struct PeriodClaimed has copy, drop {
        subscription_id: 0x2::object::ID,
        payee: address,
        periods: u64,
        amount: u64,
        periods_claimed: u64,
    }

    struct SubscriptionCancelled has copy, drop {
        subscription_id: 0x2::object::ID,
        by: address,
        refund: u64,
    }

    struct Stream has key {
        id: 0x2::object::UID,
        payer: address,
        payee: address,
        label: 0x1::string::String,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        total: u64,
        claimed: u64,
        start_ms: u64,
        duration_ms: u64,
        cancelled: bool,
    }

    struct StreamCreated has copy, drop {
        stream_id: 0x2::object::ID,
        payer: address,
        payee: address,
        total: u64,
        start_ms: u64,
        duration_ms: u64,
    }

    struct StreamClaimed has copy, drop {
        stream_id: 0x2::object::ID,
        payee: address,
        amount: u64,
        claimed: u64,
    }

    struct StreamCancelled has copy, drop {
        stream_id: 0x2::object::ID,
        by: address,
        to_payee: u64,
        refund: u64,
    }

    public fun cancel(arg0: &mut Subscription, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.cancelled, 2);
        assert!(0x2::tx_context::sender(arg1) == arg0.payer || 0x2::tx_context::sender(arg1) == arg0.payee, 4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v0), arg1), arg0.payer);
        };
        arg0.cancelled = true;
        let v1 = SubscriptionCancelled{
            subscription_id : 0x2::object::id<Subscription>(arg0),
            by              : 0x2::tx_context::sender(arg1),
            refund          : v0,
        };
        0x2::event::emit<SubscriptionCancelled>(v1);
    }

    public fun cancel_stream(arg0: &mut Stream, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.cancelled, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.payer || 0x2::tx_context::sender(arg2) == arg0.payee, 4);
        let v0 = vested_at(arg0, 0x2::clock::timestamp_ms(arg1)) - arg0.claimed;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v0), arg2), arg0.payee);
            arg0.claimed = arg0.claimed + v0;
        };
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v1), arg2), arg0.payer);
        };
        arg0.cancelled = true;
        let v2 = StreamCancelled{
            stream_id : 0x2::object::id<Stream>(arg0),
            by        : 0x2::tx_context::sender(arg2),
            to_payee  : v0,
            refund    : v1,
        };
        0x2::event::emit<StreamCancelled>(v2);
    }

    public fun claim_due(arg0: &mut Subscription, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.cancelled, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.payee, 3);
        let v0 = 0;
        while (arg0.periods_claimed + v0 < arg0.total_periods && 0x2::clock::timestamp_ms(arg1) >= arg0.next_claim_at_ms + v0 * arg0.period_ms) {
            v0 = v0 + 1;
        };
        assert!(v0 > 0, 5);
        let v1 = arg0.amount_per_period * v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v1), arg2), arg0.payee);
        arg0.periods_claimed = arg0.periods_claimed + v0;
        arg0.next_claim_at_ms = arg0.next_claim_at_ms + v0 * arg0.period_ms;
        let v2 = PeriodClaimed{
            subscription_id : 0x2::object::id<Subscription>(arg0),
            payee           : arg0.payee,
            periods         : v0,
            amount          : v1,
            periods_claimed : arg0.periods_claimed,
        };
        0x2::event::emit<PeriodClaimed>(v2);
    }

    public fun claim_stream(arg0: &mut Stream, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.cancelled, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.payee, 3);
        let v0 = vested_at(arg0, 0x2::clock::timestamp_ms(arg1)) - arg0.claimed;
        assert!(v0 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v0), arg2), arg0.payee);
        arg0.claimed = arg0.claimed + v0;
        let v1 = StreamClaimed{
            stream_id : 0x2::object::id<Stream>(arg0),
            payee     : arg0.payee,
            amount    : v0,
            claimed   : arg0.claimed,
        };
        0x2::event::emit<StreamClaimed>(v1);
    }

    public fun create_stream(arg0: address, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = Stream{
            id          : 0x2::object::new(arg5),
            payer       : 0x2::tx_context::sender(arg5),
            payee       : arg0,
            label       : arg1,
            escrow      : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            total       : v0,
            claimed     : 0,
            start_ms    : v1,
            duration_ms : arg3,
            cancelled   : false,
        };
        let v3 = StreamCreated{
            stream_id   : 0x2::object::id<Stream>(&v2),
            payer       : v2.payer,
            payee       : arg0,
            total       : v0,
            start_ms    : v1,
            duration_ms : arg3,
        };
        0x2::event::emit<StreamCreated>(v3);
        0x2::transfer::share_object<Stream>(v2);
    }

    public fun create_subscription(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(arg4 > 0, 6);
        assert!(arg3 > 0, 7);
        let v0 = arg2 * arg4;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v1 >= v0, 1);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v1 - v0), arg7), 0x2::tx_context::sender(arg7));
        };
        let v3 = 0x2::clock::timestamp_ms(arg6);
        let v4 = Subscription{
            id                : 0x2::object::new(arg7),
            payer             : 0x2::tx_context::sender(arg7),
            payee             : arg0,
            label             : arg1,
            amount_per_period : arg2,
            period_ms         : arg3,
            total_periods     : arg4,
            periods_claimed   : 0,
            escrow            : v2,
            cancelled         : false,
            created_at_ms     : v3,
            next_claim_at_ms  : v3 + arg3,
        };
        let v5 = SubscriptionCreated{
            subscription_id   : 0x2::object::id<Subscription>(&v4),
            payer             : v4.payer,
            payee             : arg0,
            amount_per_period : arg2,
            period_ms         : arg3,
            total_periods     : arg4,
            next_claim_at_ms  : v4.next_claim_at_ms,
        };
        0x2::event::emit<SubscriptionCreated>(v5);
        0x2::transfer::share_object<Subscription>(v4);
    }

    public fun e_cancelled() : u64 {
        2
    }

    public fun e_not_controller() : u64 {
        4
    }

    public fun e_not_payee() : u64 {
        3
    }

    public fun e_nothing_due() : u64 {
        5
    }

    public fun e_underfunded() : u64 {
        1
    }

    public fun e_zero_amount() : u64 {
        0
    }

    public fun stream_cancelled(arg0: &Stream) : bool {
        arg0.cancelled
    }

    public fun stream_claimed(arg0: &Stream) : u64 {
        arg0.claimed
    }

    public fun stream_escrow_value(arg0: &Stream) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun stream_payee(arg0: &Stream) : address {
        arg0.payee
    }

    public fun stream_payer(arg0: &Stream) : address {
        arg0.payer
    }

    public fun stream_total(arg0: &Stream) : u64 {
        arg0.total
    }

    public fun sub_amount_per_period(arg0: &Subscription) : u64 {
        arg0.amount_per_period
    }

    public fun sub_cancelled(arg0: &Subscription) : bool {
        arg0.cancelled
    }

    public fun sub_escrow_value(arg0: &Subscription) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun sub_next_claim_at_ms(arg0: &Subscription) : u64 {
        arg0.next_claim_at_ms
    }

    public fun sub_payee(arg0: &Subscription) : address {
        arg0.payee
    }

    public fun sub_payer(arg0: &Subscription) : address {
        arg0.payer
    }

    public fun sub_periods_claimed(arg0: &Subscription) : u64 {
        arg0.periods_claimed
    }

    public fun sub_total_periods(arg0: &Subscription) : u64 {
        arg0.total_periods
    }

    fun vested_at(arg0: &Stream, arg1: u64) : u64 {
        let v0 = if (arg1 >= arg0.start_ms + arg0.duration_ms) {
            arg0.duration_ms
        } else if (arg1 <= arg0.start_ms) {
            0
        } else {
            arg1 - arg0.start_ms
        };
        (((arg0.total as u128) * (v0 as u128) / (arg0.duration_ms as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

