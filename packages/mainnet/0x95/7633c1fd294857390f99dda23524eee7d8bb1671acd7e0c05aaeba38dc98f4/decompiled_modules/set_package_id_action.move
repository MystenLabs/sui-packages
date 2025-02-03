module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::set_package_id_action {
    struct OnDemandPackageIdSet has copy, drop {
        old_on_demand_package_id: 0x2::object::ID,
        on_demand_package_id: 0x2::object::ID,
    }

    fun actuate(arg0: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::on_demand::State, arg1: 0x2::object::ID) {
        let v0 = OnDemandPackageIdSet{
            old_on_demand_package_id : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::on_demand::on_demand_package_id(arg0),
            on_demand_package_id     : arg1,
        };
        0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::on_demand::set_on_demand_package_id(arg0, arg1);
        0x2::event::emit<OnDemandPackageIdSet>(v0);
    }

    public entry fun run(arg0: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::on_demand::AdminCap, arg1: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::on_demand::State, arg2: 0x2::object::ID) {
        validate();
        actuate(arg1, arg2);
    }

    public fun validate() {
    }

    // decompiled from Move bytecode v6
}

