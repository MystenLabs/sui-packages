module 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals {
    struct GaugeGlobals has store, key {
        id: 0x2::object::UID,
        paused: bool,
        incentive_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        voter_whitelist: 0x2::vec_set::VecSet<address>,
        gauges: 0x2::vec_map::VecMap<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>,
        pool_id_to_gauge: 0x2::vec_map::VecMap<address, address>,
    }

    public(friend) fun assert_not_paused(arg0: &GaugeGlobals) {
        assert!(is_paused(arg0), 4);
    }

    public(friend) fun add_gauge(arg0: &mut GaugeGlobals, arg1: 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge) {
        let v0 = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::gauge_id(&arg1);
        assert!(!0x2::vec_map::contains<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>(&arg0.gauges, &v0), 0);
        let v1 = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::pool_id(&arg1);
        assert!(!0x2::vec_map::contains<address, address>(&arg0.pool_id_to_gauge, &v1), 0);
        0x2::vec_map::insert<address, address>(&mut arg0.pool_id_to_gauge, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::pool_id(&arg1), 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::gauge_id(&arg1));
        0x2::vec_map::insert<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>(&mut arg0.gauges, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::gauge_id(&arg1), arg1);
    }

    public(friend) fun add_incentive_whitelist<T0>(arg0: &mut GaugeGlobals) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.incentive_whitelist, &v0), 2);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.incentive_whitelist, v0);
    }

    public(friend) fun add_whitelisted_voter(arg0: &mut GaugeGlobals, arg1: address) {
        0x2::vec_set::insert<address>(&mut arg0.voter_whitelist, arg1);
    }

    public(friend) fun all_gauge_ids(arg0: &GaugeGlobals) : vector<address> {
        0x2::vec_map::keys<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>(&arg0.gauges)
    }

    public fun all_whitelisted_incentives(arg0: &GaugeGlobals) : &vector<0x1::type_name::TypeName> {
        0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.incentive_whitelist)
    }

    public(friend) fun all_whitelisted_voters(arg0: &GaugeGlobals) : &vector<address> {
        0x2::vec_set::keys<address>(&arg0.voter_whitelist)
    }

    public(friend) fun assert_incentive_whitelisted<T0>(arg0: &GaugeGlobals) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.incentive_whitelist, &v0), 3);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : GaugeGlobals {
        GaugeGlobals{
            id                  : 0x2::object::new(arg0),
            paused              : false,
            incentive_whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            voter_whitelist     : 0x2::vec_set::empty<address>(),
            gauges              : 0x2::vec_map::empty<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>(),
            pool_id_to_gauge    : 0x2::vec_map::empty<address, address>(),
        }
    }

    public(friend) fun get_gauge(arg0: &GaugeGlobals, arg1: &address) : &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge {
        assert!(0x2::vec_map::contains<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>(&arg0.gauges, arg1), 1);
        0x2::vec_map::get<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>(&arg0.gauges, arg1)
    }

    public(friend) fun get_gauge_by_pool_id(arg0: &GaugeGlobals, arg1: &address) : &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge {
        assert!(0x2::vec_map::contains<address, address>(&arg0.pool_id_to_gauge, arg1), 1);
        get_gauge(arg0, 0x2::vec_map::get<address, address>(&arg0.pool_id_to_gauge, arg1))
    }

    public(friend) fun get_gauge_not_paused(arg0: &mut GaugeGlobals, arg1: &address) : &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge {
        assert!(0x2::vec_map::contains<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>(&arg0.gauges, arg1), 1);
        let v0 = 0x2::vec_map::get_mut<address, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::Gauge>(&mut arg0.gauges, arg1);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::assert_not_paused(v0);
        v0
    }

    public(friend) fun is_paused(arg0: &GaugeGlobals) : bool {
        arg0.paused
    }

    public fun is_whitelisted_incentive(arg0: &GaugeGlobals, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.incentive_whitelist, arg1)
    }

    public fun is_whitelisted_voter(arg0: &GaugeGlobals, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.voter_whitelist, &arg1)
    }

    public(friend) fun remove_incentive_whitelist<T0>(arg0: &mut GaugeGlobals) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.incentive_whitelist, &v0), 1);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.incentive_whitelist, &v0);
    }

    public(friend) fun remove_whitelisted_voter(arg0: &mut GaugeGlobals, arg1: address) {
        0x2::vec_set::remove<address>(&mut arg0.voter_whitelist, &arg1);
    }

    public(friend) fun set_paused(arg0: &mut GaugeGlobals, arg1: bool) {
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

