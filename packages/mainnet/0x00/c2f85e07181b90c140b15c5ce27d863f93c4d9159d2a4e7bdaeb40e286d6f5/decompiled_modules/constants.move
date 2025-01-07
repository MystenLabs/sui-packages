module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants {
    public fun default_image() : 0x1::string::String {
        0x1::string::utf8(b"QmaLFg4tQYansFpyRqmDfABdkUVy66dHtpnkH15v1LPzcY")
    }

    public fun grace_period_ms() : u64 {
        2592000000
    }

    public fun leaf_expiration_timestamp() : u64 {
        0
    }

    public fun max_bps() : u16 {
        10000
    }

    public fun max_domain_length() : u8 {
        63
    }

    public fun min_domain_length() : u8 {
        3
    }

    public fun mist_per_sui() : u64 {
        1000000000
    }

    public fun subdomain_allow_creation_key() : 0x1::string::String {
        0x1::string::utf8(b"S_AC")
    }

    public fun subdomain_allow_extension_key() : 0x1::string::String {
        0x1::string::utf8(b"S_ATE")
    }

    public fun sui_tld() : 0x1::string::String {
        0x1::string::utf8(b"sui")
    }

    public fun year_ms() : u64 {
        31536000000
    }

    // decompiled from Move bytecode v6
}

