module 0xf06b9e3eb6d753269025ef50e32f87c7491f9b33afeafa251205ad0a3b9e4748::license {
    struct RecordingAttributionLicense has drop, store {
        scopes: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LicenseAttachedEvent<phantom T0> has copy, drop {
        scopes: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct LicenseRevokedEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    fun borrow<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : &RecordingAttributionLicense {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, RecordingAttributionLicense>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0), v0)
    }

    fun assert_valid_scope(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        assert!(v1 > 0 && v1 <= 64, 3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 == 45) {
                true
            } else {
                v3 == 95
            };
            assert!(v4, 3);
            v2 = v2 + 1;
        };
    }

    public fun attach<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg2) <= 16, 2);
        let v0 = &arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(v0)) {
            assert_valid_scope(0x1::vector::borrow<0x1::string::String>(v0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::vec_set::from_keys<0x1::string::String>(arg2);
        let v3 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ExtensionKey>(v3, v4), 0);
        let v5 = LicenseAttachedEvent<T0>{scopes: v2};
        0x2::event::emit<LicenseAttachedEvent<T0>>(v5);
        let v6 = ExtensionKey{dummy_field: false};
        let v7 = RecordingAttributionLicense{scopes: v2};
        0x2::dynamic_field::add<ExtensionKey, RecordingAttributionLicense>(v3, v6, v7);
    }

    public fun grants<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0x1::string::String) : bool {
        if (!is_attached<T0, T1>(arg0)) {
            return false
        };
        0x2::vec_set::contains<0x1::string::String>(&borrow<T0, T1>(arg0).scopes, arg1)
    }

    public fun grants_all<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0x2::vec_set::VecSet<0x1::string::String>) : bool {
        if (!is_attached<T0, T1>(arg0)) {
            return false
        };
        let v0 = borrow<T0, T1>(arg0);
        let v1 = 0x2::vec_set::keys<0x1::string::String>(arg1);
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::string::String>(v1)) {
            if (!0x2::vec_set::contains<0x1::string::String>(&v0.scopes, 0x1::vector::borrow<0x1::string::String>(v1, v2))) {
                v3 = false;
                return v3
            };
            v2 = v2 + 1;
        };
        v3 = true;
        v3
    }

    public fun is_attached<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0), v0)
    }

    public fun revoke<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(v0, v1), 1);
        let v2 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::remove<ExtensionKey, RecordingAttributionLicense>(v0, v2);
        let v3 = LicenseRevokedEvent<T0>{dummy_field: false};
        0x2::event::emit<LicenseRevokedEvent<T0>>(v3);
    }

    public fun scopes<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : &0x2::vec_set::VecSet<0x1::string::String> {
        assert!(is_attached<T0, T1>(arg0), 1);
        &borrow<T0, T1>(arg0).scopes
    }

    // decompiled from Move bytecode v7
}

