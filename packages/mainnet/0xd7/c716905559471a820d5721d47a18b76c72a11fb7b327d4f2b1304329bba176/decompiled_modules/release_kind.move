module 0xd7c716905559471a820d5721d47a18b76c72a11fb7b327d4f2b1304329bba176::release_kind {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct KindSetEvent has copy, drop {
        release_id: 0x2::object::ID,
        kind: 0x1::string::String,
    }

    struct KindUnsetEvent has copy, drop {
        release_id: 0x2::object::ID,
    }

    public fun has_kind(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0)
    }

    public fun kind(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : 0x1::string::String {
        assert!(has_kind(arg0), 1);
        let v0 = ExtensionKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ExtensionKey, 0x1::string::String>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0)
    }

    public fun set_kind(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: 0x1::string::String) {
        let v0 = 0x1::string::as_bytes(&arg2);
        assert!(!0x1::vector::is_empty<u8>(v0), 2);
        assert!(0x1::vector::length<u8>(v0) <= 32, 3);
        let v1 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1);
        let v2 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v1, v2)) {
            let v3 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, 0x1::string::String>(v1, v3) = arg2;
        } else {
            let v4 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, 0x1::string::String>(v1, v4, arg2);
        };
        let v5 = KindSetEvent{
            release_id : 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0),
            kind       : arg2,
        };
        0x2::event::emit<KindSetEvent>(v5);
    }

    public fun unset_kind(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v2 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, 0x1::string::String>(v0, v2);
            let v3 = KindUnsetEvent{release_id: 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0)};
            0x2::event::emit<KindUnsetEvent>(v3);
        };
    }

    // decompiled from Move bytecode v7
}

