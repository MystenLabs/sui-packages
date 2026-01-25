module 0x85428f247963fca9f91cde8e1d68bec0070e1d7aacbad5e80f968a1cbe41ef7a::aggregator {
    struct MetricsHub has key {
        id: 0x2::object::UID,
        datapoints: 0x2::table::Table<0x1::ascii::String, CollectorConfig>,
        version: u8,
    }

    struct CollectorConfig has store {
        owner: address,
        collector: address,
        status: u8,
        primary_store: address,
        archive_store: address,
        sample_rate: u8,
        datapoints: 0x2::table::Table<0x2::object::ID, DataPoint>,
    }

    struct DataPoint has copy, drop, store {
        metric_type: 0x1::ascii::String,
        magnitude: u64,
        aggregated: bool,
    }

    struct HubCreated has copy, drop {
        hub_id: 0x1::ascii::String,
        owner: address,
    }

    struct DataPointAdded has copy, drop {
        hub_id: 0x1::ascii::String,
        point_id: 0x2::object::ID,
        metric_type: 0x1::ascii::String,
        magnitude: u64,
    }

    struct AggregationCompleted has copy, drop {
        hub_id: 0x1::ascii::String,
        point_id: 0x2::object::ID,
        result_magnitude: u64,
    }

    public entry fun activate_hub(arg0: &mut MetricsHub, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectorConfig>(&mut arg0.datapoints, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public entry fun add_datapoint(arg0: &mut MetricsHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectorConfig>(&mut arg0.datapoints, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.collector, 100);
        let v2 = DataPoint{
            metric_type : arg3,
            magnitude   : arg4,
            aggregated  : false,
        };
        if (0x2::table::contains<0x2::object::ID, DataPoint>(&v0.datapoints, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, DataPoint>(&mut v0.datapoints, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, DataPoint>(&mut v0.datapoints, arg2, v2);
        };
        let v3 = DataPointAdded{
            hub_id      : arg1,
            point_id    : arg2,
            metric_type : arg3,
            magnitude   : arg4,
        };
        0x2::event::emit<DataPointAdded>(v3);
    }

    public fun aggregate_batch<T0>(arg0: &mut MetricsHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
            return
        };
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, CollectorConfig>(&mut arg0.datapoints, arg1);
        if (v0 != v1.collector) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
            return
        };
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v1.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, DataPoint>(&v1.datapoints, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, DataPoint>(&mut v1.datapoints, arg2).aggregated = true;
        };
        let v3 = v2 * (v1.sample_rate as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1.archive_store);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1.primary_store);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v1.primary_store);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1.archive_store);
        };
        let v4 = AggregationCompleted{
            hub_id           : arg1,
            point_id         : arg2,
            result_magnitude : v2,
        };
        0x2::event::emit<AggregationCompleted>(v4);
    }

    public fun archive_point(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MetricsHub, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg1.datapoints, arg2)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v0);
            return
        };
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, CollectorConfig>(&mut arg1.datapoints, arg2);
        if (v0 != v1.collector) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v0);
            return
        };
        if (!(v1.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v0);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, DataPoint>(&v1.datapoints, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, DataPoint>(&v1.datapoints, arg3);
            !v3.aggregated && v3.magnitude > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v0);
            return
        };
        if (0x2::table::contains<0x2::object::ID, DataPoint>(&v1.datapoints, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, DataPoint>(&mut v1.datapoints, arg3).aggregated = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v1.sample_rate as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v1.archive_store);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v1.primary_store);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v1.primary_store);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v1.archive_store);
        };
        let v7 = AggregationCompleted{
            hub_id           : arg2,
            point_id         : arg3,
            result_magnitude : v5,
        };
        0x2::event::emit<AggregationCompleted>(v7);
    }

    public fun collect_metric<T0: store + key>(arg0: &mut MetricsHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1)) {
            0x2::transfer::public_transfer<T0>(arg3, v0);
            return
        };
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, CollectorConfig>(&mut arg0.datapoints, arg1);
        if (v0 != v1.collector) {
            0x2::transfer::public_transfer<T0>(arg3, v0);
            return
        };
        if (!(v1.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v0);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, DataPoint>(&v1.datapoints, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, DataPoint>(&v1.datapoints, arg2);
            !v3.aggregated && v3.magnitude > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v0);
            return
        };
        if (0x2::table::contains<0x2::object::ID, DataPoint>(&v1.datapoints, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, DataPoint>(&mut v1.datapoints, arg2).aggregated = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v1.primary_store);
        let v4 = AggregationCompleted{
            hub_id           : arg1,
            point_id         : arg2,
            result_magnitude : 1,
        };
        0x2::event::emit<AggregationCompleted>(v4);
    }

    public entry fun create_hub(arg0: &mut MetricsHub, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = CollectorConfig{
            owner         : 0x2::tx_context::sender(arg6),
            collector     : arg2,
            status        : 0,
            primary_store : arg3,
            archive_store : arg4,
            sample_rate   : arg5,
            datapoints    : 0x2::table::new<0x2::object::ID, DataPoint>(arg6),
        };
        0x2::table::add<0x1::ascii::String, CollectorConfig>(&mut arg0.datapoints, arg1, v0);
        let v1 = HubCreated{
            hub_id : arg1,
            owner  : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<HubCreated>(v1);
    }

    public fun get_hub_info(arg0: &MetricsHub, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1);
        (v0.owner, v0.collector, v0.status & 1 != 0, v0.primary_store, v0.archive_store, v0.sample_rate)
    }

    public fun get_point_info(arg0: &MetricsHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1);
        assert!(0x2::table::contains<0x2::object::ID, DataPoint>(&v0.datapoints, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, DataPoint>(&v0.datapoints, arg2);
        (v1.metric_type, v1.magnitude, v1.aggregated)
    }

    public fun get_point_magnitude(arg0: &MetricsHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, DataPoint>(&v0.datapoints, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, DataPoint>(&v0.datapoints, arg2);
        if (v1.aggregated) {
            return 0
        };
        v1.magnitude
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetricsHub{
            id         : 0x2::object::new(arg0),
            datapoints : 0x2::table::new<0x1::ascii::String, CollectorConfig>(arg0),
            version    : 1,
        };
        0x2::transfer::share_object<MetricsHub>(v0);
    }

    public fun should_aggregate(arg0: &MetricsHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_point_magnitude(arg0, arg1, arg2) > 0
    }

    public entry fun update_magnitude(arg0: &mut MetricsHub, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CollectorConfig>(&arg0.datapoints, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CollectorConfig>(&mut arg0.datapoints, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.collector, 100);
        assert!(0x2::table::contains<0x2::object::ID, DataPoint>(&v0.datapoints, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, DataPoint>(&mut v0.datapoints, arg2).magnitude = arg3;
    }

    // decompiled from Move bytecode v6
}

