module 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::commission {
    struct Listing<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        about: 0x1::string::String,
        price: u64,
        deliver_ms: u64,
        revisions: u8,
        open: bool,
        jobs: u64,
        created_ms: u64,
        version: u64,
    }

    struct Job<phantom T0> has key {
        id: 0x2::object::UID,
        listing: 0x2::object::ID,
        creator: address,
        client: address,
        title: 0x1::string::String,
        brief: 0x1::string::String,
        amount: u64,
        escrow: 0x2::balance::Balance<T0>,
        deliver_ms: u64,
        revisions_left: u8,
        status: u8,
        link: 0x1::string::String,
        note: 0x1::string::String,
        ask: 0x1::string::String,
        created_ms: u64,
        deadline_ms: u64,
        delivered_ms: u64,
        review_ms: u64,
        revision_ms: u64,
        arbiter_ms: u64,
        disputed_ms: u64,
        creator_bps: u64,
        how: u8,
        version: u64,
    }

    struct ListingCreated has copy, drop {
        listing: 0x2::object::ID,
        creator: address,
        price: u64,
        coin: 0x1::ascii::String,
    }

    struct JobRequested has copy, drop {
        job: 0x2::object::ID,
        listing: 0x2::object::ID,
        creator: address,
        client: address,
        amount: u64,
        coin: 0x1::ascii::String,
    }

    struct JobAccepted has copy, drop {
        job: 0x2::object::ID,
        deadline_ms: u64,
    }

    struct JobDelivered has copy, drop {
        job: 0x2::object::ID,
        link: 0x1::string::String,
    }

    struct JobRevision has copy, drop {
        job: 0x2::object::ID,
        revisions_left: u8,
    }

    struct JobDisputed has copy, drop {
        job: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct JobPaid has copy, drop {
        job: 0x2::object::ID,
        creator: address,
        paid: u64,
        fee: u64,
        refunded: u64,
        how: u8,
    }

    struct JobRefunded has copy, drop {
        job: 0x2::object::ID,
        client: address,
        amount: u64,
        how: u8,
    }

    public fun accept<T0>(arg0: &mut Job<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 3);
        assert!(arg0.status == 0, 2);
        arg0.status = 1;
        arg0.deadline_ms = 0x2::clock::timestamp_ms(arg1) + arg0.deliver_ms;
        let v0 = JobAccepted{
            job         : 0x2::object::id<Job<T0>>(arg0),
            deadline_ms : arg0.deadline_ms,
        };
        0x2::event::emit<JobAccepted>(v0);
    }

    public fun approve<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Job<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.client, 4);
        assert!(arg1.status == 2, 2);
        finish<T0>(arg0, arg1, 10000, 0, arg2);
    }

    public fun cancel<T0>(arg0: &mut Job<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.client, 4);
        assert!(arg0.status == 0, 2);
        refund<T0>(arg0, 10, arg1);
    }

    public fun create_listing<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        len_ok(&arg0, 80, false);
        len_ok(&arg1, 1000, false);
        settings_ok(arg2, arg3, arg4);
        let v0 = Listing<T0>{
            id         : 0x2::object::new(arg6),
            creator    : 0x2::tx_context::sender(arg6),
            title      : arg0,
            about      : arg1,
            price      : arg2,
            deliver_ms : arg3,
            revisions  : arg4,
            open       : true,
            jobs       : 0,
            created_ms : 0x2::clock::timestamp_ms(arg5),
            version    : 1,
        };
        let v1 = 0x2::object::id<Listing<T0>>(&v0);
        let v2 = ListingCreated{
            listing : v1,
            creator : v0.creator,
            price   : arg2,
            coin    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<ListingCreated>(v2);
        0x2::transfer::share_object<Listing<T0>>(v0);
        v1
    }

    public fun deadline_ms<T0>(arg0: &Job<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun decline<T0>(arg0: &mut Job<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 3);
        assert!(arg0.status == 0, 2);
        refund<T0>(arg0, 11, arg1);
    }

    public fun deliver<T0>(arg0: &mut Job<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 3);
        assert!(arg0.status == 1, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg0.deadline_ms, 8);
        len_ok(&arg1, 300, false);
        len_ok(&arg2, 500, true);
        arg0.link = arg1;
        arg0.note = arg2;
        arg0.delivered_ms = v0;
        arg0.status = 2;
        let v1 = JobDelivered{
            job  : 0x2::object::id<Job<T0>>(arg0),
            link : arg1,
        };
        0x2::event::emit<JobDelivered>(v1);
    }

    public fun dispute<T0>(arg0: &mut Job<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.client, 4);
        assert!(arg0.status == 2, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg0.delivered_ms + arg0.review_ms, 8);
        len_ok(&arg1, 500, false);
        arg0.ask = arg1;
        arg0.status = 3;
        arg0.disputed_ms = v0;
        let v1 = JobDisputed{
            job    : 0x2::object::id<Job<T0>>(arg0),
            reason : arg1,
        };
        0x2::event::emit<JobDisputed>(v1);
    }

    public fun edit_listing<T0>(arg0: &mut Listing<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u8, arg6: bool, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.creator, 3);
        len_ok(&arg1, 80, false);
        len_ok(&arg2, 1000, false);
        settings_ok(arg3, arg4, arg5);
        arg0.title = arg1;
        arg0.about = arg2;
        arg0.price = arg3;
        arg0.deliver_ms = arg4;
        arg0.revisions = arg5;
        arg0.open = arg6;
    }

    public fun escrow_value<T0>(arg0: &Job<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    fun finish<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Job<T0>, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.creator;
        let (v1, v2) = 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::pay<T0>(arg0, &mut arg1.escrow, (((0x2::balance::value<T0>(&arg1.escrow) as u128) * (arg2 as u128) / 10000) as u64), v0, arg1.client, arg4);
        let v3 = 0x2::balance::value<T0>(&arg1.escrow);
        0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::give_back<T0>(&mut arg1.escrow, v3, arg1.client, arg4);
        arg1.creator_bps = arg2;
        arg1.how = arg3;
        let v4 = if (arg2 == 10000) {
            4
        } else if (arg2 == 0) {
            5
        } else {
            6
        };
        arg1.status = v4;
        let v5 = JobPaid{
            job      : 0x2::object::id<Job<T0>>(arg1),
            creator  : v0,
            paid     : v1,
            fee      : v2,
            refunded : v3,
            how      : arg3,
        };
        0x2::event::emit<JobPaid>(v5);
    }

    public fun give_up<T0>(arg0: &mut Job<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 3);
        assert!(arg0.status == 1, 2);
        refund<T0>(arg0, 12, arg1);
    }

    public fun hire<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Listing<T0>, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.open, 6);
        assert!(v0 != arg1.creator, 5);
        assert!(0x2::coin::value<T0>(&arg3) == arg1.price, 7);
        len_ok(&arg2, 1000, false);
        arg1.jobs = arg1.jobs + 1;
        let v1 = 0x1::string::utf8(b"");
        let v2 = Job<T0>{
            id             : 0x2::object::new(arg5),
            listing        : 0x2::object::id<Listing<T0>>(arg1),
            creator        : arg1.creator,
            client         : v0,
            title          : arg1.title,
            brief          : arg2,
            amount         : arg1.price,
            escrow         : 0x2::coin::into_balance<T0>(arg3),
            deliver_ms     : arg1.deliver_ms,
            revisions_left : arg1.revisions,
            status         : 0,
            link           : v1,
            note           : v1,
            ask            : v1,
            created_ms     : 0x2::clock::timestamp_ms(arg4),
            deadline_ms    : 0,
            delivered_ms   : 0,
            review_ms      : 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::review_ms(arg0),
            revision_ms    : 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::revision_ms(arg0),
            arbiter_ms     : 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::arbiter_ms(arg0),
            disputed_ms    : 0,
            creator_bps    : 0,
            how            : 255,
            version        : 1,
        };
        let v3 = 0x2::object::id<Job<T0>>(&v2);
        let v4 = JobRequested{
            job     : v3,
            listing : v2.listing,
            creator : v2.creator,
            client  : v0,
            amount  : v2.amount,
            coin    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<JobRequested>(v4);
        0x2::transfer::share_object<Job<T0>>(v2);
        v3
    }

    fun len_ok(arg0: &0x1::string::String, arg1: u64, arg2: bool) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 <= arg1 && (arg2 || v0 > 0), 1);
    }

    public fun listing_jobs<T0>(arg0: &Listing<T0>) : u64 {
        arg0.jobs
    }

    public fun listing_open<T0>(arg0: &Listing<T0>) : bool {
        arg0.open
    }

    fun refund<T0>(arg0: &mut Job<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.escrow);
        let v1 = arg0.client;
        0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::give_back<T0>(&mut arg0.escrow, v0, v1, arg2);
        arg0.status = 5;
        arg0.how = arg1;
        let v2 = JobRefunded{
            job    : 0x2::object::id<Job<T0>>(arg0),
            client : v1,
            amount : v0,
            how    : arg1,
        };
        0x2::event::emit<JobRefunded>(v2);
    }

    public fun refund_late<T0>(arg0: &mut Job<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms, 9);
        refund<T0>(arg0, 13, arg2);
    }

    public fun release<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Job<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 2, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.delivered_ms + arg1.review_ms, 9);
        finish<T0>(arg0, arg1, 10000, 1, arg3);
    }

    public fun request_revision<T0>(arg0: &mut Job<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.client, 4);
        assert!(arg0.status == 2, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg0.delivered_ms + arg0.review_ms, 8);
        assert!(arg0.revisions_left > 0, 10);
        len_ok(&arg1, 500, false);
        arg0.revisions_left = arg0.revisions_left - 1;
        arg0.ask = arg1;
        arg0.status = 1;
        arg0.deadline_ms = v0 + arg0.revision_ms;
        let v1 = JobRevision{
            job            : 0x2::object::id<Job<T0>>(arg0),
            revisions_left : arg0.revisions_left,
        };
        0x2::event::emit<JobRevision>(v1);
    }

    public fun resolve<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Job<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::arbiter(arg0), 11);
        assert!(arg1.status == 3, 2);
        assert!(arg2 <= 10000, 12);
        finish<T0>(arg0, arg1, arg2, 2, arg3);
    }

    public fun revisions_left<T0>(arg0: &Job<T0>) : u8 {
        arg0.revisions_left
    }

    fun settings_ok(arg0: u64, arg1: u64, arg2: u8) {
        let v0 = if (arg0 > 0) {
            if (arg1 >= 60000) {
                if (arg1 <= 5184000000) {
                    arg2 <= 3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13);
    }

    public fun split_after_silence<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Job<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 3, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.disputed_ms + arg1.arbiter_ms, 9);
        finish<T0>(arg0, arg1, 5000, 3, arg3);
    }

    public fun status<T0>(arg0: &Job<T0>) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v7
}

