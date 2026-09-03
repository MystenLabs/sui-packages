module 0x27382a2058063f29c6adcf32d2489b9b8ce64202b6b2f7606335974764a84316::oracle {
    struct OracleUpdated has copy, drop {
        sid: u256,
        timestamp: u64,
        update_ts_ms: u64,
    }

    struct BatchIngested has copy, drop {
        batch_timestamp: u64,
        update_count: u64,
        applied: u64,
        update_ts_ms: u64,
    }

    struct RawSvi has copy, drop, store {
        svi_a_magnitude: u128,
        svi_a_is_negative: bool,
        svi_b: u128,
        svi_sigma: u128,
        svi_rho_magnitude: u128,
        svi_rho_is_negative: bool,
        svi_m_magnitude: u128,
        svi_m_is_negative: bool,
    }

    struct ExampleOracle has key {
        id: 0x2::object::UID,
        values: 0x2::table::Table<u256, u128>,
        svis: 0x2::table::Table<u256, RawSvi>,
        last_ts: 0x2::table::Table<u256, u64>,
        last_batch_ts: u64,
        sid_is_absolute: 0x2::table::Table<u256, bool>,
    }

    fun format_guard(arg0: &mut ExampleOracle, arg1: u256, arg2: bool) : bool {
        if (0x2::table::contains<u256, bool>(&arg0.sid_is_absolute, arg1)) {
            *0x2::table::borrow<u256, bool>(&arg0.sid_is_absolute, arg1) == arg2
        } else {
            0x2::table::add<u256, bool>(&mut arg0.sid_is_absolute, arg1, arg2);
            true
        }
    }

    public fun has_svi(arg0: &ExampleOracle, arg1: u256) : bool {
        0x2::table::contains<u256, RawSvi>(&arg0.svis, arg1)
    }

    public fun has_value(arg0: &ExampleOracle, arg1: u256) : bool {
        0x2::table::contains<u256, u128>(&arg0.values, arg1)
    }

    public fun ingest_svi_absolute_batch(arg0: &mut ExampleOracle, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviAbsoluteBatch, arg2: &0x2::clock::Clock) {
        let v0 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_absolute_batch_timestamp(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        validate_batch_timestamp(v0, v1);
        let v2 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::into_svi_absolute_updates(arg1);
        record_batch_timestamp(arg0, v0);
        let v3 = 0x1::vector::length<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviAbsoluteUpdate>(&v2);
        let v4 = 0;
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviAbsoluteUpdate>(&v2, v5);
            let v7 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_absolute_sid(v6);
            v5 = v5 + 1;
            let v8 = format_guard(arg0, v7, true);
            if (!v8) {
                continue
            };
            let v9 = replay_guard(arg0, v7, v0);
            if (!v9) {
                continue
            };
            let (v10, v11, v12, v13, v14, v15, v16, v17) = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_absolute_fields(v6);
            let v18 = &mut arg0.svis;
            let v19 = RawSvi{
                svi_a_magnitude     : v10,
                svi_a_is_negative   : v11,
                svi_b               : v12,
                svi_sigma           : v13,
                svi_rho_magnitude   : v14,
                svi_rho_is_negative : v15,
                svi_m_magnitude     : v16,
                svi_m_is_negative   : v17,
            };
            upsert<RawSvi>(v18, v7, v19);
            v4 = v4 + 1;
            let v20 = OracleUpdated{
                sid          : v7,
                timestamp    : v0,
                update_ts_ms : v1,
            };
            0x2::event::emit<OracleUpdated>(v20);
        };
        let v21 = BatchIngested{
            batch_timestamp : v0,
            update_count    : v3,
            applied         : v4,
            update_ts_ms    : v1,
        };
        0x2::event::emit<BatchIngested>(v21);
    }

    public fun ingest_svi_batch(arg0: &mut ExampleOracle, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviBatch, arg2: &0x2::clock::Clock) {
        let v0 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_batch_timestamp(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        validate_batch_timestamp(v0, v1);
        let v2 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::into_svi_updates(arg1);
        record_batch_timestamp(arg0, v0);
        let v3 = 0x1::vector::length<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviUpdate>(&v2);
        let v4 = 0;
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviUpdate>(&v2, v5);
            let v7 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_sid(v6);
            let v8 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_timestamp(v6);
            v5 = v5 + 1;
            let v9 = format_guard(arg0, v7, false);
            if (!v9) {
                continue
            };
            let v10 = replay_guard(arg0, v7, v8);
            if (!v10) {
                continue
            };
            let (v11, v12, v13, v14, v15, v16, v17, v18) = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_fields(v6);
            let v19 = &mut arg0.svis;
            let v20 = RawSvi{
                svi_a_magnitude     : v11,
                svi_a_is_negative   : v12,
                svi_b               : v13,
                svi_sigma           : v14,
                svi_rho_magnitude   : v15,
                svi_rho_is_negative : v16,
                svi_m_magnitude     : v17,
                svi_m_is_negative   : v18,
            };
            upsert<RawSvi>(v19, v7, v20);
            v4 = v4 + 1;
            let v21 = OracleUpdated{
                sid          : v7,
                timestamp    : v8,
                update_ts_ms : v1,
            };
            0x2::event::emit<OracleUpdated>(v21);
        };
        let v22 = BatchIngested{
            batch_timestamp : v0,
            update_count    : v3,
            applied         : v4,
            update_ts_ms    : v1,
        };
        0x2::event::emit<BatchIngested>(v22);
    }

    public fun ingest_value_absolute_batch(arg0: &mut ExampleOracle, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueAbsoluteBatch, arg2: &0x2::clock::Clock) {
        let v0 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_absolute_batch_timestamp(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        validate_batch_timestamp(v0, v1);
        let v2 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::into_value_absolute_updates(arg1);
        record_batch_timestamp(arg0, v0);
        let v3 = 0x1::vector::length<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueAbsoluteUpdate>(&v2);
        let v4 = 0;
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueAbsoluteUpdate>(&v2, v5);
            let v7 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_absolute_sid(v6);
            v5 = v5 + 1;
            let v8 = format_guard(arg0, v7, true);
            if (!v8) {
                continue
            };
            let v9 = replay_guard(arg0, v7, v0);
            if (!v9) {
                continue
            };
            let v10 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_absolute_v(v6);
            assert!(v10 > 0, 1);
            let v11 = &mut arg0.values;
            upsert<u128>(v11, v7, v10);
            v4 = v4 + 1;
            let v12 = OracleUpdated{
                sid          : v7,
                timestamp    : v0,
                update_ts_ms : v1,
            };
            0x2::event::emit<OracleUpdated>(v12);
        };
        let v13 = BatchIngested{
            batch_timestamp : v0,
            update_count    : v3,
            applied         : v4,
            update_ts_ms    : v1,
        };
        0x2::event::emit<BatchIngested>(v13);
    }

    public fun ingest_value_batch(arg0: &mut ExampleOracle, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueBatch, arg2: &0x2::clock::Clock) {
        let v0 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_batch_timestamp(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        validate_batch_timestamp(v0, v1);
        let v2 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::into_value_updates(arg1);
        record_batch_timestamp(arg0, v0);
        let v3 = 0x1::vector::length<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueUpdate>(&v2);
        let v4 = 0;
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueUpdate>(&v2, v5);
            let v7 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_sid(v6);
            let v8 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_timestamp(v6);
            v5 = v5 + 1;
            let v9 = format_guard(arg0, v7, false);
            if (!v9) {
                continue
            };
            let v10 = replay_guard(arg0, v7, v8);
            if (!v10) {
                continue
            };
            let v11 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_v(v6);
            assert!(v11 > 0, 1);
            let v12 = &mut arg0.values;
            upsert<u128>(v12, v7, v11);
            v4 = v4 + 1;
            let v13 = OracleUpdated{
                sid          : v7,
                timestamp    : v8,
                update_ts_ms : v1,
            };
            0x2::event::emit<OracleUpdated>(v13);
        };
        let v14 = BatchIngested{
            batch_timestamp : v0,
            update_count    : v3,
            applied         : v4,
            update_ts_ms    : v1,
        };
        0x2::event::emit<BatchIngested>(v14);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ExampleOracle{
            id              : 0x2::object::new(arg0),
            values          : 0x2::table::new<u256, u128>(arg0),
            svis            : 0x2::table::new<u256, RawSvi>(arg0),
            last_ts         : 0x2::table::new<u256, u64>(arg0),
            last_batch_ts   : 0,
            sid_is_absolute : 0x2::table::new<u256, bool>(arg0),
        };
        0x2::transfer::share_object<ExampleOracle>(v0);
    }

    public fun is_pinned_absolute(arg0: &ExampleOracle, arg1: u256) : bool {
        *0x2::table::borrow<u256, bool>(&arg0.sid_is_absolute, arg1)
    }

    public fun last_batch_timestamp(arg0: &ExampleOracle) : u64 {
        arg0.last_batch_ts
    }

    public fun last_timestamp(arg0: &ExampleOracle, arg1: u256) : u64 {
        *0x2::table::borrow<u256, u64>(&arg0.last_ts, arg1)
    }

    fun record_batch_timestamp(arg0: &mut ExampleOracle, arg1: u64) {
        if (arg1 > arg0.last_batch_ts) {
            arg0.last_batch_ts = arg1;
        };
    }

    fun replay_guard(arg0: &mut ExampleOracle, arg1: u256, arg2: u64) : bool {
        if (0x2::table::contains<u256, u64>(&arg0.last_ts, arg1)) {
            if (arg2 <= *0x2::table::borrow<u256, u64>(&arg0.last_ts, arg1)) {
                return false
            };
            *0x2::table::borrow_mut<u256, u64>(&mut arg0.last_ts, arg1) = arg2;
        } else {
            0x2::table::add<u256, u64>(&mut arg0.last_ts, arg1, arg2);
        };
        true
    }

    public fun svi_params(arg0: &ExampleOracle, arg1: u256) : (u128, bool, u128, u128, u128, bool, u128, bool) {
        let v0 = 0x2::table::borrow<u256, RawSvi>(&arg0.svis, arg1);
        (v0.svi_a_magnitude, v0.svi_a_is_negative, v0.svi_b, v0.svi_sigma, v0.svi_rho_magnitude, v0.svi_rho_is_negative, v0.svi_m_magnitude, v0.svi_m_is_negative)
    }

    fun upsert<T0: drop + store>(arg0: &mut 0x2::table::Table<u256, T0>, arg1: u256, arg2: T0) {
        if (0x2::table::contains<u256, T0>(arg0, arg1)) {
            *0x2::table::borrow_mut<u256, T0>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<u256, T0>(arg0, arg1, arg2);
        };
    }

    fun validate_batch_timestamp(arg0: u64, arg1: u64) {
        if (arg0 > arg1) {
            assert!(arg0 - arg1 <= 5000, 3);
        } else {
            assert!(arg1 - arg0 <= 60000, 2);
        };
    }

    public fun value(arg0: &ExampleOracle, arg1: u256) : u128 {
        *0x2::table::borrow<u256, u128>(&arg0.values, arg1)
    }

    // decompiled from Move bytecode v7
}

