module 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::block_scholes_store {
    struct BsRead<T0: copy + drop + store> has copy, drop, store {
        source_timestamp_ms: u64,
        onchain_timestamp_ms: u64,
        writer_digest: vector<u8>,
        value: T0,
    }

    struct SVIParams has copy, drop, store {
        a_magnitude: u128,
        a_is_negative: bool,
        b: u128,
        sigma: u128,
        rho_magnitude: u128,
        rho_is_negative: bool,
        m_magnitude: u128,
        m_is_negative: bool,
    }

    struct BlockScholesValueStore has key {
        id: 0x2::object::UID,
        propbook_underlying_id: u32,
        block_scholes_base_asset: 0x1::string::String,
        version: u64,
        values: 0x2::table::Table<u256, BsRead<u128>>,
        exact_spot_reads: 0x2::table::Table<u64, BsRead<u128>>,
    }

    struct BlockScholesSVIStore has key {
        id: 0x2::object::UID,
        propbook_underlying_id: u32,
        block_scholes_base_asset: 0x1::string::String,
        version: u64,
        svis: 0x2::table::Table<u256, BsRead<SVIParams>>,
    }

    struct BlockScholesObservationRecorded<T0: copy + drop> has copy, drop {
        propbook_underlying_id: u32,
        propbook_oracle_id: 0x2::object::ID,
        sid: u256,
        series_kind: u8,
        expiry_ms: u64,
        observation: T0,
    }

    struct BlockScholesObservationInserted<T0: copy + drop> has copy, drop {
        propbook_oracle_id: 0x2::object::ID,
        observation: T0,
    }

    struct BlockScholesBatchIngested has copy, drop {
        propbook_underlying_id: u32,
        propbook_oracle_id: 0x2::object::ID,
        series_kind: u8,
        batch_timestamp_ms: u64,
        onchain_timestamp_ms: u64,
        update_count: u64,
        applied: u64,
    }

    public fun forward(arg0: &BlockScholesValueStore, arg1: u64) : 0x1::option::Option<BsRead<u128>> {
        read<u128>(&arg0.values, forward_sid(arg0, arg1))
    }

    public fun spot(arg0: &BlockScholesValueStore) : 0x1::option::Option<BsRead<u128>> {
        read<u128>(&arg0.values, spot_sid(arg0))
    }

    public fun svi(arg0: &BlockScholesSVIStore, arg1: u64) : 0x1::option::Option<BsRead<SVIParams>> {
        read<SVIParams>(&arg0.svis, svi_sid(arg0, arg1))
    }

    fun apply<T0: copy + drop + store>(arg0: &mut 0x2::table::Table<u256, BsRead<T0>>, arg1: u32, arg2: 0x2::object::ID, arg3: u256, arg4: u8, arg5: u64, arg6: BsRead<T0>) : bool {
        if (!has_valid_timestamp<T0>(&arg6)) {
            return false
        };
        if (0x2::table::contains<u256, BsRead<T0>>(arg0, arg3)) {
            let v0 = 0x2::table::borrow_mut<u256, BsRead<T0>>(arg0, arg3);
            if (arg6.source_timestamp_ms <= v0.source_timestamp_ms) {
                return false
            };
            *v0 = arg6;
        } else {
            0x2::table::add<u256, BsRead<T0>>(arg0, arg3, arg6);
        };
        let v1 = BlockScholesObservationRecorded<BsRead<T0>>{
            propbook_underlying_id : arg1,
            propbook_oracle_id     : arg2,
            sid                    : arg3,
            series_kind            : arg4,
            expiry_ms              : arg5,
            observation            : arg6,
        };
        0x2::event::emit<BlockScholesObservationRecorded<BsRead<T0>>>(v1);
        true
    }

    fun apply_checked_svi_batch(arg0: &mut BlockScholesSVIStore, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviBatch, arg2: vector<u256>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::into_svi_updates(arg1);
        let v1 = 0x1::vector::length<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviUpdate>(&v0);
        assert!(v1 == 0x1::vector::length<u256>(&arg2), 2);
        assert!(v1 == 0x1::vector::length<u64>(&arg3), 2);
        let v2 = 0;
        while (v2 < v1) {
            assert!(0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_sid(0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviUpdate>(&v0, v2)) == *0x1::vector::borrow<u256>(&arg2, v2), 3);
            v2 = v2 + 1;
        };
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = 0;
        v2 = 0;
        while (v2 < v1) {
            let v5 = 0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviUpdate>(&v0, v2);
            let (v6, v7, v8, v9, v10, v11, v12, v13) = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_fields(v5);
            let v14 = SVIParams{
                a_magnitude     : v6,
                a_is_negative   : v7,
                b               : v8,
                sigma           : v9,
                rho_magnitude   : v10,
                rho_is_negative : v11,
                m_magnitude     : v12,
                m_is_negative   : v13,
            };
            let v15 = BsRead<SVIParams>{
                source_timestamp_ms  : 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_timestamp(v5),
                onchain_timestamp_ms : v3,
                writer_digest        : *0x2::tx_context::digest(arg5),
                value                : v14,
            };
            if (apply_svi(arg0, 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_sid(v5), *0x1::vector::borrow<u64>(&arg3, v2), v15)) {
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        let v16 = BlockScholesBatchIngested{
            propbook_underlying_id : arg0.propbook_underlying_id,
            propbook_oracle_id     : svi_store_id(arg0),
            series_kind            : 2,
            batch_timestamp_ms     : 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::svi_batch_timestamp(&arg1),
            onchain_timestamp_ms   : v3,
            update_count           : v1,
            applied                : v4,
        };
        0x2::event::emit<BlockScholesBatchIngested>(v16);
    }

    fun apply_checked_value_batch(arg0: &mut BlockScholesValueStore, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueBatch, arg2: vector<u256>, arg3: vector<u64>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::into_value_updates(arg1);
        let v1 = 0x1::vector::length<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueUpdate>(&v0);
        assert!(v1 == 0x1::vector::length<u256>(&arg2), 2);
        assert!(v1 == 0x1::vector::length<u64>(&arg3), 2);
        let v2 = 0;
        while (v2 < v1) {
            assert!(0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_sid(0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueUpdate>(&v0, v2)) == *0x1::vector::borrow<u256>(&arg2, v2), 3);
            v2 = v2 + 1;
        };
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = 0;
        v2 = 0;
        while (v2 < v1) {
            let v5 = 0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueUpdate>(&v0, v2);
            let v6 = BsRead<u128>{
                source_timestamp_ms  : 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_timestamp(v5),
                onchain_timestamp_ms : v3,
                writer_digest        : *0x2::tx_context::digest(arg6),
                value                : 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_v(v5),
            };
            if (apply_value(arg0, 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_sid(v5), arg4, *0x1::vector::borrow<u64>(&arg3, v2), v6)) {
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        let v7 = BlockScholesBatchIngested{
            propbook_underlying_id : arg0.propbook_underlying_id,
            propbook_oracle_id     : value_store_id(arg0),
            series_kind            : arg4,
            batch_timestamp_ms     : 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_batch_timestamp(&arg1),
            onchain_timestamp_ms   : v3,
            update_count           : v1,
            applied                : v4,
        };
        0x2::event::emit<BlockScholesBatchIngested>(v7);
    }

    public fun apply_forward_batch(arg0: &mut BlockScholesValueStore, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueBatch, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            0x1::vector::push_back<u256>(&mut v0, forward_sid(arg0, *0x1::vector::borrow<u64>(&arg2, v1)));
            v1 = v1 + 1;
        };
        apply_checked_value_batch(arg0, arg1, v0, arg2, 1, arg3, arg4);
    }

    public fun apply_spot_batch(arg0: &mut BlockScholesValueStore, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueBatch, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = spot_sid(arg0);
        let v1 = checked_spot_read(arg0, arg1, v0, arg2, arg3);
        let v2 = apply_value(arg0, v0, 0, 0, v1);
        insert_exact_spot(arg0, v1);
        let v3 = if (v2) {
            1
        } else {
            0
        };
        let v4 = BlockScholesBatchIngested{
            propbook_underlying_id : arg0.propbook_underlying_id,
            propbook_oracle_id     : value_store_id(arg0),
            series_kind            : 0,
            batch_timestamp_ms     : 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_batch_timestamp(&arg1),
            onchain_timestamp_ms   : v1.onchain_timestamp_ms,
            update_count           : 1,
            applied                : v3,
        };
        0x2::event::emit<BlockScholesBatchIngested>(v4);
    }

    fun apply_svi(arg0: &mut BlockScholesSVIStore, arg1: u256, arg2: u64, arg3: BsRead<SVIParams>) : bool {
        let v0 = &mut arg0.svis;
        apply<SVIParams>(v0, arg0.propbook_underlying_id, svi_store_id(arg0), arg1, 2, arg2, arg3)
    }

    public fun apply_svi_batch(arg0: &mut BlockScholesSVIStore, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::SviBatch, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            0x1::vector::push_back<u256>(&mut v0, svi_sid(arg0, *0x1::vector::borrow<u64>(&arg2, v1)));
            v1 = v1 + 1;
        };
        apply_checked_svi_batch(arg0, arg1, v0, arg2, arg3, arg4);
    }

    fun apply_value(arg0: &mut BlockScholesValueStore, arg1: u256, arg2: u8, arg3: u64, arg4: BsRead<u128>) : bool {
        let v0 = &mut arg0.values;
        apply<u128>(v0, arg0.propbook_underlying_id, value_store_id(arg0), arg1, arg2, arg3, arg4)
    }

    fun checked_spot_read(arg0: &BlockScholesValueStore, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueBatch, arg2: u256, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : BsRead<u128> {
        assert!(arg0.version == 1, 0);
        let v0 = 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::into_value_updates(arg1);
        assert!(0x1::vector::length<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueUpdate>(&v0) == 1, 2);
        let v1 = 0x1::vector::borrow<0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueUpdate>(&v0, 0);
        assert!(0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_sid(v1) == arg2, 3);
        BsRead<u128>{
            source_timestamp_ms  : 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_timestamp(v1),
            onchain_timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            writer_digest        : *0x2::tx_context::digest(arg4),
            value                : 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::value_v(v1),
        }
    }

    public(friend) fun create_and_share_svi_store(arg0: u32, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = BlockScholesSVIStore{
            id                       : 0x2::object::new(arg2),
            propbook_underlying_id   : arg0,
            block_scholes_base_asset : arg1,
            version                  : 1,
            svis                     : 0x2::table::new<u256, BsRead<SVIParams>>(arg2),
        };
        0x2::transfer::share_object<BlockScholesSVIStore>(v0);
        svi_store_id(&v0)
    }

    public(friend) fun create_and_share_value_store(arg0: u32, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = BlockScholesValueStore{
            id                       : 0x2::object::new(arg2),
            propbook_underlying_id   : arg0,
            block_scholes_base_asset : arg1,
            version                  : 1,
            values                   : 0x2::table::new<u256, BsRead<u128>>(arg2),
            exact_spot_reads         : 0x2::table::new<u64, BsRead<u128>>(arg2),
        };
        0x2::transfer::share_object<BlockScholesValueStore>(v0);
        value_store_id(&v0)
    }

    public fun forward_sid(arg0: &BlockScholesValueStore, arg1: u64) : u256 {
        0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::block_scholes_sid::forward(&arg0.block_scholes_base_asset, arg1)
    }

    fun has_valid_timestamp<T0: copy + drop + store>(arg0: &BsRead<T0>) : bool {
        arg0.source_timestamp_ms > 0 && arg0.source_timestamp_ms <= arg0.onchain_timestamp_ms
    }

    public fun insert_at(arg0: &mut BlockScholesValueStore, arg1: 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify::ValueBatch, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = checked_spot_read(arg0, arg1, spot_sid(arg0), arg2, arg3);
        insert_exact_spot(arg0, v0);
    }

    fun insert_exact_spot(arg0: &mut BlockScholesValueStore, arg1: BsRead<u128>) : bool {
        if (arg1.source_timestamp_ms % 60000 != 0) {
            return false
        };
        if (!has_valid_timestamp<u128>(&arg1)) {
            return false
        };
        if (arg1.value == 0 || arg1.value > 18446744073709551615) {
            return false
        };
        if (0x2::table::contains<u64, BsRead<u128>>(&arg0.exact_spot_reads, arg1.source_timestamp_ms)) {
            return false
        };
        0x2::table::add<u64, BsRead<u128>>(&mut arg0.exact_spot_reads, arg1.source_timestamp_ms, arg1);
        let v0 = BlockScholesObservationInserted<BsRead<u128>>{
            propbook_oracle_id : value_store_id(arg0),
            observation        : arg1,
        };
        0x2::event::emit<BlockScholesObservationInserted<BsRead<u128>>>(v0);
        true
    }

    public fun migrate_svi_store(arg0: &mut BlockScholesSVIStore) {
        assert!(1 > arg0.version, 1);
        arg0.version = 1;
    }

    public fun migrate_value_store(arg0: &mut BlockScholesValueStore) {
        assert!(1 > arg0.version, 1);
        arg0.version = 1;
    }

    fun read<T0: copy + drop + store>(arg0: &0x2::table::Table<u256, BsRead<T0>>, arg1: u256) : 0x1::option::Option<BsRead<T0>> {
        if (!0x2::table::contains<u256, BsRead<T0>>(arg0, arg1)) {
            0x1::option::none<BsRead<T0>>()
        } else {
            0x1::option::some<BsRead<T0>>(*0x2::table::borrow<u256, BsRead<T0>>(arg0, arg1))
        }
    }

    fun read_at<T0: copy + drop + store>(arg0: &0x2::table::Table<u64, BsRead<T0>>, arg1: u64) : 0x1::option::Option<BsRead<T0>> {
        if (!0x2::table::contains<u64, BsRead<T0>>(arg0, arg1)) {
            0x1::option::none<BsRead<T0>>()
        } else {
            0x1::option::some<BsRead<T0>>(*0x2::table::borrow<u64, BsRead<T0>>(arg0, arg1))
        }
    }

    public fun read_onchain_timestamp_ms<T0: copy + drop + store>(arg0: &BsRead<T0>) : u64 {
        arg0.onchain_timestamp_ms
    }

    public fun read_source_timestamp_ms<T0: copy + drop + store>(arg0: &BsRead<T0>) : u64 {
        arg0.source_timestamp_ms
    }

    public fun read_value<T0: copy + drop + store>(arg0: &BsRead<T0>) : T0 {
        arg0.value
    }

    public fun read_writer_digest<T0: copy + drop + store>(arg0: &BsRead<T0>) : vector<u8> {
        arg0.writer_digest
    }

    public fun spot_at(arg0: &BlockScholesValueStore, arg1: u64) : 0x1::option::Option<BsRead<u128>> {
        read_at<u128>(&arg0.exact_spot_reads, arg1)
    }

    public fun spot_sid(arg0: &BlockScholesValueStore) : u256 {
        0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::block_scholes_sid::spot(&arg0.block_scholes_base_asset)
    }

    public fun svi_a_is_negative(arg0: &SVIParams) : bool {
        arg0.a_is_negative
    }

    public fun svi_a_magnitude(arg0: &SVIParams) : u128 {
        arg0.a_magnitude
    }

    public fun svi_b(arg0: &SVIParams) : u128 {
        arg0.b
    }

    public fun svi_m_is_negative(arg0: &SVIParams) : bool {
        arg0.m_is_negative
    }

    public fun svi_m_magnitude(arg0: &SVIParams) : u128 {
        arg0.m_magnitude
    }

    public fun svi_rho_is_negative(arg0: &SVIParams) : bool {
        arg0.rho_is_negative
    }

    public fun svi_rho_magnitude(arg0: &SVIParams) : u128 {
        arg0.rho_magnitude
    }

    public fun svi_sid(arg0: &BlockScholesSVIStore, arg1: u64) : u256 {
        0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::block_scholes_sid::svi(&arg0.block_scholes_base_asset, arg1)
    }

    public fun svi_sigma(arg0: &SVIParams) : u128 {
        arg0.sigma
    }

    public fun svi_store_base_asset(arg0: &BlockScholesSVIStore) : 0x1::string::String {
        arg0.block_scholes_base_asset
    }

    public fun svi_store_id(arg0: &BlockScholesSVIStore) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun svi_store_version(arg0: &BlockScholesSVIStore) : u64 {
        arg0.version
    }

    public fun value_store_base_asset(arg0: &BlockScholesValueStore) : 0x1::string::String {
        arg0.block_scholes_base_asset
    }

    public fun value_store_id(arg0: &BlockScholesValueStore) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun value_store_version(arg0: &BlockScholesValueStore) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

