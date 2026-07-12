module 0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: 0x2::vec_set::VecSet<u8>,
        broker_allowlist: vector<address>,
    }

    public fun add_broker(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert_version(arg1);
        if (!0x1::vector::contains<address>(&arg1.broker_allowlist, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.broker_allowlist, arg2);
        };
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u8) {
        if (!0x2::vec_set::contains<u8>(&arg1.version, &arg2)) {
            0x2::vec_set::insert<u8>(&mut arg1.version, arg2);
        };
    }

    public fun assert_broker(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.broker_allowlist, &arg1), 1);
    }

    public fun assert_version(arg0: &GlobalConfig) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u8>(&arg0.version, &v0), 0);
    }

    public fun current_version() : u8 {
        1
    }

    public fun has_version(arg0: &GlobalConfig, arg1: u8) : bool {
        0x2::vec_set::contains<u8>(&arg0.version, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            version          : 0x2::vec_set::singleton<u8>(1),
            broker_allowlist : vector[],
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_broker(arg0: &GlobalConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.broker_allowlist, &arg1)
    }

    public fun remove_broker(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert_version(arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.broker_allowlist, &arg2);
        if (v0) {
            0x1::vector::swap_remove<address>(&mut arg1.broker_allowlist, v1);
        };
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u8) {
        assert_version(arg1);
        if (0x2::vec_set::contains<u8>(&arg1.version, &arg2)) {
            0x2::vec_set::remove<u8>(&mut arg1.version, &arg2);
        };
    }

    // decompiled from Move bytecode v7
}

