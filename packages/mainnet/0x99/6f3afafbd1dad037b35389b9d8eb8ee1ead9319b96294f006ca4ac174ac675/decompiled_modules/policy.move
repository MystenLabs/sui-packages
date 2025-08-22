module 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy {
    struct PolicyKey has copy, drop, store {
        key_name: 0x1::string::String,
    }

    struct Policy has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        adapter_type: 0x1::type_name::TypeName,
        metadata: vector<u8>,
    }

    public fun adapter_type(arg0: &Policy) : &0x1::type_name::TypeName {
        &arg0.adapter_type
    }

    public(friend) fun all_policies_key() : PolicyKey {
        PolicyKey{key_name: 0x1::string::utf8(b"all_rules")}
    }

    public fun asset_type(arg0: &Policy) : &0x1::type_name::TypeName {
        &arg0.asset_type
    }

    public fun is_adapter_type_allowed(arg0: &Policy, arg1: 0x1::type_name::TypeName) : bool {
        arg0.adapter_type == arg1
    }

    public fun is_all_policies_key(arg0: &PolicyKey) : bool {
        *key_name(arg0) == 0x1::string::utf8(b"all_rules")
    }

    public fun key_name(arg0: &PolicyKey) : &0x1::string::String {
        &arg0.key_name
    }

    public fun metadata(arg0: &Policy) : &vector<u8> {
        &arg0.metadata
    }

    public(friend) fun new(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: vector<u8>) : Policy {
        Policy{
            asset_type   : arg0,
            adapter_type : arg1,
            metadata     : arg2,
        }
    }

    public(friend) fun new_policy_key(arg0: 0x1::string::String) : PolicyKey {
        PolicyKey{key_name: arg0}
    }

    public fun verify_adapter_type(arg0: &Policy, arg1: 0x1::type_name::TypeName) {
        assert!(is_adapter_type_allowed(arg0, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::adapter_not_whitelisted());
    }

    // decompiled from Move bytecode v6
}

