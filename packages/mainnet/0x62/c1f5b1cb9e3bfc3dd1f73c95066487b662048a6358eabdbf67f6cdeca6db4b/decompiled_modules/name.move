module 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name {
    struct Name has copy, drop, store {
        org: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain,
        app: vector<0x1::string::String>,
    }

    public fun app(arg0: &Name) : &0x1::string::String {
        assert!(0x1::vector::length<0x1::string::String>(&arg0.app) == 1, 9223372281668042755);
        0x1::vector::borrow<0x1::string::String>(&arg0.app, 0)
    }

    public(friend) fun app_to_string(arg0: &Name) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = arg0.app;
        let v2 = 0x1::vector::length<0x1::string::String>(&v1);
        0x1::vector::reverse<0x1::string::String>(&mut v1);
        while (0x1::vector::length<0x1::string::String>(&v1) != 0) {
            v2 = v2 - 1;
            0x1::string::append(&mut v0, 0x1::vector::pop_back<0x1::string::String>(&mut v1));
            if (v2 > 0) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"."));
            };
        };
        0x1::vector::destroy_empty<0x1::string::String>(v1);
        v0
    }

    fun get_tld_symbol(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::sui_tld();
        assert!(arg0 == &v0, 9223372663920263173);
        0x1::string::utf8(b"@")
    }

    public fun has_valid_org(arg0: &Name, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) : bool {
        arg0.org == 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1)
    }

    fun is_valid_label(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::length(arg0);
        let v1 = 0x1::string::as_bytes(arg0);
        let v2 = 0;
        if (v0 < 1 || v0 > 64) {
            return false
        };
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(v1, v2);
            let v4 = if (97 <= v3 && v3 <= 122) {
                true
            } else if (48 <= v3 && v3 <= 57) {
                true
            } else if (v3 == 45) {
                if (v2 != 0) {
                    v2 != v0 - 1
                } else {
                    false
                }
            } else {
                false
            };
            if (!v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun new(arg0: 0x1::string::String, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain) : Name {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, arg0);
        validate_labels(&v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg0);
        Name{
            org : arg1,
            app : v1,
        }
    }

    public(friend) fun org_to_string(arg0: &Name) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = arg0.org;
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::number_of_levels(&v1);
        while (v2 > 2) {
            0x1::string::append(&mut v0, *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::label(&v1, v2 - 1));
            if (v2 > 3) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"."));
            };
            v2 = v2 - 1;
        };
        0x1::string::append(&mut v0, get_tld_symbol(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::tld(&v1)));
        0x1::string::append(&mut v0, *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(&v1));
        v0
    }

    public fun to_string(arg0: &Name) : 0x1::string::String {
        let v0 = org_to_string(arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, app_to_string(arg0));
        v0
    }

    public(friend) fun validate_labels(arg0: &vector<0x1::string::String>) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(arg0), 9223372526481047553);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            assert!(is_valid_label(0x1::vector::borrow<0x1::string::String>(arg0, v0)), 9223372535070982145);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

