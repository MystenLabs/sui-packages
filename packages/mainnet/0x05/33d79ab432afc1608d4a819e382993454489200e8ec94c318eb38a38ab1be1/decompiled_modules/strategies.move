module 0x8a17a34c76296219d2238118dd5a0fe6bb6296ce4408c3b6c1689813c5f1c72c::strategies {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry<phantom T0> has key {
        id: 0x2::object::UID,
        oracle_pubkey: vector<u8>,
        vault: 0x2::balance::Balance<T0>,
        locked: u64,
        margin_held: u64,
        by_user: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct Leg has copy, drop, store {
        kind: u8,
        strike: u64,
        expiry_ms: u64,
        ratio: u64,
        long: bool,
    }

    struct Position<phantom T0> has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        user: address,
        underlying: vector<u8>,
        legs: vector<Leg>,
        settled: vector<bool>,
        amount: u64,
        price_cap: u64,
        premium: u64,
        credit: bool,
        liquidatable: bool,
        opened_ms: u64,
        collateral: 0x2::balance::Balance<T0>,
        margin: 0x2::balance::Balance<T0>,
        status: u8,
        paid_user: u64,
        paid_by_user: u64,
    }

    struct QuoteProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        user: address,
        underlying: vector<u8>,
        legs: vector<Leg>,
        amount: u64,
        price_cap: u64,
        premium: u64,
        credit: bool,
        margin: u64,
        collateral: u64,
        liquidatable: bool,
        quote_expiry_ms: u64,
    }

    struct SettleProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        underlying: vector<u8>,
        expiry_ms: u64,
        price: u64,
    }

    struct CloseProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        user: address,
        value: u64,
        user_pays: bool,
        quote_expiry_ms: u64,
    }

    struct OrderCloseProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        user: address,
        value: u64,
        user_pays: bool,
        order: u64,
        quote_expiry_ms: u64,
    }

    struct LiquidationProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        value: u64,
        user_pays: bool,
        fee: u64,
        quote_expiry_ms: u64,
    }

    struct ReleaseProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        user: address,
        margin_after: u64,
        quote_expiry_ms: u64,
    }

    struct Opened has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        underlying: vector<u8>,
        legs: vector<Leg>,
        amount: u64,
        price_cap: u64,
        premium: u64,
        credit: bool,
        margin: u64,
        collateral: u64,
        liquidatable: bool,
        opened_ms: u64,
    }

    struct Settled has copy, drop {
        position_id: 0x2::object::ID,
        expiry_ms: u64,
        price: u64,
        to_user: u64,
        from_user: u64,
    }

    struct MarginChanged has copy, drop {
        position_id: 0x2::object::ID,
        margin: u64,
    }

    struct StatusChanged has copy, drop {
        position_id: 0x2::object::ID,
        status: u8,
        to_user: u64,
        from_user: u64,
        at_ms: u64,
    }

    public fun add_margin<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg3) == arg1.user, 2);
        assert!(arg1.status == 0, 5);
        arg0.margin_held = arg0.margin_held + 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg1.margin, 0x2::coin::into_balance<T0>(arg2));
        let v0 = MarginChanged{
            position_id : 0x2::object::id<Position<T0>>(arg1),
            margin      : 0x2::balance::value<T0>(&arg1.margin),
        };
        0x2::event::emit<MarginChanged>(v0);
    }

    fun all_settled<T0>(arg0: &Position<T0>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<bool>(&arg0.settled)) {
            if (!*0x1::vector::borrow<bool>(&arg0.settled, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun check_legs(arg0: &vector<Leg>) : u64 {
        let v0 = 0x1::vector::length<Leg>(arg0);
        assert!(v0 > 0 && v0 <= 5, 7);
        let v1 = 0;
        let v2 = 18446744073709551615;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<Leg>(arg0, v3);
            let v5 = if (v4.kind <= 2) {
                if (v4.ratio > 0) {
                    v4.kind == 2 || v4.strike > 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 7);
            if (v4.kind == 2) {
                v1 = v1 + 1;
            };
            if (v4.expiry_ms < v2) {
                v2 = v4.expiry_ms;
            };
            v3 = v3 + 1;
        };
        assert!(v1 <= 1, 7);
        v2
    }

    fun check_registry<T0>(arg0: &Registry<T0>, arg1: &Position<T0>) {
        assert!(arg1.registry == 0x2::object::id<Registry<T0>>(arg0), 14);
    }

    public fun close<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg7) == arg1.user, 2);
        assert!(arg1.status == 0, 5);
        let v0 = CloseProof{
            domain          : b"paramx-strategies-v1",
            registry        : arg1.registry,
            position        : 0x2::object::id<Position<T0>>(arg1),
            user            : arg1.user,
            value           : arg2,
            user_pays       : arg3,
            quote_expiry_ms : arg4,
        };
        verify<T0, CloseProof>(arg0, v0, &arg5);
        close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
    }

    public fun close_for<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0, 5);
        let v0 = OrderCloseProof{
            domain          : b"paramx-strategies-v1",
            registry        : arg1.registry,
            position        : 0x2::object::id<Position<T0>>(arg1),
            user            : arg1.user,
            value           : arg2,
            user_pays       : arg3,
            order           : arg4,
            quote_expiry_ms : arg5,
        };
        verify<T0, OrderCloseProof>(arg0, v0, &arg6);
        close_inner<T0>(arg0, arg1, arg2, arg3, arg5, arg7, arg8);
    }

    fun close_inner<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 <= arg4, 3);
        assert!(v0 < first_open_expiry<T0>(arg1), 6);
        let v1 = if (arg3) {
            0x2::balance::value<T0>(&arg1.margin)
        } else {
            0x2::balance::value<T0>(&arg1.collateral)
        };
        assert!(arg2 <= v1, 11);
        if (arg3) {
            let (_, _) = pay<T0>(arg0, arg1, 0, arg2, arg6);
        } else {
            let (_, _) = pay<T0>(arg0, arg1, arg2, 0, arg6);
        };
        finish<T0>(arg0, arg1, 2, v0, arg6);
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
            margin_held   : 0,
            by_user       : 0x2::table::new<address, vector<0x2::object::ID>>(arg2),
        };
        0x2::transfer::share_object<Registry<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Registry<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
    }

    fun finish<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.margin);
        arg0.margin_held = arg0.margin_held - v0;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.margin), arg4), arg1.user);
        };
        arg0.locked = arg0.locked - 0x2::balance::value<T0>(&arg1.collateral);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::withdraw_all<T0>(&mut arg1.collateral));
        arg1.status = arg2;
        let v1 = StatusChanged{
            position_id : 0x2::object::id<Position<T0>>(arg1),
            status      : arg2,
            to_user     : arg1.paid_user,
            from_user   : arg1.paid_by_user,
            at_ms       : arg3,
        };
        0x2::event::emit<StatusChanged>(v1);
    }

    fun first_open_expiry<T0>(arg0: &Position<T0>) : u64 {
        let v0 = 18446744073709551615;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Leg>(&arg0.legs)) {
            if (!*0x1::vector::borrow<bool>(&arg0.settled, v1) && 0x1::vector::borrow<Leg>(&arg0.legs, v1).expiry_ms < v0) {
                v0 = 0x1::vector::borrow<Leg>(&arg0.legs, v1).expiry_ms;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun last_open_expiry<T0>(arg0: &Position<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Leg>(&arg0.legs)) {
            if (!*0x1::vector::borrow<bool>(&arg0.settled, v1) && 0x1::vector::borrow<Leg>(&arg0.legs, v1).expiry_ms > v0) {
                v0 = 0x1::vector::borrow<Leg>(&arg0.legs, v1).expiry_ms;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun leg(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : Leg {
        Leg{
            kind      : arg0,
            strike    : arg1,
            expiry_ms : arg2,
            ratio     : arg3,
            long      : arg4,
        }
    }

    public fun legs<T0>(arg0: &Position<T0>) : vector<Leg> {
        arg0.legs
    }

    public fun liquidate<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0, 5);
        assert!(arg1.liquidatable, 12);
        let v0 = LiquidationProof{
            domain          : b"paramx-strategies-v1",
            registry        : arg1.registry,
            position        : 0x2::object::id<Position<T0>>(arg1),
            value           : arg2,
            user_pays       : arg3,
            fee             : arg4,
            quote_expiry_ms : arg5,
        };
        verify<T0, LiquidationProof>(arg0, v0, &arg6);
        liquidate_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
    }

    fun liquidate_inner<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg5, 3);
        if (arg3) {
            let (_, _) = pay<T0>(arg0, arg1, 0, arg2 + arg4, arg7);
        } else if (arg2 >= arg4) {
            let (_, _) = pay<T0>(arg0, arg1, arg2 - arg4, 0, arg7);
        } else {
            let (_, _) = pay<T0>(arg0, arg1, 0, arg4 - arg2, arg7);
        };
        finish<T0>(arg0, arg1, 3, v0, arg7);
    }

    public fun locked<T0>(arg0: &Registry<T0>) : u64 {
        arg0.locked
    }

    public fun margin_held<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.margin)
    }

    public fun open<T0>(arg0: &mut Registry<T0>, arg1: vector<u8>, arg2: vector<Leg>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: vector<u8>, arg12: 0x2::coin::Coin<T0>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = QuoteProof{
            domain          : b"paramx-strategies-v1",
            registry        : 0x2::object::id<Registry<T0>>(arg0),
            user            : v0,
            underlying      : arg1,
            legs            : arg2,
            amount          : arg3,
            price_cap       : arg4,
            premium         : arg5,
            credit          : arg6,
            margin          : arg7,
            collateral      : arg8,
            liquidatable    : arg9,
            quote_expiry_ms : arg10,
        };
        verify<T0, QuoteProof>(arg0, v1, &arg11);
        open_inner<T0>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13, arg14);
    }

    public fun open_for<T0>(arg0: &mut Registry<T0>, arg1: address, arg2: vector<u8>, arg3: vector<Leg>, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: vector<u8>, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = QuoteProof{
            domain          : b"paramx-strategies-v1",
            registry        : 0x2::object::id<Registry<T0>>(arg0),
            user            : arg1,
            underlying      : arg2,
            legs            : arg3,
            amount          : arg4,
            price_cap       : arg5,
            premium         : arg6,
            credit          : arg7,
            margin          : arg8,
            collateral      : arg9,
            liquidatable    : arg10,
            quote_expiry_ms : arg11,
        };
        verify<T0, QuoteProof>(arg0, v0, &arg12);
        open_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14, arg15);
    }

    fun open_inner<T0>(arg0: &mut Registry<T0>, arg1: address, arg2: vector<u8>, arg3: vector<Leg>, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: 0x2::coin::Coin<T0>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg13);
        assert!(v0 <= arg11, 3);
        assert!(v0 < check_legs(&arg3), 6);
        assert!(arg4 > 0 && arg5 > 0, 15);
        let v1 = if (arg7) {
            arg8
        } else {
            arg6 + arg8
        };
        assert!(0x2::coin::value<T0>(&arg12) == v1, 4);
        let v2 = 0x2::coin::into_balance<T0>(arg12);
        0x2::balance::join<T0>(&mut arg0.vault, v2);
        let v3 = if (arg7) {
            arg6 + arg9
        } else {
            arg9
        };
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v3, 8);
        if (arg7 && arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg6), arg14), arg1);
        };
        arg0.locked = arg0.locked + arg9;
        arg0.margin_held = arg0.margin_held + arg8;
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<Leg>(&arg3)) {
            0x1::vector::push_back<bool>(&mut v4, false);
            v5 = v5 + 1;
        };
        let v6 = Position<T0>{
            id           : 0x2::object::new(arg14),
            registry     : 0x2::object::id<Registry<T0>>(arg0),
            user         : arg1,
            underlying   : arg2,
            legs         : arg3,
            settled      : v4,
            amount       : arg4,
            price_cap    : arg5,
            premium      : arg6,
            credit       : arg7,
            liquidatable : arg10,
            opened_ms    : v0,
            collateral   : 0x2::balance::split<T0>(&mut arg0.vault, arg9),
            margin       : 0x2::balance::split<T0>(&mut v2, arg8),
            status       : 0,
            paid_user    : 0,
            paid_by_user : 0,
        };
        let v7 = 0x2::object::id<Position<T0>>(&v6);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_user, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.by_user, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_user, arg1), v7);
        let v8 = Opened{
            position_id  : v7,
            user         : arg1,
            underlying   : v6.underlying,
            legs         : arg3,
            amount       : arg4,
            price_cap    : arg5,
            premium      : arg6,
            credit       : arg7,
            margin       : arg8,
            collateral   : arg9,
            liquidatable : arg10,
            opened_ms    : v0,
        };
        0x2::event::emit<Opened>(v8);
        0x2::transfer::share_object<Position<T0>>(v6);
    }

    public fun paid_by_user<T0>(arg0: &Position<T0>) : u64 {
        arg0.paid_by_user
    }

    public fun paid_user<T0>(arg0: &Position<T0>) : u64 {
        arg0.paid_user
    }

    fun pay<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = if (arg2 < 0x2::balance::value<T0>(&arg1.collateral)) {
            arg2
        } else {
            0x2::balance::value<T0>(&arg1.collateral)
        };
        let v1 = if (arg3 < 0x2::balance::value<T0>(&arg1.margin)) {
            arg3
        } else {
            0x2::balance::value<T0>(&arg1.margin)
        };
        if (v0 > 0) {
            arg0.locked = arg0.locked - v0;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral, v0), arg4), arg1.user);
        };
        if (v1 > 0) {
            arg0.margin_held = arg0.margin_held - v1;
            0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg1.margin, v1));
        };
        arg1.paid_user = arg1.paid_user + v0;
        arg1.paid_by_user = arg1.paid_by_user + v1;
        (v0, v1)
    }

    public fun refund<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg3) == arg1.user, 2);
        assert!(arg1.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > last_open_expiry<T0>(arg1) + 604800000, 13);
        if (!arg1.credit) {
            let v1 = arg1.premium;
            let (_, _) = pay<T0>(arg0, arg1, v1, 0, arg3);
        };
        finish<T0>(arg0, arg1, 4, v0, arg3);
    }

    public fun registry_margin<T0>(arg0: &Registry<T0>) : u64 {
        arg0.margin_held
    }

    fun release_inner<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 3);
        let v0 = 0x2::balance::value<T0>(&arg1.margin);
        if (v0 > arg2) {
            arg0.margin_held = arg0.margin_held - v0 - arg2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.margin, v0 - arg2), arg5), arg1.user);
            let v1 = MarginChanged{
                position_id : 0x2::object::id<Position<T0>>(arg1),
                margin      : arg2,
            };
            0x2::event::emit<MarginChanged>(v1);
        };
    }

    public fun release_margin<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg6) == arg1.user, 2);
        assert!(arg1.status == 0, 5);
        let v0 = ReleaseProof{
            domain          : b"paramx-strategies-v1",
            registry        : arg1.registry,
            position        : 0x2::object::id<Position<T0>>(arg1),
            user            : arg1.user,
            margin_after    : arg2,
            quote_expiry_ms : arg3,
        };
        verify<T0, ReleaseProof>(arg0, v0, &arg4);
        release_inner<T0>(arg0, arg1, arg2, arg3, arg5, arg6);
    }

    public fun set_oracle<T0>(arg0: &OperatorCap, arg1: &mut Registry<T0>, arg2: vector<u8>) {
        arg1.oracle_pubkey = arg2;
    }

    public fun settle<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg2, 9);
        let v1 = SettleProof{
            domain     : b"paramx-strategies-v1",
            registry   : arg1.registry,
            underlying : arg1.underlying,
            expiry_ms  : arg2,
            price      : arg3,
        };
        verify<T0, SettleProof>(arg0, v1, &arg4);
        settle_inner<T0>(arg0, arg1, arg2, arg3, v0, arg6);
    }

    fun settle_inner<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = settle_legs<T0>(arg1, arg2, arg3);
        let (v2, v3) = if (v0 >= v1) {
            ((((v0 - v1) / 100000000) as u64), 0)
        } else {
            (0, (((v1 - v0 + 100000000 - 1) / 100000000) as u64))
        };
        let (v4, v5) = pay<T0>(arg0, arg1, v2, v3, arg5);
        let v6 = Settled{
            position_id : 0x2::object::id<Position<T0>>(arg1),
            expiry_ms   : arg2,
            price       : arg3,
            to_user     : v4,
            from_user   : v5,
        };
        0x2::event::emit<Settled>(v6);
        if (all_settled<T0>(arg1)) {
            finish<T0>(arg0, arg1, 1, arg4, arg5);
        };
    }

    fun settle_legs<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: u64) : (u128, u128) {
        let v0 = if (arg2 < arg0.price_cap) {
            arg2
        } else {
            arg0.price_cap
        };
        let v1 = (v0 as u128);
        let v2 = 0;
        let v3 = 0;
        let v4 = false;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Leg>(&arg0.legs)) {
            let v6 = *0x1::vector::borrow<Leg>(&arg0.legs, v5);
            if (v6.expiry_ms == arg1 && !*0x1::vector::borrow<bool>(&arg0.settled, v5)) {
                v4 = true;
                *0x1::vector::borrow_mut<bool>(&mut arg0.settled, v5) = true;
                let v7 = (v6.strike as u128);
                let v8 = (v6.ratio as u128) * (arg0.amount as u128);
                let (v9, v10) = if (v6.kind == 0) {
                    let v11 = if (v1 > v7) {
                        (v1 - v7) * v8
                    } else {
                        0
                    };
                    (v11, 0)
                } else if (v6.kind == 1) {
                    let v12 = if (v7 > v1) {
                        (v7 - v1) * v8
                    } else {
                        0
                    };
                    (v12, 0)
                } else {
                    (v1 * v8, v7 * v8)
                };
                if (v6.long) {
                    v2 = v2 + v9;
                    v3 = v3 + v10;
                } else {
                    v2 = v2 + v10;
                    v3 = v3 + v9;
                };
            };
            v5 = v5 + 1;
        };
        assert!(v4, 10);
        (v2, v3)
    }

    public fun settled<T0>(arg0: &Position<T0>) : vector<bool> {
        arg0.settled
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

    public fun withdraw<T0>(arg0: &OperatorCap, arg1: &mut Registry<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.vault), 8);
        0x2::coin::take<T0>(&mut arg1.vault, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

