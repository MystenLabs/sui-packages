module 0xd491f822b97184f7462e56d1c49879b323e5b01bb6c9557cae810fdd0488edff::booking_escrow {
    struct BookingEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        booking: 0x1::string::String,
        booker: address,
        seller: address,
        arbiter: address,
        amount: u64,
        starts_ms: u64,
        ends_ms: u64,
        disputed_at_ms: u64,
        state: u8,
        vote_booker: u8,
        vote_seller: u8,
        vote_arbiter: u8,
        held: 0x2::balance::Balance<T0>,
    }

    struct EscrowOpened<phantom T0> has copy, drop {
        escrow: 0x2::object::ID,
        booking: 0x1::string::String,
        booker: address,
        seller: address,
        arbiter: address,
        amount: u64,
        starts_ms: u64,
        ends_ms: u64,
    }

    struct EscrowReleased<phantom T0> has copy, drop {
        escrow: 0x2::object::ID,
        booking: 0x1::string::String,
        seller: address,
        amount: u64,
        by: address,
    }

    struct EscrowRefunded<phantom T0> has copy, drop {
        escrow: 0x2::object::ID,
        booking: 0x1::string::String,
        booker: address,
        amount: u64,
        by: address,
    }

    struct EscrowDisputed<phantom T0> has copy, drop {
        escrow: 0x2::object::ID,
        booking: 0x1::string::String,
        at_ms: u64,
    }

    struct DisputeVoted<phantom T0> has copy, drop {
        escrow: 0x2::object::ID,
        by: address,
        outcome: u8,
    }

    public fun abandon<T0>(arg0: &mut BookingEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3, 13);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.disputed_at_ms + 15552000000, 3);
        pay_booker<T0>(arg0, arg2);
    }

    public fun amount<T0>(arg0: &BookingEscrow<T0>) : u64 {
        arg0.amount
    }

    public fun arbiter<T0>(arg0: &BookingEscrow<T0>) : address {
        arg0.arbiter
    }

    public fun booker<T0>(arg0: &BookingEscrow<T0>) : address {
        arg0.booker
    }

    public fun booking<T0>(arg0: &BookingEscrow<T0>) : 0x1::string::String {
        arg0.booking
    }

    public fun claim<T0>(arg0: &mut BookingEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 9);
        assert!(arg0.state == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.ends_ms + 259200000, 3);
        pay_seller<T0>(arg0, arg2);
    }

    fun count(arg0: u8, arg1: u8) : u64 {
        if (arg0 == arg1) {
            1
        } else {
            0
        }
    }

    public fun dead_man_ms() : u64 {
        15552000000
    }

    public fun dispute<T0>(arg0: &mut BookingEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.booker, 1);
        assert!(arg0.state == 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.starts_ms && v0 < arg0.ends_ms + 259200000, 14);
        arg0.state = 3;
        arg0.disputed_at_ms = v0;
        let v1 = EscrowDisputed<T0>{
            escrow  : 0x2::object::id<BookingEscrow<T0>>(arg0),
            booking : arg0.booking,
            at_ms   : v0,
        };
        0x2::event::emit<EscrowDisputed<T0>>(v1);
    }

    public fun dispute_window_ms() : u64 {
        259200000
    }

    public fun ends_ms<T0>(arg0: &BookingEscrow<T0>) : u64 {
        arg0.ends_ms
    }

    public fun held<T0>(arg0: &BookingEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.held)
    }

    public fun is_disputed<T0>(arg0: &BookingEscrow<T0>) : bool {
        arg0.state == 3
    }

    public fun is_open<T0>(arg0: &BookingEscrow<T0>) : bool {
        arg0.state == 0
    }

    public fun open<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg1 > 0, 4);
        assert!(0x2::coin::value<T0>(&arg0) == arg1, 5);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg7) && arg6 >= arg5, 6);
        let v1 = if (arg3 != v0) {
            if (arg4 != v0) {
                arg4 != arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 7);
        let v2 = BookingEscrow<T0>{
            id             : 0x2::object::new(arg8),
            booking        : arg2,
            booker         : v0,
            seller         : arg3,
            arbiter        : arg4,
            amount         : arg1,
            starts_ms      : arg5,
            ends_ms        : arg6,
            disputed_at_ms : 0,
            state          : 0,
            vote_booker    : 0,
            vote_seller    : 0,
            vote_arbiter   : 0,
            held           : 0x2::coin::into_balance<T0>(arg0),
        };
        let v3 = 0x2::object::id<BookingEscrow<T0>>(&v2);
        let v4 = EscrowOpened<T0>{
            escrow    : v3,
            booking   : v2.booking,
            booker    : v0,
            seller    : arg3,
            arbiter   : arg4,
            amount    : arg1,
            starts_ms : arg5,
            ends_ms   : arg6,
        };
        0x2::event::emit<EscrowOpened<T0>>(v4);
        0x2::transfer::share_object<BookingEscrow<T0>>(v2);
        v3
    }

    fun pay_booker<T0>(arg0: &mut BookingEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.state = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.held), arg1), arg0.booker);
        let v0 = EscrowRefunded<T0>{
            escrow  : 0x2::object::id<BookingEscrow<T0>>(arg0),
            booking : arg0.booking,
            booker  : arg0.booker,
            amount  : 0x2::balance::value<T0>(&arg0.held),
            by      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EscrowRefunded<T0>>(v0);
    }

    fun pay_seller<T0>(arg0: &mut BookingEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.state = 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.held), arg1), arg0.seller);
        let v0 = EscrowReleased<T0>{
            escrow  : 0x2::object::id<BookingEscrow<T0>>(arg0),
            booking : arg0.booking,
            seller  : arg0.seller,
            amount  : 0x2::balance::value<T0>(&arg0.held),
            by      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EscrowReleased<T0>>(v0);
    }

    public fun refund<T0>(arg0: &mut BookingEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg0.booker) {
            assert!(0x2::clock::timestamp_ms(arg1) < arg0.starts_ms, 8);
        } else {
            assert!(v0 == arg0.seller, 10);
        };
        pay_booker<T0>(arg0, arg2);
    }

    public fun release<T0>(arg0: &mut BookingEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.booker, 1);
        assert!(arg0.state == 0, 2);
        pay_seller<T0>(arg0, arg1);
    }

    public fun seller<T0>(arg0: &BookingEscrow<T0>) : address {
        arg0.seller
    }

    public fun starts_ms<T0>(arg0: &BookingEscrow<T0>) : u64 {
        arg0.starts_ms
    }

    public fun state<T0>(arg0: &BookingEscrow<T0>) : u8 {
        arg0.state
    }

    public fun vote<T0>(arg0: &mut BookingEscrow<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3, 13);
        assert!(arg1 == 1 || arg1 == 2, 12);
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg0.booker) {
            assert!(arg0.vote_booker == 0, 11);
            arg0.vote_booker = arg1;
        } else if (v0 == arg0.seller) {
            assert!(arg0.vote_seller == 0, 11);
            arg0.vote_seller = arg1;
        } else {
            assert!(v0 == arg0.arbiter, 10);
            assert!(arg0.vote_arbiter == 0, 11);
            arg0.vote_arbiter = arg1;
        };
        let v1 = DisputeVoted<T0>{
            escrow  : 0x2::object::id<BookingEscrow<T0>>(arg0),
            by      : v0,
            outcome : arg1,
        };
        0x2::event::emit<DisputeVoted<T0>>(v1);
        if (count(arg0.vote_booker, arg1) + count(arg0.vote_seller, arg1) + count(arg0.vote_arbiter, arg1) >= 2) {
            if (arg1 == 1) {
                pay_seller<T0>(arg0, arg2);
            } else {
                pay_booker<T0>(arg0, arg2);
            };
        };
    }

    // decompiled from Move bytecode v7
}

