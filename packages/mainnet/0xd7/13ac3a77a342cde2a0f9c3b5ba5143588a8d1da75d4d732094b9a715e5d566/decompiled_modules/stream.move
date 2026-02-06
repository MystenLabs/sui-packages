module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream {
    struct PaymentStream<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        escrow: 0x2::balance::Balance<T0>,
        rate_per_second: u64,
        start_time: u64,
        end_time: u64,
        last_withdraw_time: u64,
        status: u8,
        total_streamed: u64,
        paused_duration: u64,
        paused_at: u64,
    }

    struct StreamCap has store, key {
        id: 0x2::object::UID,
        stream_id: 0x2::object::ID,
        is_sender: bool,
    }

    public fun cancel<T0>(arg0: &mut PaymentStream<T0>, arg1: &StreamCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg1.stream_id == 0x2::object::id<PaymentStream<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_stream_cap());
        assert!(arg1.is_sender, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_stream_sender());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_active(arg0.status) || 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_paused(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::stream_ended());
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = get_withdrawable_internal<T0>(arg0, v0);
        let v2 = 0x2::balance::value<T0>(&arg0.escrow);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::stream_status_cancelled();
        arg0.total_streamed = arg0.total_streamed + v3;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_stream_cancelled(0x2::object::id<PaymentStream<T0>>(arg0), arg0.sender, v2 - v3, v3, v0);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg2), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v3), arg2))
    }

    entry fun cancel_and_distribute<T0>(arg0: &mut PaymentStream<T0>, arg1: &StreamCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.sender;
        let v1 = arg0.recipient;
        let (v2, v3) = cancel<T0>(arg0, arg1, arg2);
        let v4 = v3;
        let v5 = v2;
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
    }

    public fun cap_is_sender(arg0: &StreamCap) : bool {
        arg0.is_sender
    }

    public fun cap_stream_id(arg0: &StreamCap) : 0x2::object::ID {
        arg0.stream_id
    }

    entry fun create_and_share<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = create_stream<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<PaymentStream<T0>>(v0);
        0x2::transfer::transfer<StreamCap>(v1, arg0);
        0x2::transfer::transfer<StreamCap>(v2, arg1);
    }

    public fun create_stream<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (PaymentStream<T0>, StreamCap, StreamCap) {
        assert!(arg3 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_rate());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_amount());
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = v0 / arg3 * 1000;
        assert!(v2 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_duration());
        let v3 = v1 + v2;
        let v4 = PaymentStream<T0>{
            id                 : 0x2::object::new(arg4),
            sender             : arg0,
            recipient          : arg1,
            escrow             : 0x2::coin::into_balance<T0>(arg2),
            rate_per_second    : arg3,
            start_time         : v1,
            end_time           : v3,
            last_withdraw_time : v1,
            status             : 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::stream_status_active(),
            total_streamed     : 0,
            paused_duration    : 0,
            paused_at          : 0,
        };
        let v5 = 0x2::object::id<PaymentStream<T0>>(&v4);
        let v6 = StreamCap{
            id        : 0x2::object::new(arg4),
            stream_id : v5,
            is_sender : true,
        };
        let v7 = StreamCap{
            id        : 0x2::object::new(arg4),
            stream_id : v5,
            is_sender : false,
        };
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_stream_created(v5, arg0, arg1, v0, arg3, v1, v3, v1);
        (v4, v6, v7)
    }

    public fun destroy<T0>(arg0: PaymentStream<T0>, arg1: StreamCap, arg2: StreamCap) {
        let PaymentStream {
            id                 : v0,
            sender             : _,
            recipient          : _,
            escrow             : v3,
            rate_per_second    : _,
            start_time         : _,
            end_time           : _,
            last_withdraw_time : _,
            status             : v8,
            total_streamed     : _,
            paused_duration    : _,
            paused_at          : _,
        } = arg0;
        let v12 = v3;
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_terminal(v8), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::stream_not_active());
        assert!(0x2::balance::value<T0>(&v12) == 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::insufficient_funds());
        0x2::balance::destroy_zero<T0>(v12);
        0x2::object::delete(v0);
        let StreamCap {
            id        : v13,
            stream_id : _,
            is_sender : _,
        } = arg1;
        let StreamCap {
            id        : v16,
            stream_id : _,
            is_sender : _,
        } = arg2;
        0x2::object::delete(v13);
        0x2::object::delete(v16);
    }

    public fun end_time<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.end_time
    }

    public fun escrow_balance<T0>(arg0: &PaymentStream<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun get_withdrawable<T0>(arg0: &PaymentStream<T0>, arg1: &0x2::tx_context::TxContext) : u64 {
        get_withdrawable_internal<T0>(arg0, 0x2::tx_context::epoch_timestamp_ms(arg1))
    }

    fun get_withdrawable_internal<T0>(arg0: &PaymentStream<T0>, arg1: u64) : u64 {
        if (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_terminal(arg0.status)) {
            return 0
        };
        let v0 = arg1;
        if (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_paused(arg0.status) && arg0.paused_at > 0) {
            v0 = arg0.paused_at;
        };
        if (v0 > arg0.end_time) {
            v0 = arg0.end_time;
        };
        if (v0 <= arg0.last_withdraw_time) {
            return 0
        };
        let v1 = (v0 - arg0.last_withdraw_time) / 1000 * arg0.rate_per_second;
        let v2 = 0x2::balance::value<T0>(&arg0.escrow);
        if (v1 > v2) {
            v2
        } else {
            v1
        }
    }

    public fun is_active<T0>(arg0: &PaymentStream<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_active(arg0.status)
    }

    public fun is_cancelled<T0>(arg0: &PaymentStream<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_cancelled(arg0.status)
    }

    public fun is_completed<T0>(arg0: &PaymentStream<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_completed(arg0.status)
    }

    public fun is_paused<T0>(arg0: &PaymentStream<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_paused(arg0.status)
    }

    public fun last_withdraw_time<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.last_withdraw_time
    }

    public fun pause<T0>(arg0: &mut PaymentStream<T0>, arg1: &StreamCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.stream_id == 0x2::object::id<PaymentStream<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_stream_cap());
        assert!(arg1.is_sender, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_stream_sender());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_active(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::stream_already_paused());
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::stream_status_paused();
        arg0.paused_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_stream_paused(0x2::object::id<PaymentStream<T0>>(arg0), arg0.sender, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public fun rate_per_second<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.rate_per_second
    }

    public fun recipient<T0>(arg0: &PaymentStream<T0>) : address {
        arg0.recipient
    }

    public fun remaining_duration<T0>(arg0: &PaymentStream<T0>, arg1: u64) : u64 {
        if (arg1 >= arg0.end_time) {
            return 0
        };
        (arg0.end_time - arg1) / 1000
    }

    public fun resume<T0>(arg0: &mut PaymentStream<T0>, arg1: &StreamCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.stream_id == 0x2::object::id<PaymentStream<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_stream_cap());
        assert!(arg1.is_sender, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_stream_sender());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_paused(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::stream_not_paused());
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = v0 - arg0.paused_at;
        arg0.paused_duration = arg0.paused_duration + v1;
        arg0.end_time = arg0.end_time + v1;
        arg0.paused_at = 0;
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::stream_status_active();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_stream_resumed(0x2::object::id<PaymentStream<T0>>(arg0), arg0.sender, v0);
    }

    public fun sender<T0>(arg0: &PaymentStream<T0>) : address {
        arg0.sender
    }

    public fun start_time<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.start_time
    }

    public fun status<T0>(arg0: &PaymentStream<T0>) : u8 {
        arg0.status
    }

    public fun top_up<T0>(arg0: &mut PaymentStream<T0>, arg1: &StreamCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.stream_id == 0x2::object::id<PaymentStream<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_stream_cap());
        assert!(arg1.is_sender, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_stream_sender());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_active(arg0.status) || 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_paused(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::stream_ended());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_amount());
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::coin::into_balance<T0>(arg2));
        arg0.end_time = arg0.end_time + v0 / arg0.rate_per_second * 1000;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_stream_topped_up(0x2::object::id<PaymentStream<T0>>(arg0), arg0.sender, v0, arg0.end_time, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public fun total_duration<T0>(arg0: &PaymentStream<T0>) : u64 {
        (arg0.end_time - arg0.start_time - arg0.paused_duration) / 1000
    }

    public fun total_streamed<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.total_streamed
    }

    public fun withdraw<T0>(arg0: &mut PaymentStream<T0>, arg1: &StreamCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.stream_id == 0x2::object::id<PaymentStream<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_stream_cap());
        assert!(!arg1.is_sender, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_stream_recipient());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_active(arg0.status) || 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_stream_paused(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::stream_not_active());
        let v0 = get_withdrawable_internal<T0>(arg0, 0x2::tx_context::epoch_timestamp_ms(arg2));
        assert!(v0 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::nothing_to_withdraw());
        let v1 = 0x2::balance::value<T0>(&arg0.escrow);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        arg0.last_withdraw_time = 0x2::tx_context::epoch_timestamp_ms(arg2);
        arg0.total_streamed = arg0.total_streamed + v2;
        let v3 = 0x2::balance::value<T0>(&arg0.escrow);
        if (v3 == 0) {
            arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::stream_status_completed();
            0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_stream_completed(0x2::object::id<PaymentStream<T0>>(arg0), arg0.total_streamed, 0x2::tx_context::epoch_timestamp_ms(arg2));
        };
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_stream_withdrawn(0x2::object::id<PaymentStream<T0>>(arg0), arg0.recipient, v2, v3, 0x2::tx_context::epoch_timestamp_ms(arg2));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v2), arg2)
    }

    entry fun withdraw_to_recipient<T0>(arg0: &mut PaymentStream<T0>, arg1: &StreamCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.recipient;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

