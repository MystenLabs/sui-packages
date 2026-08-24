module 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        fee_receiver: address,
    }

    struct MinJobAmountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MaxJobAmountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TierActiveCapKey has copy, drop, store {
        level: u8,
    }

    struct NoDeliveryRegressionFloorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ClaimedJobKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScoreBoardKey has copy, drop, store {
        dummy_field: bool,
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

    struct JobDeclined has copy, drop {
        job_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        amount: u64,
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

    fun assert_amount_in_bounds(arg0: &FeeConfig, arg1: u64) {
        assert!(arg1 >= config_min_job_amount(arg0), 15);
        assert!(arg1 <= config_max_job_amount(arg0), 16);
    }

    public(friend) fun assert_amount_in_bounds_pkg(arg0: &FeeConfig, arg1: u64) {
        assert_amount_in_bounds(arg0, arg1);
    }

    fun assert_version(arg0: &FeeConfig) {
        assert!(arg0.version == 6, 13);
    }

    public(friend) fun assert_version_pkg(arg0: &FeeConfig) {
        assert_version(arg0);
    }

    public(friend) fun bps_denominator_pkg() : u64 {
        10000
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

    public fun config_max_job_amount(arg0: &FeeConfig) : u64 {
        let v0 = MaxJobAmountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MaxJobAmountKey>(&arg0.id, v0)) {
            let v2 = MaxJobAmountKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MaxJobAmountKey, u64>(&arg0.id, v2)
        } else {
            50000000
        }
    }

    public fun config_min_job_amount(arg0: &FeeConfig) : u64 {
        let v0 = MinJobAmountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MinJobAmountKey>(&arg0.id, v0)) {
            let v2 = MinJobAmountKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MinJobAmountKey, u64>(&arg0.id, v2)
        } else {
            50000
        }
    }

    public fun config_no_delivery_regression_floor(arg0: &FeeConfig) : u64 {
        let v0 = NoDeliveryRegressionFloorKey{dummy_field: false};
        if (0x2::dynamic_field::exists<NoDeliveryRegressionFloorKey>(&arg0.id, v0)) {
            let v2 = NoDeliveryRegressionFloorKey{dummy_field: false};
            *0x2::dynamic_field::borrow<NoDeliveryRegressionFloorKey, u64>(&arg0.id, v2)
        } else {
            3
        }
    }

    public fun config_score_board_id(arg0: &FeeConfig) : 0x1::option::Option<0x2::object::ID> {
        let v0 = ScoreBoardKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ScoreBoardKey>(&arg0.id, v0)) {
            let v2 = ScoreBoardKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<ScoreBoardKey, 0x2::object::ID>(&arg0.id, v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun config_tier_active_cap(arg0: &FeeConfig, arg1: u8) : u64 {
        assert!(arg1 >= 1 && arg1 <= 4, 21);
        let v0 = TierActiveCapKey{level: arg1};
        if (0x2::dynamic_field::exists<TierActiveCapKey>(&arg0.id, v0)) {
            let v2 = TierActiveCapKey{level: arg1};
            *0x2::dynamic_field::borrow<TierActiveCapKey, u64>(&arg0.id, v2)
        } else if (arg1 == 1) {
            4
        } else if (arg1 == 2) {
            10
        } else if (arg1 == 3) {
            20
        } else {
            30
        }
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
        assert_amount_in_bounds(arg6, v1);
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

    public(friend) fun create_claimed<T0>(arg0: address, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &FeeConfig, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg8);
        assert!(arg0 != arg1, 9);
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        assert!(arg3 <= 1000, 12);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 > v1, 3);
        assert!(arg5 <= v1 + 31536000000, 11);
        assert!(arg6 <= 2592000000, 10);
        assert!(arg7 <= 10000, 4);
        let v2 = Job<T0>{
            id               : 0x2::object::new(arg10),
            buyer            : arg0,
            seller           : arg1,
            escrow           : arg2,
            amount           : v0,
            fee_bps          : arg3,
            spec_hash        : arg4,
            deliver_by_ms    : arg5,
            review_window_ms : arg6,
            reject_split_bps : arg7,
            state            : 0,
            delivery_hash    : b"",
            delivered_at_ms  : 0,
            created_at_ms    : v1,
        };
        let v3 = ClaimedJobKey{dummy_field: false};
        0x2::dynamic_field::add<ClaimedJobKey, bool>(&mut v2.id, v3, true);
        let v4 = 0x2::object::uid_to_inner(&v2.id);
        let v5 = JobCreated{
            job_id           : v4,
            buyer            : arg0,
            seller           : arg1,
            amount           : v0,
            fee_bps          : arg3,
            deliver_by_ms    : arg5,
            review_window_ms : arg6,
            reject_split_bps : arg7,
            timestamp_ms     : v1,
        };
        0x2::event::emit<JobCreated>(v5);
        0x2::transfer::share_object<Job<T0>>(v2);
        v4
    }

    public fun created_at_ms<T0>(arg0: &Job<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun decline<T0>(arg0: &mut Job<T0>, arg1: &FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 0);
        assert!(arg0.state == 0, 1);
        arg0.state = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg3), arg0.buyer);
        let v0 = JobDeclined{
            job_id       : 0x2::object::uid_to_inner(&arg0.id),
            buyer        : arg0.buyer,
            seller       : arg0.seller,
            amount       : 0x2::balance::value<T0>(&arg0.escrow),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<JobDeclined>(v0);
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
            version      : 6,
            fee_bps      : 250,
            fee_receiver : v0,
        };
        0x2::transfer::share_object<FeeConfig>(v2);
    }

    public fun is_claimed_job<T0>(arg0: &Job<T0>) : bool {
        let v0 = ClaimedJobKey{dummy_field: false};
        0x2::dynamic_field::exists<ClaimedJobKey>(&arg0.id, v0)
    }

    public(friend) fun max_deliver_horizon_ms_pkg() : u64 {
        31536000000
    }

    public(friend) fun max_review_window_ms_pkg() : u64 {
        2592000000
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut FeeConfig) {
        assert!(arg1.version < 6, 14);
        arg1.version = 6;
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun record_score_board_pkg(arg0: &mut FeeConfig, arg1: 0x2::object::ID) {
        let v0 = ScoreBoardKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ScoreBoardKey>(&arg0.id, v0), 18);
        let v1 = ScoreBoardKey{dummy_field: false};
        0x2::dynamic_field::add<ScoreBoardKey, 0x2::object::ID>(&mut arg0.id, v1, arg1);
    }

    public fun refund<T0>(arg0: &mut Job<T0>, arg1: &FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        abort 19
    }

    public(friend) fun refund_settle_pkg<T0>(arg0: &mut Job<T0>, arg1: &FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
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
        abort 19
    }

    public(friend) fun reject_settle_pkg<T0>(arg0: &mut Job<T0>, arg1: &FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
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
        abort 20
    }

    public(friend) fun release_settle_pkg<T0>(arg0: &mut Job<T0>, arg1: &FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
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

    public fun set_max_job_amount(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 <= 100000000, 17);
        assert!(arg2 >= config_min_job_amount(arg1), 17);
        let v0 = MaxJobAmountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MaxJobAmountKey>(&arg1.id, v0)) {
            let v1 = MaxJobAmountKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<MaxJobAmountKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = MaxJobAmountKey{dummy_field: false};
            0x2::dynamic_field::add<MaxJobAmountKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_min_job_amount(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 >= 10000, 17);
        assert!(arg2 <= config_max_job_amount(arg1), 17);
        let v0 = MinJobAmountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MinJobAmountKey>(&arg1.id, v0)) {
            let v1 = MinJobAmountKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<MinJobAmountKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = MinJobAmountKey{dummy_field: false};
            0x2::dynamic_field::add<MinJobAmountKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_no_delivery_regression_floor(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 > 0, 21);
        let v0 = NoDeliveryRegressionFloorKey{dummy_field: false};
        if (0x2::dynamic_field::exists<NoDeliveryRegressionFloorKey>(&arg1.id, v0)) {
            let v1 = NoDeliveryRegressionFloorKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<NoDeliveryRegressionFloorKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = NoDeliveryRegressionFloorKey{dummy_field: false};
            0x2::dynamic_field::add<NoDeliveryRegressionFloorKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_tier_active_cap(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u8, arg3: u64) {
        assert_version(arg1);
        assert!(arg2 >= 1 && arg2 <= 4, 21);
        assert!(arg3 > 0, 21);
        let v0 = TierActiveCapKey{level: arg2};
        if (0x2::dynamic_field::exists<TierActiveCapKey>(&arg1.id, v0)) {
            let v1 = TierActiveCapKey{level: arg2};
            *0x2::dynamic_field::borrow_mut<TierActiveCapKey, u64>(&mut arg1.id, v1) = arg3;
        } else {
            let v2 = TierActiveCapKey{level: arg2};
            0x2::dynamic_field::add<TierActiveCapKey, u64>(&mut arg1.id, v2, arg3);
        };
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

