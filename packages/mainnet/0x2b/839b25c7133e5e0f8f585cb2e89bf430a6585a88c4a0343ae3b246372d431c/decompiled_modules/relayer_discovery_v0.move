module 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0 {
    struct RelayerDiscovery_v0 has store {
        configurations: 0x2::table::Table<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>,
        version_control: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl,
    }

    public(friend) fun new(arg0: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl, arg1: &mut 0x2::tx_context::TxContext) : RelayerDiscovery_v0 {
        RelayerDiscovery_v0{
            configurations  : 0x2::table::new<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>(arg1),
            version_control : arg0,
        }
    }

    public(friend) fun allow_function(arg0: &mut RelayerDiscovery_v0, arg1: u64, arg2: 0x1::ascii::String) {
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::allow_function(&mut arg0.version_control, arg1, arg2);
    }

    public(friend) fun disallow_function(arg0: &mut RelayerDiscovery_v0, arg1: u64, arg2: 0x1::ascii::String) {
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::disallow_function(&mut arg0.version_control, arg1, arg2);
    }

    public(friend) fun get_transaction(arg0: &RelayerDiscovery_v0, arg1: 0x2::object::ID) : 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction {
        assert!(0x2::table::contains<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>(&arg0.configurations, arg1), 9223372328912551937);
        *0x2::table::borrow<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>(&arg0.configurations, arg1)
    }

    public(friend) fun version_control(arg0: &RelayerDiscovery_v0) : &0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        &arg0.version_control
    }

    public(friend) fun remove_transaction(arg0: &mut RelayerDiscovery_v0, arg1: 0x2::object::ID) : 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction {
        assert!(0x2::table::contains<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>(&arg0.configurations, arg1), 9223372285962878977);
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::events::transaction_removed(arg1);
        0x2::table::remove<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>(&mut arg0.configurations, arg1)
    }

    public(friend) fun set_transaction(arg0: &mut RelayerDiscovery_v0, arg1: 0x2::object::ID, arg2: 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction) {
        if (0x2::table::contains<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>(&arg0.configurations, arg1)) {
            0x2::table::remove<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>(&mut arg0.configurations, arg1);
        };
        0x2::table::add<0x2::object::ID, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction>(&mut arg0.configurations, arg1, arg2);
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::events::transaction_registered(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

