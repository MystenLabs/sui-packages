module 0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::config {
    struct SubDomainConfig has copy, drop, store {
        allowed_tlds: vector<0x1::string::String>,
        max_depth: u8,
        min_label_size: u8,
        minimum_duration: u64,
    }

    public fun assert_is_valid_subdomain(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg2: &SubDomainConfig) {
        assert!(is_valid_tld(arg1, arg2), 4);
        assert!(is_valid_label(arg1, arg2), 3);
        assert!(has_valid_depth(arg1, arg2), 1);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::is_parent_of(arg0, arg1), 2);
    }

    public fun default() : SubDomainConfig {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::sui_tld());
        SubDomainConfig{
            allowed_tlds     : v0,
            max_depth        : 10,
            min_label_size   : 3,
            minimum_duration : 86400000,
        }
    }

    public fun has_valid_depth(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg1: &SubDomainConfig) : bool {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::number_of_levels(arg0) <= (arg1.max_depth as u64)
    }

    public fun is_valid_label(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg1: &SubDomainConfig) : bool {
        0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::label(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::number_of_levels(arg0) - 1)) >= (arg1.min_label_size as u64)
    }

    public fun is_valid_tld(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg1: &SubDomainConfig) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1.allowed_tlds)) {
            if (0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::tld(arg0) == 0x1::vector::borrow<0x1::string::String>(&arg1.allowed_tlds, v0)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun minimum_duration(arg0: &SubDomainConfig) : u64 {
        arg0.minimum_duration
    }

    public fun new(arg0: vector<0x1::string::String>, arg1: u8, arg2: u8, arg3: u64) : SubDomainConfig {
        SubDomainConfig{
            allowed_tlds     : arg0,
            max_depth        : arg1,
            min_label_size   : arg2,
            minimum_duration : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

