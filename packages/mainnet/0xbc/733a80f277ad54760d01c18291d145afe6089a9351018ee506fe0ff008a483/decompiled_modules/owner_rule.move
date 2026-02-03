module 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::owner_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicyCap) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::add_main_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun is_configured(arg0: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy) : bool {
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::has_rule<Rule>(arg0)
    }

    public fun prove(arg0: &mut 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessRequest, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_vault::MemoryVault, arg2: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_vault::MemoryVaultOwnerCap) {
        assert!(0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_vault::has_access(arg1, arg2), 0);
        let v0 = Rule{dummy_field: false};
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::add_receipt<Rule>(v0, arg0);
    }

    public fun remove(arg0: &mut 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

