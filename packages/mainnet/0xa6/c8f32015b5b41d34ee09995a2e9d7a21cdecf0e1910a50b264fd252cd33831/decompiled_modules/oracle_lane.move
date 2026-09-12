module 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::oracle_lane {
    struct OracleRead<T0: copy + drop + store> has copy, drop, store {
        source_timestamp_ms: u64,
        onchain_timestamp_ms: u64,
        writer_digest: vector<u8>,
        value: T0,
    }

    struct OracleLane<T0: copy + drop + store> has store {
        latest: 0x1::option::Option<OracleRead<T0>>,
        exact_reads: 0x2::table::Table<u64, OracleRead<T0>>,
    }

    struct ObservationRecorded<T0: copy + drop> has copy, drop {
        propbook_underlying_id: 0x1::option::Option<u32>,
        propbook_oracle_id: 0x2::object::ID,
        observation: T0,
    }

    struct ObservationInserted<T0: copy + drop> has copy, drop {
        propbook_underlying_id: 0x1::option::Option<u32>,
        propbook_oracle_id: 0x2::object::ID,
        observation: T0,
    }

    public(friend) fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : OracleLane<T0> {
        OracleLane<T0>{
            latest      : 0x1::option::none<OracleRead<T0>>(),
            exact_reads : 0x2::table::new<u64, OracleRead<T0>>(arg0),
        }
    }

    public(friend) fun insert_at<T0: copy + drop + store>(arg0: &mut OracleLane<T0>, arg1: OracleRead<T0>, arg2: 0x1::option::Option<u32>, arg3: 0x2::object::ID) {
        if (!read_has_valid_timestamp<T0>(&arg1)) {
            return
        };
        if (0x2::table::contains<u64, OracleRead<T0>>(&arg0.exact_reads, arg1.source_timestamp_ms)) {
            return
        };
        0x2::table::add<u64, OracleRead<T0>>(&mut arg0.exact_reads, arg1.source_timestamp_ms, arg1);
        let v0 = ObservationInserted<OracleRead<T0>>{
            propbook_underlying_id : arg2,
            propbook_oracle_id     : arg3,
            observation            : arg1,
        };
        0x2::event::emit<ObservationInserted<OracleRead<T0>>>(v0);
    }

    public(friend) fun latest_read<T0: copy + drop + store>(arg0: &OracleLane<T0>) : 0x1::option::Option<OracleRead<T0>> {
        arg0.latest
    }

    public(friend) fun new_read<T0: copy + drop + store>(arg0: u64, arg1: u64, arg2: T0, arg3: &0x2::tx_context::TxContext) : OracleRead<T0> {
        OracleRead<T0>{
            source_timestamp_ms  : arg0,
            onchain_timestamp_ms : arg1,
            writer_digest        : *0x2::tx_context::digest(arg3),
            value                : arg2,
        }
    }

    public(friend) fun project_read<T0: copy + drop + store, T1: copy + drop + store>(arg0: &OracleRead<T0>, arg1: T1) : OracleRead<T1> {
        OracleRead<T1>{
            source_timestamp_ms  : arg0.source_timestamp_ms,
            onchain_timestamp_ms : arg0.onchain_timestamp_ms,
            writer_digest        : arg0.writer_digest,
            value                : arg1,
        }
    }

    public(friend) fun read_at<T0: copy + drop + store>(arg0: &OracleLane<T0>, arg1: u64) : 0x1::option::Option<OracleRead<T0>> {
        if (!0x2::table::contains<u64, OracleRead<T0>>(&arg0.exact_reads, arg1)) {
            0x1::option::none<OracleRead<T0>>()
        } else {
            0x1::option::some<OracleRead<T0>>(*0x2::table::borrow<u64, OracleRead<T0>>(&arg0.exact_reads, arg1))
        }
    }

    public(friend) fun read_has_valid_timestamp<T0: copy + drop + store>(arg0: &OracleRead<T0>) : bool {
        arg0.source_timestamp_ms > 0 && arg0.source_timestamp_ms <= arg0.onchain_timestamp_ms
    }

    public fun read_onchain_timestamp_ms<T0: copy + drop + store>(arg0: &OracleRead<T0>) : u64 {
        arg0.onchain_timestamp_ms
    }

    public fun read_source_timestamp_ms<T0: copy + drop + store>(arg0: &OracleRead<T0>) : u64 {
        arg0.source_timestamp_ms
    }

    public fun read_value<T0: copy + drop + store>(arg0: &OracleRead<T0>) : T0 {
        arg0.value
    }

    public fun read_writer_digest<T0: copy + drop + store>(arg0: &OracleRead<T0>) : vector<u8> {
        arg0.writer_digest
    }

    public(friend) fun update<T0: copy + drop + store>(arg0: &mut OracleLane<T0>, arg1: OracleRead<T0>, arg2: 0x1::option::Option<u32>, arg3: 0x2::object::ID) {
        if (!read_has_valid_timestamp<T0>(&arg1)) {
            return
        };
        if (0x1::option::is_some<OracleRead<T0>>(&arg0.latest)) {
            if (arg1.source_timestamp_ms <= 0x1::option::borrow<OracleRead<T0>>(&arg0.latest).source_timestamp_ms) {
                return
            };
        };
        arg0.latest = 0x1::option::some<OracleRead<T0>>(arg1);
        let v0 = ObservationRecorded<OracleRead<T0>>{
            propbook_underlying_id : arg2,
            propbook_oracle_id     : arg3,
            observation            : arg1,
        };
        0x2::event::emit<ObservationRecorded<OracleRead<T0>>>(v0);
    }

    // decompiled from Move bytecode v7
}

