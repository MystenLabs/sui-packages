module 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery {
    struct RelayerDiscovery has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    entry fun allow_function(arg0: &mut RelayerDiscovery, arg1: &0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::owner_cap::OwnerCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::RelayerDiscovery_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::version_control(v0), 0, 0x1::ascii::string(b"allow_function"));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::allow_function(v0, arg2, arg3);
    }

    entry fun disallow_function(arg0: &mut RelayerDiscovery, arg1: &0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::owner_cap::OwnerCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::RelayerDiscovery_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::version_control(v0), 0, 0x1::ascii::string(b"disallow_function"));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::disallow_function(v0, arg2, arg3);
    }

    public fun get_transaction(arg0: &RelayerDiscovery, arg1: 0x2::object::ID) : 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction {
        let v0 = 0x2::versioned::load_value<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::RelayerDiscovery_v0>(&arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::version_control(v0), 0, 0x1::ascii::string(b"register_transaction"));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::get_transaction(v0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RelayerDiscovery{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::RelayerDiscovery_v0>(0, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::new(version_control(), arg0), arg0),
        };
        0x2::transfer::share_object<RelayerDiscovery>(v0);
        0x2::transfer::public_transfer<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::owner_cap::OwnerCap>(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::owner_cap::create(arg0), 0x2::tx_context::sender(arg0));
    }

    public fun register_transaction(arg0: &mut RelayerDiscovery, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction) {
        let v0 = 0x2::versioned::load_value_mut<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::RelayerDiscovery_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::version_control(v0), 0, 0x1::ascii::string(b"register_transaction"));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::set_transaction(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::id(arg1), arg2);
    }

    public fun remove_transaction(arg0: &mut RelayerDiscovery, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel) {
        let v0 = 0x2::versioned::load_value_mut<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::RelayerDiscovery_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::version_control(v0), 0, 0x1::ascii::string(b"remove_transaction"));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::relayer_discovery_v0::remove_transaction(v0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::id(arg1));
    }

    fun version_control() : 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = vector[b"register_transaction", b"remove_transaction", b"get_transaction", b"allow_function", b"disallow_function"];
        0x1::vector::reverse<vector<u8>>(&mut v1);
        while (0x1::vector::length<vector<u8>>(&v1) != 0) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut v1)));
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        let v2 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        0x1::vector::push_back<vector<0x1::ascii::String>>(&mut v2, v0);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::new(v2)
    }

    // decompiled from Move bytecode v6
}

