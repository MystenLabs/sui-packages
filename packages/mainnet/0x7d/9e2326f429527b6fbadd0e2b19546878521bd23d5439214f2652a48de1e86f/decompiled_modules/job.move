module 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::job {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct Job has key {
        id: 0x2::object::UID,
        intent_id: 0x2::object::ID,
        buyer: address,
        provider: address,
        bid_amount: u64,
        payment: 0x2::coin::Coin<USDC>,
        bond: 0x2::coin::Coin<USDC>,
        state: u8,
        fulfil_by: u64,
        fulfilled_at: u64,
        category: vector<u8>,
    }

    struct JobCreated has copy, drop {
        job_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
        buyer: address,
        provider: address,
        bid_amount: u64,
        bond: u64,
        fulfil_by: u64,
    }

    struct JobFulfilled has copy, drop {
        job_id: 0x2::object::ID,
        fulfilled_at: u64,
    }

    struct JobComplete has copy, drop {
        job_id: 0x2::object::ID,
        paid_usdc: u64,
        toll_usdc: u64,
        bond_returned: u64,
    }

    struct JobDisputed has copy, drop {
        job_id: 0x2::object::ID,
        compensation: u64,
        bond_slashed: u64,
    }

    struct JobSilenced has copy, drop {
        job_id: 0x2::object::ID,
        bond_slashed: u64,
    }

    public entry fun attest_fulfilled(arg0: &mut Job, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 102);
        assert!(0x2::tx_context::sender(arg2) == arg0.provider, 103);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.fulfil_by, 104);
        arg0.state = 1;
        arg0.fulfilled_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = JobFulfilled{
            job_id       : 0x2::object::id<Job>(arg0),
            fulfilled_at : arg0.fulfilled_at,
        };
        0x2::event::emit<JobFulfilled>(v0);
    }

    public fun bid_amount(arg0: &Job) : u64 {
        arg0.bid_amount
    }

    public fun bond_value(arg0: &Job) : u64 {
        0x2::coin::value<USDC>(&arg0.bond)
    }

    public fun buyer(arg0: &Job) : address {
        arg0.buyer
    }

    public entry fun complete(arg0: Job, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1 || arg0.state == 0, 105);
        let Job {
            id           : v0,
            intent_id    : _,
            buyer        : _,
            provider     : v3,
            bid_amount   : v4,
            payment      : v5,
            bond         : v6,
            state        : _,
            fulfil_by    : _,
            fulfilled_at : _,
            category     : _,
        } = arg0;
        let v11 = v5;
        0x2::object::delete(v0);
        let v12 = v4 * 10 / 10000;
        if (v12 > 0 && 0x2::coin::value<USDC>(&v11) >= v12) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut v11, v12, arg2), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v11, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v6, v3);
        let v13 = JobComplete{
            job_id        : 0x2::object::id<Job>(&arg0),
            paid_usdc     : 0x2::coin::value<USDC>(&v11),
            toll_usdc     : v12,
            bond_returned : 0,
        };
        0x2::event::emit<JobComplete>(v13);
    }

    public fun create(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: 0x2::coin::Coin<USDC>, arg5: 0x2::coin::Coin<USDC>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : Job {
        assert!(0x2::coin::value<USDC>(&arg4) >= arg3, 100);
        assert!(0x2::coin::value<USDC>(&arg5) > 0, 101);
        let v0 = Job{
            id           : 0x2::object::new(arg8),
            intent_id    : arg0,
            buyer        : arg1,
            provider     : arg2,
            bid_amount   : arg3,
            payment      : arg4,
            bond         : arg5,
            state        : 0,
            fulfil_by    : arg6,
            fulfilled_at : 0,
            category     : arg7,
        };
        let v1 = JobCreated{
            job_id     : 0x2::object::id<Job>(&v0),
            intent_id  : arg0,
            buyer      : arg1,
            provider   : arg2,
            bid_amount : arg3,
            bond       : 0x2::coin::value<USDC>(&v0.bond),
            fulfil_by  : arg6,
        };
        0x2::event::emit<JobCreated>(v1);
        v0
    }

    public entry fun create_and_share(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: 0x2::coin::Coin<USDC>, arg5: 0x2::coin::Coin<USDC>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Job>(create(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public entry fun dispute_resolve(arg0: Job, arg1: &mut 0x2::tx_context::TxContext) {
        let Job {
            id           : v0,
            intent_id    : _,
            buyer        : v2,
            provider     : _,
            bid_amount   : _,
            payment      : v5,
            bond         : v6,
            state        : _,
            fulfil_by    : _,
            fulfilled_at : _,
            category     : _,
        } = arg0;
        let v11 = v6;
        let v12 = v5;
        0x2::object::delete(v0);
        let v13 = 0x2::coin::value<USDC>(&v11);
        0x2::coin::value<USDC>(&v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v12, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v11, v2);
        let v14 = JobDisputed{
            job_id       : 0x2::object::id<Job>(&arg0),
            compensation : v13,
            bond_slashed : v13,
        };
        0x2::event::emit<JobDisputed>(v14);
    }

    public fun fulfil_by(arg0: &Job) : u64 {
        arg0.fulfil_by
    }

    public fun payment_value(arg0: &Job) : u64 {
        0x2::coin::value<USDC>(&arg0.payment)
    }

    public fun provider(arg0: &Job) : address {
        arg0.provider
    }

    public entry fun silence_slash(arg0: Job, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.state == 0 && v0 > arg0.fulfil_by || arg0.state == 1 && v0 > arg0.fulfilled_at + 259200000, 106);
        let Job {
            id           : v1,
            intent_id    : _,
            buyer        : v3,
            provider     : _,
            bid_amount   : _,
            payment      : v6,
            bond         : v7,
            state        : _,
            fulfil_by    : _,
            fulfilled_at : _,
            category     : _,
        } = arg0;
        let v12 = v7;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v6, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v12, arg1);
        let v13 = JobSilenced{
            job_id       : 0x2::object::id<Job>(&arg0),
            bond_slashed : 0x2::coin::value<USDC>(&v12),
        };
        0x2::event::emit<JobSilenced>(v13);
    }

    public fun state(arg0: &Job) : u8 {
        arg0.state
    }

    public fun state_active() : u8 {
        0
    }

    public fun state_complete() : u8 {
        2
    }

    public fun state_disputed() : u8 {
        3
    }

    public fun state_fulfilled() : u8 {
        1
    }

    public fun state_silenced() : u8 {
        4
    }

    // decompiled from Move bytecode v6
}

