module 0xc77b320a443abbefd01833f2159a00f34b6ec6c141369a92fbd12a3fdb3183f8::whitelist {
    struct Config has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<address>,
    }

    public fun add_to_whitelist(arg0: &0xc77b320a443abbefd01833f2159a00f34b6ec6c141369a92fbd12a3fdb3183f8::admin::AdminCap, arg1: &mut Config, arg2: address) {
        0xc77b320a443abbefd01833f2159a00f34b6ec6c141369a92fbd12a3fdb3183f8::asserts::must_be_absent(0x2::vec_set::contains<address>(&arg1.whitelist, &arg2));
        0x2::vec_set::insert<address>(&mut arg1.whitelist, arg2);
    }

    public fun init_config(arg0: &0xc77b320a443abbefd01833f2159a00f34b6ec6c141369a92fbd12a3fdb3183f8::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg1),
            whitelist : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_whitelisted(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun remove_from_whitelist(arg0: &0xc77b320a443abbefd01833f2159a00f34b6ec6c141369a92fbd12a3fdb3183f8::admin::AdminCap, arg1: &mut Config, arg2: address) {
        0xc77b320a443abbefd01833f2159a00f34b6ec6c141369a92fbd12a3fdb3183f8::asserts::must_be_present(0x2::vec_set::contains<address>(&arg1.whitelist, &arg2));
        0x2::vec_set::remove<address>(&mut arg1.whitelist, &arg2);
    }

    // decompiled from Move bytecode v7
}

