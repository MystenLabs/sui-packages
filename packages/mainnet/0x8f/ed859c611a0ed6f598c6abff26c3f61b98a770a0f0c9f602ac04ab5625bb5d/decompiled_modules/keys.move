module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::keys {
    struct PolicyKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AccountKey has copy, drop, store {
        pos0: address,
    }

    struct TemplateKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun account_key(arg0: address) : AccountKey {
        AccountKey{pos0: arg0}
    }

    public fun actions() : 0x2::vec_set::VecSet<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"send_funds"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"unlock_funds"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"clawback_funds"));
        0x2::vec_set::from_keys<0x1::string::String>(v0)
    }

    public fun clawback_funds_action() : 0x1::string::String {
        0x1::string::utf8(b"clawback_funds")
    }

    public fun is_valid_action(arg0: 0x1::string::String) : bool {
        let v0 = actions();
        0x2::vec_set::contains<0x1::string::String>(&v0, &arg0)
    }

    public(friend) fun policy_key<T0>() : PolicyKey<T0> {
        PolicyKey<T0>{dummy_field: false}
    }

    public fun send_funds_action() : 0x1::string::String {
        0x1::string::utf8(b"send_funds")
    }

    public(friend) fun template_key() : TemplateKey {
        TemplateKey{dummy_field: false}
    }

    public fun unlock_funds_action() : 0x1::string::String {
        0x1::string::utf8(b"unlock_funds")
    }

    // decompiled from Move bytecode v7
}

