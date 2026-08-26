module 0x1f1207ccde07c5c1c2c7395d0f5771370bf7e8a99acf28f0a341fbd1ed3f3384::waterx_rule {
    struct WATERX_RULE has drop {
        dummy_field: bool,
    }

    struct WaterxRule has drop {
        dummy_field: bool,
    }

    struct PricePayload has copy, drop {
        ticker: 0x1::string::String,
        sources: vector<u64>,
        method: 0x1::string::String,
        price_timestamp_ms: u64,
        price_n: u64,
        price_scale: u64,
        confidence_n: u64,
        confidence_scale: u64,
        max_source_deviation_bps: u64,
        num_sources: u8,
    }

    struct BatchPriceItem has copy, drop {
        symbol: 0x1::string::String,
        ticker: 0x1::string::String,
        sources: vector<u64>,
        method: 0x1::string::String,
        price_timestamp_ms: u64,
        price_n: u64,
        price_scale: u64,
        confidence_n: u64,
        confidence_scale: u64,
        max_source_deviation_bps: u64,
        num_sources: u8,
    }

    struct BatchPricePayload has copy, drop {
        items: vector<BatchPriceItem>,
    }

    struct MerkleRoot has copy, drop {
        root: vector<u8>,
    }

    struct FeedConfig has copy, drop, store {
        ticker: 0x1::string::String,
        sources: vector<u64>,
        method: 0x1::string::String,
        max_age_ms: u64,
        max_confidence_bps: u64,
        max_source_deviation_bps: u64,
        min_sources: u8,
    }

    struct VerifiedPrice {
        symbol: 0x1::string::String,
        ticker: 0x1::string::String,
        sources: vector<u64>,
        method: 0x1::string::String,
        price_timestamp_ms: u64,
        price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        price_n: u64,
        price_scale: u64,
        confidence_n: u64,
        confidence_scale: u64,
        max_source_deviation_bps: u64,
        num_sources: u8,
        signed_timestamp_ms: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        feed_map: 0x2::vec_map::VecMap<0x1::string::String, FeedConfig>,
    }

    struct SignedTsHwmKey has copy, drop, store {
        symbol: 0x1::string::String,
    }

    struct HistoricalPriceVerified has copy, drop {
        symbol: 0x1::string::String,
        ticker: 0x1::string::String,
        sources: vector<u64>,
        method: 0x1::string::String,
        price_timestamp_ms: u64,
        price: u128,
        confidence: u128,
        max_source_deviation_bps: u64,
        num_sources: u8,
        signed_timestamp_ms: u64,
    }

    struct BatchLatestUpdated has copy, drop {
        count: u64,
        timestamp_ms: u64,
    }

    struct SignedTsHwmReset has copy, drop {
        symbol: 0x1::string::String,
        previous_signed_ts_hwm: u64,
        signed_ts_hwm: u64,
    }

    fun are_perp_sources(arg0: &vector<u64>) : bool {
        if (0x1::vector::is_empty<u64>(arg0)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (!is_perp_source(*0x1::vector::borrow<u64>(arg0, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun are_supported_sources(arg0: &vector<u64>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (!is_supported_source(*0x1::vector::borrow<u64>(arg0, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun batch_item_confidence_n(arg0: &BatchPriceItem) : u64 {
        arg0.confidence_n
    }

    public fun batch_item_confidence_scale(arg0: &BatchPriceItem) : u64 {
        arg0.confidence_scale
    }

    public fun batch_item_max_source_deviation_bps(arg0: &BatchPriceItem) : u64 {
        arg0.max_source_deviation_bps
    }

    public fun batch_item_method(arg0: &BatchPriceItem) : &0x1::string::String {
        &arg0.method
    }

    public fun batch_item_num_sources(arg0: &BatchPriceItem) : u8 {
        arg0.num_sources
    }

    public fun batch_item_price_n(arg0: &BatchPriceItem) : u64 {
        arg0.price_n
    }

    public fun batch_item_price_scale(arg0: &BatchPriceItem) : u64 {
        arg0.price_scale
    }

    public fun batch_item_price_timestamp_ms(arg0: &BatchPriceItem) : u64 {
        arg0.price_timestamp_ms
    }

    public fun batch_item_sources(arg0: &BatchPriceItem) : &vector<u64> {
        &arg0.sources
    }

    public fun batch_item_symbol(arg0: &BatchPriceItem) : &0x1::string::String {
        &arg0.symbol
    }

    public fun batch_item_ticker(arg0: &BatchPriceItem) : &0x1::string::String {
        &arg0.ticker
    }

    public fun batch_items(arg0: &BatchPricePayload) : &vector<BatchPriceItem> {
        &arg0.items
    }

    public fun batch_price_intent() : u8 {
        1
    }

    public fun collect_batch_latest(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::EnclaveConfig<WATERX_RULE>, arg4: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::Enclave<WATERX_RULE>, arg5: u64, arg6: BatchPricePayload, arg7: &vector<u8>) {
        validate_batch_shape(&arg6);
        if (!0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::verify_signature<WATERX_RULE, BatchPricePayload>(arg4, arg3, 1, arg5, arg6, arg7)) {
            abort 13906835724826574849
        };
        let v0 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(arg0);
        let v1 = find_item_for_symbol(&arg6, &v0);
        if (0x1::option::is_none<BatchPriceItem>(&v1) || !0x2::vec_map::contains<0x1::string::String, FeedConfig>(&arg1.feed_map, &v0)) {
            let v2 = WaterxRule{dummy_field: false};
            0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(arg0, v2, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>());
            return
        };
        let v3 = price_payload_from_batch_item(*0x1::option::borrow<BatchPriceItem>(&v1));
        let v4 = *0x2::vec_map::get<0x1::string::String, FeedConfig>(&arg1.feed_map, &v0);
        validate_payload_with_config(&v4, &v3);
        if (!latest_timing_ok(&v4, 0x2::clock::timestamp_ms(arg2), arg5, &v3)) {
            let v5 = WaterxRule{dummy_field: false};
            0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(arg0, v5, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>());
            return
        };
        if (!try_record_signed_ts(arg1, v0, arg5)) {
            let v6 = WaterxRule{dummy_field: false};
            0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(arg0, v6, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>());
            return
        };
        let v7 = WaterxRule{dummy_field: false};
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(arg0, v7, 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v3.price_n, v3.price_scale)));
    }

    public fun collect_single_with_proof(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::EnclaveConfig<WATERX_RULE>, arg4: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::Enclave<WATERX_RULE>, arg5: u64, arg6: BatchPriceItem, arg7: vector<vector<u8>>, arg8: &vector<u8>) {
        verify_merkle_root(arg4, arg3, arg5, &arg6, &arg7, arg8);
        let v0 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(arg0);
        if (arg6.symbol != v0) {
            abort 13906836184391090223
        };
        if (!0x2::vec_map::contains<0x1::string::String, FeedConfig>(&arg1.feed_map, &v0)) {
            let v1 = WaterxRule{dummy_field: false};
            0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(arg0, v1, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>());
            return
        };
        let v2 = price_payload_from_batch_item(arg6);
        let v3 = *0x2::vec_map::get<0x1::string::String, FeedConfig>(&arg1.feed_map, &v0);
        validate_payload_with_config(&v3, &v2);
        if (!latest_timing_ok(&v3, 0x2::clock::timestamp_ms(arg2), arg5, &v2)) {
            let v4 = WaterxRule{dummy_field: false};
            0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(arg0, v4, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>());
            return
        };
        if (!try_record_signed_ts(arg1, v0, arg5)) {
            let v5 = WaterxRule{dummy_field: false};
            0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(arg0, v5, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>());
            return
        };
        let v6 = WaterxRule{dummy_field: false};
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(arg0, v6, 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v2.price_n, v2.price_scale)));
    }

    public fun collect_verified_price(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg1: VerifiedPrice) : u64 {
        let VerifiedPrice {
            symbol                   : v0,
            ticker                   : _,
            sources                  : _,
            method                   : _,
            price_timestamp_ms       : v4,
            price                    : v5,
            price_n                  : _,
            price_scale              : _,
            confidence_n             : _,
            confidence_scale         : _,
            max_source_deviation_bps : _,
            num_sources              : _,
            signed_timestamp_ms      : _,
        } = arg1;
        if (0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(arg0) != v0) {
            abort 13906837185118339117
        };
        let v13 = WaterxRule{dummy_field: false};
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect_at<WaterxRule>(arg0, v13, v5, v4);
        v4
    }

    public fun destroy_verified_price(arg0: VerifiedPrice) {
        let VerifiedPrice {
            symbol                   : _,
            ticker                   : _,
            sources                  : _,
            method                   : _,
            price_timestamp_ms       : _,
            price                    : _,
            price_n                  : _,
            price_scale              : _,
            confidence_n             : _,
            confidence_scale         : _,
            max_source_deviation_bps : _,
            num_sources              : _,
            signed_timestamp_ms      : _,
        } = arg0;
    }

    fun feed_batch_item_latest(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: u64, arg4: BatchPriceItem) : bool {
        let v0 = arg4.symbol;
        if (!0x2::vec_map::contains<0x1::string::String, FeedConfig>(&arg1.feed_map, &v0)) {
            abort 13906838997593620511
        };
        let v1 = price_payload_from_batch_item(arg4);
        let v2 = *0x2::vec_map::get<0x1::string::String, FeedConfig>(&arg1.feed_map, &v0);
        validate_payload_with_config(&v2, &v1);
        if (v1.price_timestamp_ms > arg3) {
            abort 13906839092083294245
        };
        if (is_replayed_signed_ts(arg1, v0, arg3)) {
            return false
        };
        let v3 = 0x2::clock::timestamp_ms(arg2);
        if (!latest_signature_is_fresh(&v2, v3, arg3)) {
            abort 13906839212342116385
        };
        if (!latest_source_price_is_fresh(&v2, v3, v1.price_timestamp_ms)) {
            return false
        };
        if (!try_record_signed_ts(arg1, v0, arg3)) {
            return false
        };
        let v4 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::new_collector(v0);
        let v5 = WaterxRule{dummy_field: false};
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<WaterxRule>(&mut v4, v5, 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v1.price_n, v1.price_scale)));
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::aggregate(arg0, v4, arg2);
        true
    }

    public fun feed_batch_latest(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::EnclaveConfig<WATERX_RULE>, arg4: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::Enclave<WATERX_RULE>, arg5: u64, arg6: BatchPricePayload, arg7: &vector<u8>) {
        validate_batch_shape(&arg6);
        if (!0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::verify_signature<WATERX_RULE, BatchPricePayload>(arg4, arg3, 1, arg5, arg6, arg7)) {
            abort 13906835424178864129
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<BatchPriceItem>(&arg6.items)) {
            if (feed_batch_item_latest(arg0, arg1, arg2, arg5, *0x1::vector::borrow<BatchPriceItem>(&arg6.items, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        let v2 = BatchLatestUpdated{
            count        : v0,
            timestamp_ms : arg5,
        };
        0x2::event::emit<BatchLatestUpdated>(v2);
    }

    public fun feed_config(arg0: &Config, arg1: 0x1::string::String) : 0x1::option::Option<FeedConfig> {
        if (0x2::vec_map::contains<0x1::string::String, FeedConfig>(&arg0.feed_map, &arg1)) {
            0x1::option::some<FeedConfig>(*0x2::vec_map::get<0x1::string::String, FeedConfig>(&arg0.feed_map, &arg1))
        } else {
            0x1::option::none<FeedConfig>()
        }
    }

    public fun feed_single_with_proof(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::EnclaveConfig<WATERX_RULE>, arg4: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::Enclave<WATERX_RULE>, arg5: u64, arg6: BatchPriceItem, arg7: vector<vector<u8>>, arg8: &vector<u8>) {
        verify_merkle_root(arg4, arg3, arg5, &arg6, &arg7, arg8);
        let v0 = if (feed_batch_item_latest(arg0, arg1, arg2, arg5, arg6)) {
            1
        } else {
            0
        };
        let v1 = BatchLatestUpdated{
            count        : v0,
            timestamp_ms : arg5,
        };
        0x2::event::emit<BatchLatestUpdated>(v1);
    }

    fun find_item_for_symbol(arg0: &BatchPricePayload, arg1: &0x1::string::String) : 0x1::option::Option<BatchPriceItem> {
        let v0 = &arg0.items;
        let v1 = 0;
        while (v1 < 0x1::vector::length<BatchPriceItem>(v0)) {
            if (0x1::vector::borrow<BatchPriceItem>(v0, v1).symbol == *arg1) {
                return 0x1::option::some<BatchPriceItem>(*0x1::vector::borrow<BatchPriceItem>(v0, v1))
            };
            v1 = v1 + 1;
        };
        0x1::option::none<BatchPriceItem>()
    }

    fun fold_proof(arg0: vector<u8>, arg1: &vector<vector<u8>>) : vector<u8> {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg1)) {
            v0 = hash_node(v0, *0x1::vector::borrow<vector<u8>>(arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun has_duplicate_source(arg0: &vector<u64>) : bool {
        let v0 = 0x2::vec_set::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            if (0x2::vec_set::contains<u64>(&v0, &v2)) {
                return true
            };
            0x2::vec_set::insert<u64>(&mut v0, v2);
            v1 = v1 + 1;
        };
        false
    }

    fun hash_node(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (le_bytes(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: WATERX_RULE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::new_cap<WATERX_RULE>(arg0, arg1);
        0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::create_enclave_config<WATERX_RULE>(&v0, 0x1::string::utf8(b"waterx rule enclave"), x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", arg1);
        0x2::transfer::public_transfer<0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::Cap<WATERX_RULE>>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Config{
            id       : 0x2::object::new(arg1),
            feed_map : 0x2::vec_map::empty<0x1::string::String, FeedConfig>(),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    fun is_fresh(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= arg0 || arg0 - arg1 <= arg2
    }

    fun is_future_dated(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 > arg1 && arg0 - arg1 > arg2
    }

    public fun is_perp_method(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"direct")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"median")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"confidence")
        }
    }

    public fun is_perp_source(arg0: u64) : bool {
        if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    fun is_replayed_signed_ts(arg0: &Config, arg1: 0x1::string::String, arg2: u64) : bool {
        let v0 = SignedTsHwmKey{symbol: arg1};
        0x2::dynamic_field::exists_with_type<SignedTsHwmKey, u64>(&arg0.id, v0) && arg2 <= *0x2::dynamic_field::borrow<SignedTsHwmKey, u64>(&arg0.id, v0)
    }

    public fun is_supported_method(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"direct")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"median")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"confidence")
        }
    }

    public fun is_supported_source(arg0: u64) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 8) {
            true
        } else if (arg0 == 9) {
            true
        } else if (arg0 == 10) {
            true
        } else {
            arg0 == 11
        }
    }

    fun latest_signature_is_fresh(arg0: &FeedConfig, arg1: u64, arg2: u64) : bool {
        is_fresh(arg1, arg2, arg0.max_age_ms)
    }

    fun latest_source_price_is_fresh(arg0: &FeedConfig, arg1: u64, arg2: u64) : bool {
        is_fresh(arg1, arg2, arg0.max_age_ms)
    }

    fun latest_timing_ok(arg0: &FeedConfig, arg1: u64, arg2: u64, arg3: &PricePayload) : bool {
        if (arg3.price_timestamp_ms <= arg2) {
            if (latest_signature_is_fresh(arg0, arg1, arg2)) {
                latest_source_price_is_fresh(arg0, arg1, arg3.price_timestamp_ms)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun le_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u8>(arg0, v3) < *0x1::vector::borrow<u8>(arg1, v3)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(arg0, v3) > *0x1::vector::borrow<u8>(arg1, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 <= v1
    }

    fun leaf_hash(arg0: &BatchPriceItem) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<BatchPriceItem>(arg0));
        0x2::hash::keccak256(&v0)
    }

    public fun leaf_hash_of(arg0: &BatchPriceItem) : vector<u8> {
        leaf_hash(arg0)
    }

    public fun max_batch_size() : u64 {
        32
    }

    public fun merkle_root_intent() : u8 {
        2
    }

    public fun method_confidence() : 0x1::string::String {
        0x1::string::utf8(b"confidence")
    }

    public fun method_direct() : 0x1::string::String {
        0x1::string::utf8(b"direct")
    }

    public fun method_from_name(arg0: 0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (arg0 == 0x1::string::utf8(b"direct")) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"direct"))
        } else if (arg0 == 0x1::string::utf8(b"median")) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"median"))
        } else if (arg0 == 0x1::string::utf8(b"confidence")) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"confidence"))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun method_median() : 0x1::string::String {
        0x1::string::utf8(b"median")
    }

    public fun new_batch_item(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u64>, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8) : BatchPriceItem {
        BatchPriceItem{
            symbol                   : arg0,
            ticker                   : arg1,
            sources                  : arg2,
            method                   : arg3,
            price_timestamp_ms       : arg4,
            price_n                  : arg5,
            price_scale              : arg6,
            confidence_n             : arg7,
            confidence_scale         : arg8,
            max_source_deviation_bps : arg9,
            num_sources              : arg10,
        }
    }

    public fun new_batch_payload() : BatchPricePayload {
        BatchPricePayload{items: 0x1::vector::empty<BatchPriceItem>()}
    }

    fun price_payload_from_batch_item(arg0: BatchPriceItem) : PricePayload {
        PricePayload{
            ticker                   : arg0.ticker,
            sources                  : arg0.sources,
            method                   : arg0.method,
            price_timestamp_ms       : arg0.price_timestamp_ms,
            price_n                  : arg0.price_n,
            price_scale              : arg0.price_scale,
            confidence_n             : arg0.confidence_n,
            confidence_scale         : arg0.confidence_scale,
            max_source_deviation_bps : arg0.max_source_deviation_bps,
            num_sources              : arg0.num_sources,
        }
    }

    public fun push_batch_item(arg0: &mut BatchPricePayload, arg1: BatchPriceItem) {
        0x1::vector::push_back<BatchPriceItem>(&mut arg0.items, arg1);
    }

    public fun quote_for_timestamp(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::EnclaveConfig<WATERX_RULE>, arg3: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::Enclave<WATERX_RULE>, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: BatchPricePayload, arg8: &vector<u8>) : VerifiedPrice {
        validate_batch_shape(&arg7);
        if (!0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::verify_signature<WATERX_RULE, BatchPricePayload>(arg3, arg2, 1, arg5, arg7, arg8)) {
            abort 13906836768503627777
        };
        let v0 = *0x1::vector::borrow<BatchPriceItem>(&arg7.items, 0);
        if (v0.symbol != arg4) {
            abort 13906836789981347885
        };
        let v1 = price_payload_from_batch_item(v0);
        validate_historical_fields(arg0, arg1, &arg4, arg5, arg6, &v1);
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v1.price_n, v1.price_scale);
        let v3 = HistoricalPriceVerified{
            symbol                   : arg4,
            ticker                   : v1.ticker,
            sources                  : v1.sources,
            method                   : v1.method,
            price_timestamp_ms       : v1.price_timestamp_ms,
            price                    : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v2),
            confidence               : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v1.confidence_n, v1.confidence_scale)),
            max_source_deviation_bps : v1.max_source_deviation_bps,
            num_sources              : v1.num_sources,
            signed_timestamp_ms      : arg5,
        };
        0x2::event::emit<HistoricalPriceVerified>(v3);
        VerifiedPrice{
            symbol                   : arg4,
            ticker                   : v1.ticker,
            sources                  : v1.sources,
            method                   : v1.method,
            price_timestamp_ms       : v1.price_timestamp_ms,
            price                    : v2,
            price_n                  : v1.price_n,
            price_scale              : v1.price_scale,
            confidence_n             : v1.confidence_n,
            confidence_scale         : v1.confidence_scale,
            max_source_deviation_bps : v1.max_source_deviation_bps,
            num_sources              : v1.num_sources,
            signed_timestamp_ms      : arg5,
        }
    }

    public fun remove_feed(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String) {
        let v0 = &mut arg0.feed_map;
        if (0x2::vec_map::contains<0x1::string::String, FeedConfig>(v0, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, FeedConfig>(v0, &arg2);
        };
    }

    public fun reset_signed_ts_hwm(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: u64) {
        let v0 = signed_ts_hwm(arg0, arg2);
        set_signed_ts_hwm(arg0, arg2, arg3);
        let v1 = SignedTsHwmReset{
            symbol                 : arg2,
            previous_signed_ts_hwm : v0,
            signed_ts_hwm          : arg3,
        };
        0x2::event::emit<SignedTsHwmReset>(v1);
    }

    public fun set_feed(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u64>, arg5: 0x1::string::String, arg6: u64) {
        set_feed_with_limits(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 10000, 10000, 1);
    }

    fun set_feed_with_limits(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u64>, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u8) {
        if (0x1::string::is_empty(&arg2)) {
            abort 13906837670447153159
        };
        if (0x1::string::is_empty(&arg3)) {
            abort 13906837683332055047
        };
        if (0x1::vector::is_empty<u64>(&arg4)) {
            abort 13906837696217743379
        };
        if (!are_supported_sources(&arg4)) {
            abort 13906837709101596675
        };
        if (has_duplicate_source(&arg4)) {
            abort 13906837721986629637
        };
        if (!is_supported_method(&arg5)) {
            abort 13906837734872973339
        };
        if (arg6 == 0) {
            abort 13906837747756695561
        };
        if (arg7 > 10000 || arg8 > 10000) {
            abort 13906837760641597449
        };
        if (arg9 == 0) {
            abort 13906837773527154707
        };
        let v0 = FeedConfig{
            ticker                   : arg3,
            sources                  : arg4,
            method                   : arg5,
            max_age_ms               : arg6,
            max_confidence_bps       : arg7,
            max_source_deviation_bps : arg8,
            min_sources              : arg9,
        };
        let v1 = &mut arg0.feed_map;
        if (0x2::vec_map::contains<0x1::string::String, FeedConfig>(v1, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, FeedConfig>(v1, &arg2) = v0;
        } else {
            0x2::vec_map::insert<0x1::string::String, FeedConfig>(v1, arg2, v0);
        };
    }

    public fun set_perp_feed(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u64>, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u8) {
        if (!are_perp_sources(&arg4)) {
            abort 13906837533009248279
        };
        if (!is_perp_method(&arg5)) {
            abort 13906837545894412315
        };
        set_feed_with_limits(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun set_signed_ts_hwm(arg0: &mut Config, arg1: 0x1::string::String, arg2: u64) {
        let v0 = SignedTsHwmKey{symbol: arg1};
        if (0x2::dynamic_field::exists_with_type<SignedTsHwmKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<SignedTsHwmKey, u64>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<SignedTsHwmKey, u64>(&mut arg0.id, v0, arg2);
        };
    }

    public fun signed_ts_hwm(arg0: &Config, arg1: 0x1::string::String) : u64 {
        let v0 = SignedTsHwmKey{symbol: arg1};
        if (0x2::dynamic_field::exists_with_type<SignedTsHwmKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<SignedTsHwmKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun source_binance_spot() : u64 {
        1
    }

    public fun source_binance_usdm_perp_ws() : u64 {
        2
    }

    public fun source_bybit_linear_perp_ws() : u64 {
        3
    }

    public fun source_bybit_spot_ws() : u64 {
        5
    }

    public fun source_from_name(arg0: 0x1::string::String) : 0x1::option::Option<u64> {
        if (arg0 == 0x1::string::utf8(b"binance_spot")) {
            0x1::option::some<u64>(1)
        } else if (arg0 == 0x1::string::utf8(b"binance_spot_ws")) {
            0x1::option::some<u64>(1)
        } else if (arg0 == 0x1::string::utf8(b"binance_usdm_perp_ws")) {
            0x1::option::some<u64>(2)
        } else if (arg0 == 0x1::string::utf8(b"bybit_linear_perp_ws")) {
            0x1::option::some<u64>(3)
        } else if (arg0 == 0x1::string::utf8(b"gateio_usdt_perp_ws")) {
            0x1::option::some<u64>(4)
        } else if (arg0 == 0x1::string::utf8(b"gata_usdt_perp_ws")) {
            0x1::option::some<u64>(4)
        } else if (arg0 == 0x1::string::utf8(b"bybit_spot_ws")) {
            0x1::option::some<u64>(5)
        } else if (arg0 == 0x1::string::utf8(b"xstock_equity_rest")) {
            0x1::option::some<u64>(6)
        } else if (arg0 == 0x1::string::utf8(b"alpaca_equity_rest")) {
            0x1::option::some<u64>(6)
        } else if (arg0 == 0x1::string::utf8(b"okx_spot_ws")) {
            0x1::option::some<u64>(7)
        } else if (arg0 == 0x1::string::utf8(b"okx_ws")) {
            0x1::option::some<u64>(7)
        } else if (arg0 == 0x1::string::utf8(b"hyperliquid_perp_ws")) {
            0x1::option::some<u64>(8)
        } else if (arg0 == 0x1::string::utf8(b"hyperliquid_ws")) {
            0x1::option::some<u64>(8)
        } else if (arg0 == 0x1::string::utf8(b"gateio_spot_ws")) {
            0x1::option::some<u64>(9)
        } else if (arg0 == 0x1::string::utf8(b"gate_spot_ws")) {
            0x1::option::some<u64>(9)
        } else if (arg0 == 0x1::string::utf8(b"kraken_spot_ws")) {
            0x1::option::some<u64>(10)
        } else if (arg0 == 0x1::string::utf8(b"kraken_ws")) {
            0x1::option::some<u64>(10)
        } else if (arg0 == 0x1::string::utf8(b"pyth_lazer_ws")) {
            0x1::option::some<u64>(11)
        } else if (arg0 == 0x1::string::utf8(b"pyth_lazer")) {
            0x1::option::some<u64>(11)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun source_gata_usdt_perp_ws() : u64 {
        4
    }

    public fun source_gateio_spot_ws() : u64 {
        9
    }

    public fun source_gateio_usdt_perp_ws() : u64 {
        4
    }

    public fun source_hyperliquid_perp_ws() : u64 {
        8
    }

    public fun source_kraken_spot_ws() : u64 {
        10
    }

    public fun source_okx_spot_ws() : u64 {
        7
    }

    public fun source_pyth_lazer_ws() : u64 {
        11
    }

    public fun source_xstock_equity_rest() : u64 {
        6
    }

    fun try_record_signed_ts(arg0: &mut Config, arg1: 0x1::string::String, arg2: u64) : bool {
        let v0 = SignedTsHwmKey{symbol: arg1};
        if (0x2::dynamic_field::exists_with_type<SignedTsHwmKey, u64>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<SignedTsHwmKey, u64>(&mut arg0.id, v0);
            if (arg2 <= *v2) {
                false
            } else {
                *v2 = arg2;
                true
            }
        } else {
            0x2::dynamic_field::add<SignedTsHwmKey, u64>(&mut arg0.id, v0, arg2);
            true
        }
    }

    fun validate_batch_shape(arg0: &BatchPricePayload) {
        let v0 = &arg0.items;
        let v1 = 0x1::vector::length<BatchPriceItem>(v0);
        if (v1 == 0) {
            abort 13906839478630481959
        };
        if (v1 > 32) {
            abort 13906839491515514921
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v2 + 1;
            while (v3 < v1) {
                if (0x1::vector::borrow<BatchPriceItem>(v0, v2).symbol == 0x1::vector::borrow<BatchPriceItem>(v0, v3).symbol) {
                    abort 13906839530170351659
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
    }

    fun validate_historical_fields(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &0x1::string::String, arg3: u64, arg4: u64, arg5: &PricePayload) {
        if (arg5.price_timestamp_ms != arg4) {
            abort 13906839611773812765
        };
        if (!0x2::vec_map::contains<0x1::string::String, FeedConfig>(&arg0.feed_map, arg2)) {
            abort 13906839624658845727
        };
        let v0 = *0x2::vec_map::get<0x1::string::String, FeedConfig>(&arg0.feed_map, arg2);
        validate_payload_with_config(&v0, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (!is_fresh(v1, arg3, v0.max_age_ms)) {
            abort 13906839659018715169
        };
        if (is_future_dated(arg3, v1, v0.max_age_ms)) {
            abort 13906839719148388387
        };
        if (arg5.price_timestamp_ms > arg3) {
            abort 13906839813637799973
        };
    }

    fun validate_payload_with_config(arg0: &FeedConfig, arg1: &PricePayload) {
        if (arg0.sources != arg1.sources) {
            abort 13906839895240474635
        };
        if (arg0.ticker != arg1.ticker) {
            abort 13906839908125507597
        };
        if (arg0.method != arg1.method) {
            abort 13906839921011195929
        };
        if (arg1.price_scale == 0) {
            abort 13906839933895442447
        };
        if (arg1.confidence_scale == 0 || arg1.confidence_scale != arg1.price_scale) {
            abort 13906839946780475409
        };
        if (is_perp_method(&arg1.method)) {
            validate_perp_payload(arg1, arg0);
        };
    }

    fun validate_perp_payload(arg0: &PricePayload, arg1: &FeedConfig) {
        if (arg0.num_sources < arg1.min_sources) {
            abort 13906840479356551187
        };
        if (arg0.max_source_deviation_bps > arg1.max_source_deviation_bps) {
            abort 13906840492241584149
        };
        if (arg0.price_n == 0) {
            abort 13906840505126223889
        };
        if ((arg0.confidence_n as u128) * (10000 as u128) / (arg0.price_n as u128) > (arg1.max_confidence_bps as u128)) {
            abort 13906840526601060369
        };
    }

    public fun verified_confidence_n(arg0: &VerifiedPrice) : u64 {
        arg0.confidence_n
    }

    public fun verified_confidence_scale(arg0: &VerifiedPrice) : u64 {
        arg0.confidence_scale
    }

    public fun verified_max_source_deviation_bps(arg0: &VerifiedPrice) : u64 {
        arg0.max_source_deviation_bps
    }

    public fun verified_method(arg0: &VerifiedPrice) : &0x1::string::String {
        &arg0.method
    }

    public fun verified_num_sources(arg0: &VerifiedPrice) : u8 {
        arg0.num_sources
    }

    public fun verified_price(arg0: &VerifiedPrice) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.price
    }

    public fun verified_price_n(arg0: &VerifiedPrice) : u64 {
        arg0.price_n
    }

    public fun verified_price_scale(arg0: &VerifiedPrice) : u64 {
        arg0.price_scale
    }

    public fun verified_price_scaled(arg0: &VerifiedPrice) : u128 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(arg0.price)
    }

    public fun verified_price_timestamp_ms(arg0: &VerifiedPrice) : u64 {
        arg0.price_timestamp_ms
    }

    public fun verified_signed_timestamp_ms(arg0: &VerifiedPrice) : u64 {
        arg0.signed_timestamp_ms
    }

    public fun verified_sources(arg0: &VerifiedPrice) : &vector<u64> {
        &arg0.sources
    }

    public fun verified_symbol(arg0: &VerifiedPrice) : &0x1::string::String {
        &arg0.symbol
    }

    public fun verified_ticker(arg0: &VerifiedPrice) : &0x1::string::String {
        &arg0.ticker
    }

    fun verify_merkle_root(arg0: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::Enclave<WATERX_RULE>, arg1: &0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::EnclaveConfig<WATERX_RULE>, arg2: u64, arg3: &BatchPriceItem, arg4: &vector<vector<u8>>, arg5: &vector<u8>) {
        let v0 = MerkleRoot{root: fold_proof(leaf_hash(arg3), arg4)};
        if (!0xbce5b23dc3bca7b514adc36954cd01ac5227d17c2e7764c36e9b3808364c6693::enclave::verify_signature<WATERX_RULE, MerkleRoot>(arg0, arg1, 2, arg2, v0, arg5)) {
            abort 13906836416316309505
        };
    }

    // decompiled from Move bytecode v7
}

