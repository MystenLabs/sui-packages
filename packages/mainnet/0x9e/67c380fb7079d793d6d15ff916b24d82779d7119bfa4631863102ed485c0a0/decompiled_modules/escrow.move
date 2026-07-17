module 0x9e67c380fb7079d793d6d15ff916b24d82779d7119bfa4631863102ed485c0a0::escrow {
    struct Job<phantom T0> has key {
        id: 0x2::object::UID,
        buyer: address,
        seller: address,
        escrow: 0x2::balance::Balance<T0>,
        amount: u64,
        spec_hash: vector<u8>,
        deliver_by_ms: u64,
        review_window_ms: u64,
        reject_split_bps: u64,
        state: u8,
        delivery_hash: vector<u8>,
        delivered_at_ms: u64,
        created_at_ms: u64,
    }

    struct JobCreated has copy, drop {
        job_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        amount: u64,
        deliver_by_ms: u64,
        review_window_ms: u64,
        reject_split_bps: u64,
        timestamp_ms: u64,
    }

    struct JobDelivered has copy, drop {
        job_id: 0x2::object::ID,
        seller: address,
        delivery_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct JobReleased has copy, drop {
        job_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        amount: u64,
        by_timeout: bool,
        timestamp_ms: u64,
    }

    struct JobRejected has copy, drop {
        job_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        buyer_amount: u64,
        seller_amount: u64,
        timestamp_ms: u64,
    }

    struct JobRefunded has copy, drop {
        job_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun amount<T0>(arg0: &Job<T0>) : u64 {
        arg0.amount
    }

    public fun buyer<T0>(arg0: &Job<T0>) : address {
        arg0.buyer
    }

    public fun create<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 != arg0, 9);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 2);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg3 > v2, 3);
        assert!(arg5 <= 10000, 4);
        let v3 = Job<T0>{
            id               : 0x2::object::new(arg7),
            buyer            : v0,
            seller           : arg0,
            escrow           : 0x2::coin::into_balance<T0>(arg1),
            amount           : v1,
            spec_hash        : arg2,
            deliver_by_ms    : arg3,
            review_window_ms : arg4,
            reject_split_bps : arg5,
            state            : 0,
            delivery_hash    : b"",
            delivered_at_ms  : 0,
            created_at_ms    : v2,
        };
        let v4 = 0x2::object::uid_to_inner(&v3.id);
        let v5 = JobCreated{
            job_id           : v4,
            buyer            : v0,
            seller           : arg0,
            amount           : v1,
            deliver_by_ms    : arg3,
            review_window_ms : arg4,
            reject_split_bps : arg5,
            timestamp_ms     : v2,
        };
        0x2::event::emit<JobCreated>(v5);
        0x2::transfer::share_object<Job<T0>>(v3);
        v4
    }

    public fun created_at_ms<T0>(arg0: &Job<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun deliver<T0>(arg0: &mut Job<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 0);
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 <= arg0.deliver_by_ms, 5);
        arg0.delivery_hash = arg1;
        arg0.delivered_at_ms = v0;
        arg0.state = 1;
        let v1 = JobDelivered{
            job_id        : 0x2::object::uid_to_inner(&arg0.id),
            seller        : arg0.seller,
            delivery_hash : arg0.delivery_hash,
            timestamp_ms  : v0,
        };
        0x2::event::emit<JobDelivered>(v1);
    }

    public fun deliver_by_ms<T0>(arg0: &Job<T0>) : u64 {
        arg0.deliver_by_ms
    }

    public fun delivered_at_ms<T0>(arg0: &Job<T0>) : u64 {
        arg0.delivered_at_ms
    }

    public fun delivery_hash<T0>(arg0: &Job<T0>) : vector<u8> {
        arg0.delivery_hash
    }

    public fun escrow_value<T0>(arg0: &Job<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun refund<T0>(arg0: &mut Job<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > arg0.deliver_by_ms, 8);
        arg0.state = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg2), arg0.buyer);
        let v1 = JobRefunded{
            job_id       : 0x2::object::uid_to_inner(&arg0.id),
            buyer        : arg0.buyer,
            seller       : arg0.seller,
            amount       : 0x2::balance::value<T0>(&arg0.escrow),
            timestamp_ms : v0,
        };
        0x2::event::emit<JobRefunded>(v1);
    }

    public fun reject<T0>(arg0: &mut Job<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.buyer, 0);
        assert!(arg0.state == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 <= arg0.delivered_at_ms + arg0.review_window_ms, 7);
        arg0.state = 4;
        let v1 = 0x2::balance::value<T0>(&arg0.escrow);
        let v2 = v1 * arg0.reject_split_bps / 10000;
        let v3 = v1 - v2;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v2), arg2), arg0.buyer);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg2), arg0.seller);
        };
        let v4 = JobRejected{
            job_id        : 0x2::object::uid_to_inner(&arg0.id),
            buyer         : arg0.buyer,
            seller        : arg0.seller,
            buyer_amount  : v2,
            seller_amount : v3,
            timestamp_ms  : v0,
        };
        0x2::event::emit<JobRejected>(v4);
    }

    public fun reject_split_bps<T0>(arg0: &Job<T0>) : u64 {
        arg0.reject_split_bps
    }

    public fun release<T0>(arg0: &mut Job<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2) == arg0.buyer;
        let v2 = if (arg0.state == 1) {
            let v3 = v0 > arg0.delivered_at_ms + arg0.review_window_ms;
            assert!(v1 || v3, 6);
            !v1 && v3
        } else {
            assert!(arg0.state == 0, 1);
            assert!(v1, 0);
            false
        };
        arg0.state = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg2), arg0.seller);
        let v4 = JobReleased{
            job_id       : 0x2::object::uid_to_inner(&arg0.id),
            buyer        : arg0.buyer,
            seller       : arg0.seller,
            amount       : 0x2::balance::value<T0>(&arg0.escrow),
            by_timeout   : v2,
            timestamp_ms : v0,
        };
        0x2::event::emit<JobReleased>(v4);
    }

    public fun review_window_ms<T0>(arg0: &Job<T0>) : u64 {
        arg0.review_window_ms
    }

    public fun seller<T0>(arg0: &Job<T0>) : address {
        arg0.seller
    }

    public fun spec_hash<T0>(arg0: &Job<T0>) : vector<u8> {
        arg0.spec_hash
    }

    public fun state<T0>(arg0: &Job<T0>) : u8 {
        arg0.state
    }

    public fun state_delivered() : u8 {
        1
    }

    public fun state_funded() : u8 {
        0
    }

    public fun state_refunded() : u8 {
        3
    }

    public fun state_rejected() : u8 {
        4
    }

    public fun state_released() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

