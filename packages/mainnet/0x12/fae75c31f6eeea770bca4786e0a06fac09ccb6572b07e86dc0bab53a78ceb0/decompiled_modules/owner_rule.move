module 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::owner_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::add_main_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun is_configured(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy) : bool {
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::has_rule<Rule>(arg0)
    }

    public fun prove(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessRequest, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg2: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVaultOwnerCap) {
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::has_access(arg1, arg2), 0);
        let v0 = Rule{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::add_receipt<Rule>(v0, arg0);
    }

    public fun remove(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

