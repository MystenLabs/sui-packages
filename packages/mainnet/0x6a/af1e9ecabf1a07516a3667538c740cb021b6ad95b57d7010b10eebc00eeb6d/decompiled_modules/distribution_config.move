module 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::distribution_config {
    struct DISTRIBUTION_CONFIG has drop {
        dummy_field: bool,
    }

    struct DistributionConfig has store, key {
        id: 0x2::object::UID,
        alive_gauges: 0x2::vec_set::VecSet<0x2::object::ID>,
        o_sail_price_aggregator_id: 0x1::option::Option<0x2::object::ID>,
        sail_price_aggregator_id: 0x1::option::Option<0x2::object::ID>,
        version: u64,
        bag: 0x2::bag::Bag,
    }

    public fun borrow_alive_gauges(arg0: &DistributionConfig) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.alive_gauges
    }

    public fun checked_package_version(arg0: &DistributionConfig) {
        assert!(arg0.version == 4, 458466182903521300);
    }

    fun init(arg0: DISTRIBUTION_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DISTRIBUTION_CONFIG>(arg0, arg1);
        let v0 = DistributionConfig{
            id                         : 0x2::object::new(arg1),
            alive_gauges               : 0x2::vec_set::empty<0x2::object::ID>(),
            o_sail_price_aggregator_id : 0x1::option::none<0x2::object::ID>(),
            sail_price_aggregator_id   : 0x1::option::none<0x2::object::ID>(),
            version                    : 4,
            bag                        : 0x2::bag::new(arg1),
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

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public(friend) fun set_o_sail_price_aggregator(arg0: &mut DistributionConfig, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        arg0.o_sail_price_aggregator_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg1));
    }

    public fun set_package_version(arg0: &mut DistributionConfig, arg1: &0x2::package::Publisher, arg2: u64) {
        assert!(0x2::package::from_module<DISTRIBUTION_CONFIG>(arg1), 24442067766657028);
        assert!(arg2 <= 4, 326963916733903800);
        arg0.version = arg2;
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

