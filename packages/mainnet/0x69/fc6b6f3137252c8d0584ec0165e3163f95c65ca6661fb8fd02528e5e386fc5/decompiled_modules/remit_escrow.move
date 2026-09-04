module 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::remit_escrow {
    struct RemitRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        worker_addresses: vector<address>,
        paused: bool,
        total_opened: u64,
    }

    struct RemitAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RemitEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        sender: address,
        escrow: 0x2::balance::Balance<T0>,
        amount: u64,
        transfer_id: vector<u8>,
        created_ms: u64,
        timeout_ms: u64,
        status: u8,
        committed: bool,
        frozen: bool,
    }

    struct EscrowOpened has copy, drop {
        escrow_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        transfer_id: vector<u8>,
        timeout_ms: u64,
    }

    struct EscrowCommitted has copy, drop {
        escrow_id: 0x2::object::ID,
    }

    struct EscrowReleased has copy, drop {
        escrow_id: 0x2::object::ID,
        treasury: address,
        amount: u64,
    }

    struct EscrowReclaimed has copy, drop {
        escrow_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct EscrowFrozen has copy, drop {
        escrow_id: 0x2::object::ID,
    }

    struct EscrowUnfrozen has copy, drop {
        escrow_id: 0x2::object::ID,
    }

    struct WorkerAdded has copy, drop {
        worker: address,
    }

    struct WorkerRemoved has copy, drop {
        worker: address,
    }

    struct TreasuryChanged has copy, drop {
        treasury: address,
    }

    struct RegistryPauseChanged has copy, drop {
        paused: bool,
    }

    public fun sender<T0>(arg0: &RemitEscrow<T0>) : address {
        arg0.sender
    }

    public fun add_worker(arg0: &mut RemitRegistry, arg1: &RemitAdminCap, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg0.worker_addresses, &arg2), 730);
        0x1::vector::push_back<address>(&mut arg0.worker_addresses, arg2);
        let v0 = WorkerAdded{worker: arg2};
        0x2::event::emit<WorkerAdded>(v0);
    }

    public fun amount<T0>(arg0: &RemitEscrow<T0>) : u64 {
        arg0.amount
    }

    public fun cancel<T0>(arg0: &mut RemitEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.sender, 728);
        assert!(arg0.status == 0, 724);
        assert!(!arg0.committed, 725);
        assert!(!arg0.frozen, 729);
        arg0.status = 3;
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.escrow);
        let v1 = EscrowCancelled{
            escrow_id : 0x2::object::id<RemitEscrow<T0>>(arg0),
            sender    : arg0.sender,
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<EscrowCancelled>(v1);
        0x2::coin::from_balance<T0>(v0, arg1)
    }

    public fun commit<T0>(arg0: &RemitRegistry, arg1: &mut RemitEscrow<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 723);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.worker_addresses, &v0), 722);
        assert!(arg1.status == 0, 724);
        assert!(!arg1.frozen, 729);
        assert!(!arg1.committed, 725);
        arg1.committed = true;
        let v1 = EscrowCommitted{escrow_id: 0x2::object::id<RemitEscrow<T0>>(arg1)};
        0x2::event::emit<EscrowCommitted>(v1);
    }

    public fun compliance_freeze<T0>(arg0: &mut RemitEscrow<T0>, arg1: &0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::compliance::ComplianceAdminCap) {
        arg0.frozen = true;
        let v0 = EscrowFrozen{escrow_id: 0x2::object::id<RemitEscrow<T0>>(arg0)};
        0x2::event::emit<EscrowFrozen>(v0);
    }

    public fun compliance_unfreeze<T0>(arg0: &mut RemitEscrow<T0>, arg1: &0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::compliance::ComplianceAdminCap) {
        arg0.frozen = false;
        let v0 = EscrowUnfrozen{escrow_id: 0x2::object::id<RemitEscrow<T0>>(arg0)};
        0x2::event::emit<EscrowUnfrozen>(v0);
    }

    public fun escrow_value<T0>(arg0: &RemitEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RemitRegistry{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            treasury         : 0x2::tx_context::sender(arg0),
            worker_addresses : vector[],
            paused           : false,
            total_opened     : 0,
        };
        0x2::transfer::share_object<RemitRegistry>(v0);
        let v1 = RemitAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RemitAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_committed<T0>(arg0: &RemitEscrow<T0>) : bool {
        arg0.committed
    }

    public fun is_frozen<T0>(arg0: &RemitEscrow<T0>) : bool {
        arg0.frozen
    }

    public fun is_worker(arg0: &RemitRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.worker_addresses, &arg1)
    }

    public fun open<T0>(arg0: &mut RemitRegistry, arg1: &0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::compliance::ComplianceRegistry, arg2: 0x2::balance::Balance<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 723);
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 720);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 721);
        0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::compliance::assert_clear(arg1, 0x2::tx_context::sender(arg6));
        let v1 = RemitEscrow<T0>{
            id          : 0x2::object::new(arg6),
            sender      : 0x2::tx_context::sender(arg6),
            escrow      : arg2,
            amount      : v0,
            transfer_id : arg3,
            created_ms  : 0x2::clock::timestamp_ms(arg5),
            timeout_ms  : arg4,
            status      : 0,
            committed   : false,
            frozen      : false,
        };
        let v2 = 0x2::object::id<RemitEscrow<T0>>(&v1);
        arg0.total_opened = arg0.total_opened + 1;
        let v3 = EscrowOpened{
            escrow_id   : v2,
            sender      : v1.sender,
            amount      : v0,
            transfer_id : v1.transfer_id,
            timeout_ms  : arg4,
        };
        0x2::event::emit<EscrowOpened>(v3);
        0x2::transfer::share_object<RemitEscrow<T0>>(v1);
        v2
    }

    public fun reclaim<T0>(arg0: &mut RemitEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 724);
        assert!(!arg0.committed, 725);
        assert!(!arg0.frozen, 729);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.timeout_ms, 727);
        arg0.status = 2;
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.escrow);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg0.sender);
        let v1 = EscrowReclaimed{
            escrow_id : 0x2::object::id<RemitEscrow<T0>>(arg0),
            sender    : arg0.sender,
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<EscrowReclaimed>(v1);
    }

    public fun registry_paused(arg0: &RemitRegistry) : bool {
        arg0.paused
    }

    public fun release<T0>(arg0: &RemitRegistry, arg1: &mut RemitEscrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 723);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.worker_addresses, &v0), 722);
        assert!(arg1.status == 0, 724);
        assert!(!arg1.frozen, 729);
        assert!(arg1.committed, 726);
        arg1.status = 1;
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg1.escrow);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), arg0.treasury);
        let v2 = EscrowReleased{
            escrow_id : 0x2::object::id<RemitEscrow<T0>>(arg1),
            treasury  : arg0.treasury,
            amount    : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<EscrowReleased>(v2);
    }

    public fun remove_worker(arg0: &mut RemitRegistry, arg1: &RemitAdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.worker_addresses, &arg2);
        assert!(v0, 731);
        0x1::vector::remove<address>(&mut arg0.worker_addresses, v1);
        let v2 = WorkerRemoved{worker: arg2};
        0x2::event::emit<WorkerRemoved>(v2);
    }

    public fun set_paused(arg0: &mut RemitRegistry, arg1: &RemitAdminCap, arg2: bool) {
        assert!(arg2 != arg0.paused, 732);
        arg0.paused = arg2;
        let v0 = RegistryPauseChanged{paused: arg2};
        0x2::event::emit<RegistryPauseChanged>(v0);
    }

    public fun set_treasury(arg0: &mut RemitRegistry, arg1: &RemitAdminCap, arg2: address) {
        arg0.treasury = arg2;
        let v0 = TreasuryChanged{treasury: arg2};
        0x2::event::emit<TreasuryChanged>(v0);
    }

    public fun status<T0>(arg0: &RemitEscrow<T0>) : u8 {
        arg0.status
    }

    public fun status_cancelled() : u8 {
        3
    }

    public fun status_open() : u8 {
        0
    }

    public fun status_reclaimed() : u8 {
        2
    }

    public fun status_released() : u8 {
        1
    }

    public fun treasury(arg0: &RemitRegistry) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

