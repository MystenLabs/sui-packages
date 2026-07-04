module 0x2078f8b4b782ad774b00bff4b339d8b2d4e81ac22f106ac01c2ac2e0707bebcb::streaming_payment {
    struct PaymentStream<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        total_amount: u64,
        withdrawn_amount: u64,
        funds: 0x2::balance::Balance<T0>,
        start_time_ms: u64,
        end_time_ms: u64,
        memo: vector<u8>,
        status: u8,
    }

    struct WithdrawalReceipt has copy, drop, store {
        stream_id: vector<u8>,
        amount: u64,
        timestamp_ms: u64,
        total_withdrawn: u64,
    }

    struct CancellationReceipt has copy, drop, store {
        stream_id: vector<u8>,
        refunded_amount: u64,
        recipient_received: u64,
        timestamp_ms: u64,
    }

    struct StreamCreated has copy, drop {
        sender: address,
        recipient: address,
        total_amount: u64,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct StreamWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
        total_withdrawn: u64,
    }

    struct StreamCancelled has copy, drop {
        sender: address,
        recipient: address,
        refunded_amount: u64,
        recipient_received: u64,
    }

    struct StreamCompleted has copy, drop {
        sender: address,
        recipient: address,
        total_amount: u64,
    }

    struct StreamTopUp has copy, drop {
        sender: address,
        amount: u64,
    }

    public fun available_balance<T0>(arg0: &PaymentStream<T0>, arg1: u64) : u64 {
        let v0 = calculate_unlocked<T0>(arg0, arg1);
        if (v0 > arg0.withdrawn_amount) {
            v0 - arg0.withdrawn_amount
        } else {
            0
        }
    }

    public fun calculate_unlocked<T0>(arg0: &PaymentStream<T0>, arg1: u64) : u64 {
        if (arg1 <= arg0.start_time_ms) {
            0
        } else if (arg1 >= arg0.end_time_ms) {
            arg0.total_amount
        } else {
            (((arg0.total_amount as u128) * ((arg1 - arg0.start_time_ms) as u128) / ((arg0.end_time_ms - arg0.start_time_ms) as u128)) as u64)
        }
    }

    public fun cancel_stream<T0>(arg0: &mut PaymentStream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : CancellationReceipt {
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 13906835565912784897);
        assert!(arg0.status == 0, 13906835570207883267);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = calculate_unlocked<T0>(arg0, v0) - arg0.withdrawn_amount;
        let v2 = 0x2::balance::value<T0>(&arg0.funds) - v1;
        arg0.status = 2;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v1), arg2), arg0.recipient);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, 0x2::balance::value<T0>(&arg0.funds)), arg2), arg0.sender);
        };
        let v3 = CancellationReceipt{
            stream_id          : 0x2::object::uid_to_bytes(&arg0.id),
            refunded_amount    : v2,
            recipient_received : arg0.withdrawn_amount + v1,
            timestamp_ms       : v0,
        };
        let v4 = StreamCancelled{
            sender             : arg0.sender,
            recipient          : arg0.recipient,
            refunded_amount    : v2,
            recipient_received : arg0.withdrawn_amount + v1,
        };
        0x2::event::emit<StreamCancelled>(v4);
        v3
    }

    public fun cancellation_recipient_received(arg0: &CancellationReceipt) : u64 {
        arg0.recipient_received
    }

    public fun cancellation_refunded(arg0: &CancellationReceipt) : u64 {
        arg0.refunded_amount
    }

    public fun create_stream<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != arg0, 13906834960322920457);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 13906834973208215567);
        assert!(arg2 >= 60000, 13906834977502920715);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = PaymentStream<T0>{
            id               : 0x2::object::new(arg5),
            sender           : v0,
            recipient        : arg0,
            total_amount     : v1,
            withdrawn_amount : 0,
            funds            : 0x2::coin::into_balance<T0>(arg1),
            start_time_ms    : v2,
            end_time_ms      : v2 + arg2,
            memo             : arg3,
            status           : 0,
        };
        let v4 = StreamCreated{
            sender        : v0,
            recipient     : arg0,
            total_amount  : v1,
            start_time_ms : v2,
            end_time_ms   : v2 + arg2,
        };
        0x2::event::emit<StreamCreated>(v4);
        0x2::transfer::share_object<PaymentStream<T0>>(v3);
    }

    public fun min_duration_ms() : u64 {
        60000
    }

    public fun rate_per_ms<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.total_amount / (arg0.end_time_ms - arg0.start_time_ms)
    }

    public fun remaining_balance<T0>(arg0: &PaymentStream<T0>, arg1: u64) : u64 {
        arg0.total_amount - calculate_unlocked<T0>(arg0, arg1)
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_cancelled() : u8 {
        2
    }

    public fun status_completed() : u8 {
        1
    }

    public fun stream_end_time<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.end_time_ms
    }

    public fun stream_is_active<T0>(arg0: &PaymentStream<T0>) : bool {
        arg0.status == 0
    }

    public fun stream_memo<T0>(arg0: &PaymentStream<T0>) : &vector<u8> {
        &arg0.memo
    }

    public fun stream_recipient<T0>(arg0: &PaymentStream<T0>) : address {
        arg0.recipient
    }

    public fun stream_sender<T0>(arg0: &PaymentStream<T0>) : address {
        arg0.sender
    }

    public fun stream_start_time<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.start_time_ms
    }

    public fun stream_status<T0>(arg0: &PaymentStream<T0>) : u8 {
        arg0.status
    }

    public fun stream_total_amount<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.total_amount
    }

    public fun stream_withdrawn_amount<T0>(arg0: &PaymentStream<T0>) : u64 {
        arg0.withdrawn_amount
    }

    public fun top_up<T0>(arg0: &mut PaymentStream<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.sender, 13906835780661149697);
        assert!(arg0.status == 0, 13906835784956248067);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg0.end_time_ms, 13906835797841412103);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 13906835810726838287);
        assert!(arg2 > 0, 13906835815021150213);
        arg0.total_amount = arg0.total_amount + v1;
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        arg0.end_time_ms = arg0.end_time_ms + arg2;
        assert!(calculate_unlocked<T0>(arg0, v0) >= calculate_unlocked<T0>(arg0, v0), 13906835879445659653);
        let v2 = StreamTopUp{
            sender : 0x2::tx_context::sender(arg4),
            amount : v1,
        };
        0x2::event::emit<StreamTopUp>(v2);
    }

    public fun withdraw<T0>(arg0: &mut PaymentStream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : WithdrawalReceipt {
        assert!(0x2::tx_context::sender(arg2) == arg0.recipient, 13906835127826120705);
        assert!(arg0.status == 0, 13906835132121219075);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = calculate_unlocked<T0>(arg0, v0);
        let v2 = v1 - arg0.withdrawn_amount;
        assert!(v2 > 0, 13906835157891678221);
        arg0.withdrawn_amount = v1;
        if (arg0.withdrawn_amount >= arg0.total_amount) {
            arg0.status = 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v2), arg2), arg0.recipient);
        let v3 = WithdrawalReceipt{
            stream_id       : 0x2::object::uid_to_bytes(&arg0.id),
            amount          : v2,
            timestamp_ms    : v0,
            total_withdrawn : arg0.withdrawn_amount,
        };
        let v4 = StreamWithdrawn{
            recipient       : arg0.recipient,
            amount          : v2,
            total_withdrawn : arg0.withdrawn_amount,
        };
        0x2::event::emit<StreamWithdrawn>(v4);
        if (arg0.status == 1) {
            let v5 = StreamCompleted{
                sender       : arg0.sender,
                recipient    : arg0.recipient,
                total_amount : arg0.total_amount,
            };
            0x2::event::emit<StreamCompleted>(v5);
        };
        v3
    }

    public fun withdraw_amount<T0>(arg0: &mut PaymentStream<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : WithdrawalReceipt {
        assert!(0x2::tx_context::sender(arg3) == arg0.recipient, 13906835346869452801);
        assert!(arg0.status == 0, 13906835351164551171);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > 0 && arg1 <= calculate_unlocked<T0>(arg0, v0) - arg0.withdrawn_amount, 13906835376935010317);
        arg0.withdrawn_amount = arg0.withdrawn_amount + arg1;
        if (arg0.withdrawn_amount >= arg0.total_amount) {
            arg0.status = 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg1), arg3), arg0.recipient);
        let v1 = WithdrawalReceipt{
            stream_id       : 0x2::object::uid_to_bytes(&arg0.id),
            amount          : arg1,
            timestamp_ms    : v0,
            total_withdrawn : arg0.withdrawn_amount,
        };
        let v2 = StreamWithdrawn{
            recipient       : arg0.recipient,
            amount          : arg1,
            total_withdrawn : arg0.withdrawn_amount,
        };
        0x2::event::emit<StreamWithdrawn>(v2);
        if (arg0.status == 1) {
            let v3 = StreamCompleted{
                sender       : arg0.sender,
                recipient    : arg0.recipient,
                total_amount : arg0.total_amount,
            };
            0x2::event::emit<StreamCompleted>(v3);
        };
        v1
    }

    public fun withdrawal_amount(arg0: &WithdrawalReceipt) : u64 {
        arg0.amount
    }

    public fun withdrawal_stream_id(arg0: &WithdrawalReceipt) : &vector<u8> {
        &arg0.stream_id
    }

    public fun withdrawal_timestamp(arg0: &WithdrawalReceipt) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v7
}

