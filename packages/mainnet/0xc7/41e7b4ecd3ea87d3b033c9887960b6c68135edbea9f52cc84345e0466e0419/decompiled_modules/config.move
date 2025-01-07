module 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config {
    struct ProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        blacklisted_types: 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::LinkedSet<0x1::ascii::String>,
    }

    fun align_type_name<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = b"";
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v1)) {
            let v4 = *0x1::vector::borrow<u8>(v1, v3);
            if (v4 == 60) {
                break
            };
            0x1::vector::push_back<u8>(&mut v2, v4);
            v3 = v3 + 1;
        };
        0x1::ascii::string(v2)
    }

    public(friend) fun assert_type_blacklisted<T0>(arg0: &Config) {
        assert!(is_type_blacklisted<T0>(arg0), 2);
    }

    public(friend) fun assert_type_not_blacklisted<T0>(arg0: &Config) {
        assert!(!is_type_blacklisted<T0>(arg0), 1);
    }

    public(friend) fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun blacklist_type<T0>(arg0: &mut Config) {
        assert_type_not_blacklisted<T0>(arg0);
        0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::push_back<0x1::ascii::String>(&mut arg0.blacklisted_types, align_type_name<T0>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::empty<0x1::ascii::String>(arg0);
        0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::coin::Coin"));
        let v1 = Config{
            id                : 0x2::object::new(arg0),
            version           : 1,
            blacklisted_types : v0,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = ProtocolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ProtocolAdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun is_type_blacklisted<T0>(arg0: &Config) : bool {
        0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::contains<0x1::ascii::String>(&arg0.blacklisted_types, align_type_name<T0>())
    }

    public(friend) fun is_type_blacklisted_str(arg0: &Config, arg1: 0x1::ascii::String) : bool {
        0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::contains<0x1::ascii::String>(&arg0.blacklisted_types, arg1)
    }

    public(friend) fun unblacklist_type<T0>(arg0: &mut Config) {
        assert_type_blacklisted<T0>(arg0);
        0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::remove<0x1::ascii::String>(&mut arg0.blacklisted_types, align_type_name<T0>());
    }

    // decompiled from Move bytecode v6
}

