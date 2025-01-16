module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::core_config {
    struct CoreConfig has copy, drop, store {
        public_key: vector<u8>,
        min_label_length: u8,
        max_label_length: u8,
        valid_tlds: 0x2::vec_set::VecSet<0x1::string::String>,
        payments_version: u8,
        max_years: u8,
        extra: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun assert_is_valid_for_sale(arg0: &CoreConfig, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain) {
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::is_subdomain(arg1), 9223372423402094597);
        assert!(is_valid_tld(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::tld(arg1)), 9223372427696930819);
        let v0 = 0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(arg1));
        assert!(v0 >= (arg0.min_label_length as u64) && v0 <= (arg0.max_label_length as u64), 9223372449171636225);
    }

    public fun is_valid_tld(arg0: &CoreConfig, arg1: &0x1::string::String) : bool {
        0x2::vec_set::contains<0x1::string::String>(&arg0.valid_tlds, arg1)
    }

    public fun max_label_length(arg0: &CoreConfig) : u8 {
        arg0.max_label_length
    }

    public fun max_years(arg0: &CoreConfig) : u8 {
        arg0.max_years
    }

    public fun min_label_length(arg0: &CoreConfig) : u8 {
        arg0.min_label_length
    }

    public fun new(arg0: vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: vector<0x1::string::String>, arg6: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : CoreConfig {
        CoreConfig{
            public_key       : arg0,
            min_label_length : arg1,
            max_label_length : arg2,
            valid_tlds       : 0x2::vec_set::from_keys<0x1::string::String>(arg5),
            payments_version : arg3,
            max_years        : arg4,
            extra            : arg6,
        }
    }

    public fun payments_version(arg0: &CoreConfig) : u8 {
        arg0.payments_version
    }

    public fun public_key(arg0: &CoreConfig) : vector<u8> {
        arg0.public_key
    }

    // decompiled from Move bytecode v6
}

