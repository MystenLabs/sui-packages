module 0xa90efcb0fa5cb3f4fb2d6e55017529c2ec37f11eb9ccfee13228d567b24a35c8::exotics {
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
        product: vector<u8>,
        terms: vector<u8>,
        max_payout: u64,
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
        product: vector<u8>,
        terms: vector<u8>,
        max_payout: u64,
        premium: u64,
        expiry_ms: u64,
        quote_expiry_ms: u64,
    }

    struct SettleProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        payout: u64,
    }

    struct CloseProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        user: address,
        price: u64,
        quote_expiry_ms: u64,
    }

    struct Opened has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        product: vector<u8>,
        terms: vector<u8>,
        max_payout: u64,
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

    fun check_registry<T0>(arg0: &Registry<T0>, arg1: &Position<T0>) {
        assert!(arg1.registry == 0x2::object::id<Registry<T0>>(arg0), 12);
    }

    public fun close<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg6) == arg1.user, 2);
        assert!(arg1.status == 0, 5);
        let v0 = CloseProof{
            domain          : b"paramx-exotics-v1",
            registry        : arg1.registry,
            position        : 0x2::object::id<Position<T0>>(arg1),
            user            : arg1.user,
            price           : arg2,
            quote_expiry_ms : arg3,
        };
        verify<T0, CloseProof>(arg0, v0, &arg4);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 <= arg3, 3);
        assert!(v1 < arg1.expiry_ms, 6);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.collateral), 10);
        release<T0>(arg0, arg1, arg2, 2, v1, arg6);
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

    public fun expiry_ms<T0>(arg0: &Position<T0>) : u64 {
        arg0.expiry_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun locked<T0>(arg0: &Registry<T0>) : u64 {
        arg0.locked
    }

    public fun max_payout<T0>(arg0: &Position<T0>) : u64 {
        arg0.max_payout
    }

    public fun open<T0>(arg0: &mut Registry<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = QuoteProof{
            domain          : b"paramx-exotics-v1",
            registry        : 0x2::object::id<Registry<T0>>(arg0),
            user            : v0,
            product         : arg1,
            terms           : arg2,
            max_payout      : arg3,
            premium         : arg4,
            expiry_ms       : arg5,
            quote_expiry_ms : arg6,
        };
        verify<T0, QuoteProof>(arg0, v1, &arg7);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        assert!(v2 <= arg6, 3);
        assert!(v2 < arg5, 6);
        assert!(arg3 > 0, 7);
        assert!(0x2::coin::value<T0>(&arg8) >= arg4, 4);
        let v3 = 0x2::coin::value<T0>(&arg8);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg8));
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg3, 8);
        arg0.locked = arg0.locked + arg3;
        let v4 = Position<T0>{
            id         : 0x2::object::new(arg10),
            registry   : 0x2::object::id<Registry<T0>>(arg0),
            user       : v0,
            product    : arg1,
            terms      : arg2,
            max_payout : arg3,
            premium    : v3,
            opened_ms  : v2,
            expiry_ms  : arg5,
            collateral : 0x2::balance::split<T0>(&mut arg0.vault, arg3),
            status     : 0,
            payout     : 0,
        };
        let v5 = 0x2::object::id<Position<T0>>(&v4);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_user, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.by_user, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_user, v0), v5);
        let v6 = Opened{
            position_id : v5,
            user        : v0,
            product     : v4.product,
            terms       : v4.terms,
            max_payout  : arg3,
            premium     : v3,
            opened_ms   : v2,
            expiry_ms   : arg5,
        };
        0x2::event::emit<Opened>(v6);
        0x2::transfer::share_object<Position<T0>>(v4);
    }

    public fun payout<T0>(arg0: &Position<T0>) : u64 {
        arg0.payout
    }

    public fun premium<T0>(arg0: &Position<T0>) : u64 {
        arg0.premium
    }

    public fun product<T0>(arg0: &Position<T0>) : vector<u8> {
        arg0.product
    }

    public fun refund<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg3) == arg1.user, 2);
        assert!(arg1.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg1.expiry_ms + 604800000, 11);
        let v1 = 0x2::balance::value<T0>(&arg1.collateral);
        let v2 = if (arg1.premium < v1) {
            arg1.premium
        } else {
            v1
        };
        release<T0>(arg0, arg1, v2, 3, v0, arg3);
    }

    fun release<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.locked = arg0.locked - 0x2::balance::value<T0>(&arg1.collateral);
        arg1.payout = arg2;
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral, arg2), arg5), arg1.user);
        };
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::withdraw_all<T0>(&mut arg1.collateral));
        arg1.status = arg3;
        let v0 = StatusChanged{
            position_id : 0x2::object::id<Position<T0>>(arg1),
            status      : arg3,
            payout      : arg2,
            at_ms       : arg4,
        };
        0x2::event::emit<StatusChanged>(v0);
    }

    public fun set_oracle<T0>(arg0: &OperatorCap, arg1: &mut Registry<T0>, arg2: vector<u8>) {
        arg1.oracle_pubkey = arg2;
    }

    public fun settle<T0>(arg0: &mut Registry<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_registry<T0>(arg0, arg1);
        assert!(arg1.status == 0, 5);
        let v0 = SettleProof{
            domain   : b"paramx-exotics-v1",
            registry : arg1.registry,
            position : 0x2::object::id<Position<T0>>(arg1),
            payout   : arg2,
        };
        verify<T0, SettleProof>(arg0, v0, &arg3);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.collateral), 9);
        release<T0>(arg0, arg1, arg2, 1, 0x2::clock::timestamp_ms(arg4), arg5);
    }

    public fun status<T0>(arg0: &Position<T0>) : u8 {
        arg0.status
    }

    public fun terms<T0>(arg0: &Position<T0>) : vector<u8> {
        arg0.terms
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

