module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator {
    struct CurrentResult has drop, store {
        result: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal,
        min_timestamp_ms: u64,
        max_timestamp_ms: u64,
        min_result: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal,
        max_result: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal,
        stdev: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal,
        range: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal,
        mean: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal,
    }

    struct Update has copy, drop, store {
        result: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal,
        timestamp_ms: u64,
        oracle: 0x2::object::ID,
    }

    struct UpdateState has store {
        results: vector<Update>,
        curr_idx: u64,
    }

    struct Aggregator has key {
        id: 0x2::object::UID,
        queue: 0x2::object::ID,
        created_at_ms: u64,
        name: 0x1::string::String,
        authority: address,
        feed_hash: vector<u8>,
        min_sample_size: u64,
        max_staleness_seconds: u64,
        max_variance: u64,
        min_responses: u32,
        current_result: CurrentResult,
        update_state: UpdateState,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg9);
        let v1 = CurrentResult{
            result           : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero(),
            min_timestamp_ms : 0,
            max_timestamp_ms : 0,
            min_result       : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero(),
            max_result       : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero(),
            stdev            : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero(),
            range            : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero(),
            mean             : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero(),
        };
        let v2 = UpdateState{
            results  : 0x1::vector::empty<Update>(),
            curr_idx : 0,
        };
        let v3 = Aggregator{
            id                    : v0,
            queue                 : arg0,
            created_at_ms         : arg8,
            name                  : arg1,
            authority             : arg2,
            feed_hash             : arg3,
            min_sample_size       : arg4,
            max_staleness_seconds : arg5,
            max_variance          : arg6,
            min_responses         : arg7,
            current_result        : v1,
            update_state          : v2,
        };
        0x2::transfer::share_object<Aggregator>(v3);
        *0x2::object::uid_as_inner(&v0)
    }

    fun add_i128(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        if (arg1 && arg3) {
            return (arg0 + arg2, true)
        };
        if (!arg1 && arg3) {
            if (arg0 < arg2) {
                return (arg2 - arg0, true)
            };
            return (arg0 - arg2, false)
        };
        if (arg1 && !arg3) {
            if (arg0 < arg2) {
                return (arg2 - arg0, false)
            };
            return (arg0 - arg2, true)
        };
        (arg0 + arg2, false)
    }

    public(friend) fun add_result(arg0: &mut Aggregator, arg1: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = &mut arg0.update_state;
        set_update(v0, arg1, arg3, arg2);
        let v1 = compute_current_result(arg0, 0x2::clock::timestamp_ms(arg4));
        if (0x1::option::is_some<CurrentResult>(&v1)) {
            arg0.current_result = 0x1::option::extract<CurrentResult>(&mut v1);
        };
    }

    public fun authority(arg0: &Aggregator) : address {
        arg0.authority
    }

    fun compute_current_result(arg0: &Aggregator, arg1: u64) : 0x1::option::Option<CurrentResult> {
        let v0 = &arg0.update_state;
        let v1 = &v0.results;
        let v2 = valid_update_indices(v0, arg0.max_staleness_seconds * 1000, arg1);
        if (0x1::vector::length<u64>(&v2) < arg0.min_sample_size) {
            return 0x1::option::none<CurrentResult>()
        };
        if (0x1::vector::length<u64>(&v2) == 1) {
            let v3 = &mut v2;
            let v4 = median_result(v0, v3);
            let v5 = CurrentResult{
                result           : v4,
                min_timestamp_ms : 0x1::vector::borrow<Update>(v1, *0x1::vector::borrow<u64>(&v2, 0)).timestamp_ms,
                max_timestamp_ms : 0x1::vector::borrow<Update>(v1, *0x1::vector::borrow<u64>(&v2, 0)).timestamp_ms,
                min_result       : v4,
                max_result       : v4,
                stdev            : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero(),
                range            : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero(),
                mean             : v4,
            };
            return 0x1::option::some<CurrentResult>(v5)
        };
        let v6 = 0;
        let v7 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::max_value();
        let v8 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::zero();
        let v9 = 18446744073709551615;
        let v10 = 0;
        let v11 = 0;
        let v12 = false;
        let v13 = 0;
        let v14 = false;
        let v15 = 0;
        let v16 = &v2;
        let v17 = 0;
        while (v17 < 0x1::vector::length<u64>(v16)) {
            let v18 = 0x1::vector::borrow<Update>(v1, *0x1::vector::borrow<u64>(v16, v17));
            let v19 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::value(&v18.result);
            let v20 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::neg(&v18.result);
            let v21 = v15 + 1;
            v15 = v21;
            let (v22, v23) = sub_i128(v19, v20, v11, v12);
            let (v24, v25) = add_i128(v11, v12, v22 / v21, v23);
            v12 = v25;
            v11 = v24;
            let (v26, v27) = sub_i128(v19, v20, v24, v25);
            let (v28, v29) = add_i128(v13, v14, v22 * v26, v23 != v27);
            v14 = v29;
            v13 = v28;
            v6 = v6 + v19;
            let v30 = &v7;
            v7 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::min(v30, &v18.result);
            let v31 = &v8;
            v8 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::max(v31, &v18.result);
            v9 = 0x1::u64::min(v9, v18.timestamp_ms);
            v10 = 0x1::u64::max(v10, v18.timestamp_ms);
            v17 = v17 + 1;
        };
        let v32 = &mut v2;
        let v33 = CurrentResult{
            result           : median_result(v0, v32),
            min_timestamp_ms : v9,
            max_timestamp_ms : v10,
            min_result       : v7,
            max_result       : v8,
            stdev            : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::new(0x1::u128::sqrt(v13 / (v15 - 1)), false),
            range            : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::sub(&v8, &v7),
            mean             : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::new(v11, false),
        };
        0x1::option::some<CurrentResult>(v33)
    }

    public fun created_at_ms(arg0: &Aggregator) : u64 {
        arg0.created_at_ms
    }

    public fun current_result(arg0: &Aggregator) : &CurrentResult {
        &arg0.current_result
    }

    public fun feed_hash(arg0: &Aggregator) : vector<u8> {
        arg0.feed_hash
    }

    public fun has_authority(arg0: &Aggregator, arg1: &mut 0x2::tx_context::TxContext) : bool {
        arg0.authority == 0x2::tx_context::sender(arg1)
    }

    public fun id(arg0: &Aggregator) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun max_result(arg0: &CurrentResult) : &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal {
        &arg0.max_result
    }

    public fun max_staleness_seconds(arg0: &Aggregator) : u64 {
        arg0.max_staleness_seconds
    }

    public fun max_timestamp_ms(arg0: &CurrentResult) : u64 {
        arg0.max_timestamp_ms
    }

    public fun max_variance(arg0: &Aggregator) : u64 {
        arg0.max_variance
    }

    public fun mean(arg0: &CurrentResult) : &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal {
        &arg0.mean
    }

    fun median_result(arg0: &UpdateState, arg1: &mut vector<u64>) : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal {
        let v0 = &arg0.results;
        let v1 = 0x1::vector::length<u64>(arg1);
        let v2 = v1 / 2;
        let v3 = 0;
        let v4 = v1 - 1;
        while (v3 < v4) {
            let v5 = v3;
            while (v3 < v4) {
                if (0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::lt(&0x1::vector::borrow<Update>(v0, *0x1::vector::borrow<u64>(arg1, v3)).result, &0x1::vector::borrow<Update>(v0, *0x1::vector::borrow<u64>(arg1, v4)).result)) {
                    0x1::vector::swap<u64>(arg1, v5, v3);
                    v5 = v5 + 1;
                };
                v3 = v3 + 1;
            };
            0x1::vector::swap<u64>(arg1, v5, v4);
            if (v5 == v2) {
                break
            };
            if (v5 < v2) {
                v3 = v5 + 1;
                continue
            };
            v4 = v5 - 1;
        };
        0x1::vector::borrow<Update>(v0, *0x1::vector::borrow<u64>(arg1, v2)).result
    }

    public fun min_responses(arg0: &Aggregator) : u32 {
        arg0.min_responses
    }

    public fun min_result(arg0: &CurrentResult) : &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal {
        &arg0.min_result
    }

    public fun min_sample_size(arg0: &Aggregator) : u64 {
        arg0.min_sample_size
    }

    public fun min_timestamp_ms(arg0: &CurrentResult) : u64 {
        arg0.min_timestamp_ms
    }

    public fun name(arg0: &Aggregator) : 0x1::string::String {
        arg0.name
    }

    public fun queue(arg0: &Aggregator) : 0x2::object::ID {
        arg0.queue
    }

    public fun range(arg0: &CurrentResult) : &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal {
        &arg0.range
    }

    public fun result(arg0: &CurrentResult) : &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal {
        &arg0.result
    }

    public(friend) fun set_authority(arg0: &mut Aggregator, arg1: address) {
        arg0.authority = arg1;
    }

    public(friend) fun set_configs(arg0: &mut Aggregator, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u32) {
        arg0.feed_hash = arg1;
        arg0.min_sample_size = arg2;
        arg0.max_staleness_seconds = arg3;
        arg0.max_variance = arg4;
        arg0.min_responses = arg5;
    }

    fun set_update(arg0: &mut UpdateState, arg1: 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = &mut arg0.results;
        let v1 = arg0.curr_idx;
        let v2 = (v1 + 1) % 16;
        if (0x1::vector::length<Update>(v0) == 0) {
            let v3 = Update{
                result       : arg1,
                timestamp_ms : arg3,
                oracle       : arg2,
            };
            0x1::vector::push_back<Update>(v0, v3);
            return
        };
        if (0x1::vector::length<Update>(v0) > 0) {
            if (arg3 < 0x1::vector::borrow<Update>(v0, v1).timestamp_ms) {
                abort arg3
            };
        };
        if (0x1::vector::length<Update>(v0) < 16) {
            let v4 = Update{
                result       : arg1,
                timestamp_ms : arg3,
                oracle       : arg2,
            };
            0x1::vector::push_back<Update>(v0, v4);
        } else {
            let v5 = 0x1::vector::borrow_mut<Update>(v0, v2);
            v5.result = arg1;
            v5.timestamp_ms = arg3;
            v5.oracle = arg2;
        };
        arg0.curr_idx = v2;
    }

    public fun stdev(arg0: &CurrentResult) : &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal {
        &arg0.stdev
    }

    fun sub_i128(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        add_i128(arg0, arg1, arg2, !arg3)
    }

    fun valid_update_indices(arg0: &UpdateState, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = &arg0.results;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x2::vec_set::empty<0x2::object::ID>();
        let v3 = arg0.curr_idx;
        let v4 = 0x1::u64::min(16, 0x1::vector::length<Update>(v0));
        if (v4 == 0) {
            return v1
        };
        loop {
            if (v4 == 0 || 0x1::vector::borrow<Update>(v0, v3).timestamp_ms + arg1 < arg2) {
                break
            };
            let v5 = 0x1::vector::borrow<Update>(v0, v3).oracle;
            if (!0x2::vec_set::contains<0x2::object::ID>(&v2, &v5)) {
                0x2::vec_set::insert<0x2::object::ID>(&mut v2, v5);
                0x1::vector::push_back<u64>(&mut v1, v3);
            };
            if (v3 == 0) {
                v3 = 0x1::vector::length<Update>(v0) - 1;
            } else {
                v3 = v3 - 1;
            };
            v4 = v4 - 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

