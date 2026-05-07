module 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation {
    fun assert_non_empty_max(arg0: &0x1::string::String, arg1: u64) {
        assert!(0x1::string::length(arg0) > 0, 22);
        assert!(0x1::string::length(arg0) <= arg1, 21);
    }

    fun assert_vector_items(arg0: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg0, v0);
            assert!(0x1::string::length(v1) > 0, 23);
            assert!(0x1::string::length(v1) <= 128, 21);
            v0 = v0 + 1;
        };
    }

    public fun authors(arg0: &vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(arg0) > 0, 17);
        assert!(0x1::vector::length<0x1::string::String>(arg0) <= 20, 19);
        assert_vector_items(arg0);
    }

    public fun content_fields(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 10);
        assert!(0x1::string::length(arg0) <= 128, 21);
        assert!(0x1::string::length(arg1) > 0, 11);
        assert!(0x1::string::length(arg1) <= 128, 21);
        assert!(0x1::string::length(arg2) > 0, 12);
        assert!(0x1::string::length(arg2) <= 128, 21);
        assert!(0x1::string::length(arg3) > 0, 13);
        assert!(0x1::string::length(arg3) <= 64, 21);
    }

    public fun keywords(arg0: &vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(arg0) <= 10, 18);
        assert_vector_items(arg0);
    }

    public fun long_text(arg0: &0x1::string::String) {
        assert_non_empty_max(arg0, 4096);
    }

    public fun medium_text(arg0: &0x1::string::String) {
        assert_non_empty_max(arg0, 1024);
    }

    public fun short_text(arg0: &0x1::string::String) {
        assert_non_empty_max(arg0, 256);
    }

    public fun tags(arg0: &vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(arg0) <= 20, 20);
        assert_vector_items(arg0);
    }

    public fun title(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 14);
        assert!(0x1::string::length(arg0) <= 256, 21);
    }

    // decompiled from Move bytecode v7
}

