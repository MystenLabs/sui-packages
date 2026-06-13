module 0xa6a18b2b2dbf264e60e68a174c36c6c8af8cd0963575e4c97c7f7b87b7469c62::nautilus_oracle {
    struct NAUTILUS_ORACLE has drop {
        dummy_field: bool,
    }

    struct EnclaveConfig has key {
        id: 0x2::object::UID,
        pcr0: vector<u8>,
        pcr1: vector<u8>,
        pcr2: vector<u8>,
        enclave_pubkey: vector<u8>,
        prev_enclave_pubkey: 0x1::option::Option<vector<u8>>,
        prev_key_valid_until_ms: u64,
        max_timestamp_drift_ms: u64,
    }

    struct RichPriceData has copy, drop, store {
        market_id: 0x2::object::ID,
        price: u64,
        bids: vector<u64>,
        asks: vector<u64>,
        volume: u64,
        timestamp_ms: u64,
        session_flag: u8,
        confidence: u64,
    }

    struct NautilusDataStore has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x2::object::ID, RichPriceData>,
        staleness_threshold_ms: u64,
    }

    struct RichPriceDataV2 has copy, drop, store {
        market_id: 0x2::object::ID,
        price: u64,
        bids: vector<u64>,
        asks: vector<u64>,
        volume: u64,
        attested_at_ms: u64,
        data_window_end_ms: u64,
        session_flag: u8,
        market_status: u8,
        price_freshness: u8,
        session: u8,
        confidence: u64,
    }

    struct NautilusDataStoreV2 has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x2::object::ID, RichPriceDataV2>,
        attestation_staleness_threshold_ms: u64,
        data_recency_threshold_ms: u64,
    }

    struct NautilusAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceUpdateEvent has copy, drop {
        market_id: 0x2::object::ID,
        price: u64,
        bids: vector<u64>,
        asks: vector<u64>,
        volume: u64,
        timestamp_ms: u64,
        session_flag: u8,
        confidence: u64,
    }

    struct PriceUpdateEventV2 has copy, drop {
        market_id: 0x2::object::ID,
        price: u64,
        bids: vector<u64>,
        asks: vector<u64>,
        volume: u64,
        attested_at_ms: u64,
        data_window_end_ms: u64,
        session_flag: u8,
        market_status: u8,
        price_freshness: u8,
        session: u8,
        confidence: u64,
    }

    struct PriceUpdateEventV4 has copy, drop {
        market_id: 0x2::object::ID,
        index_price_usd: u64,
        index_price_local: u64,
        fx_to_usd: u64,
        fx_ts_ms: u64,
        price_freshness: u8,
        quote_currency: vector<u8>,
        volume: u64,
        session_flag: u8,
        confidence: u64,
        timestamp: u64,
    }

    struct PriceUpdateEventV5 has copy, drop {
        market_id: 0x2::object::ID,
        index_price_usd: u64,
        index_price_local: u64,
        fx_to_usd: u64,
        fx_ts_ms: u64,
        price_freshness: u8,
        quote_currency: vector<u8>,
        volume: u64,
        session_flag: u8,
        confidence: u64,
        timestamp: u64,
        price_trace_id: vector<u8>,
    }

    struct EnclaveKeyRotated has copy, drop {
        old_pubkey: vector<u8>,
        new_pubkey: vector<u8>,
        prev_valid_until_ms: u64,
        timestamp_ms: u64,
    }

    struct StalenessThresholdUpdateEvent has copy, drop {
        old_threshold_ms: u64,
        new_threshold_ms: u64,
    }

    struct AttestationThresholdUpdateEvent has copy, drop {
        old_threshold_ms: u64,
        new_threshold_ms: u64,
    }

    struct DataRecencyThresholdUpdateEvent has copy, drop {
        old_threshold_ms: u64,
        new_threshold_ms: u64,
    }

    struct MaxTimestampDriftSet has copy, drop {
        old_ms: u64,
        new_ms: u64,
        timestamp_ms: u64,
    }

    struct TimestampDriftWarning has copy, drop {
        market_id: 0x2::object::ID,
        age_ms: u64,
        max_drift_ms: u64,
    }

    fun emit_timestamp_drift_observability(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        if (arg1 >= 240000) {
            let v0 = TimestampDriftWarning{
                market_id    : arg0,
                age_ms       : arg1,
                max_drift_ms : arg2,
            };
            0x2::event::emit<TimestampDriftWarning>(v0);
        };
    }

    public entry fun emit_v4(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: u64, arg8: u8, arg9: u64, arg10: u64) {
        let v0 = PriceUpdateEventV4{
            market_id         : arg0,
            index_price_usd   : arg1,
            index_price_local : arg2,
            fx_to_usd         : arg3,
            fx_ts_ms          : arg4,
            price_freshness   : arg5,
            quote_currency    : arg6,
            volume            : arg7,
            session_flag      : arg8,
            confidence        : arg9,
            timestamp         : arg10,
        };
        0x2::event::emit<PriceUpdateEventV4>(v0);
    }

    public entry fun emit_v5(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: vector<u8>) {
        let v0 = PriceUpdateEventV5{
            market_id         : arg0,
            index_price_usd   : arg1,
            index_price_local : arg2,
            fx_to_usd         : arg3,
            fx_ts_ms          : arg4,
            price_freshness   : arg5,
            quote_currency    : arg6,
            volume            : arg7,
            session_flag      : arg8,
            confidence        : arg9,
            timestamp         : arg10,
            price_trace_id    : arg11,
        };
        0x2::event::emit<PriceUpdateEventV5>(v0);
    }

    public fun get_attestation_threshold(arg0: &NautilusDataStoreV2) : u64 {
        arg0.attestation_staleness_threshold_ms
    }

    public fun get_data_recency_threshold(arg0: &NautilusDataStoreV2) : u64 {
        arg0.data_recency_threshold_ms
    }

    public fun get_price(arg0: &NautilusDataStore, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = get_rich_price(arg0, arg1, arg2);
        (v0.price, v0.timestamp_ms)
    }

    public fun get_rich_price(arg0: &NautilusDataStore, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : RichPriceData {
        assert!(0x2::table::contains<0x2::object::ID, RichPriceData>(&arg0.prices, arg1), 5);
        let v0 = *0x2::table::borrow<0x2::object::ID, RichPriceData>(&arg0.prices, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) - v0.timestamp_ms <= arg0.staleness_threshold_ms, 4);
        v0
    }

    public fun get_rich_price_v2(arg0: &NautilusDataStoreV2, arg1: vector<u8>, arg2: &0x2::clock::Clock) : RichPriceDataV2 {
        let v0 = 0x2::object::id_from_bytes(arg1);
        assert!(0x2::table::contains<0x2::object::ID, RichPriceDataV2>(&arg0.prices, v0), 5);
        let v1 = *0x2::table::borrow<0x2::object::ID, RichPriceDataV2>(&arg0.prices, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = if (v2 > v1.attested_at_ms) {
            v2 - v1.attested_at_ms
        } else {
            0
        };
        assert!(v3 <= arg0.attestation_staleness_threshold_ms, 4);
        v1
    }

    public fun get_session_flag(arg0: &NautilusDataStore, arg1: 0x2::object::ID) : u8 {
        assert!(0x2::table::contains<0x2::object::ID, RichPriceData>(&arg0.prices, arg1), 5);
        0x2::table::borrow<0x2::object::ID, RichPriceData>(&arg0.prices, arg1).session_flag
    }

    public fun get_staleness_threshold(arg0: &NautilusDataStore) : u64 {
        arg0.staleness_threshold_ms
    }

    fun init(arg0: NAUTILUS_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NautilusAdminCap{id: 0x2::object::new(arg1)};
        let v1 = NautilusDataStore{
            id                     : 0x2::object::new(arg1),
            prices                 : 0x2::table::new<0x2::object::ID, RichPriceData>(arg1),
            staleness_threshold_ms : 60000,
        };
        let v2 = NautilusDataStoreV2{
            id                                 : 0x2::object::new(arg1),
            prices                             : 0x2::table::new<0x2::object::ID, RichPriceDataV2>(arg1),
            attestation_staleness_threshold_ms : 60000,
            data_recency_threshold_ms          : 60000,
        };
        0x2::transfer::share_object<NautilusDataStore>(v1);
        0x2::transfer::share_object<NautilusDataStoreV2>(v2);
        0x2::transfer::transfer<NautilusAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_price_fresh(arg0: &NautilusDataStore, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, RichPriceData>(&arg0.prices, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, RichPriceData>(&arg0.prices, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 < v0.timestamp_ms) {
            return false
        };
        v1 - v0.timestamp_ms <= arg0.staleness_threshold_ms
    }

    public fun is_price_fresh_v2(arg0: &NautilusDataStoreV2, arg1: vector<u8>, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x2::object::id_from_bytes(arg1);
        if (!0x2::table::contains<0x2::object::ID, RichPriceDataV2>(&arg0.prices, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, RichPriceDataV2>(&arg0.prices, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = if (v2 > v1.attested_at_ms) {
            v2 - v1.attested_at_ms
        } else {
            0
        };
        v3 <= arg0.attestation_staleness_threshold_ms
    }

    fun is_valid_market_status(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    fun is_valid_price_freshness(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    fun is_valid_session(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    public fun max_timestamp_drift_ms() : u64 {
        300000
    }

    public fun price_data_asks(arg0: &RichPriceData) : vector<u64> {
        arg0.asks
    }

    public fun price_data_best_ask(arg0: &RichPriceData) : u64 {
        *0x1::vector::borrow<u64>(&arg0.asks, 0)
    }

    public fun price_data_best_bid(arg0: &RichPriceData) : u64 {
        *0x1::vector::borrow<u64>(&arg0.bids, 0)
    }

    public fun price_data_bids(arg0: &RichPriceData) : vector<u64> {
        arg0.bids
    }

    public fun price_data_confidence(arg0: &RichPriceData) : u64 {
        arg0.confidence
    }

    public fun price_data_market_id(arg0: &RichPriceData) : 0x2::object::ID {
        arg0.market_id
    }

    public fun price_data_price(arg0: &RichPriceData) : u64 {
        arg0.price
    }

    public fun price_data_session_flag(arg0: &RichPriceData) : u8 {
        arg0.session_flag
    }

    public fun price_data_timestamp_ms(arg0: &RichPriceData) : u64 {
        arg0.timestamp_ms
    }

    public fun price_data_v2_asks(arg0: &RichPriceDataV2) : vector<u64> {
        arg0.asks
    }

    public fun price_data_v2_attested_at_ms(arg0: &RichPriceDataV2) : u64 {
        arg0.attested_at_ms
    }

    public fun price_data_v2_best_ask(arg0: &RichPriceDataV2) : u64 {
        *0x1::vector::borrow<u64>(&arg0.asks, 0)
    }

    public fun price_data_v2_best_bid(arg0: &RichPriceDataV2) : u64 {
        *0x1::vector::borrow<u64>(&arg0.bids, 0)
    }

    public fun price_data_v2_bids(arg0: &RichPriceDataV2) : vector<u64> {
        arg0.bids
    }

    public fun price_data_v2_confidence(arg0: &RichPriceDataV2) : u64 {
        arg0.confidence
    }

    public fun price_data_v2_data_window_end_ms(arg0: &RichPriceDataV2) : u64 {
        arg0.data_window_end_ms
    }

    public fun price_data_v2_market_id(arg0: &RichPriceDataV2) : 0x2::object::ID {
        arg0.market_id
    }

    public fun price_data_v2_market_status(arg0: &RichPriceDataV2) : u8 {
        arg0.market_status
    }

    public fun price_data_v2_price(arg0: &RichPriceDataV2) : u64 {
        arg0.price
    }

    public fun price_data_v2_price_freshness(arg0: &RichPriceDataV2) : u8 {
        arg0.price_freshness
    }

    public fun price_data_v2_session(arg0: &RichPriceDataV2) : u8 {
        arg0.session
    }

    public fun price_data_v2_session_flag(arg0: &RichPriceDataV2) : u8 {
        arg0.session_flag
    }

    public fun price_data_v2_volume(arg0: &RichPriceDataV2) : u64 {
        arg0.volume
    }

    public fun price_data_volume(arg0: &RichPriceData) : u64 {
        arg0.volume
    }

    public entry fun register_enclave(arg0: &NautilusAdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = EnclaveConfig{
            id                      : 0x2::object::new(arg5),
            pcr0                    : arg1,
            pcr1                    : arg2,
            pcr2                    : arg3,
            enclave_pubkey          : arg4,
            prev_enclave_pubkey     : 0x1::option::none<vector<u8>>(),
            prev_key_valid_until_ms : 0,
            max_timestamp_drift_ms  : 300000,
        };
        0x2::transfer::share_object<EnclaveConfig>(v0);
    }

    public entry fun remove_market(arg0: &NautilusAdminCap, arg1: &mut NautilusDataStore, arg2: address) {
        0x2::table::remove<0x2::object::ID, RichPriceData>(&mut arg1.prices, 0x2::object::id_from_address(arg2));
    }

    public entry fun remove_market_ref(arg0: &NautilusAdminCap, arg1: &mut NautilusDataStore, arg2: address) {
        0x2::table::remove<0x2::object::ID, RichPriceData>(&mut arg1.prices, 0x2::object::id_from_address(arg2));
    }

    public fun rich_price_data_v2_1_version() : u64 {
        21
    }

    public entry fun set_attestation_threshold(arg0: &NautilusAdminCap, arg1: &mut NautilusDataStoreV2, arg2: u64) {
        arg1.attestation_staleness_threshold_ms = arg2;
        let v0 = AttestationThresholdUpdateEvent{
            old_threshold_ms : arg1.attestation_staleness_threshold_ms,
            new_threshold_ms : arg2,
        };
        0x2::event::emit<AttestationThresholdUpdateEvent>(v0);
    }

    public entry fun set_data_recency_threshold(arg0: &NautilusAdminCap, arg1: &mut NautilusDataStoreV2, arg2: u64) {
        arg1.data_recency_threshold_ms = arg2;
        let v0 = DataRecencyThresholdUpdateEvent{
            old_threshold_ms : arg1.data_recency_threshold_ms,
            new_threshold_ms : arg2,
        };
        0x2::event::emit<DataRecencyThresholdUpdateEvent>(v0);
    }

    public entry fun set_max_timestamp_drift_ms(arg0: &NautilusAdminCap, arg1: &mut EnclaveConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 >= 60000, 10);
        assert!(arg2 <= 300000, 11);
        arg1.max_timestamp_drift_ms = arg2;
        let v0 = MaxTimestampDriftSet{
            old_ms       : arg1.max_timestamp_drift_ms,
            new_ms       : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MaxTimestampDriftSet>(v0);
    }

    public entry fun set_staleness_threshold(arg0: &NautilusAdminCap, arg1: &mut NautilusDataStore, arg2: u64) {
        arg1.staleness_threshold_ms = arg2;
        let v0 = StalenessThresholdUpdateEvent{
            old_threshold_ms : arg1.staleness_threshold_ms,
            new_threshold_ms : arg2,
        };
        0x2::event::emit<StalenessThresholdUpdateEvent>(v0);
    }

    public entry fun update_enclave_key(arg0: &NautilusAdminCap, arg1: &mut EnclaveConfig, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = v0 + arg1.max_timestamp_drift_ms;
        let v2 = arg1.enclave_pubkey;
        arg1.prev_enclave_pubkey = 0x1::option::some<vector<u8>>(v2);
        arg1.prev_key_valid_until_ms = v1;
        arg1.enclave_pubkey = arg2;
        let v3 = EnclaveKeyRotated{
            old_pubkey          : v2,
            new_pubkey          : arg2,
            prev_valid_until_ms : v1,
            timestamp_ms        : v0,
        };
        0x2::event::emit<EnclaveKeyRotated>(v3);
    }

    public entry fun update_pcrs(arg0: &NautilusAdminCap, arg1: &mut EnclaveConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        arg1.pcr0 = arg2;
        arg1.pcr1 = arg3;
        arg1.pcr2 = arg4;
    }

    public entry fun update_prices(arg0: &EnclaveConfig, arg1: &mut NautilusDataStore, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<u64>, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::clock::Clock) {
        abort 9
    }

    public entry fun update_prices_v2(arg0: &mut NautilusDataStoreV2, arg1: &EnclaveConfig, arg2: vector<RichPriceDataV2>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        update_prices_v2_impl(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun update_prices_v2_impl(arg0: &mut NautilusDataStoreV2, arg1: &EnclaveConfig, arg2: vector<RichPriceDataV2>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(verify_enclave_signature(arg1, &arg3, &arg4, v0), 1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<RichPriceDataV2>(&arg2)) {
            let v2 = *0x1::vector::borrow<RichPriceDataV2>(&arg2, v1);
            let v3 = v2.market_id;
            let v4 = v2.price;
            let v5 = v2.bids;
            let v6 = v2.asks;
            let v7 = v2.volume;
            let v8 = v2.attested_at_ms;
            let v9 = v2.data_window_end_ms;
            let v10 = v2.session_flag;
            let v11 = v2.market_status;
            let v12 = v2.price_freshness;
            let v13 = v2.session;
            let v14 = v2.confidence;
            assert!(v4 > 0, 2);
            assert!(0x1::vector::length<u64>(&v5) == 10, 8);
            assert!(0x1::vector::length<u64>(&v6) == 10, 8);
            assert!(v10 == 1 || v10 == 0, 6);
            assert!(is_valid_market_status(v11), 6);
            assert!(is_valid_price_freshness(v12), 6);
            assert!(is_valid_session(v13), 6);
            let v15 = if (v8 > v0) {
                v8 - v0
            } else {
                v0 - v8
            };
            emit_timestamp_drift_observability(v3, v15, arg1.max_timestamp_drift_ms);
            assert!(v15 <= arg1.max_timestamp_drift_ms, 3);
            let v16 = RichPriceDataV2{
                market_id          : v3,
                price              : v4,
                bids               : v5,
                asks               : v6,
                volume             : v7,
                attested_at_ms     : v8,
                data_window_end_ms : v9,
                session_flag       : v10,
                market_status      : v11,
                price_freshness    : v12,
                session            : v13,
                confidence         : v14,
            };
            if (0x2::table::contains<0x2::object::ID, RichPriceDataV2>(&arg0.prices, v3)) {
                let v17 = 0x2::table::borrow_mut<0x2::object::ID, RichPriceDataV2>(&mut arg0.prices, v3);
                assert!(v8 > v17.attested_at_ms, 4);
                *v17 = v16;
            } else {
                0x2::table::add<0x2::object::ID, RichPriceDataV2>(&mut arg0.prices, v3, v16);
            };
            let v18 = PriceUpdateEventV2{
                market_id          : v3,
                price              : v4,
                bids               : v5,
                asks               : v6,
                volume             : v7,
                attested_at_ms     : v8,
                data_window_end_ms : v9,
                session_flag       : v10,
                market_status      : v11,
                price_freshness    : v12,
                session            : v13,
                confidence         : v14,
            };
            0x2::event::emit<PriceUpdateEventV2>(v18);
            v1 = v1 + 1;
        };
    }

    public entry fun update_prices_v2_with_trace(arg0: &mut NautilusDataStoreV2, arg1: &EnclaveConfig, arg2: vector<RichPriceDataV2>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        update_prices_v2_impl(arg0, arg1, arg2, arg4, arg5, arg6);
    }

    fun verify_enclave_signature(arg0: &EnclaveConfig, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : bool {
        0x2::ed25519::ed25519_verify(arg1, &arg0.enclave_pubkey, arg2) || 0x1::option::is_some<vector<u8>>(&arg0.prev_enclave_pubkey) && arg3 <= arg0.prev_key_valid_until_ms && 0x2::ed25519::ed25519_verify(arg1, 0x1::option::borrow<vector<u8>>(&arg0.prev_enclave_pubkey), arg2)
    }

    // decompiled from Move bytecode v7
}

