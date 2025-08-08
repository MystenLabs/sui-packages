module 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule {
    struct RuleKey has copy, drop, store {
        key_name: 0x1::string::String,
    }

    struct Rule has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        adapter_type: 0x1::type_name::TypeName,
        metadata: vector<u8>,
    }

    public fun adapter_type(arg0: &Rule) : &0x1::type_name::TypeName {
        &arg0.adapter_type
    }

    public fun all_rules_key() : RuleKey {
        RuleKey{key_name: 0x1::string::utf8(b"all_rules")}
    }

    public fun asset_type(arg0: &Rule) : &0x1::type_name::TypeName {
        &arg0.asset_type
    }

    public fun is_adapter_type_allowed(arg0: &Rule, arg1: 0x1::type_name::TypeName) : bool {
        arg0.adapter_type == arg1
    }

    public fun is_all_rules_key(arg0: &RuleKey) : bool {
        *key_name(arg0) == 0x1::string::utf8(b"all_rules")
    }

    public fun key_name(arg0: &RuleKey) : &0x1::string::String {
        &arg0.key_name
    }

    public fun metadata(arg0: &Rule) : &vector<u8> {
        &arg0.metadata
    }

    public fun new(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: vector<u8>) : Rule {
        Rule{
            asset_type   : arg0,
            adapter_type : arg1,
            metadata     : arg2,
        }
    }

    public fun new_rule_key(arg0: 0x1::string::String) : RuleKey {
        RuleKey{key_name: arg0}
    }

    public fun verify_adapter_type(arg0: &Rule, arg1: 0x1::type_name::TypeName) {
        assert!(is_adapter_type_allowed(arg0, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::adapter_not_whitelisted());
    }

    // decompiled from Move bytecode v6
}

