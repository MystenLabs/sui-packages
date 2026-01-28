module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle {
    struct AggregatedOracle has key {
        id: 0x2::object::UID,
        minimum_sources: u8,
        oracle_feed_ids: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
        limits: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::OracleLimits,
    }

    struct PythConfidenceBps has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun id(arg0: &AggregatedOracle) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun new(arg0: u8, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::OracleLimits, arg2: &mut 0x2::tx_context::TxContext) : AggregatedOracle {
        let v0 = AggregatedOracle{
            id              : 0x2::object::new(arg2),
            minimum_sources : arg0,
            oracle_feed_ids : 0x2::vec_map::empty<0x1::string::String, vector<u8>>(),
            limits          : arg1,
        };
        validate(&v0);
        v0
    }

    public(friend) fun add_feed(arg0: &mut AggregatedOracle, arg1: 0x1::string::String, arg2: vector<u8>) {
        0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut arg0.oracle_feed_ids, arg1, arg2);
    }

    public(friend) fun commit_pyth_oracle_price(arg0: &AggregatedOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::OracleProof, arg3: &0x2::clock::Clock) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::assert_is_valid_for(arg2, 0x2::object::uid_to_inner(&arg0.id));
        let v0 = 0x1::string::utf8(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::pyth_oracle_internal_identifier());
        assert!(0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg0.oracle_feed_ids, &v0), 13835339942575734785);
        let (v1, v2, v3) = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::pyth_oracle::calculate_usd_price(arg1, *0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg0.oracle_feed_ids, &v0), pyth_confidence_bps(arg0));
        if (!v3) {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_pyth_confidence_not_valid(0x2::object::id<AggregatedOracle>(arg0));
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::commit_oracle_price(arg2, v0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::new_invalid_price());
            return
        };
        if (v2 < 0x2::clock::timestamp_ms(arg3) - 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::max_age_ms(&arg0.limits)) {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_price_stale(id(arg0), v0);
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::commit_oracle_price(arg2, v0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::new_invalid_price());
            return
        };
        if (v1 < 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::min_price(&arg0.limits)) {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_price_too_small(id(arg0), v0, v1);
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::commit_oracle_price(arg2, v0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::new_invalid_price());
            return
        };
        if (v1 > 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::max_price(&arg0.limits)) {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_price_too_large(id(arg0), v0, v1);
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::commit_oracle_price(arg2, v0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::new_invalid_price());
            return
        };
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_price_committed(id(arg0), v0, v1, v2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::commit_oracle_price(arg2, v0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::new_valid_price(v0, v1, v2));
    }

    public(friend) fun enabled_oracle_feeds(arg0: &AggregatedOracle) : 0x2::vec_set::VecSet<0x1::string::String> {
        0x2::vec_set::from_keys<0x1::string::String>(0x2::vec_map::keys<0x1::string::String, vector<u8>>(&arg0.oracle_feed_ids))
    }

    public(friend) fun limits(arg0: &AggregatedOracle) : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::OracleLimits {
        arg0.limits
    }

    public(friend) fun limits_mut(arg0: &mut AggregatedOracle) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::OracleLimits {
        &mut arg0.limits
    }

    public(friend) fun minimum_sources(arg0: &AggregatedOracle) : u8 {
        arg0.minimum_sources
    }

    public(friend) fun new_proof(arg0: &mut AggregatedOracle) : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::OracleProof {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::new(0x2::object::uid_to_inner(&arg0.id), enabled_oracle_feeds(arg0), arg0.minimum_sources)
    }

    public(friend) fun pyth_confidence_bps(arg0: &AggregatedOracle) : u16 {
        let v0 = PythConfidenceBps{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<PythConfidenceBps, u16>(&arg0.id, v0)) {
            let v2 = PythConfidenceBps{dummy_field: false};
            *0x2::dynamic_field::borrow<PythConfidenceBps, u16>(&arg0.id, v2)
        } else {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::max_pyth_confidence_bps()
        }
    }

    public(friend) fun remove_feed(arg0: &mut AggregatedOracle, arg1: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, vector<u8>>(&mut arg0.oracle_feed_ids, &arg1);
    }

    public(friend) fun set_minimum_sources(arg0: &mut AggregatedOracle, arg1: u8) {
        arg0.minimum_sources = arg1;
        validate(arg0);
    }

    public(friend) fun set_pyth_confidence_bps(arg0: &mut AggregatedOracle, arg1: u16) {
        assert!(arg1 <= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::max_pyth_confidence_bps(), 13835621262933753859);
        let v0 = PythConfidenceBps{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<PythConfidenceBps, u16>(&arg0.id, v0)) {
            let v1 = PythConfidenceBps{dummy_field: false};
            0x2::dynamic_field::add<PythConfidenceBps, u16>(&mut arg0.id, v1, arg1);
            return
        };
        let v2 = PythConfidenceBps{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<PythConfidenceBps, u16>(&mut arg0.id, v2) = arg1;
    }

    public fun share(arg0: AggregatedOracle) {
        0x2::transfer::share_object<AggregatedOracle>(arg0);
    }

    fun validate(arg0: &AggregatedOracle) {
        assert!(arg0.minimum_sources > 0, 13835903343500984325);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::validate(&arg0.limits);
    }

    // decompiled from Move bytecode v6
}

