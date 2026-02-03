module 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::owner_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::add_main_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun is_configured(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy) : bool {
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::has_rule<Rule>(arg0)
    }

    public fun prove(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessRequest, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVault, arg2: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVaultOwnerCap) {
        assert!(0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::has_access(arg1, arg2), 0);
        let v0 = Rule{dummy_field: false};
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::add_receipt<Rule>(v0, arg0);
    }

    public fun remove(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

