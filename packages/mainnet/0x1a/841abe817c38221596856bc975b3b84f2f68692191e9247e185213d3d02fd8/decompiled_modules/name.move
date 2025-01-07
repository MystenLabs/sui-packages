module 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::name {
    struct Name has copy, drop, store {
        labels: vector<0x1::string::String>,
        normalized: 0x1::string::String,
    }

    public fun app(arg0: &Name) : &0x1::string::String {
        assert!(is_app(arg0), 4);
        label(arg0, 1)
    }

    public fun depth(arg0: &Name) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.labels)
    }

    public fun is_app(arg0: &Name) : bool {
        depth(arg0) > 1
    }

    public fun is_org(arg0: &Name) : bool {
        depth(arg0) == 1
    }

    public fun is_valid_for(arg0: &Name, arg1: &Name) : bool {
        is_org(arg0) && org(arg1) == org(arg0)
    }

    fun is_valid_label(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::length(arg0);
        let v1 = 0x1::string::bytes(arg0);
        let v2 = 0;
        if (v0 < 1 || v0 > 64) {
            return false
        };
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(v1, v2);
            let v4 = 97 <= v3 && v3 <= 122 || 48 <= v3 && v3 <= 57 || v3 == 45 && v2 != 0 && v2 != v0 - 1;
            if (!v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun label(arg0: &Name, arg1: u64) : &0x1::string::String {
        0x1::vector::borrow<0x1::string::String>(&arg0.labels, arg1)
    }

    public fun new(arg0: 0x1::string::String) : Name {
        let v0 = split_by_separator(arg0);
        validate_labels(&v0);
        assert!(0x1::string::length(&arg0) <= 129, 3);
        assert!(0x1::vector::length<0x1::string::String>(&v0) <= 2, 2);
        Name{
            labels     : v0,
            normalized : arg0,
        }
    }

    public fun normalized(arg0: &Name) : 0x1::string::String {
        arg0.normalized
    }

    public fun org(arg0: &Name) : &0x1::string::String {
        label(arg0, 0)
    }

    public(friend) fun split_by_separator(arg0: 0x1::string::String) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::string::utf8(b"@");
        while (!0x1::string::is_empty(&arg0)) {
            let v2 = 0x1::string::index_of(&arg0, &v1);
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::sub_string(&arg0, 0, v2));
            let v3 = if (v2 == 0x1::string::length(&arg0)) {
                0x1::string::length(&arg0)
            } else {
                v2 + 1
            };
            let v4 = &arg0;
            let v5 = 0x1::string::length(&arg0);
            arg0 = 0x1::string::sub_string(v4, v3, v5);
        };
        0x1::vector::reverse<0x1::string::String>(&mut v0);
        v0
    }

    public(friend) fun validate_labels(arg0: &vector<0x1::string::String>) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(arg0), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            assert!(is_valid_label(0x1::vector::borrow<0x1::string::String>(arg0, v0)), 1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

