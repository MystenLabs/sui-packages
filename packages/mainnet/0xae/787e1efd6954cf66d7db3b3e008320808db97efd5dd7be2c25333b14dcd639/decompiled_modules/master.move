module 0xae787e1efd6954cf66d7db3b3e008320808db97efd5dd7be2c25333b14dcd639::master {
    struct ExtensionKey has copy, drop, store {
        ingester: 0x1::type_name::TypeName,
        content_digest: vector<u8>,
    }

    public fun borrow<T0, T1, T2: store>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: vector<u8>) : &T2 {
        let v0 = ExtensionKey{
            ingester       : arg1,
            content_digest : arg2,
        };
        0x2::dynamic_field::borrow<ExtensionKey, T2>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid<T0, T1>(arg0), v0)
    }

    public fun add<T0, T1, T2: drop, T3: store>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::RecordingAdminCap<T0>, arg2: T2, arg3: vector<u8>, arg4: T3) {
        let v0 = ExtensionKey{
            ingester       : 0x1::type_name::with_defining_ids<T2>(),
            content_digest : arg3,
        };
        0x2::dynamic_field::add<ExtensionKey, T3>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid_mut<T0, T1>(arg0, arg1), v0, arg4);
    }

    public fun remove<T0, T1, T2: store>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::RecordingAdminCap<T0>, arg2: 0x1::type_name::TypeName, arg3: vector<u8>) : T2 {
        let v0 = ExtensionKey{
            ingester       : arg2,
            content_digest : arg3,
        };
        0x2::dynamic_field::remove<ExtensionKey, T2>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid_mut<T0, T1>(arg0, arg1), v0)
    }

    public fun exists_<T0, T1>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: vector<u8>) : bool {
        let v0 = ExtensionKey{
            ingester       : arg1,
            content_digest : arg2,
        };
        0x2::dynamic_field::exists<ExtensionKey>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid<T0, T1>(arg0), v0)
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

