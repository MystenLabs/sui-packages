module 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::keys {
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

