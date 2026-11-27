module 0xef31466306bc7d4b5e56e85f61a0edd43fd673c075d19d50be02d8def0072073::stream {
    struct StreamRegistry has key {
        id: 0x2::object::UID,
        paused: bool,
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
        stopped_at_ms: u64,
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

    struct TranchesReleased has copy, drop {
        stream_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        from_tranche: u64,
        tranches_done: u64,
        released_amount: u64,
        ts_ms: u64,
    }

    struct StreamPaused has copy, drop {
        stream_id: 0x2::object::ID,
        paused_at_ms: u64,
    }

    struct StreamResumed has copy, drop {
        stream_id: 0x2::object::ID,
        shift_ms: u64,
        start_ms: u64,
    }

    struct StreamCancelled has copy, drop {
        stream_id: 0x2::object::ID,
        settled: u64,
        refunded: u64,
        released: u64,
        reserved: u64,
    }

    struct RegistryPauseChanged has copy, drop {
        paused: bool,
    }

    public fun sender<T0>(arg0: &Stream<T0>) : address {
        arg0.sender
    }

    fun can_receive<T0>(arg0: &0x2::deny_list::DenyList, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        !0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<T0>(arg0, arg2) && !0x2::coin::deny_list_v2_contains_current_epoch<T0>(arg0, arg1, arg2)
    }

    public fun cancel<T0>(arg0: &mut Stream<T0>, arg1: &0x2::deny_list::DenyList, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.cancelled, 205);
        assert!(0x2::tx_context::sender(arg3) == arg0.sender, 208);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = due_tranches<T0>(arg0, v0);
        assert!(v1 < arg0.num_tranches, 206);
        let v2 = arg0.total_amount - paid_through<T0>(arg0, v1);
        if (!arg0.paused) {
            arg0.stopped_at_ms = v0;
        };
        arg0.cancelled = true;
        let v3 = 0x2::balance::split<T0>(&mut arg0.escrow, v2);
        let v4 = if (can_receive<T0>(arg1, arg0.recipient, arg3)) {
            settle<T0>(arg0, v0, arg3)
        } else {
            0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg3), arg0.sender);
        let v5 = StreamCancelled{
            stream_id : 0x2::object::id<Stream<T0>>(arg0),
            settled   : v4,
            refunded  : v2,
            released  : arg0.released_amount,
            reserved  : 0x2::balance::value<T0>(&arg0.escrow),
        };
        0x2::event::emit<StreamCancelled>(v5);
    }

    public fun claim_accrued<T0>(arg0: &mut Stream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        settle<T0>(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    public fun claimable<T0>(arg0: &Stream<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = due_tranches<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        if (v0 <= arg0.tranches_done) {
            return 0
        };
        paid_through<T0>(arg0, v0) - arg0.released_amount
    }

    public fun create<T0>(arg0: &StreamRegistry, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 203);
        assert!(arg2 != @0x0, 213);
        assert!(arg4 > 0, 201);
        assert!(arg4 <= 1000, 212);
        assert!(arg3 > 0, 201);
        assert!(arg6 > 0, 201);
        assert!(arg6 <= 31622400000, 216);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg5 <= v0 + 31622400000, 215);
        let v1 = 0x2::balance::value<T0>(&arg1);
        assert!(v1 > 0, 200);
        assert!(arg4 - 1 <= (v1 - 1) / arg3, 201);
        let v2 = 0x1::u64::max(arg5, v0);
        let v3 = 0x2::tx_context::sender(arg8);
        let v4 = Stream<T0>{
            id              : 0x2::object::new(arg8),
            sender          : v3,
            recipient       : arg2,
            escrow          : arg1,
            total_amount    : v1,
            released_amount : 0,
            tranche_amount  : arg3,
            num_tranches    : arg4,
            tranches_done   : 0,
            start_ms        : v2,
            interval_ms     : arg6,
            paused          : false,
            stopped_at_ms   : 0,
            cancelled       : false,
        };
        let v5 = 0x2::object::id<Stream<T0>>(&v4);
        let v6 = StreamCreated{
            stream_id      : v5,
            sender         : v3,
            recipient      : arg2,
            total          : v1,
            tranche_amount : arg3,
            num_tranches   : arg4,
            start_ms       : v2,
            interval_ms    : arg6,
        };
        0x2::event::emit<StreamCreated>(v6);
        0x2::transfer::share_object<Stream<T0>>(v4);
        v5
    }

    fun due_tranches<T0>(arg0: &Stream<T0>, arg1: u64) : u64 {
        let v0 = if (arg0.paused || arg0.cancelled) {
            arg0.stopped_at_ms
        } else {
            arg1
        };
        if (v0 < arg0.start_ms) {
            return 0
        };
        let v1 = (v0 - arg0.start_ms) / arg0.interval_ms;
        if (v1 >= arg0.num_tranches) {
            arg0.num_tranches
        } else {
            v1 + 1
        }
    }

    public fun escrow_value<T0>(arg0: &Stream<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StreamRegistry{
            id     : 0x2::object::new(arg0),
            paused : false,
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

    fun paid_through<T0>(arg0: &Stream<T0>, arg1: u64) : u64 {
        if (arg1 >= arg0.num_tranches) {
            arg0.total_amount
        } else {
            arg1 * arg0.tranche_amount
        }
    }

    public fun pause<T0>(arg0: &mut Stream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.cancelled, 205);
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 208);
        assert!(!arg0.paused, 214);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(due_tranches<T0>(arg0, v0) < arg0.num_tranches, 206);
        arg0.paused = true;
        arg0.stopped_at_ms = v0;
        let v1 = StreamPaused{
            stream_id    : 0x2::object::id<Stream<T0>>(arg0),
            paused_at_ms : v0,
        };
        0x2::event::emit<StreamPaused>(v1);
    }

    public fun recipient<T0>(arg0: &Stream<T0>) : address {
        arg0.recipient
    }

    public fun registry_paused(arg0: &StreamRegistry) : bool {
        arg0.paused
    }

    public fun released_amount<T0>(arg0: &Stream<T0>) : u64 {
        arg0.released_amount
    }

    public fun resume<T0>(arg0: &mut Stream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.cancelled, 205);
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 208);
        assert!(arg0.paused, 214);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x1::u64::max(arg0.stopped_at_ms, arg0.start_ms);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        let v3 = arg0.start_ms + v2;
        arg0.start_ms = v3;
        arg0.paused = false;
        arg0.stopped_at_ms = 0;
        let v4 = StreamResumed{
            stream_id : 0x2::object::id<Stream<T0>>(arg0),
            shift_ms  : v2,
            start_ms  : v3,
        };
        0x2::event::emit<StreamResumed>(v4);
    }

    public fun set_paused(arg0: &mut StreamRegistry, arg1: &StreamAdminCap, arg2: bool) {
        assert!(arg2 != arg0.paused, 214);
        arg0.paused = arg2;
        let v0 = RegistryPauseChanged{paused: arg2};
        0x2::event::emit<RegistryPauseChanged>(v0);
    }

    fun settle<T0>(arg0: &mut Stream<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = due_tranches<T0>(arg0, arg1);
        let v1 = arg0.tranches_done;
        if (v0 <= v1) {
            return 0
        };
        let v2 = paid_through<T0>(arg0, v0);
        let v3 = v2 - arg0.released_amount;
        arg0.tranches_done = v0;
        arg0.released_amount = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v3), arg2), arg0.recipient);
        let v4 = TranchesReleased{
            stream_id       : 0x2::object::id<Stream<T0>>(arg0),
            recipient       : arg0.recipient,
            amount          : v3,
            from_tranche    : v1,
            tranches_done   : v0,
            released_amount : v2,
            ts_ms           : arg1,
        };
        0x2::event::emit<TranchesReleased>(v4);
        v3
    }

    public fun start_ms<T0>(arg0: &Stream<T0>) : u64 {
        arg0.start_ms
    }

    public fun tranches_done<T0>(arg0: &Stream<T0>) : u64 {
        arg0.tranches_done
    }

    // decompiled from Move bytecode v7
}

