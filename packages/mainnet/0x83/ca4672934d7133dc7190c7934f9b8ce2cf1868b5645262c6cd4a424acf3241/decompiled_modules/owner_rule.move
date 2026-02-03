module 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::owner_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicyCap) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::add_main_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun is_configured(arg0: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy) : bool {
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::has_rule<Rule>(arg0)
    }

    public fun prove(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessRequest, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::memory_vault::MemoryVault, arg2: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::memory_vault::MemoryVaultOwnerCap) {
        assert!(0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::memory_vault::has_access(arg1, arg2), 0);
        let v0 = Rule{dummy_field: false};
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::add_receipt<Rule>(v0, arg0);
    }

    public fun remove(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

