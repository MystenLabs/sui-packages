module 0x97a9560a34766d4556f98881672e81f33c1c0c35188728813595cd05fb160a8::cheque {
    struct ChequeRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        worker_addresses: vector<address>,
        paused: bool,
        cheques_total: u64,
    }

    struct ChequeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Cheque<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        escrow: 0x2::balance::Balance<T0>,
        amount: u64,
        expiry_ms: u64,
        claimed: bool,
        bound_recipient: 0x1::option::Option<address>,
        hashlock: 0x1::option::Option<vector<u8>>,
    }

    struct ChequeCreated has copy, drop {
        cheque_id: 0x2::object::ID,
        creator: address,
        amount: u64,
        expiry_ms: u64,
    }

    struct ChequeClaimed has copy, drop {
        cheque_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        ts_ms: u64,
    }

    struct ChequeReclaimed has copy, drop {
        cheque_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct WorkerAdded has copy, drop {
        worker: address,
    }

    struct WorkerRemoved has copy, drop {
        worker: address,
    }

    public fun add_worker(arg0: &mut ChequeRegistry, arg1: &ChequeAdminCap, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg0.worker_addresses, &arg2), 307);
        0x1::vector::push_back<address>(&mut arg0.worker_addresses, arg2);
        let v0 = WorkerAdded{worker: arg2};
        0x2::event::emit<WorkerAdded>(v0);
    }

    public fun amount<T0>(arg0: &Cheque<T0>) : u64 {
        arg0.amount
    }

    public fun claim<T0>(arg0: &mut ChequeRegistry, arg1: &mut Cheque<T0>, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 303);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg0.worker_addresses, &v0), 302);
        assert!(!arg1.claimed, 304);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.expiry_ms, 305);
        if (0x1::option::is_some<address>(&arg1.bound_recipient)) {
            assert!(arg2 == *0x1::option::borrow<address>(&arg1.bound_recipient), 310);
        };
        if (0x1::option::is_some<vector<u8>>(&arg1.hashlock)) {
            assert!(0x1::hash::sha2_256(arg3) == *0x1::option::borrow<vector<u8>>(&arg1.hashlock), 311);
        };
        arg1.claimed = true;
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg1.escrow);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg5), arg2);
        let v2 = ChequeClaimed{
            cheque_id : 0x2::object::id<Cheque<T0>>(arg1),
            recipient : arg2,
            amount    : 0x2::balance::value<T0>(&v1),
            ts_ms     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ChequeClaimed>(v2);
    }

    public fun create<T0>(arg0: &mut ChequeRegistry, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 300);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5), 301);
        assert!(0x1::option::is_some<address>(&arg3) || 0x1::option::is_some<vector<u8>>(&arg4), 309);
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg4)) == 32, 311);
        };
        let v1 = Cheque<T0>{
            id              : 0x2::object::new(arg6),
            creator         : 0x2::tx_context::sender(arg6),
            escrow          : arg1,
            amount          : v0,
            expiry_ms       : arg2,
            claimed         : false,
            bound_recipient : arg3,
            hashlock        : arg4,
        };
        let v2 = 0x2::object::id<Cheque<T0>>(&v1);
        arg0.cheques_total = arg0.cheques_total + 1;
        let v3 = ChequeCreated{
            cheque_id : v2,
            creator   : 0x2::tx_context::sender(arg6),
            amount    : v0,
            expiry_ms : arg2,
        };
        0x2::event::emit<ChequeCreated>(v3);
        0x2::transfer::share_object<Cheque<T0>>(v1);
        v2
    }

    public fun creator<T0>(arg0: &Cheque<T0>) : address {
        arg0.creator
    }

    public fun escrow_value<T0>(arg0: &Cheque<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun expiry_ms<T0>(arg0: &Cheque<T0>) : u64 {
        arg0.expiry_ms
    }

    public fun has_hashlock<T0>(arg0: &Cheque<T0>) : bool {
        0x1::option::is_some<vector<u8>>(&arg0.hashlock)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChequeRegistry{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            worker_addresses : vector[],
            paused           : false,
            cheques_total    : 0,
        };
        0x2::transfer::share_object<ChequeRegistry>(v0);
        let v1 = ChequeAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ChequeAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_bound<T0>(arg0: &Cheque<T0>) : bool {
        0x1::option::is_some<address>(&arg0.bound_recipient)
    }

    public fun is_claimed<T0>(arg0: &Cheque<T0>) : bool {
        arg0.claimed
    }

    public fun is_worker(arg0: &ChequeRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.worker_addresses, &arg1)
    }

    public fun reclaim<T0>(arg0: &mut Cheque<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 306);
        assert!(!arg0.claimed, 304);
        arg0.claimed = true;
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.escrow);
        let v1 = ChequeReclaimed{
            cheque_id : 0x2::object::id<Cheque<T0>>(arg0),
            creator   : arg0.creator,
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<ChequeReclaimed>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun reclaim_expired<T0>(arg0: &mut Cheque<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 304);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 312);
        arg0.claimed = true;
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.escrow);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg0.creator);
        let v1 = ChequeReclaimed{
            cheque_id : 0x2::object::id<Cheque<T0>>(arg0),
            creator   : arg0.creator,
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<ChequeReclaimed>(v1);
    }

    public fun registry_paused(arg0: &ChequeRegistry) : bool {
        arg0.paused
    }

    public fun remove_worker(arg0: &mut ChequeRegistry, arg1: &ChequeAdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.worker_addresses, &arg2);
        assert!(v0, 308);
        0x1::vector::remove<address>(&mut arg0.worker_addresses, v1);
        let v2 = WorkerRemoved{worker: arg2};
        0x2::event::emit<WorkerRemoved>(v2);
    }

    public fun set_paused(arg0: &mut ChequeRegistry, arg1: &ChequeAdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    // decompiled from Move bytecode v7
}

