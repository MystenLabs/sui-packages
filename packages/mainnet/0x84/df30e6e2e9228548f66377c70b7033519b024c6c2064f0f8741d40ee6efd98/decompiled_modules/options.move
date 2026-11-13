module 0x9c2d79460b654959fb36911d75b9cb29d7c1cc6f545380742b9a8a2710db2204::options {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry<phantom T0> has key {
        id: 0x2::object::UID,
        oracle_pubkey: vector<u8>,
        vault: 0x2::balance::Balance<T0>,
        locked: u64,
        by_user: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct Position<phantom T0> has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        user: address,
        underlying: vector<u8>,
        hedge: vector<u8>,
        option_type: u8,
        barrier_kind: u8,
        strike: u64,
        barrier: u64,
        cap: u64,
        amount: u64,
        premium: u64,
        opened_ms: u64,
        expiry_ms: u64,
        collateral: 0x2::balance::Balance<T0>,
        status: u8,
        payout: u64,
    }

    struct QuoteProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        user: address,
        underlying: vector<u8>,
        hedge: vector<u8>,
        option_type: u8,
        barrier_kind: u8,
        strike: u64,
        barrier: u64,
        cap: u64,
        amount: u64,
        premium: u64,
        expiry_ms: u64,
        quote_expiry_ms: u64,
    }

    struct CloseProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        user: address,
        price: u64,
        quote_expiry_ms: u64,
    }

    struct OrderCloseProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        user: address,
        price: u64,
        order: u64,
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

    struct SettleProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        underlying: vector<u8>,
        expiry_ms: u64,
        price: u64,
    }

    struct Opened has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        underlying: vector<u8>,
        hedge: vector<u8>,
        option_type: u8,
        barrier_kind: u8,
        strike: u64,
        barrier: u64,
        cap: u64,
        amount: u64,
        premium: u64,
        opened_ms: u64,
        expiry_ms: u64,
    }

    struct StatusChanged has copy, drop {
        position_id: 0x2::object::ID,
        status: u8,
        payout: u64,
        at_ms: u64,
    }

    fun changed<T0>(arg0: &mut Position<T0>, arg1: u8, arg2: u64) {
        arg0.status = arg1;
        let v0 = StatusChanged{
            position_id : 0x2::object::id<Position<T0>>(arg0),
            status      : arg1,
            payout      : arg0.payout,
            at_ms       : arg2,
        };
        0x2::event::emit<StatusChanged>(v0);
    }

    fun check_registry<T0>(arg0: &Registry<T0>, arg1: &Position<T0>) {
        assert!(arg1.registry == 0x2::object::id<Registry<T0>>(arg0), 17);
    }

    public fun close<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg6) == arg1.user, 2);
        assert!(arg1.status == 0 || arg1.status == 1, 5);
        let v0 = CloseProof{
            domain          : b"paramx-options-v1",
            registry        : arg1.registry,
            position        : 0x2::object::id<Position<T0>>(arg1),
            user            : arg1.user,
            price           : arg2,
            quote_expiry_ms : arg3,
        };
        verify<T0, CloseProof>(arg0, v0, &arg4);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 <= arg3, 3);
        assert!(v1 < arg1.expiry_ms, 12);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.collateral), 16);
        release<T0>(arg0, arg1, arg2, arg6);
        changed<T0>(arg1, 3, v1);
    }

    public fun close_for<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0 || arg1.status == 1, 5);
        let v0 = OrderCloseProof{
            domain          : b"paramx-options-v1",
            registry        : arg1.registry,
            position        : 0x2::object::id<Position<T0>>(arg1),
            user            : arg1.user,
            price           : arg2,
            order           : arg3,
            quote_expiry_ms : arg4,
        };
        verify<T0, OrderCloseProof>(arg0, v0, &arg5);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 <= arg4, 3);
        assert!(v1 < arg1.expiry_ms, 12);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.collateral), 16);
        release<T0>(arg0, arg1, arg2, arg7);
        changed<T0>(arg1, 3, v1);
    }

    fun collateral_for(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + 100000000 - 1) / 100000000) as u64)
    }

    public fun collateral_held<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun create_registry<T0>(arg0: &OperatorCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry<T0>{
            id            : 0x2::object::new(arg2),
            oracle_pubkey : arg1,
            vault         : 0x2::balance::zero<T0>(),
            locked        : 0,
            by_user       : 0x2::table::new<address, vector<0x2::object::ID>>(arg2),
        };
        0x2::transfer::share_object<Registry<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Registry<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun expire<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0, 5);
        assert!(is_in(arg1.barrier_kind), 11);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= arg1.expiry_ms, 8);
        verify_no_touch<T0>(arg0, arg1, arg2, arg3, arg4, arg5, &arg6);
        release_all<T0>(arg0, arg1);
        changed<T0>(arg1, 5, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_in(arg0: u8) : bool {
        arg0 == 1 || arg0 == 3
    }

    fun is_out(arg0: u8) : bool {
        arg0 == 2 || arg0 == 4
    }

    fun is_up(arg0: u8) : bool {
        arg0 == 1 || arg0 == 2
    }

    public fun knock<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0, 5);
        assert!(arg1.barrier_kind != 0, 11);
        let v0 = TouchProof{
            domain       : b"paramx-options-v1",
            registry     : arg1.registry,
            underlying   : arg1.underlying,
            price        : arg2,
            timestamp_ms : arg3,
        };
        verify<T0, TouchProof>(arg0, v0, &arg4);
        assert!(arg3 >= arg1.opened_ms && arg3 <= arg1.expiry_ms, 7);
        assert!(is_up(arg1.barrier_kind) && arg2 >= arg1.barrier || arg2 <= arg1.barrier, 6);
        if (is_in(arg1.barrier_kind)) {
            changed<T0>(arg1, 1, 0x2::clock::timestamp_ms(arg5));
        } else {
            release_all<T0>(arg0, arg1);
            changed<T0>(arg1, 2, 0x2::clock::timestamp_ms(arg5));
        };
    }

    public fun locked<T0>(arg0: &Registry<T0>) : u64 {
        arg0.locked
    }

    public fun open<T0>(arg0: &mut Registry<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        open_as<T0>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    fun open_as<T0>(arg0: &mut Registry<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = QuoteProof{
            domain          : b"paramx-options-v1",
            registry        : 0x2::object::id<Registry<T0>>(arg0),
            user            : arg1,
            underlying      : arg2,
            hedge           : arg3,
            option_type     : arg4,
            barrier_kind    : arg5,
            strike          : arg6,
            barrier         : arg7,
            cap             : arg8,
            amount          : arg9,
            premium         : arg10,
            expiry_ms       : arg11,
            quote_expiry_ms : arg12,
        };
        verify<T0, QuoteProof>(arg0, v0, &arg13);
        let v1 = 0x2::clock::timestamp_ms(arg15);
        assert!(v1 <= arg12, 3);
        assert!(v1 < arg11, 12);
        assert!(arg4 <= 1, 13);
        assert!(arg5 <= 4, 11);
        assert!(arg5 == 0 && arg7 == 0 || arg7 > 0, 11);
        assert!(arg8 > 0 && arg9 > 0, 14);
        assert!(arg4 == 0 || arg8 <= arg6, 15);
        assert!(0x2::coin::value<T0>(&arg14) >= arg10, 4);
        let v2 = 0x2::coin::value<T0>(&arg14);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg14));
        let v3 = collateral_for(arg8, arg9);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v3, 10);
        arg0.locked = arg0.locked + v3;
        let v4 = Position<T0>{
            id           : 0x2::object::new(arg16),
            registry     : 0x2::object::id<Registry<T0>>(arg0),
            user         : arg1,
            underlying   : arg2,
            hedge        : arg3,
            option_type  : arg4,
            barrier_kind : arg5,
            strike       : arg6,
            barrier      : arg7,
            cap          : arg8,
            amount       : arg9,
            premium      : v2,
            opened_ms    : v1,
            expiry_ms    : arg11,
            collateral   : 0x2::balance::split<T0>(&mut arg0.vault, v3),
            status       : 0,
            payout       : 0,
        };
        let v5 = 0x2::object::id<Position<T0>>(&v4);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_user, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.by_user, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_user, arg1), v5);
        let v6 = Opened{
            position_id  : v5,
            user         : arg1,
            underlying   : v4.underlying,
            hedge        : v4.hedge,
            option_type  : arg4,
            barrier_kind : arg5,
            strike       : arg6,
            barrier      : arg7,
            cap          : arg8,
            amount       : arg9,
            premium      : v2,
            opened_ms    : v1,
            expiry_ms    : arg11,
        };
        0x2::event::emit<Opened>(v6);
        0x2::transfer::share_object<Position<T0>>(v4);
    }

    public fun open_for<T0>(arg0: &mut Registry<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        open_as<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public fun payout<T0>(arg0: &Position<T0>) : u64 {
        arg0.payout
    }

    fun payout_for<T0>(arg0: &Position<T0>, arg1: u64) : u64 {
        let v0 = if (arg0.option_type == 0) {
            if (arg1 > arg0.strike) {
                arg1 - arg0.strike
            } else {
                0
            }
        } else if (arg0.strike > arg1) {
            arg0.strike - arg1
        } else {
            0
        };
        let v1 = if (v0 < arg0.cap) {
            v0
        } else {
            arg0.cap
        };
        (((v1 as u128) * (arg0.amount as u128) / 100000000) as u64)
    }

    fun release<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.locked = arg0.locked - 0x2::balance::value<T0>(&arg1.collateral);
        arg1.payout = arg2;
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral, arg2), arg3), arg1.user);
        };
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::withdraw_all<T0>(&mut arg1.collateral));
    }

    fun release_all<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>) {
        arg0.locked = arg0.locked - 0x2::balance::value<T0>(&arg1.collateral);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::withdraw_all<T0>(&mut arg1.collateral));
    }

    public fun set_oracle<T0>(arg0: &OperatorCap, arg1: &mut Registry<T0>, arg2: vector<u8>) {
        arg1.oracle_pubkey = arg2;
    }

    public fun settle<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0 && arg1.barrier_kind == 0 || arg1.status == 1, 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg1.expiry_ms, 8);
        settle_at<T0>(arg0, arg1, arg2, &arg3, v0, arg5);
    }

    fun settle_at<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: &vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SettleProof{
            domain     : b"paramx-options-v1",
            registry   : arg1.registry,
            underlying : arg1.underlying,
            expiry_ms  : arg1.expiry_ms,
            price      : arg2,
        };
        verify<T0, SettleProof>(arg0, v0, arg3);
        let v1 = payout_for<T0>(arg1, arg2);
        release<T0>(arg0, arg1, v1, arg5);
        changed<T0>(arg1, 4, arg4);
    }

    public fun settle_knock_out<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0, 5);
        assert!(is_out(arg1.barrier_kind), 11);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(v0 >= arg1.expiry_ms, 8);
        verify_no_touch<T0>(arg0, arg1, arg2, arg3, arg4, arg5, &arg6);
        settle_at<T0>(arg0, arg1, arg7, &arg8, v0, arg10);
    }

    public fun status<T0>(arg0: &Position<T0>) : u8 {
        arg0.status
    }

    public fun user<T0>(arg0: &Position<T0>) : address {
        arg0.user
    }

    public fun user_positions<T0>(arg0: &Registry<T0>, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_user, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.by_user, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun vault_value<T0>(arg0: &Registry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    fun verify<T0, T1: drop>(arg0: &Registry<T0>, arg1: T1, arg2: &vector<u8>) {
        let v0 = 0x2::bcs::to_bytes<T1>(&arg1);
        assert!(0x2::ed25519::ed25519_verify(arg2, &arg0.oracle_pubkey, &v0), 1);
    }

    fun verify_no_touch<T0>(arg0: &Registry<T0>, arg1: &Position<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &vector<u8>) {
        let v0 = NoTouchProof{
            domain     : b"paramx-options-v1",
            registry   : arg1.registry,
            underlying : arg1.underlying,
            low        : arg2,
            high       : arg3,
            start_ms   : arg4,
            end_ms     : arg5,
        };
        verify<T0, NoTouchProof>(arg0, v0, arg6);
        assert!(arg4 <= arg1.opened_ms && arg5 >= arg1.expiry_ms, 9);
        assert!(is_up(arg1.barrier_kind) && arg2 <= arg1.barrier && arg3 == 18446744073709551615 || arg2 == 0 && arg3 >= arg1.barrier, 9);
    }

    public fun withdraw<T0>(arg0: &OperatorCap, arg1: &mut Registry<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.vault), 10);
        0x2::coin::take<T0>(&mut arg1.vault, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

