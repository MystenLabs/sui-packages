module 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator {
    struct Aggregator has key {
        id: 0x2::object::UID,
        authority: address,
        queue_addr: address,
        token_addr: address,
        batch_size: u64,
        min_oracle_results: u64,
        min_update_delay_seconds: u64,
        name: vector<u8>,
        history_limit: u64,
        variance_threshold: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
        force_report_period: u64,
        min_job_results: u64,
        crank_disabled: bool,
        crank_row_count: u8,
        next_allowed_update_time: u64,
        created_at: u64,
        read_charge: u64,
        reward_escrow: address,
        read_whitelist: 0x2::bag::Bag,
        limit_reads_to_whitelist: bool,
        update_data: SlidingWindow,
        interval_id: u64,
        curr_interval_payouts: u64,
        next_interval_refresh_time: u64,
        escrows: 0x2::bag::Bag,
        friend_key: vector<u8>,
        version: u64,
    }

    struct SlidingWindowElement has copy, drop, store {
        oracle_addr: address,
        value: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
        timestamp: u64,
    }

    struct SlidingWindow has copy, store {
        data: vector<SlidingWindowElement>,
        latest_result: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
        latest_timestamp: u64,
    }

    struct AggregatorHistoryData has store, key {
        id: 0x2::object::UID,
        data: vector<AggregatorHistoryRow>,
        history_write_idx: u64,
    }

    struct AggregatorHistoryRow has copy, drop, store {
        value: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
        timestamp: u64,
    }

    struct AggregatorJobData has store, key {
        id: 0x2::object::UID,
        job_keys: vector<address>,
        job_weights: vector<u8>,
        jobs_checksum: vector<u8>,
    }

    public fun new<T0: drop>(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: address, arg12: vector<address>, arg13: bool, arg14: u64, arg15: address, arg16: &T0, arg17: &mut 0x2::tx_context::TxContext) : Aggregator {
        let v0 = 0x2::object::new(arg17);
        let v1 = AggregatorHistoryData{
            id                : 0x2::object::new(arg17),
            data              : 0x1::vector::empty<AggregatorHistoryRow>(),
            history_write_idx : 0,
        };
        0x2::dynamic_object_field::add<vector<u8>, AggregatorHistoryData>(&mut v0, b"history", v1);
        let v2 = AggregatorJobData{
            id            : 0x2::object::new(arg17),
            job_keys      : 0x1::vector::empty<address>(),
            job_weights   : 0x1::vector::empty<u8>(),
            jobs_checksum : 0x1::vector::empty<u8>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, AggregatorJobData>(&mut v0, b"job_data", v2);
        let v3 = 0x2::bag::new(arg17);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg12)) {
            0x2::bag::add<address, bool>(&mut v3, *0x1::vector::borrow<address>(&arg12, v4), true);
            v4 = v4 + 1;
        };
        let v5 = SlidingWindow{
            data             : 0x1::vector::empty<SlidingWindowElement>(),
            latest_result    : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::zero(),
            latest_timestamp : arg14,
        };
        Aggregator{
            id                         : v0,
            authority                  : arg15,
            queue_addr                 : arg1,
            token_addr                 : @0x0,
            batch_size                 : arg2,
            min_oracle_results         : arg3,
            min_update_delay_seconds   : arg5,
            name                       : arg0,
            history_limit              : arg9,
            variance_threshold         : arg6,
            force_report_period        : arg7,
            min_job_results            : arg4,
            crank_disabled             : arg8,
            crank_row_count            : 0,
            next_allowed_update_time   : 0,
            created_at                 : arg14,
            read_charge                : arg10,
            reward_escrow              : arg11,
            read_whitelist             : v3,
            limit_reads_to_whitelist   : arg13,
            update_data                : v5,
            interval_id                : 0,
            curr_interval_payouts      : 0,
            next_interval_refresh_time : arg14,
            escrows                    : 0x2::bag::new(arg17),
            friend_key                 : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>(),
            version                    : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(),
        }
    }

    public fun add_crank_row_count<T0>(arg0: &mut Aggregator, arg1: &T0) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.crank_row_count = arg0.crank_row_count + 1;
    }

    public fun add_job(arg0: &mut Aggregator, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::Job, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_authority(arg0, arg3), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, AggregatorJobData>(&mut arg0.id, b"job_data");
        if (!0x2::dynamic_field::exists_with_type<address, vector<u8>>(&v0.id, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::job_address(arg1))) {
            0x2::dynamic_field::add<address, vector<u8>>(&mut v0.id, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::job_address(arg1), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::hash(arg1));
        };
        0x1::vector::push_back<address>(&mut v0.job_keys, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::job_address(arg1));
        0x1::vector::push_back<u8>(&mut v0.job_weights, arg2);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.job_keys)) {
            0x1::vector::append<u8>(&mut v1, *0x2::dynamic_field::borrow<address, vector<u8>>(&v0.id, *0x1::vector::borrow<address>(&v0.job_keys, v2)));
            let v3 = v1;
            v1 = 0x1::hash::sha3_256(v3);
            v2 = v2 + 1;
        };
        v0.jobs_checksum = v1;
    }

    public fun add_to_sliding_window(arg0: &mut SlidingWindow, arg1: address, arg2: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg3: u64, arg4: u64, arg5: u64) : (bool, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<SlidingWindowElement>(&arg0.data)) {
            let v2 = 0x1::vector::borrow<SlidingWindowElement>(&arg0.data, v0);
            if (v2.oracle_addr == arg1) {
                0x1::vector::swap_remove<SlidingWindowElement>(&mut arg0.data, v0);
                continue
            };
            if (v2.timestamp < v1) {
                v1 = v2.timestamp;
            };
            v0 = v0 + 1;
        };
        let v3 = SlidingWindowElement{
            oracle_addr : arg1,
            value       : arg2,
            timestamp   : arg5,
        };
        0x1::vector::push_back<SlidingWindowElement>(&mut arg0.data, v3);
        if (0x1::vector::length<SlidingWindowElement>(&arg0.data) > arg3) {
            0x1::vector::swap_remove<SlidingWindowElement>(&mut arg0.data, 0);
        };
        if (0x1::vector::length<SlidingWindowElement>(&arg0.data) < arg4) {
            return (false, arg0.latest_result)
        };
        let v4 = 0x1::vector::empty<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal>();
        v0 = 0;
        while (v0 < 0x1::vector::length<SlidingWindowElement>(&arg0.data)) {
            0x1::vector::push_back<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal>(&mut v4, 0x1::vector::borrow<SlidingWindowElement>(&arg0.data, v0).value);
            v0 = v0 + 1;
        };
        arg0.latest_result = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::median(&mut v4);
        arg0.latest_timestamp = arg5;
        (true, arg0.latest_result)
    }

    public fun aggregator_address(arg0: &Aggregator) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun authority(arg0: &Aggregator) : address {
        arg0.authority
    }

    public fun batch_size(arg0: &Aggregator) : u64 {
        arg0.batch_size
    }

    public fun can_open_round(arg0: &Aggregator, arg1: u64) : bool {
        arg1 >= arg0.next_allowed_update_time
    }

    public fun crank_disabled(arg0: &Aggregator) : bool {
        arg0.crank_disabled
    }

    public fun crank_row_count(arg0: &Aggregator) : u8 {
        arg0.crank_row_count
    }

    public fun created_at(arg0: &Aggregator) : u64 {
        arg0.created_at
    }

    public fun curr_interval_payouts(arg0: &Aggregator) : u64 {
        arg0.curr_interval_payouts
    }

    public fun escrow_balance<T0>(arg0: &Aggregator, arg1: address) : u64 {
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::escrow_balance<T0>(&arg0.escrows, arg1)
    }

    public fun escrow_deposit<T0, T1>(arg0: &mut Aggregator, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &T1) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T1>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::escrow_deposit<T0>(&mut arg0.escrows, arg1, arg2);
    }

    public fun escrow_withdraw<T0, T1>(arg0: &mut Aggregator, arg1: address, arg2: u64, arg3: &T1, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T1>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::escrow_withdraw<T0>(&mut arg0.escrows, arg1, arg2, arg4)
    }

    public fun has_authority(arg0: &Aggregator, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.authority == 0x2::tx_context::sender(arg1)
    }

    public fun increment_curr_interval_payouts<T0>(arg0: &mut Aggregator, arg1: &T0) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.curr_interval_payouts = arg0.curr_interval_payouts + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun interval_id(arg0: &Aggregator) : u64 {
        arg0.interval_id
    }

    public fun is_locked(arg0: &Aggregator) : bool {
        arg0.authority == @0x0
    }

    public fun job_keys(arg0: &Aggregator) : vector<address> {
        0x2::dynamic_object_field::borrow<vector<u8>, AggregatorJobData>(&arg0.id, b"job_data").job_keys
    }

    public fun latest_value(arg0: &Aggregator) : (0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, u64) {
        assert!(arg0.read_charge == 0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        (arg0.update_data.latest_result, arg0.update_data.latest_timestamp)
    }

    entry fun migrate(arg0: &mut Aggregator, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::AdminCap) {
        assert!(arg0.version < 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        arg0.version = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version();
    }

    public fun migrate_package<T0, T1>(arg0: &mut Aggregator, arg1: &T0, arg2: &T1) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        arg0.friend_key = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T1>();
    }

    public fun min_oracle_results(arg0: &Aggregator) : u64 {
        arg0.min_oracle_results
    }

    public fun new_sliding_window() : SlidingWindow {
        SlidingWindow{
            data             : 0x1::vector::empty<SlidingWindowElement>(),
            latest_result    : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::zero(),
            latest_timestamp : 0,
        }
    }

    public fun next_payment_interval<T0>(arg0: &mut Aggregator, arg1: &T0) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.interval_id = arg0.interval_id + 1;
        arg0.curr_interval_payouts = 0;
    }

    public fun push_update<T0>(arg0: &mut Aggregator, arg1: address, arg2: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg3: u64, arg4: &T0) : (bool, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (arg0.next_interval_refresh_time < arg3) {
            arg0.interval_id = arg0.interval_id + 1;
            arg0.curr_interval_payouts = 0;
            arg0.next_interval_refresh_time = arg3 + arg0.min_update_delay_seconds;
        };
        let v1 = &mut arg0.update_data;
        let (v2, v3) = add_to_sliding_window(v1, arg1, arg2, arg0.batch_size, arg0.min_oracle_results, arg3);
        if (arg0.history_limit != 0) {
            let v4 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, AggregatorHistoryData>(&mut arg0.id, b"history");
            if (0x1::vector::length<AggregatorHistoryRow>(&v4.data) != arg0.history_limit) {
                let v5 = &mut v4.data;
                let v6 = AggregatorHistoryRow{
                    value     : arg0.update_data.latest_result,
                    timestamp : arg3,
                };
                0x1::vector::push_back<AggregatorHistoryRow>(v5, v6);
            } else {
                let v7 = 0x1::vector::borrow_mut<AggregatorHistoryRow>(&mut v4.data, v4.history_write_idx);
                v7.value = arg0.update_data.latest_result;
                v7.timestamp = arg3;
            };
            v4.history_write_idx = (v4.history_write_idx + 1) % arg0.history_limit;
        };
        (v2, v3)
    }

    public fun queue_address(arg0: &Aggregator) : address {
        arg0.queue_addr
    }

    public fun remove_job(arg0: &mut Aggregator, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_authority(arg0, arg2), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, AggregatorJobData>(&mut arg0.id, b"job_data");
        let (v1, v2) = 0x1::vector::index_of<address>(&v0.job_keys, &arg1);
        if (!v1) {
            return
        };
        0x1::vector::swap_remove<address>(&mut v0.job_keys, v2);
        0x1::vector::swap_remove<u8>(&mut v0.job_weights, v2);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v0.job_keys)) {
            0x1::vector::append<u8>(&mut v3, *0x2::dynamic_field::borrow<address, vector<u8>>(&v0.id, *0x1::vector::borrow<address>(&v0.job_keys, v4)));
            let v5 = v3;
            v3 = 0x1::hash::sha3_256(v5);
            v4 = v4 + 1;
        };
        v0.jobs_checksum = v3;
    }

    public fun results_older_than(arg0: &SlidingWindow, arg1: &0x2::clock::Clock, arg2: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SlidingWindowElement>(&arg0.data)) {
            if (0x2::clock::timestamp_ms(arg1) / 1000 - 0x1::vector::borrow<SlidingWindowElement>(&arg0.data, v0).timestamp >= arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun set_aggregator_token(arg0: &mut Aggregator, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_authority(arg0, arg2), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.token_addr = arg1;
    }

    public fun set_authority(arg0: &mut Aggregator, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_authority(arg0, arg2), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.authority = arg1;
    }

    public fun set_config(arg0: &mut Aggregator, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: address, arg13: vector<address>, arg14: vector<address>, arg15: bool, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(has_authority(arg0, arg16), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.name = arg1;
        arg0.min_job_results = arg5;
        arg0.variance_threshold = arg7;
        arg0.force_report_period = arg8;
        arg0.crank_disabled = arg9;
        arg0.queue_addr = arg2;
        arg0.batch_size = arg3;
        arg0.min_oracle_results = arg4;
        arg0.min_update_delay_seconds = arg6;
        arg0.variance_threshold = arg7;
        arg0.force_report_period = arg8;
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg13)) {
            0x2::bag::add<address, bool>(&mut arg0.read_whitelist, *0x1::vector::borrow<address>(&arg13, v0), true);
            v0 = v0 + 1;
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg14)) {
            0x2::bag::remove<address, bool>(&mut arg0.read_whitelist, *0x1::vector::borrow<address>(&arg14, v1));
            v1 = v1 + 1;
        };
        arg0.read_charge = arg11;
        arg0.reward_escrow = arg12;
        arg0.limit_reads_to_whitelist = arg15;
        if (arg10 != arg0.history_limit) {
            let v2 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, AggregatorHistoryData>(&mut arg0.id, b"history");
            v2.data = 0x1::vector::empty<AggregatorHistoryRow>();
            v2.history_write_idx = 0;
            arg0.history_limit = arg10;
        };
    }

    public fun share_aggregator(arg0: Aggregator) {
        0x2::transfer::share_object<Aggregator>(arg0);
    }

    public fun sliding_window_latest_result(arg0: &SlidingWindow) : (0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, u64) {
        (arg0.latest_result, arg0.latest_timestamp)
    }

    public fun sub_crank_row_count<T0>(arg0: &mut Aggregator, arg1: &T0) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.crank_row_count = arg0.crank_row_count - 1;
    }

    // decompiled from Move bytecode v6
}

