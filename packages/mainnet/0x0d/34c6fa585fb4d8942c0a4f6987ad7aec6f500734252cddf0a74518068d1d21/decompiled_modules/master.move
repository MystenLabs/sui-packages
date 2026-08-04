module 0xd34c6fa585fb4d8942c0a4f6987ad7aec6f500734252cddf0a74518068d1d21::master {
    struct ExtensionKey has copy, drop, store {
        ingester: 0x1::type_name::TypeName,
        content_digest: vector<u8>,
    }

    public fun borrow<T0, T1, T2: store>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: vector<u8>) : &T2 {
        let v0 = ExtensionKey{
            ingester       : arg1,
            content_digest : arg2,
        };
        0x2::dynamic_field::borrow<ExtensionKey, T2>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0), v0)
    }

    public fun add<T0, T1, T2: drop, T3: store>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: T2, arg3: vector<u8>, arg4: T3) {
        let v0 = ExtensionKey{
            ingester       : 0x1::type_name::with_defining_ids<T2>(),
            content_digest : arg3,
        };
        0x2::dynamic_field::add<ExtensionKey, T3>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1), v0, arg4);
    }

    public fun remove<T0, T1, T2: store>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: 0x1::type_name::TypeName, arg3: vector<u8>) : T2 {
        let v0 = ExtensionKey{
            ingester       : arg2,
            content_digest : arg3,
        };
        0x2::dynamic_field::remove<ExtensionKey, T2>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1), v0)
    }

    public fun exists_<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: vector<u8>) : bool {
        let v0 = ExtensionKey{
            ingester       : arg1,
            content_digest : arg2,
        };
        0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0), v0)
    }

    public fun key_content_digest(arg0: &ExtensionKey) : vector<u8> {
        arg0.content_digest
    }

    public fun key_ingester(arg0: &ExtensionKey) : 0x1::type_name::TypeName {
        arg0.ingester
    }

    public fun new_key(arg0: 0x1::type_name::TypeName, arg1: vector<u8>) : ExtensionKey {
        ExtensionKey{
            ingester       : arg0,
            content_digest : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

