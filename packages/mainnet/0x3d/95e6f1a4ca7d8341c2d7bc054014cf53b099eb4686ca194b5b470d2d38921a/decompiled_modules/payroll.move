module 0x3d95e6f1a4ca7d8341c2d7bc054014cf53b099eb4686ca194b5b470d2d38921a::payroll {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        employer: 0x2::object::ID,
    }

    struct AuditorCap has store, key {
        id: 0x2::object::UID,
        employer: 0x2::object::ID,
    }

    struct Employer has key {
        id: 0x2::object::UID,
        owner: address,
        name: vector<u8>,
        auditor_pubkey: vector<u8>,
        runs_created: u64,
    }

    struct PayrollRun has store, key {
        id: 0x2::object::UID,
        employer: 0x2::object::ID,
        status: u8,
        recipient_count: u64,
        manifest_blob: 0x1::option::Option<vector<u8>>,
        created_at_ms: u64,
    }

    struct PayoutEscrow<phantom T0> has store, key {
        id: 0x2::object::UID,
        run: 0x2::object::ID,
        recipient_id_hash: vector<u8>,
        funds: 0x2::balance::Balance<T0>,
        status: u8,
    }

    struct Payslip has store, key {
        id: 0x2::object::UID,
        run: 0x2::object::ID,
        recipient: address,
        payslip_blob: vector<u8>,
    }

    struct RunCreated has copy, drop {
        run: 0x2::object::ID,
        employer: 0x2::object::ID,
    }

    struct PayoutEscrowed has copy, drop {
        run: 0x2::object::ID,
        escrow: 0x2::object::ID,
        recipient_id_hash: vector<u8>,
    }

    struct PayoutClaimed has copy, drop {
        run: 0x2::object::ID,
        escrow: 0x2::object::ID,
        recipient: address,
    }

    struct RunFinalized has copy, drop {
        run: 0x2::object::ID,
        recipient_count: u64,
    }

    public fun auditor_pubkey(arg0: &Employer) : vector<u8> {
        arg0.auditor_pubkey
    }

    public fun claim_payout<T0>(arg0: PayoutEscrow<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let PayoutEscrow {
            id                : v0,
            run               : v1,
            recipient_id_hash : v2,
            funds             : v3,
            status            : v4,
        } = arg0;
        assert!(v4 == 0, 2);
        assert!(0x2::hash::keccak256(&arg1) == v2, 3);
        0x2::object::delete(v0);
        let v5 = PayoutClaimed{
            run       : v1,
            escrow    : 0x2::object::id<PayoutEscrow<T0>>(&arg0),
            recipient : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PayoutClaimed>(v5);
        0x2::coin::from_balance<T0>(v3, arg2)
    }

    public fun claim_to_sender<T0>(arg0: PayoutEscrow<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_payout<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun create_employer(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : (Employer, AdminCap, AuditorCap) {
        let v0 = Employer{
            id             : 0x2::object::new(arg2),
            owner          : 0x2::tx_context::sender(arg2),
            name           : arg0,
            auditor_pubkey : arg1,
            runs_created   : 0,
        };
        let v1 = 0x2::object::id<Employer>(&v0);
        let v2 = AdminCap{
            id       : 0x2::object::new(arg2),
            employer : v1,
        };
        let v3 = AuditorCap{
            id       : 0x2::object::new(arg2),
            employer : v1,
        };
        (v0, v2, v3)
    }

    public fun create_run(arg0: &mut Employer, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : PayrollRun {
        assert!(arg1.employer == 0x2::object::id<Employer>(arg0), 0);
        arg0.runs_created = arg0.runs_created + 1;
        let v0 = if (0x1::vector::length<u8>(&arg2) == 0) {
            0x1::option::none<vector<u8>>()
        } else {
            0x1::option::some<vector<u8>>(arg2)
        };
        let v1 = PayrollRun{
            id              : 0x2::object::new(arg4),
            employer        : 0x2::object::id<Employer>(arg0),
            status          : 1,
            recipient_count : 0,
            manifest_blob   : v0,
            created_at_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        let v2 = RunCreated{
            run      : 0x2::object::id<PayrollRun>(&v1),
            employer : 0x2::object::id<Employer>(arg0),
        };
        0x2::event::emit<RunCreated>(v2);
        v1
    }

    public fun escrow_payout<T0>(arg0: &mut PayrollRun, arg1: &AdminCap, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.employer == arg0.employer, 0);
        assert!(arg0.status == 1, 1);
        arg0.recipient_count = arg0.recipient_count + 1;
        let v0 = PayoutEscrow<T0>{
            id                : 0x2::object::new(arg4),
            run               : 0x2::object::id<PayrollRun>(arg0),
            recipient_id_hash : arg2,
            funds             : 0x2::coin::into_balance<T0>(arg3),
            status            : 0,
        };
        let v1 = PayoutEscrowed{
            run               : 0x2::object::id<PayrollRun>(arg0),
            escrow            : 0x2::object::id<PayoutEscrow<T0>>(&v0),
            recipient_id_hash : arg2,
        };
        0x2::event::emit<PayoutEscrowed>(v1);
        0x2::transfer::public_share_object<PayoutEscrow<T0>>(v0);
    }

    public fun finalize_run(arg0: &mut PayrollRun, arg1: &AdminCap) {
        assert!(arg1.employer == arg0.employer, 0);
        arg0.status = 2;
        let v0 = RunFinalized{
            run             : 0x2::object::id<PayrollRun>(arg0),
            recipient_count : arg0.recipient_count,
        };
        0x2::event::emit<RunFinalized>(v0);
    }

    public fun issue_payslip(arg0: &PayrollRun, arg1: &AdminCap, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.employer == arg0.employer, 0);
        let v0 = Payslip{
            id           : 0x2::object::new(arg4),
            run          : 0x2::object::id<PayrollRun>(arg0),
            recipient    : arg2,
            payslip_blob : arg3,
        };
        0x2::transfer::public_transfer<Payslip>(v0, arg2);
    }

    public fun recipient_count(arg0: &PayrollRun) : u64 {
        arg0.recipient_count
    }

    public fun register(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = create_employer(arg0, arg1, arg2);
        let v3 = 0x2::tx_context::sender(arg2);
        0x2::transfer::transfer<Employer>(v0, v3);
        0x2::transfer::public_transfer<AdminCap>(v1, v3);
        0x2::transfer::public_transfer<AuditorCap>(v2, v3);
    }

    public fun run_status(arg0: &PayrollRun) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v7
}

