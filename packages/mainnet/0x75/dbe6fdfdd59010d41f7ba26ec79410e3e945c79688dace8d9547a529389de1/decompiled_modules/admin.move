module 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x4836f258cbac78c06040309b9dafa6609e46f1d44dc60e370a3d6330880fb0d1);
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::custodian::new(arg0);
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::configuration::new(arg0);
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::state::new(arg0);
    }

    public entry fun set_admin(arg0: &0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::version::assert_current_version(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::version::assert_current_version(arg0);
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::operator::new_operator(arg2, arg3);
    }

    public entry fun update_configuration(arg0: &0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::version::Version, arg1: &AdminCap, arg2: &mut 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::configuration::Configuration, arg3: u64, arg4: u64) {
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::version::assert_current_version(arg0);
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::configuration::update(arg2, arg3, arg4);
    }

    public entry fun withdraw_treasury_balance(arg0: &0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::version::Version, arg1: &AdminCap, arg2: &mut 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::version::assert_current_version(arg0);
        0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

