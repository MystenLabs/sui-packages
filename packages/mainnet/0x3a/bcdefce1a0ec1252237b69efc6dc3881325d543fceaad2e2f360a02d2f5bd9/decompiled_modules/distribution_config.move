module 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::distribution_config {
    struct DistributionConfig has store, key {
        id: 0x2::object::UID,
        alive_gauges: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DistributionConfig{
            id           : 0x2::object::new(arg0),
            alive_gauges : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<DistributionConfig>(v0);
    }

    public fun is_gauge_alive(arg0: &DistributionConfig, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.alive_gauges, &arg1)
    }

    public(friend) fun update_gauge_liveness(arg0: &mut DistributionConfig, arg1: vector<0x2::object::ID>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
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

