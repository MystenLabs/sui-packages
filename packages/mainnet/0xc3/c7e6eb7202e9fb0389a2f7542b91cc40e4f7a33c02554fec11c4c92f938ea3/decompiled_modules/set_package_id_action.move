module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::set_package_id_action {
    struct OnDemandPackageIdSet has copy, drop {
        old_on_demand_package_id: 0x2::object::ID,
        on_demand_package_id: 0x2::object::ID,
    }

    fun actuate(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::on_demand::State, arg1: 0x2::object::ID) {
        let v0 = OnDemandPackageIdSet{
            old_on_demand_package_id : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::on_demand::on_demand_package_id(arg0),
            on_demand_package_id     : arg1,
        };
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::on_demand::set_on_demand_package_id(arg0, arg1);
        0x2::event::emit<OnDemandPackageIdSet>(v0);
    }

    public entry fun run(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::on_demand::AdminCap, arg1: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::on_demand::State, arg2: 0x2::object::ID) {
        validate();
        actuate(arg1, arg2);
    }

    public fun validate() {
    }

    // decompiled from Move bytecode v6
}

