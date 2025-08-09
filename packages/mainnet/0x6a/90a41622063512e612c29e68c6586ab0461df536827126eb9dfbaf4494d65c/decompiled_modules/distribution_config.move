module 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config {
    struct DistributionConfig has store, key {
        id: 0x2::object::UID,
        alive_gauges: 0x2::vec_set::VecSet<0x2::object::ID>,
        o_sail_price_aggregator_id: 0x1::option::Option<0x2::object::ID>,
        sail_price_aggregator_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun borrow_alive_gauges(arg0: &DistributionConfig) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.alive_gauges
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DistributionConfig{
            id                         : 0x2::object::new(arg0),
            alive_gauges               : 0x2::vec_set::empty<0x2::object::ID>(),
            o_sail_price_aggregator_id : 0x1::option::none<0x2::object::ID>(),
            sail_price_aggregator_id   : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<DistributionConfig>(v0);
    }

    public fun is_gauge_alive(arg0: &DistributionConfig, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.alive_gauges, &arg1)
    }

    public fun is_valid_o_sail_price_aggregator(arg0: &DistributionConfig, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : bool {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.o_sail_price_aggregator_id)) {
            let v1 = 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg1);
            &v1 == 0x1::option::borrow<0x2::object::ID>(&arg0.o_sail_price_aggregator_id)
        } else {
            false
        }
    }

    public fun is_valid_sail_price_aggregator(arg0: &DistributionConfig, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : bool {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.sail_price_aggregator_id)) {
            let v1 = 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg1);
            &v1 == 0x1::option::borrow<0x2::object::ID>(&arg0.sail_price_aggregator_id)
        } else {
            false
        }
    }

    public(friend) fun set_o_sail_price_aggregator(arg0: &mut DistributionConfig, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        arg0.o_sail_price_aggregator_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg1));
    }

    public(friend) fun set_sail_price_aggregator(arg0: &mut DistributionConfig, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        arg0.sail_price_aggregator_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg1));
    }

    public(friend) fun update_gauge_liveness(arg0: &mut DistributionConfig, arg1: vector<0x2::object::ID>, arg2: bool) {
        let v0 = 0;
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(v1 > 0, 9223372148523925503);
        if (arg2) {
            while (v0 < v1) {
                if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.alive_gauges, 0x1::vector::borrow<0x2::object::ID>(&arg1, v0))) {
                    0x2::vec_set::insert<0x2::object::ID>(&mut arg0.alive_gauges, *0x1::vector::borrow<0x2::object::ID>(&arg1, v0));
                };
                v0 = v0 + 1;
            };
        } else {
            while (v0 < v1) {
                if (0x2::vec_set::contains<0x2::object::ID>(&arg0.alive_gauges, 0x1::vector::borrow<0x2::object::ID>(&arg1, v0))) {
                    0x2::vec_set::remove<0x2::object::ID>(&mut arg0.alive_gauges, 0x1::vector::borrow<0x2::object::ID>(&arg1, v0));
                };
                v0 = v0 + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

