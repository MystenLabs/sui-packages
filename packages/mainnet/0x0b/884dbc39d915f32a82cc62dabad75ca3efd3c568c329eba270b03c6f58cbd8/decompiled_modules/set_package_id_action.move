module 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::set_package_id_action {
    struct OnDemandPackageIdSet has copy, drop {
        old_on_demand_package_id: 0x2::object::ID,
        on_demand_package_id: 0x2::object::ID,
    }

    fun actuate(arg0: &mut 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::on_demand::State, arg1: 0x2::object::ID) {
        let v0 = OnDemandPackageIdSet{
            old_on_demand_package_id : 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::on_demand::on_demand_package_id(arg0),
            on_demand_package_id     : arg1,
        };
        0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::on_demand::set_on_demand_package_id(arg0, arg1);
        0x2::event::emit<OnDemandPackageIdSet>(v0);
    }

    public entry fun run(arg0: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::on_demand::AdminCap, arg1: &mut 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::on_demand::State, arg2: 0x2::object::ID) {
        validate();
        actuate(arg1, arg2);
    }

    public fun validate() {
    }

    // decompiled from Move bytecode v6
}

