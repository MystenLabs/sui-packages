module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain {
    struct Domain has copy, drop, store {
        labels: vector<0x1::string::String>,
    }

    public fun is_parent_of(arg0: &Domain, arg1: &Domain) : bool {
        if (number_of_levels(arg0) < number_of_levels(arg1)) {
            let v1 = parent(arg1);
            &v1.labels == &arg0.labels
        } else {
            false
        }
    }

    public fun is_subdomain(arg0: &Domain) : bool {
        number_of_levels(arg0) > 2
    }

    fun is_valid_label(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::length(arg0);
        let v1 = 0x1::string::bytes(arg0);
        let v2 = 0;
        let v3 = v0 >= 1 && v0 <= 63;
        if (!v3) {
            return false
        };
        while (v2 < v0) {
            let v4 = *0x1::vector::borrow<u8>(v1, v2);
            let v5 = 97 <= v4 && v4 <= 122 || 48 <= v4 && v4 <= 57 || v4 == 45 && v2 != 0 && v2 != v0 - 1;
            if (!v5) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun label(arg0: &Domain, arg1: u64) : &0x1::string::String {
        0x1::vector::borrow<0x1::string::String>(&arg0.labels, arg1)
    }

    public fun new(arg0: 0x1::string::String) : Domain {
        assert!(0x1::string::length(&arg0) <= 235, 0);
        let v0 = split_by_dot(arg0);
        validate_labels(&v0);
        0x1::vector::reverse<0x1::string::String>(&mut v0);
        Domain{labels: v0}
    }

    public fun number_of_levels(arg0: &Domain) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.labels)
    }

    public fun parent(arg0: &Domain) : Domain {
        let v0 = arg0.labels;
        0x1::vector::pop_back<0x1::string::String>(&mut v0);
        Domain{labels: v0}
    }

    public fun sld(arg0: &Domain) : &0x1::string::String {
        label(arg0, 1)
    }

    fun split_by_dot(arg0: 0x1::string::String) : vector<0x1::string::String> {
        let v0 = 0x1::string::utf8(b".");
        let v1 = 0x1::vector::empty<0x1::string::String>();
        while (!0x1::string::is_empty(&arg0)) {
            let v2 = 0x1::string::index_of(&arg0, &v0);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::sub_string(&arg0, 0, v2));
            let v3 = 0x1::string::length(&arg0);
            let v4 = if (v2 == v3) {
                v3
            } else {
                v2 + 1
            };
            let v5 = &arg0;
            arg0 = 0x1::string::sub_string(v5, v4, v3);
        };
        v1
    }

    public fun tld(arg0: &Domain) : &0x1::string::String {
        label(arg0, 0)
    }

    public fun to_string(arg0: &Domain) : 0x1::string::String {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0.labels);
        let v1 = 0;
        let v2 = 0x1::string::utf8(0x1::vector::empty<u8>());
        while (v1 < v0) {
            0x1::string::append(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg0.labels, v0 - v1 - 1));
            let v3 = v1 + 1;
            v1 = v3;
            if (v3 != v0) {
                0x1::string::append(&mut v2, 0x1::string::utf8(b"."));
            };
        };
        v2
    }

    fun validate_labels(arg0: &vector<0x1::string::String>) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(arg0), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            assert!(is_valid_label(0x1::vector::borrow<0x1::string::String>(arg0, v0)), 0);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

