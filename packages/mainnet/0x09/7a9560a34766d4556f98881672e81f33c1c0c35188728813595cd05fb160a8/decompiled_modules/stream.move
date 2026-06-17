module 0x97a9560a34766d4556f98881672e81f33c1c0c35188728813595cd05fb160a8::stream {
    struct StreamRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        worker_addresses: vector<address>,
        paused: bool,
        streams_total: u64,
    }

    struct StreamAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Stream<phantom T0> has key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        escrow: 0x2::balance::Balance<T0>,
        total_amount: u64,
        released_amount: u64,
        tranche_amount: u64,
        num_tranches: u64,
        tranches_done: u64,
        start_ms: u64,
        interval_ms: u64,
        paused: bool,
        cancelled: bool,
    }

    struct StreamCreated has copy, drop {
        stream_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        total: u64,
        tranche_amount: u64,
        num_tranches: u64,
        start_ms: u64,
        interval_ms: u64,
    }

    struct TrancheReleased has copy, drop {
        stream_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        tranche_index: u64,
        ts_ms: u64,
    }

    struct StreamCancelled has copy, drop {
        stream_id: 0x2::object::ID,
        refunded: u64,
        released: u64,
    }

    struct StreamPaused has copy, drop {
        stream_id: 0x2::object::ID,
    }

    struct StreamResumed has copy, drop {
        stream_id: 0x2::object::ID,
    }

    struct WorkerAdded has copy, drop {
        worker: address,
    }

    struct WorkerRemoved has copy, drop {
        worker: address,
    }

    public fun add_worker(arg0: &mut StreamRegistry, arg1: &StreamAdminCap, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg0.worker_addresses, &arg2), 209);
        0x1::vector::push_back<address>(&mut arg0.worker_addresses, arg2);
        let v0 = WorkerAdded{worker: arg2};
        0x2::event::emit<WorkerAdded>(v0);
    }

    public fun cancel_and_withdraw<T0>(arg0: &mut Stream<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.sender, 208);
        arg0.cancelled = true;
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.escrow);
        let v1 = StreamCancelled{
            stream_id : 0x2::object::id<Stream<T0>>(arg0),
            refunded  : 0x2::balance::value<T0>(&v0),
            released  : arg0.released_amount,
        };
        0x2::event::emit<StreamCancelled>(v1);
        0x2::coin::from_balance<T0>(v0, arg1)
    }

    public fun claim_accrued<T0>(arg0: &mut Stream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.cancelled, 205);
        assert!(!arg0.paused, 204);
        while (arg0.tranches_done < arg0.num_tranches) {
            if (0x2::clock::timestamp_ms(arg1) < arg0.start_ms + arg0.tranches_done * arg0.interval_ms) {
                break
            };
            let v0 = if (arg0.tranches_done + 1 == arg0.num_tranches) {
                0x2::balance::value<T0>(&arg0.escrow)
            } else {
                arg0.tranche_amount
            };
            arg0.released_amount = arg0.released_amount + v0;
            arg0.tranches_done = arg0.tranches_done + 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v0), arg2), arg0.recipient);
            let v1 = TrancheReleased{
                stream_id     : 0x2::object::id<Stream<T0>>(arg0),
                recipient     : arg0.recipient,
                amount        : v0,
                tranche_index : arg0.tranches_done,
                ts_ms         : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<TrancheReleased>(v1);
        };
    }

    public fun create<T0>(arg0: &mut StreamRegistry, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 200);
        assert!(arg4 > 0, 201);
        assert!(arg3 > 0, 201);
        assert!(arg6 > 0, 201);
        assert!(arg4 - 1 <= v0 / arg3, 201);
        let v1 = Stream<T0>{
            id              : 0x2::object::new(arg8),
            sender          : 0x2::tx_context::sender(arg8),
            recipient       : arg2,
            escrow          : arg1,
            total_amount    : v0,
            released_amount : 0,
            tranche_amount  : arg3,
            num_tranches    : arg4,
            tranches_done   : 0,
            start_ms        : arg5,
            interval_ms     : arg6,
            paused          : false,
            cancelled       : false,
        };
        let v2 = 0x2::object::id<Stream<T0>>(&v1);
        arg0.streams_total = arg0.streams_total + 1;
        let v3 = StreamCreated{
            stream_id      : v2,
            sender         : 0x2::tx_context::sender(arg8),
            recipient      : arg2,
            total          : v0,
            tranche_amount : arg3,
            num_tranches   : arg4,
            start_ms       : arg5,
            interval_ms    : arg6,
        };
        0x2::event::emit<StreamCreated>(v3);
        0x2::transfer::share_object<Stream<T0>>(v1);
        v2
    }

    public fun escrow_value<T0>(arg0: &Stream<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StreamRegistry{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            worker_addresses : vector[],
            paused           : false,
            streams_total    : 0,
        };
        0x2::transfer::share_object<StreamRegistry>(v0);
        let v1 = StreamAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<StreamAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_cancelled<T0>(arg0: &Stream<T0>) : bool {
        arg0.cancelled
    }

    public fun is_paused<T0>(arg0: &Stream<T0>) : bool {
        arg0.paused
    }

    public fun is_worker(arg0: &StreamRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.worker_addresses, &arg1)
    }

    public fun pause<T0>(arg0: &mut Stream<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.sender, 208);
        arg0.paused = true;
        let v0 = StreamPaused{stream_id: 0x2::object::id<Stream<T0>>(arg0)};
        0x2::event::emit<StreamPaused>(v0);
    }

    public fun recipient<T0>(arg0: &Stream<T0>) : address {
        arg0.recipient
    }

    public fun registry_paused(arg0: &StreamRegistry) : bool {
        arg0.paused
    }

    public fun release<T0>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 203);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.worker_addresses, &v0), 202);
        assert!(!arg1.cancelled, 205);
        assert!(!arg1.paused, 204);
        assert!(arg1.tranches_done < arg1.num_tranches, 206);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.start_ms + arg1.tranches_done * arg1.interval_ms, 207);
        let v1 = if (arg1.tranches_done + 1 == arg1.num_tranches) {
            0x2::balance::value<T0>(&arg1.escrow)
        } else {
            arg1.tranche_amount
        };
        arg1.released_amount = arg1.released_amount + v1;
        arg1.tranches_done = arg1.tranches_done + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.escrow, v1), arg3), arg1.recipient);
        let v2 = TrancheReleased{
            stream_id     : 0x2::object::id<Stream<T0>>(arg1),
            recipient     : arg1.recipient,
            amount        : v1,
            tranche_index : arg1.tranches_done,
            ts_ms         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TrancheReleased>(v2);
    }

    public fun released_amount<T0>(arg0: &Stream<T0>) : u64 {
        arg0.released_amount
    }

    public fun remove_worker(arg0: &mut StreamRegistry, arg1: &StreamAdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.worker_addresses, &arg2);
        assert!(v0, 210);
        0x1::vector::remove<address>(&mut arg0.worker_addresses, v1);
        let v2 = WorkerRemoved{worker: arg2};
        0x2::event::emit<WorkerRemoved>(v2);
    }

    public fun resume<T0>(arg0: &mut Stream<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.sender, 208);
        arg0.paused = false;
        let v0 = StreamResumed{stream_id: 0x2::object::id<Stream<T0>>(arg0)};
        0x2::event::emit<StreamResumed>(v0);
    }

    public fun set_paused(arg0: &mut StreamRegistry, arg1: &StreamAdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun tranches_done<T0>(arg0: &Stream<T0>) : u64 {
        arg0.tranches_done
    }

    // decompiled from Move bytecode v7
}

