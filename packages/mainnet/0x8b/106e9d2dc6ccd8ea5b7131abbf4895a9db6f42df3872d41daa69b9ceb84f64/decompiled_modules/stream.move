module 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::stream {
    struct PaymentStream<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        rate: u64,
        interval_ms: u64,
        max_intervals: u64,
        ticks_claimed: u64,
        state: u8,
        locked_balance: 0x2::balance::Balance<T0>,
        last_tick_time: u64,
        created_at: u64,
    }

    struct StreamOpened has copy, drop {
        stream_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        rate: u64,
        interval_ms: u64,
        max_intervals: u64,
        total_locked: u64,
    }

    struct StreamTicked has copy, drop {
        stream_id: 0x2::object::ID,
        tick_number: u64,
        amount_released: u64,
    }

    struct StreamClosed has copy, drop {
        stream_id: 0x2::object::ID,
        ticks_completed: u64,
        amount_paid: u64,
        amount_refunded: u64,
    }

    struct StreamPaused has copy, drop {
        stream_id: 0x2::object::ID,
    }

    struct StreamResumed has copy, drop {
        stream_id: 0x2::object::ID,
    }

    public fun sender<T0>(arg0: &PaymentStream<T0>) : address {
        arg0.sender
    }

    public fun amount_paid<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.rate * arg0.ticks_claimed
    }

    fun checked_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = arg0 * arg1;
        assert!(v0 / arg0 == arg1, 206);
        v0
    }

    public fun close_stream<T0>(arg0: &mut PaymentStream<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state != 2, 203);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.sender || v0 == arg0.recipient, 200);
        let v1 = 0x2::balance::value<T0>(&arg0.locked_balance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.locked_balance, v1), arg1), arg0.sender);
        };
        arg0.state = 2;
        let v2 = StreamClosed{
            stream_id       : 0x2::object::id<PaymentStream<T0>>(arg0),
            ticks_completed : arg0.ticks_claimed,
            amount_paid     : arg0.rate * arg0.ticks_claimed,
            amount_refunded : v1,
        };
        0x2::event::emit<StreamClosed>(v2);
    }

    public fun is_active<T0>(arg0: &PaymentStream<T0>) : bool {
        arg0.state == 0
    }

    public fun is_closed<T0>(arg0: &PaymentStream<T0>) : bool {
        arg0.state == 2
    }

    public fun locked_amount<T0>(arg0: &PaymentStream<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked_balance)
    }

    public fun max_intervals<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.max_intervals
    }

    public fun open_stream<T0>(arg0: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 207);
        assert!(arg3 > 0, 208);
        let v0 = checked_mul(arg1, arg3);
        assert!(arg5 == 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::sequence_number(arg0), 209);
        0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::increment_sequence(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = PaymentStream<T0>{
            id             : 0x2::object::new(arg7),
            sender         : 0x2::tx_context::sender(arg7),
            recipient      : arg4,
            rate           : arg1,
            interval_ms    : arg2,
            max_intervals  : arg3,
            ticks_claimed  : 0,
            state          : 0,
            locked_balance : 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::debit<T0>(arg0, v0),
            last_tick_time : v1,
            created_at     : v1,
        };
        let v3 = StreamOpened{
            stream_id     : 0x2::object::id<PaymentStream<T0>>(&v2),
            sender        : 0x2::tx_context::sender(arg7),
            recipient     : arg4,
            rate          : arg1,
            interval_ms   : arg2,
            max_intervals : arg3,
            total_locked  : v0,
        };
        0x2::event::emit<StreamOpened>(v3);
        0x2::transfer::share_object<PaymentStream<T0>>(v2);
    }

    public fun pause_stream<T0>(arg0: &mut PaymentStream<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 201);
        assert!(0x2::tx_context::sender(arg1) == arg0.sender, 200);
        arg0.state = 1;
        let v0 = StreamPaused{stream_id: 0x2::object::id<PaymentStream<T0>>(arg0)};
        0x2::event::emit<StreamPaused>(v0);
    }

    public fun rate<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.rate
    }

    public fun recipient<T0>(arg0: &PaymentStream<T0>) : address {
        arg0.recipient
    }

    public fun resume_stream<T0>(arg0: &mut PaymentStream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 202);
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 200);
        arg0.last_tick_time = 0x2::clock::timestamp_ms(arg1);
        arg0.state = 0;
        let v0 = StreamResumed{stream_id: 0x2::object::id<PaymentStream<T0>>(arg0)};
        0x2::event::emit<StreamResumed>(v0);
    }

    public fun tick<T0>(arg0: &mut PaymentStream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 201);
        assert!(arg0.ticks_claimed < arg0.max_intervals, 205);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_tick_time + arg0.interval_ms, 204);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.locked_balance, arg0.rate), arg2), arg0.recipient);
        arg0.ticks_claimed = arg0.ticks_claimed + 1;
        arg0.last_tick_time = v0;
        let v1 = StreamTicked{
            stream_id       : 0x2::object::id<PaymentStream<T0>>(arg0),
            tick_number     : arg0.ticks_claimed,
            amount_released : arg0.rate,
        };
        0x2::event::emit<StreamTicked>(v1);
        if (arg0.ticks_claimed >= arg0.max_intervals) {
            arg0.state = 2;
            let v2 = StreamClosed{
                stream_id       : 0x2::object::id<PaymentStream<T0>>(arg0),
                ticks_completed : arg0.ticks_claimed,
                amount_paid     : arg0.rate * arg0.max_intervals,
                amount_refunded : 0,
            };
            0x2::event::emit<StreamClosed>(v2);
        };
    }

    public fun ticks_claimed<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.ticks_claimed
    }

    // decompiled from Move bytecode v6
}

