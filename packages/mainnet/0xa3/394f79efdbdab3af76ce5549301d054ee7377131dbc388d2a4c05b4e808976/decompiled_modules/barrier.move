module 0xa3394f79efdbdab3af76ce5549301d054ee7377131dbc388d2a4c05b4e808976::barrier {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        oracle_pubkey: vector<u8>,
        payee: address,
        delivery_window_ms: u64,
        payout_window_ms: u64,
        by_user: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct Barrier<phantom T0> has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        user: address,
        instrument: vector<u8>,
        underlying: vector<u8>,
        kind: u8,
        strike: u64,
        barrier: u64,
        amount: u64,
        opened_ms: u64,
        expiry_ms: u64,
        premium: 0x2::balance::Balance<T0>,
        status: u8,
        deadline_ms: u64,
        reference: vector<u8>,
        payout: u64,
    }

    struct QuoteProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        user: address,
        instrument: vector<u8>,
        underlying: vector<u8>,
        kind: u8,
        strike: u64,
        barrier: u64,
        amount: u64,
        premium: u64,
        expiry_ms: u64,
        quote_expiry_ms: u64,
    }

    struct TouchProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        underlying: vector<u8>,
        price: u64,
        timestamp_ms: u64,
    }

    struct NoTouchProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        underlying: vector<u8>,
        low: u64,
        high: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct Opened has copy, drop {
        barrier_id: 0x2::object::ID,
        user: address,
        instrument: vector<u8>,
        underlying: vector<u8>,
        kind: u8,
        strike: u64,
        barrier: u64,
        amount: u64,
        premium: u64,
        opened_ms: u64,
        expiry_ms: u64,
    }

    struct StatusChanged has copy, drop {
        barrier_id: 0x2::object::ID,
        status: u8,
        reference: vector<u8>,
        payout: u64,
        at_ms: u64,
    }

    public fun attest_delivery<T0>(arg0: &OperatorCap, arg1: &Registry, arg2: &mut Barrier<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 1, 5);
        arg2.reference = arg3;
        pay<T0>(arg2, arg1.payee, arg5);
        changed<T0>(arg2, 2, 0x2::clock::timestamp_ms(arg4));
    }

    public fun attest_payout<T0>(arg0: &OperatorCap, arg1: &Registry, arg2: &mut Barrier<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 5, 5);
        arg2.reference = arg3;
        arg2.payout = arg4;
        pay<T0>(arg2, arg1.payee, arg6);
        changed<T0>(arg2, 6, 0x2::clock::timestamp_ms(arg5));
    }

    fun changed<T0>(arg0: &mut Barrier<T0>, arg1: u8, arg2: u64) {
        arg0.status = arg1;
        let v0 = StatusChanged{
            barrier_id : 0x2::object::id<Barrier<T0>>(arg0),
            status     : arg1,
            reference  : arg0.reference,
            payout     : arg0.payout,
            at_ms      : arg2,
        };
        0x2::event::emit<StatusChanged>(v0);
    }

    public fun create_registry(arg0: &OperatorCap, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                 : 0x2::object::new(arg5),
            oracle_pubkey      : arg1,
            payee              : arg2,
            delivery_window_ms : arg3,
            payout_window_ms   : arg4,
            by_user            : 0x2::table::new<address, vector<0x2::object::ID>>(arg5),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun deadline_ms<T0>(arg0: &Barrier<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun expire<T0>(arg0: &Registry, arg1: &mut Barrier<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= arg1.expiry_ms, 8);
        let v1 = NoTouchProof{
            domain     : b"paramx-barrier-v1",
            registry   : arg1.registry,
            underlying : arg1.underlying,
            low        : arg2,
            high       : arg3,
            start_ms   : arg4,
            end_ms     : arg5,
        };
        verify<NoTouchProof>(arg0, v1, &arg6);
        assert!(arg4 <= arg1.opened_ms && arg5 >= arg1.expiry_ms, 9);
        assert!(is_up(arg1.kind) && arg2 <= arg1.barrier && arg3 == 18446744073709551615 || arg2 == 0 && arg3 >= arg1.barrier, 9);
        if (is_in(arg1.kind)) {
            pay<T0>(arg1, arg0.payee, arg8);
            changed<T0>(arg1, 4, v0);
        } else {
            arg1.deadline_ms = v0 + arg0.payout_window_ms;
            changed<T0>(arg1, 5, v0);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_in(arg0: u8) : bool {
        arg0 == 0 || arg0 == 2
    }

    fun is_up(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    public fun knock<T0>(arg0: &Registry, arg1: &mut Barrier<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 5);
        let v0 = TouchProof{
            domain       : b"paramx-barrier-v1",
            registry     : arg1.registry,
            underlying   : arg1.underlying,
            price        : arg2,
            timestamp_ms : arg3,
        };
        verify<TouchProof>(arg0, v0, &arg4);
        assert!(arg3 >= arg1.opened_ms && arg3 <= arg1.expiry_ms, 7);
        assert!(is_up(arg1.kind) && arg2 >= arg1.barrier || arg2 <= arg1.barrier, 6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        if (is_in(arg1.kind)) {
            arg1.deadline_ms = v1 + arg0.delivery_window_ms;
            changed<T0>(arg1, 1, v1);
        } else {
            pay<T0>(arg1, arg0.payee, arg6);
            changed<T0>(arg1, 3, v1);
        };
    }

    public fun open<T0>(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: 0x2::coin::Coin<T0>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = QuoteProof{
            domain          : b"paramx-barrier-v1",
            registry        : 0x2::object::id<Registry>(arg0),
            user            : v0,
            instrument      : arg1,
            underlying      : arg2,
            kind            : arg3,
            strike          : arg4,
            barrier         : arg5,
            amount          : arg6,
            premium         : arg7,
            expiry_ms       : arg8,
            quote_expiry_ms : arg9,
        };
        verify<QuoteProof>(arg0, v1, &arg10);
        let v2 = 0x2::clock::timestamp_ms(arg12);
        assert!(v2 <= arg9, 3);
        assert!(v2 < arg8, 12);
        assert!(arg3 <= 3, 11);
        assert!(0x2::coin::value<T0>(&arg11) >= arg7, 4);
        let v3 = Barrier<T0>{
            id          : 0x2::object::new(arg13),
            registry    : 0x2::object::id<Registry>(arg0),
            user        : v0,
            instrument  : arg1,
            underlying  : arg2,
            kind        : arg3,
            strike      : arg4,
            barrier     : arg5,
            amount      : arg6,
            opened_ms   : v2,
            expiry_ms   : arg8,
            premium     : 0x2::coin::into_balance<T0>(arg11),
            status      : 0,
            deadline_ms : 0,
            reference   : b"",
            payout      : 0,
        };
        let v4 = 0x2::object::id<Barrier<T0>>(&v3);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_user, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.by_user, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_user, v0), v4);
        let v5 = Opened{
            barrier_id : v4,
            user       : v0,
            instrument : v3.instrument,
            underlying : v3.underlying,
            kind       : arg3,
            strike     : arg4,
            barrier    : arg5,
            amount     : arg6,
            premium    : 0x2::coin::value<T0>(&arg11),
            opened_ms  : v2,
            expiry_ms  : arg8,
        };
        0x2::event::emit<Opened>(v5);
        0x2::transfer::share_object<Barrier<T0>>(v3);
    }

    fun pay<T0>(arg0: &mut Barrier<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.premium, 0x2::balance::value<T0>(&arg0.premium)), arg2), arg1);
    }

    public fun premium_held<T0>(arg0: &Barrier<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.premium)
    }

    public fun refund<T0>(arg0: &mut Barrier<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.user, 13);
        assert!(arg0.status == 1 || arg0.status == 5, 5);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > arg0.deadline_ms, 10);
        let v1 = arg0.user;
        pay<T0>(arg0, v1, arg2);
        changed<T0>(arg0, 7, v0);
    }

    public fun set_oracle(arg0: &OperatorCap, arg1: &mut Registry, arg2: vector<u8>) {
        arg1.oracle_pubkey = arg2;
    }

    public fun set_payee(arg0: &OperatorCap, arg1: &mut Registry, arg2: address) {
        arg1.payee = arg2;
    }

    public fun status<T0>(arg0: &Barrier<T0>) : u8 {
        arg0.status
    }

    public fun user<T0>(arg0: &Barrier<T0>) : address {
        arg0.user
    }

    public fun user_barriers(arg0: &Registry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_user, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.by_user, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    fun verify<T0: drop>(arg0: &Registry, arg1: T0, arg2: &vector<u8>) {
        let v0 = 0x2::bcs::to_bytes<T0>(&arg1);
        assert!(0x2::ed25519::ed25519_verify(arg2, &arg0.oracle_pubkey, &v0), 1);
    }

    // decompiled from Move bytecode v7
}

