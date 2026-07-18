module 0x88de0d2a5f36691c0b198637350b9cedfa9ba300ed322851b184bda97859508b::escrow {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        fee_receiver: address,
    }

    struct Job<phantom T0> has key {
        id: 0x2::object::UID,
        buyer: address,
        seller: address,
        escrow: 0x2::balance::Balance<T0>,
        amount: u64,
        fee_bps: u64,
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
        fee_bps: u64,
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
        fee_amount: u64,
        by_timeout: bool,
        timestamp_ms: u64,
    }

    struct JobRejected has copy, drop {
        job_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        buyer_amount: u64,
        seller_amount: u64,
        fee_amount: u64,
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

    fun assert_version(arg0: &FeeConfig) {
        assert!(arg0.version == 2, 13);
    }

    public fun buyer<T0>(arg0: &Job<T0>) : address {
        arg0.buyer
    }

    public fun config_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.fee_bps
    }

    public fun config_fee_receiver(arg0: &FeeConfig) : address {
        arg0.fee_receiver
    }

    public fun config_version(arg0: &FeeConfig) : u64 {
        arg0.version
    }

    public fun create<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &FeeConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(v0 != arg0, 9);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 2);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg3 > v2, 3);
        assert!(arg3 <= v2 + 31536000000, 11);
        assert!(arg4 <= 2592000000, 10);
        assert!(arg5 <= 10000, 4);
        let v3 = Job<T0>{
            id               : 0x2::object::new(arg8),
            buyer            : v0,
            seller           : arg0,
            escrow           : 0x2::coin::into_balance<T0>(arg1),
            amount           : v1,
            fee_bps          : arg6.fee_bps,
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
            fee_bps          : arg6.fee_bps,
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

    public fun deliver<T0>(arg0: &mut Job<T0>, arg1: vector<u8>, arg2: &FeeConfig, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.seller, 0);
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
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

    public fun fee_bps<T0>(arg0: &Job<T0>) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = FeeConfig{
            id           : 0x2::object::new(arg0),
            version      : 2,
            fee_bps      : 250,
            fee_receiver : v0,
        };
        0x2::transfer::share_object<FeeConfig>(v2);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut FeeConfig) {
        assert!(arg1.version < 2, 14);
        arg1.version = 2;
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun refund<T0>(arg0: &mut Job<T0>, arg1: &FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg0.deliver_by_ms, 8);
        arg0.state = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg3), arg0.buyer);
        let v1 = JobRefunded{
            job_id       : 0x2::object::uid_to_inner(&arg0.id),
            buyer        : arg0.buyer,
            seller       : arg0.seller,
            amount       : 0x2::balance::value<T0>(&arg0.escrow),
            timestamp_ms : v0,
        };
        0x2::event::emit<JobRefunded>(v1);
    }

    public fun reject<T0>(arg0: &mut Job<T0>, arg1: &FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.buyer, 0);
        assert!(arg0.state == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 <= arg0.delivered_at_ms + arg0.review_window_ms, 7);
        arg0.state = 4;
        let v1 = 0x2::balance::value<T0>(&arg0.escrow);
        let v2 = mul_bps(v1, arg0.reject_split_bps);
        let v3 = v1 - v2;
        let v4 = mul_bps(v3, arg0.fee_bps);
        let v5 = v3 - v4;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v2), arg3), arg0.buyer);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v4), arg3), arg1.fee_receiver);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg3), arg0.seller);
        };
        let v6 = JobRejected{
            job_id        : 0x2::object::uid_to_inner(&arg0.id),
            buyer         : arg0.buyer,
            seller        : arg0.seller,
            buyer_amount  : v2,
            seller_amount : v5,
            fee_amount    : v4,
            timestamp_ms  : v0,
        };
        0x2::event::emit<JobRejected>(v6);
    }

    public fun reject_split_bps<T0>(arg0: &Job<T0>) : u64 {
        arg0.reject_split_bps
    }

    public fun release<T0>(arg0: &mut Job<T0>, arg1: &FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3) == arg0.buyer;
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
        let v4 = 0x2::balance::value<T0>(&arg0.escrow);
        let v5 = mul_bps(v4, arg0.fee_bps);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v5), arg3), arg1.fee_receiver);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg3), arg0.seller);
        let v6 = JobReleased{
            job_id       : 0x2::object::uid_to_inner(&arg0.id),
            buyer        : arg0.buyer,
            seller       : arg0.seller,
            amount       : v4,
            fee_amount   : v5,
            by_timeout   : v2,
            timestamp_ms : v0,
        };
        0x2::event::emit<JobReleased>(v6);
    }

    public fun review_window_ms<T0>(arg0: &Job<T0>) : u64 {
        arg0.review_window_ms
    }

    public fun seller<T0>(arg0: &Job<T0>) : address {
        arg0.seller
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 <= 1000, 12);
        arg1.fee_bps = arg2;
    }

    public fun set_fee_receiver(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: address) {
        assert_version(arg1);
        arg1.fee_receiver = arg2;
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

